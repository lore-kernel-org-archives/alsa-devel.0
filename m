From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001822]: Can't record with Hercules
	Fortissimo II
Date: Sat, 15 Jul 2006 13:22:08 +0200
Message-ID: <8f18d1f9933d4200b437ddd49f39b280@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1D2B417E
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 13:22:09 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1822> 
======================================================================
Reported By:                atler
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1822
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               PLD
Kernel Version:             2.6.14.7
======================================================================
Date Submitted:             02-05-2006 16:16 CET
Last Modified:              07-15-2006 13:22 CEST
======================================================================
Summary:                    Can't record with Hercules Fortissimo II
Description: 
I can hear my voice from speakers but "arecord -f cd -t wav out.wav" always
produces 19K-32K file with no sound. What is weird is that I can record
through alsa oss emulation in programs that use /dev/dsp.
Similar problems already appeard here, but none of the solutions worked
for me.
======================================================================

----------------------------------------------------------------------
 Raymond - 07-15-06 09:13 
----------------------------------------------------------------------
The old cs46xx driver support stereo playback and the new cs46xx driver
support multi-channels playback and hardware mixing.

cat /proc/asound/pcm

Does the example latency.c work ? (playback/capture)

Remove .asoundrc

Post the complete output of 

arecord -v -f cd -d 10 test.wav

----------------------------------------------------------------------
 atler - 07-15-06 13:22 
----------------------------------------------------------------------
$ cat /proc/asound/pcm
00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-00: CS46xx : CS46xx : playback 31 : capture 1


$ arecord -v -f cd -d 10 test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 7526
  period_size  : 470
  period_time  : 10666
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 470
  xfer_align   : 470
  start_threshold  : 1
  stop_threshold   : 7526
  silence_threshold: 0
  silence_size : 0
  boundary     : 986447872
Slave: Direct Snoop PCM
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 8192
  period_size  : 512
  period_time  : 10666
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 512
  xfer_align   : 512
  start_threshold  : 1
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'Sound Fusion CS46xx' device 0 subdevice 0
Its setup is:  
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 8192
  period_size  : 512
  period_time  : 10666
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 512
  xfer_align   : 512
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824

and it doesn't stop after 10s, just hangs forever.

latency.c seems to work fine. Here's some output:
...
Success
Playback:
*** frames = 661760 ***
  state       : RUNNING
  trigger_time: 1152962110.306942000
  tstamp      : 1152962140.307566000
  delay       : 256
  avail       : 0
  avail_max   : 176
Capture:
*** frames = 661504 ***
  state       : RUNNING
  trigger_time: 1152962110.306937000
  tstamp      : 1152962140.307733000
  delay       : 16
  avail       : 16
  avail_max   : 176
Maximum read: 128 frames
Maximum read latency: 5804.989us, 5.804989ms (172.2656Hz)
Playback time = 1152962110.306942, Record time = 1152962110.306937, diff =
5

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 16:16 atler          New Issue                                    
02-05-06 16:16 atler          File Added: asound.state                     
02-05-06 16:16 atler          Distribution              => PLD             
02-05-06 16:16 atler          Kernel Version            => 2.6.14.7        
02-05-06 16:19 atler          Note Added: 0007937                          
02-07-06 16:30 perex          Note Added: 0007959                          
02-11-06 20:47 atler          Note Added: 0008021                          
07-11-06 16:24 Raymond        Note Added: 0010974                          
07-11-06 16:28 Raymond        Note Edited: 0010974                         
07-14-06 22:28 atler          Note Added: 0011007                          
07-15-06 09:13 Raymond        Note Added: 0011019                          
07-15-06 13:22 atler          Note Added: 0011021                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
