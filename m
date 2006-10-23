From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: delayed dma trigger
Date: Mon, 23 Oct 2006 16:31:07 +0200
Message-ID: <1161613867.6617.64.camel@ux156>
References: <1161593391.6617.25.camel@ux156> <s5hbqo317yo.wl%tiwai@suse.de>
	<1161611212.6617.53.camel@ux156>  <s5h64eb15qs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 79572162
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Oct 2006 16:30:07 +0200 (MEST)
In-Reply-To: <s5h64eb15qs.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Paul Mackerras <paulus@samba.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-10-23 at 16:11 +0200, Takashi Iwai wrote:
> [Removed Paul Collins from Cc now]

Thanks.

> > Right, but prepare can sleep as well so it's easy to do. Though if the
> > prepare doesn't actually change anything, couldn't we not stop the DMA
> > and just continue?
> 
> It's up to you.  My point is the prepare callback is called anyway,
> and if you want to resolve the DMA call conflict, prepare callback is
> the right place.  But, if trigger(START) checks whether the DMA is
> already is running and just continues, then yes, you don't have to
> wait in prepare.

But is prepare also called between pause/resume? I was assuming it
isn't.

> > Now, with stop/play instead of pause/resume, does the picture change?
> > There's a prepare between the trigger calls, and that could give us a
> > whole new buffer, right? And the period size might even be different.
> > Hence, we'll need to create a whole new set of DBDMA commands after
> > waiting for the stop to complete, I guess.
> 
> Yes, almost.  The prepare callback won't assign any new buffers but
> just reset the positions to zero in most cases.  But, the app could
> resize the buffer, so yes, it can happen after the following sequence:
> 	stop -> hw_free -> hw_params -> prepare -> start

Ah, good, so if we only sync in hw_free we should in theory be fine
since that's the point where the buffers go away, and changes are only
made after hw_params.

> > Anyway, except for that I'd think that in the play/resume trigger, we
> > can see if things are stopped and if it's still running we just clear
> > the stop condition. If in prepare we wait for it to stop completely,
> > that's fine since we'll have created a whole new dbdma command set.
> 
> Sounds feasible.  You can add a check whether you can reuse the
> running DBDMA (i.e. period/buffer address and size are unchanged), for
> example.
> 
> But, still I think a DMA sync in prepare would be an easier solution
> since the same check would be needed for hw_free anyway.
> Another merit is that the trigger(START) callback does start the
> stream at the very same moment it's issued.  With the continous DBDMA,
> the start of stream might be delayed than the triggered time.

I agree, mostly mental exercise to make sure I understand things
correctly.

Technical details for us now... I guess what we'll do is
 * wait for dma to stop completely in hw_free and at the beginning of
   prepare
 * create a new set of commands in prepare as I do now (except they need
   to be different with S0 for the stop condition etc)
 * in the start/resume trigger, simply turn on the DMA engine or if it's
   still running clear the stop condition [1]
 * in the pause/stop trigger just set the stop condition
 * in the interrupt sync up internal state if we have done a stop and
   disable the DMA engine completely (clear RUN bit)

That way, since prepare isn't called between pause/resume, we'll get
perfect pause operation unlike now, and since prepare resets the dbdma
command pointer it'll start at the beginning of the buffer when we
enable the dma engine in the start/resume trigger.

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
