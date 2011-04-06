From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Wed, 6 Apr 2011 16:29:56 +0800
Message-ID: <BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0403A1037EE
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 10:29:56 +0200 (CEST)
Received: by fxm5 with SMTP id 5so906300fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 06 Apr 2011 01:29:56 -0700 (PDT)
In-Reply-To: <s5hy63nq12a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/6 Takashi Iwai <tiwai@suse.de>

> At Wed, 6 Apr 2011 15:35:16 +0800,
> Raymond Yau wrote:
> >
> > 2011/4/6 Takashi Iwai <tiwai@suse.de>
> >
> > > At Tue, 5 Apr 2011 22:59:29 +0800,
> > > Raymond Yau wrote:
> > > >
> > > > Fix alc662_dac_nid and change "6stack-dig" to "5stack-dig"
> > > >
> > > > alc662 series only have 3 stereo DAC , so it can only support
> 5stack-dig
> > > > instead of 6stack-dig
> > >
> > > Applied now.  Thanks.
> > >
> > >
> > > Takashi
> > >
> >
> > The other problem is this patch
> >
> >    { .id = 0x10ec0892, .name = "ALC892", .patch = patch_alc662 },
> >
> >
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=274693f37090ada2cadd09944ab883f05ea6ebe6
> >
> > ALC892 provides ten DAC channels that simultaneously support 7.1 channel
> > sound playback, plus 2 channels of independent stereo sound output
> (multiple
> > streaming) through the front panel stereo outputs.
> >
> > It seem  that there is no specific code to distinguish a 10 channels
> alc892
> > from those 6 channels alc6xx
>
> Yeah, but there is no quirks specific to alc892.
>
> Remember that the final goal is to remove all model-quirks from the
> driver.
>
>
> Takashi
>

My patch reduce the size of alc662_dac_nid may be wrong if the driver intend
to use  alc662_auto_fill_dac_nids()  to handle 6, 8 , 10 channels
