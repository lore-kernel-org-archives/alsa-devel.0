From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000711]: Sound still bad with alsa on sb audigyls / ca0106
Date: Wed, 8 Dec 2004 12:35:53 +0100
Message-ID: <8f7d29915f4bd06ee7d6f316fe9ce20a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E9750E8
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2004 12:35:56 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=711> 
======================================================================
Reported By:                scorpion77
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   711
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.9-1.6_FC2custom
======================================================================
Date Submitted:             12-07-2004 18:12 CET
Last Modified:              12-08-2004 12:35 CET
======================================================================
Summary:                    Sound still bad with alsa on sb audigyls / ca0106
Description: 
Sound is choppy and at wrong speed with both the snd-audigyls from alsa
1.0.7 and snd-ca0106 from alsa CVS. CVS seems worse, which bugs me since
last bug report was closed woth a "Use snd-ca0106 from CVS remark"!
Workaround seems to select (Threaded)OSS as artsd backend instead of Alsa.
Esd as artsd backend only works / fixes things in 1.0.7, it crashes when
the CVS version is used.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-07-04 20:24 
----------------------------------------------------------------------
"CVS seems worse, which bugs me since last bug report was closed woth a
"Use snd-ca0106 from CVS remark"!"

Dude, take it easy.  The second part of James advice was "If it still
doesn't work, open a new bug report", for the simple reason that the
"Audigy LS" driver was replaced by the CA0106 driver, and leaving bugs
open against a nonexistent driver does not make sense.

This was all explained in James' note when he closed the original bug.

----------------------------------------------------------------------
 scorpion77 - 12-07-04 21:40 
----------------------------------------------------------------------
Well should have said 'kind of bugs me' then ;) You have to do quite some
work just to find out it's probably wise to just stick with the 1.0.7
snd-audigyls driver because it works better and there doesn't seem to be
much changes when it comes to features.

Most important question would be, is this work in progress and if it is,
when can I / we expect decent support for this chip, soon or rather on the
longterm? I can still return the thing and get a better card u know ;)

----------------------------------------------------------------------
 jcdutton - 12-07-04 21:53 
----------------------------------------------------------------------
You don't really give me much information do you.
How about some useful info, like:
cat /proc/asound/card0/cards
cat /proc/asound/version
etc.

I suspect you are trying to play a file at 44.1khz, and the sound card
does not support that rate(hardware limitation), so alsa-lib tries to
resample 44.1khz to 48khz.
That, together with badly written applications that you might be using is
bound to fail.
If the media file plays fine in xine, this is not an alsa bug.

----------------------------------------------------------------------
 scorpion77 - 12-08-04 00:22 
----------------------------------------------------------------------
I'm having the same problem lots of other folks have with this driver, not
trying anything fancy. Before the only problem was with artsd and the
hardware limitations of my onboard sound, so i bought a real soundcard, or
at least I thought I did: 

- Old Artsd problem defined: some apps / games can't play audio when artsd
is running

- Define old hardware limitations: lots of noise and too few input options
(cd sound OR tvsound not both). Define non problematic setup: onboard
realtec chip, intel8x0 driver. Other problems, sometimes I got "Device in
use" messages from artsd when not using alsa as backend. Don't ask me why
the silly thing doesn't use alsa as default ;) 

That much for the old setup, now for the new one. To answer your
questions: 

- Xine plays just fine indeed and so does mpg123 with a mp3 file if and
only if I completly disable kde's soundsystem (select no input/output in
control panel && kill artsd).

- Some output:
cd /proc/asound
cat cards
0 [AUDIGYLS       ]: AudigyLS - AUDIGYLS
                     AudigyLS [SB0310] at 0x9000 irq 9
1 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with ALC650F at 0xe2201000, irq 5

cat version
Advanced Linux Sound Architecture Driver Version 1.0.7.
Compiled on Dec  6 2004 for kernel 2.6.9-1.6_FC2custom.

cat devices
  0: [0- 0]: ctl
 19: [0- 3]: digital audio playback
 18: [0- 2]: digital audio playback
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer
 32: [1- 0]: ctl
 52: [1- 4]: digital audio playback
 59: [1- 3]: digital audio capture
 58: [1- 2]: digital audio capture
 57: [1- 1]: digital audio capture
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture

cat modules
0 snd_audigyls
1 snd_intel8x0

cat pcm
00-00: audigyls : AUDIGYLS : playback 1 : capture 1
00-01: audigyls : AUDIGYLS : playback 1
00-02: audigyls : AUDIGYLS : playback 1
00-03: audigyls : AUDIGYLS : playback 1
01-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
01-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
01-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
01-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
01-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1


cat timers
G0: system timer : 1000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P0-2-0: PCM playback 0-2-0 : SLAVE
P0-3-0: PCM playback 0-3-0 : SLAVE
P1-0-0: PCM playback 1-0-0 : SLAVE
P1-0-1: PCM capture 1-0-1 : SLAVE
P1-1-1: PCM capture 1-1-1 : SLAVE
P1-2-1: PCM capture 1-2-1 : SLAVE
P1-3-1: PCM capture 1-3-1 : SLAVE
P1-4-0: PCM playback 1-4-0 : SLAVE

