From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001216]: Microphone does not work
Date: Wed, 6 Jul 2005 22:11:29 +0200
Message-ID: <dc04f0c9589ebc12355dde7fbbf190d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AE090199
	for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2005 22:11:29 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1216> 
======================================================================
Reported By:                enilef
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1216
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC4smp
======================================================================
Date Submitted:             06-28-2005 07:13 CEST
Last Modified:              07-06-2005 22:11 CEST
======================================================================
Summary:                    Microphone does not work
Description: 
I noticed that the microphone did not work in Skype. Then I tested with
arecord/aplay and did not work there either. I have toggled/adjusted
everything in alsamixer. Now I can speak into the microphone and hear it
on my speakers if I adjust volumes correctly. But I can not capture
anything from it. The microphone does work....I tested that :) Now, the
microphone did work with Fedora Core 3....perfectly. Just after I
installed Fc4 (not an upgrade, a reinstall) it no longer works. I have
done multiple websearches....and tried alot of things as a result....but
nothing has worked. The machine is not a Dell.

Below is some information...

lspci (trimmed down)
--------------------
05:01.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
0a)
05:01.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 0a)

lsmod (trimmed)
---------------
emu10k1_gp              7617  0 
gameport               19913  2 emu10k1_gp
snd_emu10k1_synth      10945  0 
snd_emux_synth         38337  1 snd_emu10k1_synth
snd_seq_virmidi        11585  1 snd_emux_synth
snd_seq_midi_emul      10817  1 snd_emux_synth
snd_emu10k1           112069  2 snd_emu10k1_synth
snd_rawmidi            28513  2 snd_seq_virmidi,snd_emu10k1
snd_ac97_codec         78393  1 snd_emu10k1
snd_seq_dummy           7621  0 
snd_seq_oss            35777  0 
snd_seq_midi_event     11585  2 snd_seq_virmidi,snd_seq_oss
snd_seq                54097  8
snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         12621  7
snd_emu10k1_synth,snd_emux_synth,snd_emu10k1,snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            54257  0 
snd_mixer_oss          21953  2 snd_pcm_oss
snd_pcm                91973  3 snd_emu10k1,snd_ac97_codec,snd_pcm_oss
snd_timer              28357  3 snd_emu10k1,snd_seq,snd_pcm
snd_page_alloc         13765  2 snd_emu10k1,snd_pcm
snd_util_mem            8641  2 snd_emux_synth,snd_emu10k1
snd_hwdep              12897  2 snd_emux_synth,snd_emu10k1
snd                    58149  13
snd_emux_synth,snd_seq_virmidi,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_hwdep
soundcore              13345  2 snd

uname -a
---------
Linux jynx 2.6.11-1.1369_FC4smp
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 SMP Thu Jun 2 23:08:39
EDT 2005 i686
i686 i386 GNU/Linux

cat /proc/asound/cards
----------------------
0 [Unknown        ]: EMU10K1 - SB Live [Unknown]
                     SB Live [Unknown] (rev.10, serial:0x80651102) at
0x5000, irq 217

cat /proc/asound/devices
------------------------
  1:       : sequencer
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 19: [0- 3]: digital audio playback
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  6: [0- 2]: hardware dependent
  9: [0- 1]: raw midi
 10: [0- 2]: raw midi
 33:       : timer

cat /proc/asound/pcm
--------------------
00-00: emu10k1 : ADC Capture/Standard PCM Playback : playback 32 : capture
1
00-01: emu10k1 mic : Mic Capture : capture 1
00-02: emu10k1 efx : Multichannel Capture/PT Playback : playback 8 :
capture 1
00-03: emu10k1 : Multichannel Playback : playback 1

cat /proc/asound/version
------------------------
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).

cat /proc/asound/hwdep
-----------------------
00-00: EMU10K1 (FX8010)
00-02: Emux WaveTable

cat /proc/asound/modules
------------------------
0 snd_emu10k1

