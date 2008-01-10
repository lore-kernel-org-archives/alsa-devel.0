From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] virtual master control for HD-audio
Date: Thu, 10 Jan 2008 15:09:46 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801101421390.30240@tm8103.perex-int.cz>
References: <s5hprx12x6x.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0712212030470.8567@tm8103.perex-int.cz>
	<s5hd4syu6co.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0801101027300.30240@tm8103.perex-int.cz>
	<s5hzlvdaoin.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E9F062451B
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 15:09:46 +0100 (CET)
In-Reply-To: <s5hzlvdaoin.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Jan 2008, Takashi Iwai wrote:

> At Thu, 10 Jan 2008 11:29:39 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Sat, 22 Dec 2007, Takashi Iwai wrote:
> > 
> > > At Fri, 21 Dec 2007 20:37:09 +0100 (CET),
> > > Jaroslav Kysela wrote:
> > > > 
> > > > On Thu, 20 Dec 2007, Takashi Iwai wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > another thing I'd like to push into the next kernel is the virtual
> > > > > master volume control.  As I posted in earlier posts, it adds virtual
> > > > > controls that have several slave controls with the same types,
> > > > > e.g. Front, Surround, Center, LFE, etc.  Then these are adjusted
> > > > > simultaneously via the master control.
> > > > > 
> > > > > It'd be appreciated if some one can test the patches with HD-audio h/w
> > > > > that has no master control yet (e.g. some STAC codecs).
> > > > > 
> > > > > Note that this won't add the master volumes if there are no real
> > > > > volume controls.  Some codecs have really no volume control, and this
> > > > > won't help for such devices.
> > > > > 
> > > > > Two (and one for driver) patches will follow after this.
> > > > 
> > > > NAK from my side. I am convinced that this code can be implemented in the 
> > > > user space even without any daemon just in the mixer abstract layer using 
> > > > standard control elements and using eventually new user controls to store 
> > > > data for virtual mixer controls.
> > > 
> > > A user-space implementation of virtual mixer elements would be far
> > > more complicated than the simplistic kernel-space patch.  I've
> > > considered it many times, even tried to implement it, but got that
> > > conclusion.  You'll see obviously the following difficulties:
> > > 
> > > 1. Many user-space virtual elements
> > > 
> > > Each slave control element needs a virtual element (eventually a
> > > user-space one) because we need to keep both raw and virtual values to
> > > handle saturation.  That is, the same number of additional controls
> > > would be added.  Significant for 7.1 outputs.
> > 
> > Note that these "extra" values can be handled together using only one 
> > user-space control element without "Volume/Switch" in name.
> 
> This method is very likely fragile.  Think what happens if the number
> of elements changes, or if the element numid changes.  Then the packed
> values will be screwed up.
> 
> 
> > > 2. Easy incosistency between virtual and raw elements
> > > 
> > > Even if the mixer abstraction hides the virtual elements, both
> > > virtual and raw elements are exposed on control API.  This can cause
> > > the value-inconsistency between them quite easily, because many apps
> > > access directly via control API (even some mixer apps), and they
> > > likely change only raw values.  The similar situation is for kernel
> > > OSS emulation.
> > 
> > I have basically two ideas to handle this.
> > 
> > 1) create a plugin system directly in the snd_ctl_* interface
> > 
> >    - basically code might be very same code as you proposed in kernel
> 
> No.  The big difference is that the raw values are still exposed via
> control API (otherwise how do you read/write raw values?).  That is,
> any user-space program may break consistency.  OTOH, the kernel
> solution doesn't expose raw values.

Alsa-lib can filter raw writes from applications, but it's really not 
something I prefer, of course.

> > 2) create virtual things only in smixer
> > 
> >    - it's something I strongly prefer
> >    - if mixers uses CTL interface, it's not our bussiness because
> >      we haven't claimed to create virtual layers in CTL
> 
> Hm, I have to say it's a bad attitude.  It's our business to keep the
> whole system consistent.  We shouldn't build such a weak and fragile
> system any more.

But the definition of consistency is relative in this case. If we have 
universal control API (which is not a mixer API, but just API to pass 
runtime configuration parameters to driver) and second one API (simple 
mixer - fully abstract) then everything is consistent.

> And what about the kernel OSS mixer?  There are still many apps to
> handle it.

Yes, OSS mixer support still requires a rework. My idea is to create a 
helper userspace application which will start automatically by udev when 
/dev/mixer devices are created passing values through smixer API in user 
space.

For OSS PCM emulation, similar thing can be done using snd-aloop module.

> > > 3. Complicated configuration
> > > 
> > > The requirement of virtual master controls is very much dependent on
> > > the hardware.  In the case of HD-audio, it depends on codec chip
> > > types, and even on the preset model chosen via PCI SSID or a module
> > > option.  Implementing such a complex conditional in alsa-lib
> > > configuration is a clear overhead.
> > 
> > I don't agree much here. Of course, we might need some hints from the 
> > driver (using information about components in sndrv_ctl_card_info) or we 
> > might analyze available controls using their names if Master control is 
> > present or we can eventually create a configuration tool saving hints to 
> > alsa-lib's configuration files which controls should be added for given 
> > hardware (this configuration tool might create a list of useable PCM 
> > devices handled in the driver, too). Just idea.
> 
> But it *is* an overhead.

Maybe for this simple case. I would be really happy to see a system which 
allows me to split for example six channel hardware to three 
stereo soundcards with full abstract and independent mixers.

If we agree that it's the way to go, it does not make much sense to 
implement these things again in the kernel space, because virtual master
implemented there becomes unuseable.

> Note taht this isn't for solving every mixer problem.  It doesn't
> solve the world hunger.  But, it solves nicely the really annoying
> problem we face right now, without messy, fragile and overly complex
> implementation.

My point is that if we allow this now, we might have trouble to remove it 
in future when it becomes obsolete. It is much more difficult for the 
kernel code. We definitely need to settle a clear way about future mixer 
directions now and decide where the abstraction should be.

I'm sure I can hack smixer - simple_none.c - to add virtual master support 
in few days. If I fail for a reason or code is really ugly, I give you my 
ack for your implementation, ok?

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
