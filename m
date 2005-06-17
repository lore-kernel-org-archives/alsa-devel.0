From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001169]: route plugin: unneeded ttable levels propagation
Date: Fri, 17 Jun 2005 14:58:24 +0200
Message-ID: <324ca92aa6454fc8f6cc0086ffd41097@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 099F317A
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 14:58:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1169> 
======================================================================
Reported By:                Andrew
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1169
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             06-08-2005 07:51 CEST
Last Modified:              06-17-2005 14:58 CEST
======================================================================
Summary:                    route plugin: unneeded ttable levels propagation
Description: 
v.1.0.9a is in use. All 1.0.9rcX have the same effect.

To replicate stereo to all eight channles I use this fragment in my
.asoundrc file:

pcm.!default {
        type plug
        slave {
                pcm "2x4"
                format S32_LE
        }
}

pcm.2x4 {
    type route
    slave.pcm surround71
    slave.channels 8
    ttable.0.0 0.03
    ttable.1.1 0.03
    ttable.0.2 1
    ttable.1.3 1
    ttable.0.4 1
    ttable.1.5 1
    ttable.0.6 1
    ttable.1.7 1
} 

All works fine except for levels are reduced for ALL channles rather
channels 0 and 1 only (the aim is to balance headphone output channels 0-1
with external amplifier(s) channels 2-7 levels).

Terratec Aureon 7.1 Space is in use.

I have selected "major" level as such situation is very error-prone:
unexpected high level output is possible which is danger for ears.
======================================================================

----------------------------------------------------------------------
 Andrew - 06-16-05 19:24 
----------------------------------------------------------------------
Perex,

'aplay -v -D2x4 41.wav' doesn't work: 

Playing WAVE '41.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
aplay: set_params:882: Sample format non available

'aplay -v -Dplug:2x4 41.wav' output is below ("0.1" level for ch.0,1 is
used).

I have tried 'aplay -Dplug:front <somefile>' and 'aplay -Dplug:rear
<somefile>' without any problems - they work the same way level as with
level "1" in ttable.

(I don't think there are some mixer mismatches as I was able to create own
config file for qamix :-)



=============== 'aplay -v -Dplug:2x4 41.wav' output ==========
Playing WAVE '41.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Plug PCM: Linear conversion PCM (S32_LE)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8192
period_size  : 2048
period_time  : 46439
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Route conversion PCM
Transformation table:
0 <- 0*0.1
1 <- 1*0.1
2 <- 0
3 <- 1
4 <- 0
5 <- 1
6 <- 0
7 <- 1
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 32
buffer_size  : 8192
period_size  : 2048
period_time  : 46439
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Hardware PCM card 0 'Terratec Aureon 7.1-Space' device 0 subdevice
0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 8
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 8192
period_size  : 2048
period_time  : 46439
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824

----------------------------------------------------------------------
 tiwai - 06-17-05 14:58 
----------------------------------------------------------------------
The ttable output looks OK to me.  But you stillget the same volumes
(multiplied with 0.1) on all channels, right?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 07:51 Andrew         New Issue                                    
06-16-05 15:04 perex          Status                   new => assigned     
06-16-05 15:04 perex          Assigned To               => perex           
06-16-05 15:34 perex          Project                  ALSA - driver => ALSA -
lib
06-16-05 15:35 perex          Category                 PCI - ice1724 => 1_pcm -
digital audio
06-16-05 15:44 perex          Note Added: 0005061                          
06-16-05 19:24 Andrew         Note Added: 0005063                          
06-17-05 14:58 tiwai          Note Added: 0005074                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
