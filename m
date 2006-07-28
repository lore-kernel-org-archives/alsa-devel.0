From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001822]: Can't record with Hercules
	Fortissimo II
Date: Fri, 28 Jul 2006 18:52:49 +0200
Message-ID: <eb82549d530c703c91897262b96f855e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 72E6D17B
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 18:52:49 +0200 (MEST)
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
Last Modified:              07-28-2006 18:52 CEST
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
 Raymond - 07-15-06 13:50 
----------------------------------------------------------------------
Post the complete output of 

arecord -v -Dhw:0,0 -d 10 test.wav

or

arecord -v -Dplughw:0,0 -d 10 test.wav


Refer to https://bugtrack.alsa-project.org/alsa-bug/view.php?id=259#1090

If dmix does not work, this means dsnoop may also not work

----------------------------------------------------------------------
 atler - 07-28-06 18:52 
----------------------------------------------------------------------
$ arecord -v -Dhw:0,0 -d 10 -f cd test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
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
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824


Sorry I'm not very familiar with all this dmix/dsnoop stuff as I've never
needed to care about it. Do you mean that dsnoop might not work until I
enable mixing through dmix? If yes, why recording through oss works fine?

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
07-15-06 13:50 Raymond        Note Added: 0011022                          
07-28-06 18:52 atler          Note Added: 0011285                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
