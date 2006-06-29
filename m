From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002076]: arecord gives silence
Date: Thu, 29 Jun 2006 09:27:34 +0200
Message-ID: <a12673f218f27a16eeb185464424afe1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9DE42280
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 09:27:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2076> 
======================================================================
Reported By:                jaime
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2076
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-26-2006 16:28 CEST
Last Modified:              06-29-2006 09:27 CEST
======================================================================
Summary:                    arecord gives silence
Description: 
IBM Thinkpad T21 with Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion
Audio Accelerator] (rev 01).

alsamixer correctly mixes the inputs over to the line out (I can hear
microphone in and line in successfully mixed) but arecord gives silence.

I've tried using a usb soundcard on the same machine, and everything works
fine there, so I think this is only the snd-cs46xx driver.

I'm not sure what other info is useful - please let me know. Thank you.

======================================================================

----------------------------------------------------------------------
 atler - 06-29-06 09:08 
----------------------------------------------------------------------
First two methods work fine, third one fails. Here comes complete output:

% cat /proc/asound/pcm 
00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-00: CS46xx : CS46xx : playback 31 : capture 1

% arecord -v -Dhw:0,0 -f cd test1.wav
Recording WAVE 'test1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Hardware PCM card 0 'Sound Fusion CS46xx' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 512
period_time  : 11609
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 512
xfer_align   : 512
start_threshold  : 1
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824


% arecord -v -Dplughw:0,0 -f cd test2.wav
Recording WAVE 'test2.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Plug PCM: Hardware PCM card 0 'Sound Fusion CS46xx' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 512 
period_time  : 11609
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 512
xfer_align   : 512
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824


% arecord -v -f cd test3.wav
Recording WAVE 'test3.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
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

----------------------------------------------------------------------
 Raymond - 06-29-06 09:27 
----------------------------------------------------------------------
Refer to https://bugtrack.alsa-project.org/alsa-bug/view.php?id=371#9010

Does it mean mean dsnoop is also not work with the hardware like CS46xx
due to its design ?

http://hg-mirror.alsa-project.org/alsa-lib?cmd=file;file=src/conf/cards/CS46xx.conf;filenode=8b52e1eece1b1e1e2f78d4c64b956197be5014ea;style=raw

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 16:28 jaime          New Issue                                    
05-02-06 18:11 tiwai          Note Added: 0009568                          
05-04-06 12:11 jaime          Note Added: 0009613                          
05-08-06 12:14 atler          Note Added: 0009645                          
05-24-06 14:03 fuman          Issue Monitored: fuman                       
06-29-06 03:29 Raymond        Note Added: 0010638                          
06-29-06 03:30 Raymond        Note Edited: 0010638                         
06-29-06 09:08 atler          Note Added: 0010642                          
06-29-06 09:27 Raymond        Note Added: 0010643                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
