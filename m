From: Tomas Black <tomas.black@gmail.com>
Subject: 2.1 audio not working in Kubuntu 13.10
Date: Wed, 2 Apr 2014 15:44:52 -0300
Message-ID: <CAL8wzGRtAVhL2dioHRL-7rtZjSCRduBfWpdpZHTxEnp22i=ftA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id BB185265164
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 20:45:14 +0200 (CEST)
Received: by mail-pd0-f178.google.com with SMTP id x10so573276pdj.37
 for <alsa-devel@alsa-project.org>; Wed, 02 Apr 2014 11:45:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear friends,


I have a Dell L702X laptop which comes with a 2.1 sound configuration - 2
speakers + subwoofer from JBL. Sound is suberb in Windows, but  I can't get
the subwoofer to work in Linux!


Here's the information I think you need:


&&&&&@dell-xps:~$ aplay -l
**** Lista de Dispositivos PLAYBACK Hardware ****
placa 0: PCH [HDA Intel PCH], dispositivo 0: ALC665 Analog [ALC665 Analog]
  Dispositivo secund=E1rio: 1/1
  Dispositivo secund=E1rio #0: subdevice #0
placa 0: PCH [HDA Intel PCH], dispositivo 1: ALC665 Digital [ALC665 Digital]
  Dispositivo secund=E1rio: 1/1
  Dispositivo secund=E1rio #0: subdevice #0
placa 0: PCH [HDA Intel PCH], dispositivo 3: HDMI 0 [HDMI 0]
  Dispositivo secund=E1rio: 1/1
  Dispositivo secund=E1rio #0: subdevice #0




#######@dell-xps:~$ aplay -L
default
    Playback/recording through the PulseAudio sound server
sysdefault:CARD=3DPCH
    HDA Intel PCH, ALC665 Analog
    Default Audio Device
front:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    Front speakers
surround40:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Digital
    IEC958 (S/PDIF) Digital Audio Output
hdmi:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, HDMI 0
    HDMI Audio Output
dmix:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    Direct sample mixing device
dmix:CARD=3DPCH,DEV=3D1
    HDA Intel PCH, ALC665 Digital
    Direct sample mixing device
dmix:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Direct sample mixing device
dsnoop:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    Direct sample snooping device
dsnoop:CARD=3DPCH,DEV=3D1
    HDA Intel PCH, ALC665 Digital
    Direct sample snooping device
dsnoop:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Direct sample snooping device
hw:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    Direct hardware device without any conversions
hw:CARD=3DPCH,DEV=3D1
    HDA Intel PCH, ALC665 Digital
    Direct hardware device without any conversions
hw:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Direct hardware device without any conversions
plughw:CARD=3DPCH,DEV=3D0
    HDA Intel PCH, ALC665 Analog
    Hardware device with all software conversions
plughw:CARD=3DPCH,DEV=3D1
    HDA Intel PCH, ALC665 Digital
    Hardware device with all software conversions
plughw:CARD=3DPCH,DEV=3D3
    HDA Intel PCH, HDMI 0
    Hardware device with all software conversions





))))))))@dell-xps:~$ lspci -v | grep -A7 -i audio
00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family
High Definition Audio Controller (rev 05)
        Subsystem: Dell Device 04b8
        Flags: bus master, fast devsel, latency 0, IRQ 54
        Memory at f3c00000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: <access denied>
        Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family
PCI Express Root Port 1 (rev b5) (prog-if 00 [Normal decode])





^^^^^^@dell-xps:~$ cat /proc/asound/card0/codec* | grep Codec
Codec: Realtek ALC665
Codec: Intel CougarPoint HDMI








I've installed Realtek audio drivers and pretty much tried all tweaks on
alsa .conf files a pulse .conf files.


As I said, currently the stereo sound is good on both speakers, but how can
I get the subwoofer to work?

THanks a million in advance,



Tomas
