From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Strange behaviour in snd-usb-cayak with Audio4DJ
Date: Tue, 16 Feb 2010 16:35:29 +0000
Message-ID: <74fd948d1002160835j3df4a44sbfa3d3fdaabfdb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B91024398
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 17:35:31 +0100 (CET)
Received: by ewy23 with SMTP id 23so730562ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 08:35:30 -0800 (PST)
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

Hi all,

I'm trying to setup my Audio4DJ usb soundcard. It has 4 channels (2
stereo ones).

ALSA information script output is here
http://www.alsa-project.org/db/?f=fe4cc3eda2df49c6055f55d4cef935524124d1a1
and my .asoundrc is here  http://pastebin.com/m3f70572d

Currently my .asoundrc has 4 devices:
- Audio4DJ_A (combines channels 1 and 2)
- Audio4DJ_B (combines channels 3 and 4)
- Audio4DJ (combines Audio4DJ_A and Audio4DJ_B)
- ttable is a device for JACK according to this
http://alsa-project.org/main/index.php/Asoundrc#Virtual_multi_channel_devices

My goal is to have a separate ALSA soundcard for each pair of
channels, an ALSA soundcard for 4 channels and a JACK device for all 4
channels.

Running speaker-test -c2 -D plughw:Audio4DJ,0,X -twav -l1
with X=0 and X=1 correctly outputs to each channel. Also,
pcm.Audio4DJ_A and pcm.Audio4DJ_B correctly work through both ALSA and
JACK for each pair of channels.

However, if I try to use the pcm.Audio4DJ (which combines both
pcm.Audio4DJ_A and pcm.Audio4DJ_B), I get correct output through
channels 1 and 2, but channels 3 and 4 have a lot of garbage - you can
hear the track playing but it is at a very high pitch and distorted.

JACK doesn't even start with the Audio4DJ device:

#  jackd -R --timeout 4500 -d alsa -d Audio4DJ -p 128 -n 3 -r 44100 -i 4 -o
apparent rate = 44100
creating alsa driver ... Audio4DJ|Audio4DJ|128|3|44100|4|4|nomon|swmeter|-|32bit
configuring for 44100Hz, period = 128 frames (2.9 ms), buffer = 3 periods
ALSA: final selected sample format for capture: 32bit float little-endian
ALSA: use 3 periods for capture
ALSA: final selected sample format for playback: 32bit float little-endian
ALSA: use 3 periods for playback
ALSA: could not complete read of 0 frames: error = -32
cycle execution failure, exiting
DRIVER NT: could not run driver cycle
jack main caught signal 12
(crashes immediately)

The ttable device locks up the system for a few seconds and then JACK crashes:

#  jackd -R --timeout 4500 -d alsa -d ttable -p 128 -n 3 -r 44100 -i 4 -o
apparent rate = 44100
creating alsa driver ... ttable|ttable|128|3|44100|4|4|nomon|swmeter|-|32bit
configuring for 44100Hz, period = 128 frames (2.9 ms), buffer = 3 periods
ALSA: final selected sample format for capture: 32bit integer little-endian
ALSA: use 3 periods for capture
ALSA: final selected sample format for playback: 32bit integer little-endian
ALSA: use 3 periods for playback
jackd watchdog: timeout - killing jackd

Without a .asoundrc it doesn't even work.

Can someone please tell me if this is expected behaviour or a bug?

Thanks,
Pedro
