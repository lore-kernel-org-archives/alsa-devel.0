From: Raymond Jennings <shentino@gmail.com>
Subject: possible bug: input and output devices are getting
	mixed up
Date: Sun, 15 Apr 2018 18:22:56 -0700
Message-ID: <CAGDaZ_pcwGbsoqb6YCYKJ3GFdyfHJ3MeA2mGuBQiZbpfnQV0OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A03AD267168
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 03:23:39 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id x9-v6so13083499oig.7
 for <alsa-devel@alsa-project.org>; Sun, 15 Apr 2018 18:23:39 -0700 (PDT)
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

I used arecord -L to list some things, and I got weird results, saying
among other things that my webcam was capable of surround sound output
even though it's strictly an input device.

I already reported it downstream with my distro but so far no news.

I was told it was a bug with alsa.

As for the card in question, U0x46d0x825 is my logitech brand webcam
connected via USB.

$ arecord -L

null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
sysdefault:CARD=PCH
    HDA Intel PCH, ALC887-VD Analog
    Default Audio Device
front:CARD=PCH,DEV=0
    HDA Intel PCH, ALC887-VD Analog
    Front speakers
sysdefault:CARD=U0x46d0x825
    USB Device 0x46d:0x825, USB Audio
    Default Audio Device
front:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    Front speakers
surround21:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    2.1 Surround output to Front and Subwoofer speakers
surround40:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=U0x46d0x825,DEV=0
    USB Device 0x46d:0x825, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