lsmod (edited)

Module                  Size  Used by
snd_seq                44816  0
snd_seq_device          8588  1 snd_seq
snd_pcm_oss            46504  1
snd_mixer_oss          16768  1 snd_pcm_oss
snd_intel8x0           29372  0
snd_audigyls           22576  1
snd_ac97_codec         63584  2 snd_intel8x0,snd_audigyls
snd_pcm                81928  4
snd_pcm_oss,snd_intel8x0,snd_audigyls,snd_ac97_codec
snd_timer              21764  2 snd_seq,snd_pcm
snd                    49252  10
snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_audigyls,snd_ac97_codec,snd_pcm,snd_timer
soundcore               8800  2 snd
snd_page_alloc          9608  3 snd_intel8x0,snd_audigyls,snd_pcm

cat ~/.asoundrc

pcm.audigyls {
        type hw
        card 0
}

ctl.audigyls {
        type hw
        card 0
}

pcm.intel8x0 {
        type hw
        card 1
}

ctl.intel8x0 {
        type hw
        card 1
}

Both artsd and esd have problems (as in esd as arts backend), only OSS
(emulation) seems  to work as mentioned before. Sound is both choppy and
at wrong speed otherwise. Soundcardbox mentions it CAN play 44.1khz (8,
11.025, 22.05, 44,1, 48, 96 out at 16 or 24 bit / 44.1, 48, 96 in at max
24 bit).

To me it seems I'm using an experimental driver and I'm mainly curious if
and when it will be fixed, but I'm the soundcard amateur here.

edited on: 12-08-04 00:22

----------------------------------------------------------------------
 jcdutton - 12-08-04 01:23 
----------------------------------------------------------------------
The sound card hardware is able to do:
1) Capture at 8, 11.025, 22.05, 44,1, 48, 96, at 16 or 24 bit
2) Analog playback at 48, 96 at 16 or 24bit.
3) Digital playback at 44.1, 48, 96.
4) Only one stream at a time.

All the other rates and options are all done in software in windows.

You are correct that the sound card driver is new, and will probably not
be updated for some time as I will be doing work on other alsa drivers
before I come back to the Audigy LS. For example, add support for 96khz,
24bit to the Audigy 2 class of sound cards.

I can only suggest that you try to configure arts to talk to the sound
card in a better fashion. e.g. Use buffers of 8 periods if you can get
arts to do that, otherwise use 4 periods. I expect that the problems you
are having is that the sound app is setting 2 periods, and as the sound
card hardware has a fairly small limit on max size of a period, your PC
cannot handle the interrupts quickly enough, and thus get the bad sound.
More periods is better with this sound card, up to a max of 8 periods.
Also, try forcing arts to output at 48khz.

I do not use arts or esd, so I am not the best person to ask regarding
them.

----------------------------------------------------------------------
 scorpion77 - 12-08-04 01:26 
----------------------------------------------------------------------
I'm sorry read the box to fast, it said spdif out upto 24bit 44.1, 48 or
96kbit samplerate

----------------------------------------------------------------------
 scorpion77 - 12-08-04 03:40 
----------------------------------------------------------------------
Tried your tips but no luck, threaded OSS sounds good, alsa doesn't as
artsd backend. It looks like forcing 48kbit gets the speed a bit better
but it still sounds very very choppy. Well If OSS emulation works I can
live with that.

However will there be support for the extra input channels (CD and TAD)
anywere soon? And got an input / output error on /dev/dsp when playing a
SDL game (ennemy territory), I by then already recreated /dev/dsp and
/dev/dsp0 with snddevices from alsa-driver.

Finally could this be the problem perhaps, looks a bit weird to me:

cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: SigmaTel STAC9721/23

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0
Extended status  : SDAC

----------------------------------------------------------------------
 tiwai - 12-08-04 12:35 
----------------------------------------------------------------------
Moved to snd-ca0106 category.  Sorry for the delay.


Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:12 scorpion77     New Issue                                    
12-07-04 18:12 scorpion77     Distribution              => Fedora Core 2   
12-07-04 18:12 scorpion77     Kernel Version            => 2.6.9-1.6_FC2custom
12-07-04 20:24 rlrevell       Note Added: 0002764                          
12-07-04 21:40 scorpion77     Note Added: 0002765                          
12-07-04 21:53 jcdutton       Note Added: 0002766                          
12-08-04 00:21 scorpion77     Note Added: 0002769                          
12-08-04 00:22 scorpion77     Note Edited: 0002769                         
12-08-04 01:23 jcdutton       Note Added: 0002770                          
12-08-04 01:26 scorpion77     Note Added: 0002771                          
12-08-04 03:40 scorpion77     Note Added: 0002773                          
12-08-04 12:35 tiwai          Note Added: 0002781                          
12-08-04 12:35 tiwai          Category                 PCI - audigyls => PCI -
ca0106
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
