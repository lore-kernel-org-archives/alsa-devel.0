From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise on snd-hda-intel
Date: Mon, 4 Jul 2011 13:20:26 +0800
Message-ID: <CAN8cciZowuMyXhzzvW-dUKodXWw0+8ntYR3R70F76DDCCsNzTw@mail.gmail.com>
References: <4E00F373.6050001@molgaard.org> <4E00F41E.5090303@molgaard.org>
	<1308691120.6844.1.camel@mattotaupa>
	<4E01A8FA.8060709@molgaard.org>
	<BANLkTimWWvc8t9G91u4f6yUzm4fRAitx0w@mail.gmail.com>
	<4E044C98.8060509@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 9B844243C1
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 07:20:27 +0200 (CEST)
Received: by fxh2 with SMTP id 2so5261284fxh.9
	for <alsa-devel@alsa-project.org>; Sun, 03 Jul 2011 22:20:26 -0700 (PDT)
In-Reply-To: <4E044C98.8060509@molgaard.org>
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

2011/6/24 Sune M=F8lgaard <sune@molgaard.org>:


Refer to patch eb541337b7a43822fce7d0c9d967ee149b2d9a96

"ALSA: hda - Make converter setups sticky"

The patch create an array of 8 elements for converter caches but there
are more than 8 converters in ad1988/ad1989

5 analog Audio Output + 3 analog Audio Input + Digital Audio Output +
DIgital Input


+       snd_array_init(&codec->cvt_setups, sizeof(struct hda_cvt_setup), 8);


>>
>> Is this a clean install of 11.4 or upgrade from previous version of
>> ubuntu which use "default:2" and create "Digital Capture Volume" ?
>
> It is an upgrade.


!!Modprobe options (Sound related)
!!--------------------------------

snd-usb-audio: index=3D-2
snd_hda_intel: model=3D6stack enable=3D1 index=3D0

Seem those snd-usb-audio are loaded before snd-hda-intel and that's
why your onboard become card 2 instead of card 0


>
>> since pulseaudio use "front:2" for playback and capture and this won't
>> create "digital capture volume" control
>
> How to remedy?

Are you upgarded from version which use dmix/dsnoop ?

or the "Digital Capture Volume" control is created when  remove
alsa-pulse-plugin

There are three capture subdevices since ad1988/ad1989 have 3 [Audio Input]

when application using dsnoop which use subdevice 0 by default

However for PA server release the capture device after probe
so it is possible that other application (e.g. arecord ) can open subdevice=
 0

PA server will open the next available subdevice

https://qa.mandriva.com/show_bug.cgi?id=3D52175


card 2: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2



Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 48 [89%] [13.50dB] [on]
  Front Right: Capture 48 [89%] [13.50dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 0 [0%] [-58.50dB] [off]
  Front Right: Capture 0 [0%] [-58.50dB] [off]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 0 [0%] [-58.50dB] [off]
  Front Right: Capture 0 [0%] [-58.50dB] [off]
