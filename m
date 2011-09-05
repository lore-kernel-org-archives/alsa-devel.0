From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Help With Getting Line-in monitoring working
Date: Mon, 5 Sep 2011 16:16:54 +0800
Message-ID: <CAN8cciZS0wxW+MJgERzSYBW4_JKen13UEjwT-SQ10OV9WOWKpQ@mail.gmail.com>
References: <alpine.BSF.2.00.1109050127250.10767@bas.flux.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 75ECD1038BE
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 10:16:55 +0200 (CEST)
Received: by fxh10 with SMTP id 10so3398646fxh.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Sep 2011 01:16:54 -0700 (PDT)
In-Reply-To: <alpine.BSF.2.00.1109050127250.10767@bas.flux.utah.edu>
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

2011/9/5 Kevin Atkinson <kevina@gnu.org>:
> Hi,
>
> I need some help getting my cards line-in monitoring working. =A0That is
> analog pass-through from line-in to headphone out.
>
> I am using Ubuntu 10.04 with Linux kernel Linux Intel 2.6.38-10 (Ubuntu
> package). =A0I am using on-board audio with HDA-Intel with the Realtek AL=
C892
> codec.
>
> With the stock Ubuntu kernel (lets call this setup "stable") I can't get
> line-in monitoring working (note however I can record from line in, I just
> can't get the analog pass-through working). =A0However, when I install the
> latest ALSA drivers (lets call this setup "soso") (recompiled a source
> package from the Ubuntu-audio-dev ppa, head 7c48f32b). I can get Line-in
> monitoring but the mixer controls are all mixed up. =A0The Line-in control
> controls the Line-in volume, but the master control has no effect. =A0Als=
o,
> the PCM control has no effect on PCM volume and the front control controls
> the output to the headphone but in order to mute the headphone
> I still need to use the headphone mute. =A0The mixer work correctly with =
the
> stable setup.
>
> Thus I am lead to the conclusion that the latest ALSA drivers are doing
> something right with line-in but getting a lot of other things wrong.
>

connect node 0x1b  HP to 0x02 instead of 0x26, you will unable to use
the headphone playback volume at 0x25


 Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
+  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
+    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
@@ -436,11 +444,11 @@
     Conn =3D 1/8, Color =3D Green
     DefAssociation =3D 0x2, Sequence =3D 0x0
   Pin-ctls: 0xc0: OUT HP VREF_HIZ
-  Unsolicited: tag=3D00, enabled=3D0
+  Unsolicited: tag=3D04, enabled=3D1
   Power states:  D0 D1 D2 D3 EPSS
   Power: setting=3DD0, actual=3DD0
   Connection: 5
-     0x0c 0x0d 0x0e 0x0f 0x26*
+     0x0c* 0x0d 0x0e 0x0f 0x26




Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=3D5, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x25 0x0b


[    6.272032] snd: bad kfree (called from f87381e3)
--
[    6.272043]  [<f85612b1>] ? snd_hidden_kfree+0x91/0xa0 [snd]
[    6.272048]  [<f87381e3>] ? snd_array_free+0x13/0x30 [snd_hda_codec]
[    6.272052]  [<f87381e3>] ? snd_array_free+0x13/0x30 [snd_hda_codec]
[    6.272057]  [<f87abfaf>] ? alc_free_kctls+0x4f/0x60 [snd_hda_codec_real=
tek]
[    6.272061]  [<f87affed>] ? alc_build_controls+0x44d/0x4b0
[snd_hda_codec_realtek]
[    6.272066]  [<f873c4a5>] ? snd_hda_codec_build_controls+0x45/0x50
[snd_hda_codec]
[    6.272071]  [<f873c4df>] ? snd_hda_build_controls+0x2f/0x90 [snd_hda_co=
dec]
[    6.272074]  [<f857651d>] ? azx_probe+0xc5c/0x173f [snd_hda_intel]
[    6.272078]  [<f8575590>] ? azx_send_cmd+0x0/0x2a0 [snd_hda_intel]
[    6.272080]  [<f85752b0>] ? azx_get_response+0x0/0x2e0 [snd_hda_intel]
[    6.272083]  [<f8574660>] ? azx_attach_pcm_stream+0x0/0x1b0 [snd_hda_int=
el]
[    6.272086]  [<f8574300>] ? azx_bus_reset+0x0/0x70 [snd_hda_intel]
[    6.272088]  [<f8573ff0>] ? azx_power_notify+0x0/0xa0 [snd_hda_intel]
[    6.272092]  [<c129b807>] ? local_pci_probe+0x47/0xb0
--
[    6.272116]  [<c129c935>] ? __pci_register_driver+0x45/0xb0
[    6.272119]  [<f8542017>] ? alsa_card_azx_init+0x17/0x1000 [snd_hda_inte=
l]
[    6.272122]  [<c1003045>] ? do_one_initcall+0x35/0x170
[    6.272125]  [<f8542000>] ? alsa_card_azx_init+0x0/0x1000 [snd_hda_intel]
[    6.272129]  [<c108f32b>] ? sys_init_module+0xdb/0x230
--
[    6.272136]  [<c100a99f>] ? sysenter_do_call+0x12/0x28


Take a diff of your alsa-info,

"Side Playback Volume" and "auto-mute mode"


 !!Amixer output
 !!-------------
@@ -649,8 +658,8 @@
 Card hw:0 'Intel'/'HDA Intel at 0xf7ef4000 irq 42'
   Mixer name	: 'Intel IbexPeak HDMI'
   Components	: 'HDA:10ec0892,10438436,00100302 HDA:80862804,80860101,00100=
000'
-  Controls      : 37
-  Simple ctrls  : 20
+  Controls      : 40
+  Simple ctrls  : 22
 Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
   Playback channels: Mono
@@ -708,6 +717,13 @@
   Playback channels: Mono
   Limits: Playback 0 - 64
   Mono: Playback 0 [0%] [-64.00dB] [off]
+Simple mixer control 'Side',0
+  Capabilities: pvolume pswitch penum
+  Playback channels: Front Left - Front Right
+  Limits: Playback 0 - 64
+  Mono:
+  Front Left: Playback 0 [0%] [-64.00dB] [on]
+  Front Right: Playback 0 [0%] [-64.00dB] [on]
 Simple mixer control 'Line',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
@@ -739,6 +755,10 @@
   Limits: Capture 0 - 46
   Front Left: Capture 19 [41%] [3.00dB] [off]
   Front Right: Capture 19 [41%] [3.00dB] [off]
+Simple mixer control 'Auto-Mute Mode',0
+  Capabilities: enum
+  Items: 'Disabled' 'Enabled'
+  Item0: 'Enabled'
 Simple mixer control 'Digital',0
   Capabilities: cvolume penum
   Capture channels: Front Left - Front Right
