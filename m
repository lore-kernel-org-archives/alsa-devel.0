From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: [FFADO-devel] Call for testing: ALSA driver for
	Fireworks/BeBoB	based devices
Date: Sun, 23 Feb 2014 06:20:54 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F3451818755B52@CRETE.nmmu.ac.za>
References: <525B624B.4060906@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C7A3261A18
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 07:21:03 +0100 (CET)
In-Reply-To: <525B624B.4060906@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Takashi,

Firstly: thank you so much for taking the time to do this!  I am very, very grateful!

You asked for the following:

$ cat /proc/asound/card2/#clock
Sampling rate: 48000
Clock Source: Internal (MSU-dest: 5)
$ cat /proc/asound/card2/#firmware
Manufacturer:   bridgeCo
Protocol Ver:   1
Build Ver:      0
GUID:           0x000D6C0A009D269F
Model ID:       0x01
Model Rev:      1
Firmware Date:  20050905
Firmware Time:  091022
Firmware ID:    0xA
Firmware Ver:   20
Base Addr:      0x20080000
Max Size:       1572864
Loader Date:    20040915
Loader Time:    175644
$ cat /proc/asound/card2/#formation
Output Stream from device:
        Rate    PCM     MIDI
        22050   0       0
        24000   0       0
        32000   0       0
        44100   4       1
        48000   4       1
        88200   4       1
        96000   4       1
        176400  0       0
        192000  0       0
Input Stream to device:
        Rate    PCM     MIDI
        22050   0       0
        24000   0       0
        32000   0       0
        44100   4       1
        48000   4       1
        88200   4       1
        96000   4       1
        176400  0       0
        192000  0       0
$ cat /proc/asound/card2/#meter
Analog In 1:    1328896
Analog In 2:    1216256
Analog In 3:    1326097920
Analog In 4:    8012800
Stream In 1:    0
Stream In 2:    0
Stream In 3:    0
Stream In 4:    0
Analog Out 1:   0
Analog Out 2:   0
Analog Out 3:   0
Analog Out 4:   0

Now, my experience:

I am testing on a new, well provisioned PC, freshly loaded with Ubuntu 13.10.  My firewire card has a Texas Instruments chipset, and my device is the Ozonic.  I install via DKMS, as per your instructions, and then sudo modprobe snd-bebob.  The snd_firewire_lib and snd_bebob modules are now listed in the output of lsmod.  The device has installed as card2 (hw:2,0).  I can now test MIDI input with:
$ amidi -p hw:2,0,0 -d
... which satisfies me that all MIDI output from the various controllers on the Ozonic is being received.  I have not yet tried to send any MIDI data to the device.

I open Audacity, which now lists "Ozonic: Ozonic PCM (hw:2,0)" as ALSA input and output options.  However, no audio input is shown when I try to monitor the audio input, and trying to play generated audio (e.g. DTMF tones) results in the message: "Error while opening sound device. Please check the output device settings and the project sample rate."  I have repeated the experiment at all supported sampling rates (44100, 48000, 88200 & 96000 Hz), and obtained the same result in each case.  I then close Audacity and try:
$aplay -D hw:2,0 test.wav
(where test.wav has been saved from Audacity)
... and this responds with:
aplay: main:722: audio open error: Input/output error

Based on my experiences with the Ozonic under FFADO, I might easily have resigned myself to thinking that full functionality will only be apparent once a mixer is implemented.  I had hacked together the "unmute-ozonic" utility under FFADO in order to overcome the need the need to dual boot in order to get I/O.  However, the fact that an error message is returned upon trying to open the Ozonic's output makes me think that this is another problem entirely.

UPDATE: I have just this moment been able to do the following:
$ aplay -D hw:2,0 Desktop/test.wav
Playing WAVE 'Desktop/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
aplay: set_params:1239: Channels count not available
... which appears in order to me, except that no audio can be heard.  I assume this is due to the lack of a mixer.  I will retrace my steps to try and figure out why it is now apparently working.  However, I now open Audacity again, and the first thing I notice is that my pass-through audio immediately disappears (I have a sound source playing into the unbalanced inputs throughout).  Audacity responds exactly the same as before.  I close Audacity and aplay can no longer open hw:2,0 (I/O error as before).  Now I modprobe -r the modules (and lsmod to confirm they're gone), cycle the Ozonic's power off and on, and the audio pass-through has reappeared!  I also see that lsmod lists both snd_firewire_lib & snd_bebob as having reloaded themselves automatically.

My testing is probably not particularly rigorous, and I would sincerely appreciate your advice on what steps to follow in order to verify your driver's functionality.  In particular, you mention "(to control mixer channels please use FFADO upstream)".  I have not yet set up FFADO on this machine, but I also see under "Note":
"- Don't use simultaneously 'ALSA PCM/MIDI playback/capture' and 'jackd with Firewire (FFADO) backend'. Both of them try connecting to the device when another is running."  Would you please explain?  How should one rely on the "upstream" mixer functionality while keeping jackd out of ALSA's way?

Once again, thank you sincerely for doing this.  I, for one, feel like a kid on Christmas Eve!

Kind regards,
Mark Brand.
________________________________________
From: Takashi Sakamoto [o-takashi@sakamocchi.jp]
Sent: Monday, October 14, 2013 5:17 AM
To: alsa-devel@alsa-project.org; ffado-devel@lists.sf.net; linux1394-devel@lists.sourceforge.net; linux-audio-dev@lists.linuxaudio.org
Subject: [FFADO-devel] Call for testing: ALSA driver for Fireworks/BeBoB        based devices

Hi all,

This is a call for testing my ALSA driver for Fireworks/BeBoB based devices.

Please test 'snd-fireworks' for Fireworks and 'snd-bebob' for BeBoB if
you have some devices listed in the end of this mail.

[snip]

Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
FFADO-devel mailing list
FFADO-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ffado-devel

________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
