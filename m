From: noreply@alsa-project.org
Subject: [ALSA - driver 0000231]: ALSA plays only one sound at a time
Date: Fri, 16 Jul 2004 12:41:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104132.24F4626008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 58BB0255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:41:32 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000231
======================================================================
Reported By:                macdonalder
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     231
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-25-2004 04:00 CEST
Last Modified:              07-16-2004 12:41 CEST
======================================================================
Summary:                    ALSA plays only one sound at a time
Description: 
Upon installing Slackware then Dropline Gnome I removed any old ALSA
installs and installed 1.0.4 from sources. Opening one application to play
music works, but sound from a second opened app doesn't start playing
uptil the first app is closed or the sound is stopped.

As an example, I can open up Rhythmbox, stream music from di.fm, open up
BMP to play an MP3, and BMP will just wait at 0:00 on the MP3 until I exit
Rhythmbox. Once Rhythmbox closes, BMP starts playing as it normally would.
Nothing crashes or faults as it patiently waits its turn. This problem
isn't isloated to Rhythmbox and BMP, as it is reproducible with Gaim,
Totem, etc.
======================================================================

----------------------------------------------------------------------
 macdonalder - 04-25-2004 04:59 CEST 
----------------------------------------------------------------------
Sorry... it would seem as though this problem has already been addressed
and dismissed as a support request rather than an actual bug. I'll post
here anyways what I've been trying any if anyone feels like posting input
please feel free.

After looking though the steps that were taken there, I've tried running
two instances of aplay and I still get the same results; one sound is
queued and doesn't start until the first instance runs though.

Here is the output from one instance of aplay:

macdonalder@bellerophon:~$ aplay -v 2.wav
Playing WAVE '2.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
Plug PCM: Route conversion PCM (sformat=S16_LE)
Transformation table:
0 <- 0
1 <- 0
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 11025
exact rate   : 11025 (11025/1)
msbits       : 8
buffer_size  : 5512
period_size  : 1378
period_time  : 124988
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1378
xfer_align   : 1378
start_threshold  : 5512
stop_threshold   : 5512
silence_threshold: 0
silence_size : 0
boundary     : 1444937728
Slave: Hardware PCM card 0 'NVidia nForce2' device 0 subdevice 0
 
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 11025
exact rate   : 11025 (11025/1)
msbits       : 16
buffer_size  : 5512
period_size  : 1378
period_time  : 124988
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1378
xfer_align   : 1378
start_threshold  : 5512
stop_threshold   : 5512
silence_threshold: 0
silence_size : 0
boundary     : 1444937728

After adding the following .asoundrc to /home/macdonalder/:

pcm.nforce-hw {
type hw
card 0
}
                                                                          
    
pcm.!default {
type plug
slave.pcm "nforce"
}
                                                                          
    
pcm.nforce {
type dmix
ipc_key 1234
slave {
pcm "hw:0,0"
period_time 0
period_size 1024
buffer_size 4096
rate 44100
}
}
                                                                          
    
ctl.nforce-hw {
type hw
card 0
}

Running two instances of aplay does work, however if I start with an
instance of BMP or Rhythmbox aplay doesn't start until BMP or Rhythmbox
are finished. This is the output from aplay the second time around with
the addition of the .asoundrc.

macdonalder@bellerophon:~$ aplay -v 1.wav
Playing WAVE '1.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
Plug PCM: Rate conversion PCM (44100, sformat=U8)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 11025
exact rate   : 11025 (11025/1)
msbits       : 8
buffer_size  : 1024
period_size  : 256
period_time  : 23219
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 256
xfer_align   : 256
start_threshold  : 1024
stop_threshold   : 1024
silence_threshold: 0
silence_size : 0
boundary     : 268435456
Slave: Route conversion PCM (sformat=S16_LE)
Transformation table:
0 <- 0
1 <- 0
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 8
buffer_size  : 4096
period_size  : 1024
period_time  : 23219
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 4096
stop_threshold   : 4096
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Direct Stream Mixing PCM
 
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 4096
period_size  : 1024
period_time  : 23219
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 4096
stop_threshold   : 4096
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'NVidia nForce2' device 0 subdevice 0
 
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 4096
period_size  : 1024
period_time  : 23219
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 1
stop_threshold   : 1073741824
silence_threshold: 0
silence_size : 1073741824
boundary     : 1073741824

edited on: 04-25-04 04:59

----------------------------------------------------------------------
 macdonalder - 04-25-2004 06:58 CEST 
----------------------------------------------------------------------
Ha what to you know, reading the manual works (looked at dmix plugin over
on the wiki) ;)

Problem solved, sorry for the bug-report.

----------------------------------------------------------------------
 perex - 04-25-2004 09:51 CEST 
----------------------------------------------------------------------
Solved, configuration problem.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-25-04 04:00 macdonalder    New Bug                                      
04-25-04 04:00 macdonalder    Distribution              => Slackware       
04-25-04 04:00 macdonalder    Kernel Version            => 2.6.5           
04-25-04 04:20 macdonalder    Bugnote Added: 0000931                       
04-25-04 04:29 macdonalder    Bugnote Edited: 0000931                      
04-25-04 04:56 macdonalder    Bugnote Edited: 0000931                      
04-25-04 04:59 macdonalder    Bugnote Edited: 0000931                      
04-25-04 04:59 macdonalder    Bugnote Edited: 0000931                      
04-25-04 06:58 macdonalder    Bugnote Added: 0000933                       
04-25-04 09:51 perex          Bugnote Added: 0000935                       
04-25-04 09:51 perex          Assigned To               => perex           
04-25-04 09:51 perex          Resolution               open => fixed       
04-25-04 09:51 perex          Status                   new => resolved     
07-16-04 12:41 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
