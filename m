From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001658]: Capture happens only on one channel
Date: Mon, 9 Jan 2006 01:34:09 +0100
Message-ID: <b432f086c6200749ab21b791a2d15626@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 977D413C
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 01:34:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1658> 
======================================================================
Reported By:                phil_troin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1658
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r2
======================================================================
Date Submitted:             12-18-2005 08:40 CET
Last Modified:              01-09-2006 01:34 CET
======================================================================
Summary:                    Capture happens only on one channel
Description: 
When I am playing a CD, if I capture the sound output via the capture
channel OR the CD channel (amixer output attached), the captured sound is
only one one channel (the right one) and is very distorted.
The audio plays normally in stereo on the speakers.
======================================================================

----------------------------------------------------------------------
 tgutwin - 01-07-06 06:24 
----------------------------------------------------------------------
Same issue here, plus a few others on the MythTV user list have the same
symptoms after kernel and/or ALSA dirver updates.

Playback works fine
Capture only gets one channel (Left).
I can monitor the 2ch audio fine but when it gets recorded through Myth
(or LiveTV which is also a capture and record process) it loses its right
channel of audio with plain old analog 2 channel output.
NO digital AC3 used here (yet)

I have gone through the alsa setup with a fine tooth comb. it looks
correct.
plus all audio and video apps outside of MythTV play back work correctly.


I have tried every mute/capture setting using a couple of different
mixers.
The problem persists.

My system is a freshly built system specifically to be a home for
>>  AMD X2
>>  Asus A8N-e with onboard nvidia CK804/intel8x0
>>  Fedora core 4 built for x86_64
>>  with smp kernel 2.6.14-1.1653_FC4
>>  Alsa Version 1.0.10rc3  for kernel 2.6.14-1.1653_FC4smp (SMP)
    From atrpms

[root@dvr dev]# cd /proc
[root@dvr proc]# cd asound
[root@dvr asound]# ls
card0  cards  CK804  devices  hwdep  modules  oss  pcm  seq  timers 
version
[root@dvr asound]# cat version
Advanced Linux Sound Architecture Driver Version 1.0.10rc3.
Compiled on Dec 14 2005 for kernel 2.6.14-1.1653_FC4smp (SMP).
[root@dvr asound]# cat cards
0 [CK804          ]: NFORCE - NVidia CK804
                     NVidia CK804 with ALC850 at 0xc8103000, irq 50

lsmod | grep snd
snd_usb_audio          92160  0
snd_usb_lib            21504  1 snd_usb_audio
snd_rawmidi            32544  1 snd_usb_lib
snd_hwdep              14624  1 snd_usb_audio
snd_intel8x0           39848  1
snd_ac97_codec        115516  1 snd_intel8x0
snd_ac97_bus            6784  1 snd_ac97_codec
snd_seq_dummy           8068  0
snd_seq_oss            42596  0
snd_seq_midi_event     12672  1 snd_seq_oss
snd_seq                67288  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         14224  4
snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            61984  0
snd_mixer_oss          22656  2 snd_pcm_oss
snd_pcm               106888  4
snd_usb_audio,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              30344  2 snd_seq,snd_pcm
snd                    69088  15
snd_usb_audio,snd_usb_lib,snd_rawmidi,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              16353  2 snd
snd_page_alloc         15376  2 snd_intel8x0,snd_pcm


There are other users that have reported the same issue.

What other debugging can I do?
I can send in amixer scontents, but I have enumerated all options.

----------------------------------------------------------------------
 legluondunet - 01-09-06 01:34 
----------------------------------------------------------------------
Hello,

I had the same problem: suddenly and with no reason, my system record
sound with only one channel :-(.
After severals hours of searches on internet and in the deeper place of my
system, I found a solution.

I have a Ubuntu live disc. I boot on it and test the record: 2 channels
were record (ok).
So I begin to replace the alsa config of my system with the Ubuntu one's.
After several tests, I found that when I change my
/usr/share/alsa/alsa.conf with the ubuntu nes, I could again record with 2
channels :-).
I don't know the differences between this 2 files so I join them.

I hope this help :-)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 08:40 phil_troin     New Issue                                    
12-18-05 08:40 phil_troin     File Added: amixout                          
12-18-05 08:40 phil_troin     Distribution              => Gentoo          
12-18-05 08:40 phil_troin     Kernel Version            => 2.6.14-gentoo-r2
12-18-05 12:00 linuxbear      Note Added: 0007071                          
12-18-05 12:02 linuxbear      Note Edited: 0007071                         
12-27-05 10:34 linuxbear      Issue Monitored: linuxbear                    
01-07-06 06:24 tgutwin        Note Added: 0007508                          
01-07-06 06:25 tgutwin        Issue Monitored: tgutwin                     
01-09-06 01:34 legluondunet   Note Added: 0007529                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
