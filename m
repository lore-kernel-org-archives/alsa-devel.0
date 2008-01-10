From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] virtual master control for HD-audio
Date: Thu, 10 Jan 2008 11:29:39 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801101027300.30240@tm8103.perex-int.cz>
References: <s5hprx12x6x.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0712212030470.8567@tm8103.perex-int.cz>
	<s5hd4syu6co.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E5192450A
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 11:29:40 +0100 (CET)
In-Reply-To: <s5hd4syu6co.wl%tiwai@suse.de>
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

On Sat, 22 Dec 2007, Takashi Iwai wrote:

> At Fri, 21 Dec 2007 20:37:09 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Thu, 20 Dec 2007, Takashi Iwai wrote:
> > 
> > > Hi,
> > > 
> > > another thing I'd like to push into the next kernel is the virtual
> > > master volume control.  As I posted in earlier posts, it adds virtual
> > > controls that have several slave controls with the same types,
> > > e.g. Front, Surround, Center, LFE, etc.  Then these are adjusted
> > > simultaneously via the master control.
> > > 
> > > It'd be appreciated if some one can test the patches with HD-audio h/w
> > > that has no master control yet (e.g. some STAC codecs).
> > > 
> > > Note that this won't add the master volumes if there are no real
> > > volume controls.  Some codecs have really no volume control, and this
> > > won't help for such devices.
> > > 
> > > Two (and one for driver) patches will follow after this.
> > 
> > NAK from my side. I am convinced that this code can be implemented in the 
> > user space even without any daemon just in the mixer abstract layer using 
> > standard control elements and using eventually new user controls to store 
> > data for virtual mixer controls.
> 
> A user-space implementation of virtual mixer elements would be far
> more complicated than the simplistic kernel-space patch.  I've
> considered it many times, even tried to implement it, but got that
> conclusion.  You'll see obviously the following difficulties:
> 
> 1. Many user-space virtual elements
> 
> Each slave control element needs a virtual element (eventually a
> user-space one) because we need to keep both raw and virtual values to
> handle saturation.  That is, the same number of additional controls
> would be added.  Significant for 7.1 outputs.

Note that these "extra" values can be handled together using only one 
user-space control element without "Volume/Switch" in name.

> 2. Easy incosistency between virtual and raw elements
> 
> Even if the mixer abstraction hides the virtual elements, both
> virtual and raw elements are exposed on control API.  This can cause
> the value-inconsistency between them quite easily, because many apps
> access directly via control API (even some mixer apps), and they
> likely change only raw values.  The similar situation is for kernel
> OSS emulation.

I have basically two ideas to handle this.

1) create a plugin system directly in the snd_ctl_* interface

   - basically code might be very same code as you proposed in kernel

2) create virtual things only in smixer

   - it's something I strongly prefer
   - if mixers uses CTL interface, it's not our bussiness because
     we haven't claimed to create virtual layers in CTL

> 3. Complicated configuration
> 
> The requirement of virtual master controls is very much dependent on
> the hardware.  In the case of HD-audio, it depends on codec chip
> types, and even on the preset model chosen via PCI SSID or a module
> option.  Implementing such a complex conditional in alsa-lib
> configuration is a clear overhead.

I don't agree much here. Of course, we might need some hints from the 
driver (using information about components in sndrv_ctl_card_info) or we 
might analyze available controls using their names if Master control is 
present or we can eventually create a configuration tool saving hints to 
alsa-lib's configuration files which controls should be added for given 
hardware (this configuration tool might create a list of useable PCM 
devices handled in the driver, too). Just idea.

> 4. More resource requirement
> 
> Clearly a user-space solution requires more layers in alsa-lib, which
> is invoked by each process, and even more memory footprint than the
> kernel solution, not only the additional complexity.
> 
> 
> ... and think again what is the benifit of the user-space solution in
> this case, in comparison with the demerits above.

The benefit is flexibility for future extensions.

> If you could implement the same feature on user-space with less amount
> of codes, I'd happily take it.  But, I'm sure it's very hard.

The question is also how to behave in future and if we should allow to 
break our basic rule in the current ALSA design - everything that can be
moved to user space will be moved to user space.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
