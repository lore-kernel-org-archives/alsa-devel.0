From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: delayed dma trigger
Date: Mon, 23 Oct 2006 15:46:52 +0200
Message-ID: <1161611212.6617.53.camel@ux156>
References: <1161593391.6617.25.camel@ux156>  <s5hbqo317yo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D26A316A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Oct 2006 15:45:53 +0200 (MEST)
In-Reply-To: <s5hbqo317yo.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Paul Mackerras <paulus@samba.org>, Paul Collins <paul@briny.ondioline.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

Paul (Collins), sorry about that, I didn't mean to CC you. Please
ignore.
Paul (Mackeras), sorry as well, I meant to CC you on the original mail
instead of Paul Collins. I've left all the quoted text instead.

Takashi, thanks for your reply.

> > For AOA, there are some DMA engine programming pitfalls I wasn't aware
> > of previously (actually, I was aware of the bug it triggered but not
> > quite why it happened). But now we have two questions about the trigger
> > callback.
> > 
> > (1)
> > When correctly using the i2s bus (aoa isn't at the moment), it is not
> > possible to immediately stop doing DMA, the DMA engine has to finish the
> > current period first, then go into a stop condition, and only after that
> > we can stop the engine completely. Hence, this can take quite a while
> > (up to the period length). Is it ok to set the stop condition and return
> > from the trigger function without having DMA stopped? It'll be
> > completely stopped asynchronously on the next interrupt, and we'd have
> > to make the hw_free callback wait for that, I guess.
> 
> Yes, but hw_free isn't enough.  You'd need a DMA sync in prepare
> callback since a typical repeated play flow is like:
> 	open -> hw_params -> prepare -> trigger(START) ->
> 		running -> trigger(STOP) ->
> 		 prepare -> trigger(START) -> ...

Right, but prepare can sleep as well so it's easy to do. Though if the
prepare doesn't actually change anything, couldn't we not stop the DMA
and just continue?

> > (2)
> > Relating to that, if a start trigger comes in before the DMA engine is
> > stopped, it would be nice if we could just clear the stop condition and
> > let it continue to run. Can recording start at any arbitrary period in
> > the buffer relying only on the pointer callback?
> > [Actually, come to think of it, isn't this required for proper 'pause'
> > function during playback or recording? I guess aoa is wrong now then?]
> 
> Well, you can of course trick in the lowlevel code as if DMA is newly
> started.  For PCM middle layer, it doesn't matter.
> 
> But, the value returned from pointer callback must be reset to zero
> once after prepare callback is called.  So, the lowlevel code should
> handle an offset from the actual DMA pointer value in such a case.

Let me put it in my words to see if I understand things correctly.
Let me always use a picture like this
  |...|...|...|...|
for the sample buffer, where the | indicates a new period.

First, pause/resume. If we pause playing in the middle of some period
  |...|...|...|...|
        ^ pause request here
what we'll have to do is make it play until the period ends:
  |...|...|...|...|
          ^ pauses here
Then, if we want to resume playing, we should probably continue at
exactly that same spot, right? Currently, I think I restart at the first
period.

Now, with stop/play instead of pause/resume, does the picture change?
There's a prepare between the trigger calls, and that could give us a
whole new buffer, right? And the period size might even be different.
Hence, we'll need to create a whole new set of DBDMA commands after
waiting for the stop to complete, I guess.

But if the prepare can give us a whole new buffer, what guarantees that
the old buffer is still there to do DMA on after triggering a stop? Or
does one need to close/re-open the device to change
buffers/periodsize/...?

Anyway, except for that I'd think that in the play/resume trigger, we
can see if things are stopped and if it's still running we just clear
the stop condition. If in prepare we wait for it to stop completely,
that's fine since we'll have created a whole new dbdma command set.

Correct me if I'm wrong.

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
