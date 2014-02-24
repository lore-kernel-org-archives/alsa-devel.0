From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Call for testing: ALSA driver for Fireworks/BeBoB
	based devices
Date: Mon, 24 Feb 2014 16:17:11 +0900
Message-ID: <530AF1F7.50901@sakamocchi.jp>
References: <525B624B.4060906@sakamocchi.jp>
 <35FE09CFAB387A4BA7ACDDED49F3451818755B52@CRETE.nmmu.ac.za>,
 <5309A966.6060709@sakamocchi.jp>
 <35FE09CFAB387A4BA7ACDDED49F3451818755DD6@CRETE.nmmu.ac.za>
 <35FE09CFAB387A4BA7ACDDED49F34518187561E7@CRETE.nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A790A265282
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 08:17:18 +0100 (CET)
In-Reply-To: <35FE09CFAB387A4BA7ACDDED49F34518187561E7@CRETE.nmmu.ac.za>
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

 > The terminal output of aplay seems to reflect successful playback, 
and I hear audible clicks as
 >  the file starts and ends its playback.

It's quirk of BeBoB. If you avoid the click noise, add silent PCM 
samples into your file or use sound server such like jackd/PulseAudio.

But PulseAudio have an issue. See:
[pulseaudio-discuss] 'Failed to find a working profile' for firewire 
sound devices
http://lists.freedesktop.org/archives/pulseaudio-discuss/2014-January/019685.html

 > Please, is there anything you can suggest that I should try next?
 > Is there anything obvious that I appear to have overlooked?

A combination of these tools will help your debug.
  - ffado-mixer/ffado-dbus (the recent revision)
  - aplay/arecord
  - /proc/asound/Ozonic/#meter

Especially, Ozonic can reports its metering for each Analog input/Stream 
input/Analog output.

 > However, I have not yet been able to get audio playback (using "aplay 
-D plughw:2,0
 > Desktop/test.wav").  The .wav file is a short, 44.1/16 mono file 
saved from Audacity,
 > if that's relevant.

I guess that:
  - You expected to listen to 'Analog out 3/4'.
  - The aplay with plughw playbacks into 'Stream in 1/2'.
  - Ozonic's internal mixer didn't route 'Stream in 1/2' into 'Analog 
out 3/4'.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
