From: "Nir Tzachar" <nir.tzachar@gmail.com>
Subject: Nvidia hdmi problems
Date: Mon, 20 Oct 2008 16:35:01 +0200
Message-ID: <9b2db90b0810200735g61cad43dr538c3afc495398ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id A9D5A2454A
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 16:35:20 +0200 (CEST)
Received: by gxk10 with SMTP id 10so3642502gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 07:35:02 -0700 (PDT)
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
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hello,

I have been trying to get audio through hdmi to work for some time
now. I have cloned the sound-2.6 repository to get the latest drivers,
which should support hdmi, AFAIK.

Motherboard is Gigabyte GA-73PVM-S2H, with nforce 630i and realtek alc889a.

aplay lists the hdmi device:

> aplay -L
default:CARD=NVidia
    HDA NVidia, ALC885 Analog
    Default Audio Device
front:CARD=NVidia,DEV=0
    HDA NVidia, ALC885 Analog
    Front speakers
surround40:CARD=NVidia,DEV=0
    HDA NVidia, ALC885 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=NVidia,DEV=0
    HDA NVidia, ALC885 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=NVidia,DEV=0
    HDA NVidia, ALC885 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=NVidia,DEV=0
    HDA NVidia, ALC885 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=NVidia,DEV=0
    HDA NVidia, ALC885 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=NVidia,DEV=0
    HDA NVidia, ALC885 Digital
    IEC958 (S/PDIF) Digital Audio Output
hdmi:CARD=NVidia,DEV=0
    HDA NVidia
    HDMI Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)

but,
> aplay -D hdmi test.wav
aplay: main:583: audio open error: No such file or directory

fails when trying to open /dev/snd/pcmC0D3p

only the following devices exists:
/dev/snd/seq
/dev/snd/controlC0
/dev/snd/pcmC0D0c
/dev/snd/pcmC0D0p
/dev/snd/pcmC0D1c
/dev/snd/pcmC0D1p
/dev/snd/pcmC0D2c
/dev/snd/timer

I am using alsa-lib and alsa-utils 1.0.17 .

Does anyone have an idea?

Thanks.
