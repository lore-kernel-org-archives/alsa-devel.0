From: Jeremy Hall <jhall@maoz.com>
Subject: Re: rme9652: possible deadlock
Date: Mon, 28 Apr 2003 04:44:31 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304280844.h3S8iVtT030058@sith.maoz.com>
References: <Pine.LNX.4.44.0304232101560.18005-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304232101560.18005-100000@pnote.perex-int.cz> from
 Jaroslav Kysela at "Apr 23, 2003 09:19:27 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jeremy Hall <jhall@maoz.com>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

oh I didn't see this bit before

In the new year, Jaroslav Kysela wrote:
> On Wed, 23 Apr 2003, Jeremy Hall wrote:
> 
> > In the new year, Jaroslav Kysela wrote:
> > > On Tue, 22 Apr 2003, Jeremy Hall wrote:
> > > 
> > > > If both cards try to ru> > > If we stop all linked streams at one time XRUN, application must restart 
> > > all things and the driver will GUERANTEE that the restarted streams are 
> > > in sample sync if hardware supports this feature. I don't see any problem 
> > > in this area.
> > > 
> > yes, if we stop them at one time, but we might not stop them at the "same" 
> > time.
> 
> Note: We don't even stop the stream for once card "precisely" at period 
> boundary (if interrupt arrived late) so it's academic question. Does it 
> hurt something if streams are in different position after XRUN? They must 
> be restarted anyway.
> 
If we know exactly where and on what channels the XRUN occurred, we might 
be able to save more audio and minimize the xrun to the actual xrun time 
rather than the nearest fragment boundary (if that is what we do) if our 
fragment size (if you will allow me to use a deprecated term) is big, say 
4096 frames, then you're telling me that if a xrun happens in that moment 
the whole 4096 frames will be lost? or 8192 or whatever you set your 
fragsize to

> > > And yes, applications might use no-xrun mode. The sample sync is always 
> > > guaranteed, but the transferred stream might be invalid.
> > > 
> > What does jack use?
> 
> Jack uses standard xrun mode and Paul doesn't probably work with multiple 
> cards connected together. He uses RME hardware with 24 channels.

I have two rme9652 connected together synced with wordclock and have 
chosen to cable them so that the 24 channels are spread across both cards 
in such a way that to use 24 channels at 96 all I need to do is press the 
DS button on my adi8DS's and don't need to reconfig the optical cables.  
So in theory I should have hardware synch, but in the case of XRUN it 
seems both cards lose.

I think we are speaking past one another.  You say that sample-synch is 
guaranteed, and that is because both cards have the same fragment size and 
are told to go get one fragment.  Paul has considered the possability that 
the RME9652 may not tell us the hw pointer position properly--maybe there 
is a firmware upgrade for this--maybe not, but is that why we must go on 
fragment synch?

but I am saying that if an XRUN occurs time is no longer a constant, and 
thus samples in the buffer are no longer relative.  Restarting the 
substreams might be similar to closing the barn door after the horse has 
already run away, closing an empty stall.

_J

> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
