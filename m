From: Scott Doty <scott@ponzo.net>
Subject: Re: SPDIF trouble with multiple usb devices
Date: Thu, 14 Apr 2016 18:02:23 -0700
Message-ID: <57103D9F.9080803@ponzo.net>
References: <570D7676.1060004@ponzo.net>
 <alpine.DEB.2.02.1604131128080.9999@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 605D0261A34
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 03:02:28 +0200 (CEST)
Received: from eva.ponzo.net (bastion.ponzo.net [69.12.218.213])
 (authenticated bits=0)
 by d.mail.sonic.net (8.15.1/8.15.1) with ESMTPSA id u3F12NiI006505
 (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 18:02:23 -0700
In-Reply-To: <alpine.DEB.2.02.1604131128080.9999@lnxricardw1.se.axis.com>
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

On 04/13/2016 02:30 AM, Ricard Wanderlof wrote:
> On Wed, 13 Apr 2016, Scott Doty wrote:
>
>> So I'm having the worst luck with optical SPDIF devices.
>>  ...
>>
>>  3 [HD             ]: USB-Audio - USB Sound Blaster HD
>>                       Creative Technology USB Sound Blaster HD at
>> usb-0000:00:14.0-4.7.6, full speed
>>
>> I used to be able to use the optical SPDIF input for this device from my
>> synth, but that seems to have stopped working.  Further, I can't play
>> audio out of the Sound Blaster HD's optical SPDIF output, either.  It
>> works in Windows 10, which is where I had to spend my latest music
>> session -- yuck.
> Exactly what does 'stopped working' mean? Doesn't it should up when you 
> enumerate audio devices, does it show up but input and output results in 
> silence, does it show up but attempting to send audio results in an error, 
> etc. (I know you linked to a long ALSA dump, but folks around here would 
> be more willing to help if you stated as precisely as you could which 
> symptoms you actually have.)
>
> /Ricard

Sorry for being asleep at the switch, tax time hit me squarely between
the eyes. :/

The problem I'm seeing is that pulse can select the spdif input on both
devices, but I never hear any sound.  I've also tried using alsa via rec
(from SOX) to record from various hw: devices with no joy.  Also using
ALSA devices from Audacity (which is what I started with in the first
place.)

HOWEVER, I was able to get at the optical audio in on the SIIG device
with the following command:

   arecord -c 2 -f S32_LE -r 48000 -D dsnoop:CARD=Audio,DEV=1 trythis2.wav

And then I investigated the "plughw" interface, and this worked too:

   arecord -c 2 -f S16_LE -r 48000 -D plughw:CARD=Audio,DEV=1
trythisPLUG.wav

So at least I can investigate that, and read up on using dsnoop and
plughw devices with Audacity.

The Sound Blaster HD, though, didn't have the same luck -- it is still
flatline when I view the dsnoop: device recording .wav files with
audacity, as well as the files from arecord on the plughw devices.

The output of arecord -L is in my .sig.

I see also "dmix" devices on the SIIG device, I will now investigate
those for optical spdif playback on the SIIG device, and the Sound
Blaster HD device if I have a chance.  The X-Fi device plays through the
optical spdif connector as expected.

Thank you!

-- 
 -Scott
default
    Playback/recording through the PulseAudio sound server
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
special
sysdefault:CARD=HD
    USB Sound Blaster HD, USB Audio
    Default Audio Device
front:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    Front speakers
surround40:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    Direct sample mixing device
dmix:CARD=HD,DEV=1
    USB Sound Blaster HD, USB Audio #1
    Direct sample mixing device
dsnoop:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    Direct sample snooping device
dsnoop:CARD=HD,DEV=1
    USB Sound Blaster HD, USB Audio #1
    Direct sample snooping device
hw:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    Direct hardware device without any conversions
hw:CARD=HD,DEV=1
    USB Sound Blaster HD, USB Audio #1
    Direct hardware device without any conversions
plughw:CARD=HD,DEV=0
    USB Sound Blaster HD, USB Audio
    Hardware device with all software conversions
plughw:CARD=HD,DEV=1
    USB Sound Blaster HD, USB Audio #1
    Hardware device with all software conversions
sysdefault:CARD=Pro
    SB X-Fi Surround 5.1 Pro, USB Audio
    Default Audio Device
front:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    Front speakers
surround40:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    Direct sample mixing device
dsnoop:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    Direct sample snooping device
hw:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    Direct hardware device without any conversions
plughw:CARD=Pro,DEV=0
    SB X-Fi Surround 5.1 Pro, USB Audio
    Hardware device with all software conversions
sysdefault:CARD=PCH
    HDA Intel PCH, CA0132 Analog
    Default Audio Device
front:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    Front speakers
surround40:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Digital
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    Direct sample mixing device
dmix:CARD=PCH,DEV=1
    HDA Intel PCH, CA0132 Digital
    Direct sample mixing device
dmix:CARD=PCH,DEV=2
    HDA Intel PCH, CA0132 Analog Mic-In2
    Direct sample mixing device
dmix:CARD=PCH,DEV=4
    HDA Intel PCH, CA0132 What U Hear
    Direct sample mixing device
dsnoop:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    Direct sample snooping device
dsnoop:CARD=PCH,DEV=1
    HDA Intel PCH, CA0132 Digital
    Direct sample snooping device
dsnoop:CARD=PCH,DEV=2
    HDA Intel PCH, CA0132 Analog Mic-In2
    Direct sample snooping device
dsnoop:CARD=PCH,DEV=4
    HDA Intel PCH, CA0132 What U Hear
    Direct sample snooping device
hw:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    Direct hardware device without any conversions
hw:CARD=PCH,DEV=1
    HDA Intel PCH, CA0132 Digital
    Direct hardware device without any conversions
hw:CARD=PCH,DEV=2
    HDA Intel PCH, CA0132 Analog Mic-In2
    Direct hardware device without any conversions
hw:CARD=PCH,DEV=4
    HDA Intel PCH, CA0132 What U Hear
    Direct hardware device without any conversions
plughw:CARD=PCH,DEV=0
    HDA Intel PCH, CA0132 Analog
    Hardware device with all software conversions
plughw:CARD=PCH,DEV=1
    HDA Intel PCH, CA0132 Digital
    Hardware device with all software conversions
plughw:CARD=PCH,DEV=2
    HDA Intel PCH, CA0132 Analog Mic-In2
    Hardware device with all software conversions
plughw:CARD=PCH,DEV=4
    HDA Intel PCH, CA0132 What U Hear
    Hardware device with all software conversions
sysdefault:CARD=M8
    Default Audio Device
sysdefault:CARD=Audio
    USB2.0 High-Speed True HD Audio, USB Audio
    Default Audio Device
front:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    Front speakers
surround40:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    Direct sample mixing device
dmix:CARD=Audio,DEV=1
    USB2.0 High-Speed True HD Audio, USB Audio #1
    Direct sample mixing device
dsnoop:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    Direct sample snooping device
dsnoop:CARD=Audio,DEV=1
    USB2.0 High-Speed True HD Audio, USB Audio #1
    Direct sample snooping device
hw:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    Direct hardware device without any conversions
hw:CARD=Audio,DEV=1
    USB2.0 High-Speed True HD Audio, USB Audio #1
    Direct hardware device without any conversions
plughw:CARD=Audio,DEV=0
    USB2.0 High-Speed True HD Audio, USB Audio
    Hardware device with all software conversions
plughw:CARD=Audio,DEV=1
    USB2.0 High-Speed True HD Audio, USB Audio #1
    Hardware device with all software conversions
