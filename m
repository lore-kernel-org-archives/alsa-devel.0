From: Valerio tesei <valerio.tesei@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Fri, 8 Apr 2011 10:38:07 +0200
Message-ID: <BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B42B1103A7E
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 10:38:08 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2473689fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 01:38:08 -0700 (PDT)
In-Reply-To: <BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

I spent a little time reading sound documentation but doesn't find anything
about how to apply a patch to snd-hda-intel, but it is needed? there is no
an "patch auto detect"? i enable the patch option in HDA-Intel kernel
config, this WE i will study more, Takashi could you please give me
documentation about patch applying?

About the NVIDIA video card, do you think that the hdmi on NVIDIA could
conflicts with the one in motherboard, creating the problem that I'm
experiencing?
I didn't check anything on kernel regarding HDMI, and i use an "edited"
NVIDIA driver (by me) to build against 2.6.39 (only rename smp_lock.h to
smp.h in the code) version is 270, taken from gentoo repos.

To clarify my self
- I *need* to apply alc662 patch to snd-hda-intel to test if commits work?
- I *need* to solve problems with NVIDIA drivers to make my sound card work?
(and if i must specify witch port nvidia must use how i could do that?)
- alsaconf doesn't find my sound card, even when it works (crackly but
works) is this problem linked to capture streams problems ?


Some news:
- after module loading I hear a big noise
- after upgrade to Takashi's sound-2.6 kernel tree, i hear dx louder than sx
- some times the sounds mute, after 7/10 seconds sound come back (no changes
in alsamixer)

I know that I'm completely usefulness and a little bit annoying, I'm reading
about alsa devel but I gess is a little bit hard for me.

V.

2011/4/8 Raymond Yau <superquad.vortex2@gmail.com>

> 2011/4/6 Takashi Iwai <tiwai@suse.de>
>
> > At Wed, 6 Apr 2011 16:29:56 +0800,
> > Raymond Yau wrote:
> > >
> > > 2011/4/6 Takashi Iwai <tiwai@suse.de>
> > >
> > > > At Wed, 6 Apr 2011 15:35:16 +0800,
> > > > Raymond Yau wrote:
> > > > >
> > > > > 2011/4/6 Takashi Iwai <tiwai@suse.de>
> > > > >
> > > > > > At Tue, 5 Apr 2011 22:59:29 +0800,
> > > > > > Raymond Yau wrote:
> > > > > > >
> > > > > > > Fix alc662_dac_nid and change "6stack-dig" to "5stack-dig"
> > > > > > >
> > > > > > > alc662 series only have 3 stereo DAC , so it can only support
> > > > 5stack-dig
> > > > > > > instead of 6stack-dig
> > > > > >
> > > > > > Applied now.  Thanks.
> > > > > >
> > > > > >
> > > > > > Takashi
> > > > > >
> > > > >
> > > > > The other problem is this patch
> > > > >
> > > > >    { .id = 0x10ec0892, .name = "ALC892", .patch = patch_alc662 },
> > > > >
> > > > >
> > > >
> >
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=274693f37090ada2cadd09944ab883f05ea6ebe6
> > > > >
> > > > > ALC892 provides ten DAC channels that simultaneously support 7.1
> > channel
> > > > > sound playback, plus 2 channels of independent stereo sound output
> > > > (multiple
> > > > > streaming) through the front panel stereo outputs.
> > > > >
> > > > > It seem  that there is no specific code to distinguish a 10
> channels
> > > > alc892
> > > > > from those 6 channels alc6xx
> > > >
> > > > Yeah, but there is no quirks specific to alc892.
> > > >
> > > > Remember that the final goal is to remove all model-quirks from the
> > > > driver.
> > > >
> > > >
> > > > Takashi
> > > >
> > >
> > > My patch reduce the size of alc662_dac_nid may be wrong if the driver
> > intend
> > > to use  alc662_auto_fill_dac_nids()  to handle 6, 8 , 10 channels
> >
> > Don't worry, alc662_dac_nids is used only for the fixed quirks.
> > The auto-parser doesn't use these fixed defined pin arrays.
> >
> >
> >
> I wonder why a motherboard with 5 audio jacks on rear panel need
> alc662_5stack_modes since it already have enough jacks for surround51 and
> don't need any retasking
>
> static struct hda_channel_mode alc662_5stack_modes[2] = {
>       { 2, alc662_sixstack_ch6_init },
>       { 6, alc662_sixstack_ch8_init },
> };
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