cat /proc/asound/timers
-----------------------
G0: system timer : 1000.000us (10000000 ticks)
C0-0: EMU10K1 timer : 20.833us (1024 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-2: PCM playback 0-0-2 : SLAVE
P0-0-4: PCM playback 0-0-4 : SLAVE
P0-0-6: PCM playback 0-0-6 : SLAVE
P0-0-8: PCM playback 0-0-8 : SLAVE
P0-0-10: PCM playback 0-0-10 : SLAVE
P0-0-12: PCM playback 0-0-12 : SLAVE
P0-0-14: PCM playback 0-0-14 : SLAVE
P0-0-16: PCM playback 0-0-16 : SLAVE
P0-0-18: PCM playback 0-0-18 : SLAVE
P0-0-20: PCM playback 0-0-20 : SLAVE
P0-0-22: PCM playback 0-0-22 : SLAVE
P0-0-24: PCM playback 0-0-24 : SLAVE
P0-0-26: PCM playback 0-0-26 : SLAVE
P0-0-28: PCM playback 0-0-28 : SLAVE
P0-0-30: PCM playback 0-0-30 : SLAVE
P0-0-32: PCM playback 0-0-32 : SLAVE
P0-0-34: PCM playback 0-0-34 : SLAVE
P0-0-36: PCM playback 0-0-36 : SLAVE
P0-0-38: PCM playback 0-0-38 : SLAVE
P0-0-40: PCM playback 0-0-40 : SLAVE
P0-0-42: PCM playback 0-0-42 : SLAVE
P0-0-44: PCM playback 0-0-44 : SLAVE
P0-0-46: PCM playback 0-0-46 : SLAVE
P0-0-48: PCM playback 0-0-48 : SLAVE
P0-0-50: PCM playback 0-0-50 : SLAVE
P0-0-52: PCM playback 0-0-52 : SLAVE
P0-0-54: PCM playback 0-0-54 : SLAVE
P0-0-56: PCM playback 0-0-56 : SLAVE
P0-0-58: PCM playback 0-0-58 : SLAVE
P0-0-60: PCM playback 0-0-60 : SLAVE
P0-0-62: PCM playback 0-0-62 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE
P0-2-0: PCM playback 0-2-0 : SLAVE
P0-2-1: PCM capture 0-2-1 : SLAVE
P0-2-2: PCM playback 0-2-2 : SLAVE
P0-2-4: PCM playback 0-2-4 : SLAVE
P0-2-6: PCM playback 0-2-6 : SLAVE
P0-2-8: PCM playback 0-2-8 : SLAVE
P0-2-10: PCM playback 0-2-10 : SLAVE
P0-2-12: PCM playback 0-2-12 : SLAVE
P0-2-14: PCM playback 0-2-14 : SLAVE
P0-3-0: PCM playback 0-3-0 : SLAVE

cat /proc/asound/card0/pcm1c
----------------------------
card: 0
device: 1
subdevice: 0
stream: CAPTURE
id: emu10k1 mic
name: Mic Capture
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

cat /etc/asound.conf
--------------------
# Generated by system-config-soundcard, do not edit by hand
defaults.pcm.card 0 
defaults.ctl.card 0 

What other information do you require?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001218 Line-In and Mic-In do not work
has duplicate       0001237 Audigy ES not recognised
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-06-05 22:11 
----------------------------------------------------------------------
Fixed in CVS.  Should also be fixed in the next stable kernel release.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-05 07:13 enilef         New Issue                                    
06-28-05 07:13 enilef         Distribution              => Fedora Core 4   
06-28-05 07:13 enilef         Kernel Version            => 2.6.11-1.1369_FC4smp
07-06-05 22:10 rlrevell       Relationship added       has duplicate 0001218
07-06-05 22:10 rlrevell       Relationship added       has duplicate 0001237
07-06-05 22:11 rlrevell       Note Added: 0005394                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
