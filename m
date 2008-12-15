From: "Mark Jenks" <mjenks1968@gmail.com>
Subject: Trying to figure out what went wrong with my HDMI.
Date: Mon, 15 Dec 2008 09:42:08 -0600
Message-ID: <e5df86c90812150742l71fcdccdp6c8b4ce51a02155d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16])
	by alsa0.perex.cz (Postfix) with ESMTP id E9A4B1037ED
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 16:42:10 +0100 (CET)
Received: by gxk9 with SMTP id 9so2697240gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 07:42:09 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a M3N78 Pro motherboard, and am running alsa 1.0.18a on it.

I had HDMI audio working on it, but for some reason it has stopped.  I
really didn't change too much about the computer, other then take out a
hvr-1800, and put in a hvr-1600.   I did try to go up to .27 kernel, but had
other problems and went back to .26.   Recompiled alsa 1.0.18a and even
tried multiple versions of the nvidia drivers.  (173, 177)..     And now I
have just tried the snapshot with the same results.

I believe it was recognised as a ALC883 before, and not is is a ALC1200, but
I'm not completely sure about it.

Help!  :)

-Mark

aplay -l shows:

card 0: NVidia [HDA NVidia], device 0: ALC1200 Analog [ALC1200 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: ALC1200 Digital [ALC1200 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

So, everything looks good there.

If I try and do an aplay, I get.

#aplay -D hw:0,3 /usr/share/sounds/alsa/Noise.wav
Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little
Endian, Rate 48000 Hz, Mono
aplay: set_params:966: Channels count non available

I noticed that I am missing hdmi in my aplay -L.   When it worked, it was
there.

# aplay -L
front:CARD=NVidia,DEV=0
    HDA NVidia, ALC1200 Analog
    Front speakers
surround40:CARD=NVidia,DEV=0
    HDA NVidia, ALC1200 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=NVidia,DEV=0
    HDA NVidia, ALC1200 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=NVidia,DEV=0
    HDA NVidia, ALC1200 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=NVidia,DEV=0
    HDA NVidia, ALC1200 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=NVidia,DEV=0
    HDA NVidia, ALC1200 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=NVidia,DEV=0
    HDA NVidia, ALC1200 Digital
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
default
    Default
