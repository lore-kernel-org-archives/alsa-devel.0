From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Call for testing: ALSA driver for
	Fireworks/BeBoB	based devices
Date: Sun, 23 Feb 2014 16:55:18 +0900
Message-ID: <5309A966.6060709@sakamocchi.jp>
References: <525B624B.4060906@sakamocchi.jp>
 <35FE09CFAB387A4BA7ACDDED49F3451818755B52@CRETE.nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B31F265083
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 08:55:25 +0100 (CET)
In-Reply-To: <35FE09CFAB387A4BA7ACDDED49F3451818755B52@CRETE.nmmu.ac.za>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for your testing. Ozonic is one of devices for which I test.

 > My testing is probably not particularly rigorous, and I would
 > sincerely appreciate your advice on what steps to follow
 > in order to verify your driver's functionality.

Try playback/capture PCM samples/MIDI messages with ALSA applications.

 > In particular, you mention "(to control mixer channels please use
 > FFADO upstream)".

My drivers don't give ways to control device's internal mixer. So you 
need the other stuff for this purpose.

Please refer to this page. You can see some screenshots of ffado-mixer 
for 'M-Audio Ozonic'. I already commited these improvement to current 
FFADO trunk except for FW1814/ProjectMiX:
MaudioBebob
http://subversion.ffado.org/wiki/MaudioBebob

 > I have not yet set up FFADO on this machine, but I also see under
 > "Note": "- Don't use simultaneously 'ALSA PCM/MIDI playback/capture'
 > and 'jackd with Firewire (FFADO) backend'. Both of them try
 > connecting to the device when another is running." Would you please
 > explain?  How should one rely on the "upstream" mixer functionality
 > while keeping jackd out of ALSA's way?

Devices which my drivers support handle a pair of streams over IEEE1394 
bus. PCM samples/MIDI messages are multiplexed into these streams. And 
snd-fireworks/snd-bebob uses 'duplex streams synchronization'.
As a result:
  - ALSA PCM/MIDI functionality and jackd with firewire backend conflict 
for its streaming functionality.
But:
  - ALSA PCM/MIDI fuctionality and ffado-dbus-server/ffado-mixer do not 
interrupt each other.

 > I open Audacity, which now lists "Ozonic: Ozonic PCM (hw:2,0)" as
 > ALSA input and output options. However, no audio input is shown when
 > I try to monitor the audio input

I confirm that Audacity has such bugs to detect ALSA PCM character 
devices. In detail, its PortAudio v19 codes includes bugs. I have no 
will to investigate this bug because it's not within my work for these 
drivers.

 > $aplay -D hw:2,0 test.wav
 > (where test.wav has been saved from Audacity)
 > ... and this responds with:
 > aplay: main:722: audio open error: Input/output error

According to aplay codes, snd_pcm_open() generate this error.
I guess that another application still uses PCM character device for Ozonic.

 > $ aplay -D hw:2,0 Desktop/test.wav
 > Playing WAVE 'Desktop/test.wav' : Signed 16 bit Little Endian, Rate
 > 44100 Hz, Mono aplay: set_params:1239: Channels count not available

You MUST add 'c' option to indicate the number of channels with 'hw' PCM 
device. For convinience, use 'plughw' PCM device instead, like:
$ aplay -D plughw:2,0 Desktop/test.wav

I note an item:
  - A few days ago, I fixed bug to fail to start stream for Ozonic. See:
bebob: fix mappling for MIDI conformant data in stream channels
https://github.com/takaswie/snd-firewire-improve/commit/545ab7068f1d53b2b17d5615f768af1d53076d6b

Thanks


Takashi Sakamoto
o-takashi@sakamocchi.jp
