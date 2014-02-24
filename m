From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Call for testing: ALSA driver for
	Fireworks/BeBoB	based devices
Date: Mon, 24 Feb 2014 06:34:40 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F34518187561E7@CRETE.nmmu.ac.za>
References: <525B624B.4060906@sakamocchi.jp>
 <35FE09CFAB387A4BA7ACDDED49F3451818755B52@CRETE.nmmu.ac.za>,
 <5309A966.6060709@sakamocchi.jp>
 <35FE09CFAB387A4BA7ACDDED49F3451818755DD6@CRETE.nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CF79265268
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 07:34:47 +0100 (CET)
In-Reply-To: <35FE09CFAB387A4BA7ACDDED49F3451818755DD6@CRETE.nmmu.ac.za>
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
To: "o-takashi@sakamocchi.jp" <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thank you once again!  Your comments have been very helpful.  I now understand how to run ffado-dbus-server/ffado-mixer alongside your ALSA driver.  I have pulled your revised Ozonic mixer from ffado-mixer, and when I now invoke ffado-mixer, it properly detects the Ozonic.  I can also verify that the mixer control of my audio pass-through (which is plugged into inputs 3 & 4) works as expected.

However, I have not yet been able to get audio playback (using "aplay -D plughw:2,0 Desktop/test.wav").  The .wav file is a short, 44.1/16 mono file saved from Audacity, if that's relevant.  The terminal output of aplay seems to reflect successful playback, and I hear audible clicks as the file starts and ends its playback.  The pass-through is also momentarily muted as aplay starts and stops.  I have experimented with every conceivable combination of ffado-mixer settings, ultimately returning to the default settings that it was installed with.  When aplay executes, the mixer app shows check marks next to both "Outgoing" and "Incoming".  I have been testing the latest git version of the driver (updated this morning), and installing/uninstalling by DKMS.

Please, is there anything you can suggest that I should try next?  Is there anything obvious that I appear to have overlooked?    I will try with a wider range of test materials tomorrow, as well as trying other ALSA apps, but I wanted to get this posted in case that's not the issue.  I also recently saw some comments suggesting that pulseaudio be killed.  Could that be the issue?  I will investigate this tomorrow too.

Thank you sincerely,
Mark Brand.
________________________________________
From: Takashi Sakamoto [o-takashi@sakamocchi.jp]
Sent: Sunday, February 23, 2014 9:55 AM
To: Brand, Mark (Mr) (Summerstrand Campus South)
Cc: alsa-devel@alsa-project.org; ffado-devel@lists.sf.net
Subject: Re: Call for testing: ALSA driver for Fireworks/BeBoB  based devices

Hi Mark,

Thanks for your testing. Ozonic is one of devices for which I test.

 > My testing is probably not particularly rigorous, and I would  > sincerely appreciate your advice on what steps to follow  > in order to verify your driver's functionality.

Try playback/capture PCM samples/MIDI messages with ALSA applications.

 > In particular, you mention "(to control mixer channels please use  > FFADO upstream)".

My drivers don't give ways to control device's internal mixer. So you need the other stuff for this purpose.

Please refer to this page. You can see some screenshots of ffado-mixer for 'M-Audio Ozonic'. I already commited these improvement to current FFADO trunk except for FW1814/ProjectMiX:
MaudioBebob
http://subversion.ffado.org/wiki/MaudioBebob

 > I have not yet set up FFADO on this machine, but I also see under  > "Note": "- Don't use simultaneously 'ALSA PCM/MIDI playback/capture'
 > and 'jackd with Firewire (FFADO) backend'. Both of them try  > connecting to the device when another is running." Would you please  > explain?  How should one rely on the "upstream" mixer functionality  > while keeping jackd out of ALSA's way?

Devices which my drivers support handle a pair of streams over IEEE1394 bus. PCM samples/MIDI messages are multiplexed into these streams. And snd-fireworks/snd-bebob uses 'duplex streams synchronization'.
As a result:
  - ALSA PCM/MIDI functionality and jackd with firewire backend conflict for its streaming functionality.
But:
  - ALSA PCM/MIDI fuctionality and ffado-dbus-server/ffado-mixer do not interrupt each other.

 > I open Audacity, which now lists "Ozonic: Ozonic PCM (hw:2,0)" as  > ALSA input and output options. However, no audio input is shown when  > I try to monitor the audio input

I confirm that Audacity has such bugs to detect ALSA PCM character devices. In detail, its PortAudio v19 codes includes bugs. I have no will to investigate this bug because it's not within my work for these drivers.

 > $aplay -D hw:2,0 test.wav
 > (where test.wav has been saved from Audacity)  > ... and this responds with:
 > aplay: main:722: audio open error: Input/output error

According to aplay codes, snd_pcm_open() generate this error.
I guess that another application still uses PCM character device for Ozonic.

 > $ aplay -D hw:2,0 Desktop/test.wav
 > Playing WAVE 'Desktop/test.wav' : Signed 16 bit Little Endian, Rate  > 44100 Hz, Mono aplay: set_params:1239: Channels count not available

You MUST add 'c' option to indicate the number of channels with 'hw' PCM device. For convinience, use 'plughw' PCM device instead, like:
$ aplay -D plughw:2,0 Desktop/test.wav

I note an item:
  - A few days ago, I fixed bug to fail to start stream for Ozonic. See:
bebob: fix mappling for MIDI conformant data in stream channels https://github.com/takaswie/snd-firewire-improve/commit/545ab7068f1d53b2b17d5615f768af1d53076d6b

Thanks


Takashi Sakamoto
o-takashi@sakamocchi.jp


________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
