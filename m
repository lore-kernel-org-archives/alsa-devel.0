From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: ATI Technologies Inc SBx00 Azalia
Date: Fri, 11 Jan 2008 17:34:11 +0100
Message-ID: <d9def9db0801110834j58f3e3d6j68eff3b38a4ffc56@mail.gmail.com>
References: <d9def9db0801110647s2f9005bbi977e1f5a981b4fdf@mail.gmail.com>
	<s5h8x2w8kbe.wl%tiwai@suse.de>
	<d9def9db0801110811k585405d5g78088c68ec2dff01@mail.gmail.com>
	<s5h3at4mj0v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 30AEB245C3
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 17:34:12 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so831424rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 08:34:11 -0800 (PST)
In-Reply-To: <s5h3at4mj0v.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jan 11, 2008 5:20 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 11 Jan 2008 17:11:56 +0100,
>
> Markus Rechberger wrote:
> >
> > Hi Takashi,
> >
> > On Jan 11, 2008 4:15 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Fri, 11 Jan 2008 15:47:56 +0100,
> > > Markus Rechberger wrote:
> > > >
> > > > Hi,
> > > >
> > > > there seems to be an issue with this ATI SBx00 Azalia driver.
> > >
> > > It's rather about the codec than the controller.
> > >
> > > > nmixer (which uses the oss emulated interface shows up 4 controls)
> > > > Vol (volume which seems to control the whole output volume)
> > > > PCM2 (maybe not routed on that notebook, it practically has no effect)
> > > > IGain (guess for the microphone which I haven't tested yet)
> > > > Digital1 (don't know)
> > > >
> > > > if I try to start alsamixer, it doesn't seem to work and I get an
> > > > entry in dmesg whenever I try to run it:
> > > > $ alsamixer
> > > > alsamixer: function snd_mixer_load failed: Invalid argument
> > > >
> > > > $ dmesg
> > > > ...
> > > > [ 1269.997724] hda_codec: num_steps = 0 for NID=0x12
> > >
> > > Looks like the invalid access to HD-audio codec occurs.
> > > Since it's an unknown device, the driver tries to probe the BIOS
> > > setting.  Maybe there is some bug there.
> > >
> > > Anyway, try the latest ALSA HG version if you still didn't.  There
> > > are some recent fixes regarding the realtek auto-probe routine.
> > >
> >
> > I'm using the latest one.
> >
> > > Also, use the patch below.  This will show which control element is
> > > affected.
> > >
> >
> > [   39.753443] hda_codec: Unknown model for ALC262, trying auto-probe
> > from BIOS...
> > [   39.754025] ALSA /devel/alsa/alsa-driver/pci/hda/hda_codec.c:2855:
> > autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
> > [   39.754029] ALSA /devel/alsa/alsa-driver/pci/hda/hda_codec.c:2859:
> >   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> > [   39.754032] ALSA /devel/alsa/alsa-driver/pci/hda/hda_codec.c:2863:
> >   hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> > [   39.754035] ALSA /devel/alsa/alsa-driver/pci/hda/hda_codec.c:2871:
> >   inputs: mic=0x12, fmic=0x18, line=0x0, fline=0x0, cd=0x0, aux=0x0
> > [   39.828608] hda_codec: num_steps = 0 for NID=0x12 (ctl = Mic Boost)
> > [   40.497040] hda_codec: num_steps = 0 for NID=0x12 (ctl = Mic Boost)
> > [   40.500522] hda_codec: num_steps = 0 for NID=0x12 (ctl = Mic Boost)
> > [   40.504570] hda_codec: num_steps = 0 for NID=0x12 (ctl = Mic Boost)
> > [   40.508863] hda_codec: num_steps = 0 for NID=0x12 (ctl = Mic Boost)
> > [   40.513168] hda_codec: num_steps = 0 for NID=0x12 (ctl = Mic Boost)
>
> Ah, so your machine uses the digital-mic for the mic input.  That's
> new.
>
> Does the patch below fix the problem?
>

yes, it fixed the problem!

thanks alot,
Markus
