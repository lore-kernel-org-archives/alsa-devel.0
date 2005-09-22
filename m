From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000070]: Sound driver loses synch during high cpu activity.
Date: Thu, 22 Sep 2005 14:59:59 +0200
Message-ID: <814656b505995e10a8dda0b3e4f8320b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5556E14E
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 14:59:59 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=70> 
======================================================================
Reported By:                mystica
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   70
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Slackware Linux 9.1 (with Dropline Gnome and extra
software installed manually)
Kernel Version:             2.4.23-mywin4lin-xfs-v4l2 (currently, but also
2.6.1-mywin4lin as well)
======================================================================
Date Submitted:             02-18-2004 07:36 CET
Last Modified:              09-22-2005 14:59 CEST
======================================================================
Summary:                    Sound driver loses synch during high cpu activity.
Description: 
About half the time I am playing a video with mplayer/xine or sometimes
even during periods of high cpu activity not caused by video (compiling a
program and listening to music for example) the audio will stop playing
back, sound like static for a few seconds, and then restart about 30
seconds (in the source) after it lost continuity/synch. If its in a video,
the video will then play back as fast as it can to meet back up with the
audio, but if its an MP3 it just keeps playing normally from where it
re-synchs.

======================================================================

----------------------------------------------------------------------
 mystica - 02-18-04 07:40 
----------------------------------------------------------------------
My god im an idiot. :) Forgot to let you know the soundcard. Turtle Beach
Santa Cruz, Crystal cs4630. Also, some dmesg output shows

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure
waiting for FIFO command to complete
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure
waiting for FIFO command to complete

at some point. Not quite sure when that was.

----------------------------------------------------------------------
 mystica - 03-02-04 08:36 
----------------------------------------------------------------------
One point of note- 0.9.8 has the same issue, but it is MUCH less severe. I
can listen to mp3s all day long in xmms without it dying. Only does
REPEATED fullscreening/windowing in mplayer cause the audio stream to
die/crackle.

----------------------------------------------------------------------
 mystica - 03-09-04 08:36 
----------------------------------------------------------------------
Also as an aside: The FIFO error i was recieving keeps occuring whenever
any program (xmms for example) try to use MMAP mode for output. This
effectively locks the program's sound output. Also, when trying different
games that make use of some of the CS4630's 31 hardware mixed sound
streams, I get a LOT of sound distortion and garbling. Should I file this
as a seperate bug? and  Has anyone else had this same problem?

----------------------------------------------------------------------
 tiwai - 03-09-04 15:20 
----------------------------------------------------------------------
hmm, there is no big change regarding cs46xx driver itself
since 0.9.8.

does the problem persist even if you disable mmap by removing
SNDRV_PCM_INFO_MMAP from snd_cs46xx_playback in pci/cs46xx/cs46xx_lib.c?

----------------------------------------------------------------------
 mystica - 03-11-04 08:06 
----------------------------------------------------------------------
This is with 1.03 (upgraded a few days ago seeing if it made a difference,
it didnt) 

As soon as i modprobe snd-cs46xx i get
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure
waiting for FIFO command to complete
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:416: cs46xx: failure
waiting for FIFO command to complete
in the dmesg.
Xmms plays ok, for the most part, regardless if i have 'Enable Alsa MMAP
mode' turned on or off. (Previous, enabling that function caused all audio
output to halt)
Mplayer still has sound desynching issues (static/crackly/popping sound,
for 2 seconds which somehow eats about 30 seconds of audio data timecode)
and the video then goes faster-than-realtime to try and resynch.
A new issue now- stepmania (which uses multiple hardware-mixed audio
streams) now fails to load:

mike@thor:~/stepmania$ stepmania 
StepMania 3.9 alpha 14
Log starting 2004-03-11 01:05:42
Loading window: sdl
OS: Linux ver 020423
Crash backtrace component: x86 custom backtrace
Crash lookup component: dladdr
Crash demangle component: cxa_demangle
ALSA: Advanced Linux Sound Architecture Driver Version 1.0.3.
ALSA Driver: 0: Sound Fusion CS46xx [CS46xx], device 0: CS46xx [CS46xx],
31/31 subdevices avail
ALSA Driver: 0: Sound Fusion CS46xx [CS46xx], device 1: CS46xx - Rear
[CS46xx - Rear], 31/31 subdevices avail
ALSA Driver: 0: Sound Fusion CS46xx [CS46xx], device 2: CS46xx - IEC958
[CS46xx - IEC958], 1/1 subdevices avail
ALSA Driver: 0: Sound Fusion CS46xx [CS46xx], device 3: CS46xx - Center
LFE [CS46xx - Center LFE], 31/31 subdevices avail
ALSA: dsnd_pcm_hw_params_set_access: Invalid argument
Couldn't load driver ALSA: SetHWParams failed
ALSA: dsnd_pcm_hw_params_set_access: Invalid argument
Couldn't load driver ALSA-sw: SetHWParams failed
Couldn't load driver OSS: RageSound_OSS: ALSA detected.  ALSA OSS
emulation is buggy; use ALSA natively.
Language:
Theme: SMMAX2
Error: Couldn't find a sound driver that works
mike@thor:~/stepmania$ 

and, in dmesg i see
ALSA pcm_lib.c:198: Unexpected hw_pointer value [1] (stream = 0, delta:
-512, max jitter = 8192): wrong interrupt acknowledge?
ALSA pcm_lib.c:198: Unexpected hw_pointer value [1] (stream = 0, delta:
-512, max jitter = 8192): wrong interrupt acknowledge?
ALSA pcm_lib.c:198: Unexpected hw_pointer value [1] (stream = 0, delta:
-512, max jitter = 8192): wrong interrupt acknowledge?

----------------------------------------------------------------------
 mystica - 03-16-04 11:38 
----------------------------------------------------------------------
In the time since bug was reported, I have purchased a SB Live from eBay
for $10. snd-emu10k1 works perfectly.

----------------------------------------------------------------------
 jdthood - 03-10-05 15:13 
----------------------------------------------------------------------
I still see "cs46xx: failure waiting for FIFO command to complete"
with the 1.0.8 drivers.

I haven't seen the other problem (of ALSA dropping 30 seconds of sound on
the floor) though.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-04 07:36 mystica        New Issue                                    
02-18-04 07:40 mystica        Note Added: 0000263                          
02-22-04 15:24 bheung         Issue Monitored: bheung                      
03-02-04 08:36 mystica        Note Added: 0000431                          
03-09-04 08:36 mystica        Note Added: 0000538                          
03-09-04 15:20 tiwai          Note Added: 0000548                          
03-11-04 08:06 mystica        Note Added: 0000568                          
03-16-04 11:38 mystica        Note Added: 0000625                          
03-10-05 15:13 jdthood        Note Added: 0003858                          
09-22-05 14:59 jdthood        Status                   new => acknowledged 
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
