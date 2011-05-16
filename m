From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALC892 Support (Intel HDA) - HDMI
Date: Mon, 16 May 2011 11:45:33 +0800
Message-ID: <BANLkTikseuwof1PXqyw1mk928JPWT1TqWA@mail.gmail.com>
References: <F8FDC04B-B0AC-48F8-A6FB-E533F1931DC7@gmail.com>
	<BANLkTinGpqJc9Pnr5rn-NqR6aztr2nv1bA@mail.gmail.com>
	<A90C44D0-5C9F-4B97-BEE8-2EBBB5EAFFED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id C2AA124154
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 05:45:48 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3106907fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 20:45:48 -0700 (PDT)
In-Reply-To: <A90C44D0-5C9F-4B97-BEE8-2EBBB5EAFFED@gmail.com>
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

2011/5/16 Jeremy Bush <contractfrombelow@gmail.com>

> >> However, it seems that the ALSA drivers (even the ones from the realtek
> >> website) limit the output to 2 channels, 16bit, 88.2KHz.
> >>
> >> Here is my system information that you can see these results:
> >>
> >>
> http://www.alsa-project.org/db/?f=5b55a63fea6580dfcbf1a85c7c734f977df798f1
> >>
> >> I see the ALC892 as being supported in the ALSA changelog, but I don't
> see
> >> any model options in Documentation/HD-Audio-Models.txt. I'm currently
> using
> >> "options snd-hda-intel model=6stack-digout" (as I have 6-jack with a
> SPDIF
> >> out on the motherboard) but I'm not sure that is actually doing
> anything.
> >>
> >>
> > As your codec info does not have "Side Playback Channel" and "Side
> Playback
> > Switch", it look like the model is used for 5stack motherboard which
> support
> > 5.1
> >
> > Do you hear any noise since Valerio reported noise appear when using the
> > model=auto in
> >
> > http://thread.gmane.org/gmane.linux.alsa.devel/84653/focus=84724
>
> I'm not actually trying to get analog working or the front-panel output.
> Only surround sound over HDMI. I have tried model=auto and didn't notice
> anything different than specifying the model.
>
> >> Is what I'm getting now the best I should expect over HDMI? I saw
> support
> >> in ALSA and bought the motherboard expecting it to be fully supported
> since
> >> the changelogs say support was added.
> >
> > Codec: Intel CougarPoint HDMI
> >
> > Address: 3
> > AFG Function Id: 0x1 (unsol 0)
> > Vendor Id: 0x80862805
> > Subsystem Id: 0x80862805
> > Revision Id: 0x100000
> > No Modem Function Group found
> >
> > Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
> >
> >  Control: name="IEC958 Playback Con Mask", index=1, device=0
> >  Control: name="IEC958 Playback Pro Mask", index=1, device=0
> >  Control: name="IEC958 Playback Default", index=1, device=0
> >  Control: name="IEC958 Playback Switch", index=1, device=0
> >  Device: name="HDMI 0", type="HDMI", device=3
> >  Converter: stream=8, channel=0
> >  Digital: Enabled
> >  Digital category: 0x0
> >  PCM:
> >    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
> >    bits [0x1e]: 16 20 24 32
> >    formats [0x5]: PCM AC3
> >  Power states:  D0 D3 EPSS
> >  Power: setting=D0, actual=D0
> >
> > Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
> >  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> >  Amp-Out vals:  [0x00 0x00]
> >  Pincap 0x09000094: OUT Detect HBR HDMI DP
> >  Pin Default 0x18560020: [Jack] Digital Out at Int HDMI
> >    Conn = Digital, Color = Unknown
> >    DefAssociation = 0x2, Sequence = 0x0
> >  Pin-ctls: 0x40: OUT
> >  Unsolicited: tag=06, enabled=1
> >  Power states:  D0 D3 EPSS
> >  Power: setting=D0, actual=D0
> >  Connection: 1
> >     0x03
>
> So this seems to say I should be getting 7.1 over the HDMI output. What do
> I need to change in my config to actually get it? I tried messing around
> with /sys/class/sound/hwC1D3/user_pin_configs but I'm not sure what to
> change.
>
>
Do your hdmi monitor support 7.1 ?

[ 2.090473] HDMI: detected monitor at connection type HDMI
[    2.090475] HDMI: available speakers: FL/FR
[    2.090477] HDMI: supports coding type LPCM: channels = 2, rates =
44100 48000 88200, bits = 16
[    2.090480] HDMI hot plug event: Pin=6 Presence_Detect=1 ELD_Valid=1
