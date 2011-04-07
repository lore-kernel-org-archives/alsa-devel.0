From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Thu, 7 Apr 2011 09:53:06 +0800
Message-ID: <BANLkTinSpX+EOs2EMTxTpwKKk4sm89Q_LA@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTim1wU9RBpZ3As9uxb=YEXWVST1FVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D3DD10387D
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 03:53:08 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1526526fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 06 Apr 2011 18:53:06 -0700 (PDT)
In-Reply-To: <BANLkTim1wU9RBpZ3As9uxb=YEXWVST1FVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Valerio tesei <valerio.tesei@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/4/6 Valerio tesei <valerio.tesei@gmail.com>

> Sorry for the intrusion,
>
> I've a P7H55D-M Pro motherboard with an hda-intel realtek card (ALC892) i
> open a ticket in alsa bugtracker and Raymond says me to post here.
> My motherboard had 6 pinjack behind and optical output on it, from the
> specification page on asus (
> http://uk.asus.com/product.aspx?P_ID=qWmZUAdNKeozTOXb&templete=2 )
>
> Realtek ALC892 8-Channel High Definition Audio CODEC
> - BD Audio Layer Content Protection
> - Support Jack-dectection, Multi-streaming,Front Panel Jack-Retasking (Mic
> in port)
> - ASUS Noise Filter
> - Optical S/PDIF out ports at back I/O
>
> From 2.6.38 kernel i've got a lot of problems with it, sound cracky,
> microphone doesnt work or work badly, no sound after a random time of use
> and some other problems.
> I'm now using 2.6.39-rc1 with kernel distribuited alsa build-in with
> kernel,
>
> About my bios config
> [Front Panel] = AC97
> [SPDIF OUT] = SPDIF
>
> my latest alsa info is http://valeriotesei.com/alsa/alsainfo
>
> Link to ticket (to see my discussion with Raymond)
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5331
>
> Let me know if i could help in some way, i'm not so skilled to help with
> source code, but i could be a beta tester.
>
> Sorry if i'm off-topic.
>
> Hope this will help you.
>
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
> > Takashi
> >


http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=1304ac8993e32c0530bc82bf1d3f953548a20971

I guess the driver still need to provide init_verbs for alc892 for the side
channel mixer 0x0f since alc662_parse_auto_config() use different init_verbs
for different codec

especially alc662_init_verbs

send: NID=0x15, VERB=0x70c(set_eapd_btl), PARM=0x2
EAPD command to non-capable pin 0x15
