From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000398]: aplay produces no sound on short wav files through dmix
Date: Mon, 21 Mar 2005 09:20:32 +0100
Message-ID: <0aa8959c188280f8a489027c0e3ed071@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3413F26F
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2005 09:20:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=398> 
======================================================================
Reported By:                raveng
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   398
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-19-2004 16:21 CEST
Last Modified:              03-21-2005 09:20 CET
======================================================================
Summary:                    aplay produces no sound on short wav files through
dmix
Description: 
Wav files shorter than about 0.157 seconds produce no sound under aplay and
dmix. No error message is given, and it looks like it should be working.
If I add silence to the file to make the duration longer, it plays fine.
Also, if I direct aplay to use the hardware directly, it plays the
original file just fine.  Tested on both ens1371 and i810 audio.

Other media players (xmms, mplayer, and artsplay) all play the same file
correctly with dmix. It is only the ALSA-provided aplay that seems to have
difficulty.
======================================================================

----------------------------------------------------------------------
 leahcim - 03-21-05 03:16 
----------------------------------------------------------------------
Affirmative.

For completeness:

root@zaphod:~# aplay --version
aplay: version 1.0.8 by Jaroslav Kysela <perex@suse.cz>
root@zaphod:~# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15
07:17:53 2004 UTC).
Compiled on Dec 13 2004 for kernel 2.6.10-rc3.
root@zaphod:~# egrep -v '^(#|$)' /etc/asound.conf
pcm.!default {
        type plug
        slave.pcm "swmix"
}
pcm.swmix  {
        type dmix
        ipc_key 4269
        slave {
                pcm "hw:0,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                periods 128
                rate 44100
        }
}
root@zaphod:~# aplay -v -R46462 /usr/share/sounds/pop.wav 2>&1 |tee pop
Playing WAVE '/usr/share/sounds/pop.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Mono
Plug PCM: Route conversion PCM (sformat=S16_LE)
Transformation table:
0 <- 0
1 <- 0
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 1
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
start_threshold  : 2048
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
start_threshold  : 2048
stop_threshold   : 4096
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'Intel 82801BA-ICH2' device 0 subdevice 0

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
root@zaphod:~# aplay -v -R46463 /usr/share/sounds/pop.wav 2>&1 |tee nopop
Playing WAVE '/usr/share/sounds/pop.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Mono
Plug PCM: Route conversion PCM (sformat=S16_LE)
Transformation table:
0 <- 0
1 <- 0
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 1
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
start_threshold  : 2049
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
start_threshold  : 2049
stop_threshold   : 4096
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'Intel 82801BA-ICH2' device 0 subdevice 0

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
root@zaphod:~# diff -u pop nopop
--- pop 2005-03-21 09:51:21.876708848 +0800
+++ nopop       2005-03-21 09:51:27.982023419 +0800
@@ -21,7 +21,7 @@
 sleep_min    : 0
 avail_min    : 1024
 xfer_align   : 1024
-start_threshold  : 2048
+start_threshold  : 2049
 stop_threshold   : 4096
 silence_threshold: 0
 silence_size : 0
@@ -46,7 +46,7 @@
 sleep_min    : 0
 avail_min    : 1024
 xfer_align   : 1024
-start_threshold  : 2048
+start_threshold  : 2049
 stop_threshold   : 4096
 silence_threshold: 0
 silence_size : 0

----------------------------------------------------------------------
 Clemens Ladisch - 03-21-05 09:20 
----------------------------------------------------------------------
My patch from six weeks ago ("start pcm when draining in prepared state")
might have fixed this.  Please try the CVS version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-04 16:21 raveng         New Issue                                    
07-28-04 02:08 lesieur        Note Added: 0001478                          
12-07-04 03:24 leahcim        Issue Monitored: leahcim                     
12-07-04 03:58 leahcim        Note Added: 0002745                          
03-20-05 15:49 jdthood        Note Added: 0004095                          
03-21-05 03:16 leahcim        Note Added: 0004111                          
03-21-05 09:20 Clemens LadischNote Added: 0004116                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
