From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Fri, 8 Apr 2011 08:48:36 +0800
Message-ID: <BANLkTinMvtTpDs54dWzrbyUH9ee+7PkE7A@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTim1wU9RBpZ3As9uxb=YEXWVST1FVw@mail.gmail.com>
	<BANLkTinSpX+EOs2EMTxTpwKKk4sm89Q_LA@mail.gmail.com>
	<BANLkTi=D1AX9b-kU6oZv+F0aWa0fGcuNtg@mail.gmail.com>
	<BANLkTikorXUoaGiJ94i_syzfN-0Oy98tzw@mail.gmail.com>
	<4D9E1428.1080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4936C24362
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 02:48:37 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2297316fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2011 17:48:37 -0700 (PDT)
In-Reply-To: <4D9E1428.1080702@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/4/8 Valerio Tesei <valerio.tesei@gmail.com>

> I checkout the takashi kernel tree, selected hda-intel and alsa as
> module and reboot.
>
> After probe i get these debug http://pastebin.com/7hGVe4U3 with (i
> think) useful informations about,
>
> Looking for the ioremap that Raymond ask about i found :
>
> [ 1048.230360] nvidia: module license 'NVIDIA' taints kernel.
> [ 1048.230363] Disabling lock debugging due to kernel taint
> [ 1048.664298] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) ->
> IRQ 16
> [ 1048.664304] nvidia 0000:01:00.0: setting latency timer to 64
> [ 1048.664308] vgaarb: device changed decodes:
> PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
> [ 1048.664529] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  270.18
> Tue Jan 18 21:46:26 PST 2011
> [ 1048.866318] ioremap error for 0xdde70000-0xdde71000, requested 0x10,
> got 0x0
>
> So i could say that ioremap is about nvidia, do you?
>

Since your motheboard have hdmi port , you will need to find out whether
hdmi port is belonged to nvidia graphic

http://thread.gmane.org/gmane.linux.alsa.devel/81856



> This is my latest alsa-info
> http://www.alsa-project.org/db/?f=184ce71bf28e38656c1a31a607f9c38c396808a3
>
> Dont care about "failed to load firmware bla bla bla" i found wrong
> google informations about it :)
>
>
It seem that you don't know how to apply patch

you may need to ask Takashi



As for the capture device and two set of capture controls


    spec->stream_analog_playback = &alc662_pcm_analog_playback;
    spec->stream_analog_capture = &alc662_pcm_analog_capture;

+        if (codec->vendor_id == 0x10ec0892)
+               spec->stream_analog_alt_capture =
&alc880_pcm_analog_alt_capture;
