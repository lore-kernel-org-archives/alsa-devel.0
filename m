From: noreply@alsa-project.org
Subject: [ALSA - lib 0000127]: aplay segfaults when attemptingto use "dmix" plugin with 1.0.3a libs
Date: Fri, 16 Jul 2004 13:05:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110557.C064126008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F1671255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:05:57 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000127
======================================================================
Reported By:                dandruczyk
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     127
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-09-2004 22:49 CET
Last Modified:              07-16-2004 13:05 CEST
======================================================================
Summary:                    aplay segfaults when attemptingto use "dmix" plugin with 1.0.3a libs
Description: 
aplay still segfaults even with alsa-lib-1.0.3a installed

aplay -v -Dplug:dmix horse.wav 
Playing WAVE 'horse.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 11025
period_size  : 5512
period_time  : 125000
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 5512
xfer_align   : 5512
start_threshold  : 11024
stop_threshold   : 11025
silence_threshold: 0
silence_size : 0
boundary     : 1445068800
Slave: Direct Stream Mixing PCM

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 12000
period_size  : 6000
period_time  : 125000
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 12000
stop_threshold   : 12000
silence_threshold: 0
silence_size : 0
boundary     : 1572864000
Hardware PCM card 0 'Intel 82801BA-ICH2' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 12000
period_size  : 6000
period_time  : 125000
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 1
stop_threshold   : 1572864000
silence_threshold: 0
silence_size : 1572864000
boundary     : 1572864000
Segmentation fault

======================================================================

----------------------------------------------------------------------
 perex - 03-10-2004 17:23 CET 
----------------------------------------------------------------------
Duplicated bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-09-04 22:49 dandruczyk     New Bug                                      
03-10-04 17:23 perex          Bugnote Added: 0000561                       
03-10-04 17:23 perex          duplicate_id             0 => 117            
03-10-04 17:23 perex          Assigned To               => perex           
03-10-04 17:23 perex          Resolution               open => duplicate   
03-10-04 17:23 perex          Status                   new => resolved     
07-16-04 13:05 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
