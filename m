From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000116]: alsalib raises assertion
Date: Thu, 13 Jan 2005 17:14:35 +0100
Message-ID: <cb800ebfd601538cb271aae85ce99366@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D3B49309
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 17:14:35 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=116> 
======================================================================
Reported By:                Benjamin Otte
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   116
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-04-2004 15:30 CET
Last Modified:              01-13-2005 17:14 CET
======================================================================
Summary:                    alsalib raises assertion
Description: 
I'm reproducing this from
http://bugzilla.gnome.org/show_bug.cgi?id=134007
I'm not able to reproduce this myself as I don't have a broken soundcard.
You might want to contact the reporter of the Gnome bug.
======================================================================

----------------------------------------------------------------------
 Benjamin Otte - 06-09-04 20:04 
----------------------------------------------------------------------
Attached is a .c file to reproduce the bug.
Compile with "gcc -ggdb3 `pkg-config --libs --cflags alsa` test.c -o test"
and run with "./test <device>" where "./test plughw:0" fails while "./test
hw:0" succeeds when you use an nForce2 or similar.

The problem is related to how the plug device has a dependency between
rate conversions and buffer sizes and the fact that the autodetection of
correct matches is pretty weak, because rate conversions don't check for
valid buffer sizes.

I'll attached some outputs of hw params while refining that show the issue
pretty well:
==> bt:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 
snd_pcm_plug_hw_refine_schange (pcm=0x80d47e0, params=0xbfffe9d8,
sparams=0xbfffe630) at pcm_plug.c:653
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x405452d1 in
snd_pcm_plug_hw_params (pcm=0x80d47e0,
params=0xbfffe9d8) at pcm_plug.c:882
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x4052e0d0 in
sndrv_pcm_hw_params (pcm=0x80d47e0, params=0xbfffe9d8)
at pcm_params.c:2260
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x4051f80d in
snd_pcm_hw_params (pcm=0x80d47e0, params=0xbfffe9d8) at
pcm.c:784
==> params:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: [4000 4000]
PERIOD_TIME: (166 2048000]
PERIOD_SIZE: 8192
PERIOD_BYTES: 8192
PERIODS: 2
BUFFER_TIME: (331 4096000]
BUFFER_SIZE: 16384
BUFFER_BYTES: 16384
TICK_TIME: 1000
U24_3LE U24_3BE S20_3LE S20_3BE U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE
U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: [4000 4294967295)
PERIOD_TIME: (62 2048000]
PERIOD_SIZE: (0 4294967295)
PERIOD_BYTES: (0 4294967295)
PERIODS: (0 4294967295]
BUFFER_TIME: [1 4294967295]
BUFFER_SIZE: [1 4294967294]
BUFFER_BYTES: [1 4294967295]
TICK_TIME: 1000

==> bt:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 
snd_pcm_plug_hw_refine_schange (pcm=0x80dc9d0, params=0xbfffe9c8,
sparams=0xbfffe620) at pcm_plug.c:736
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x405452d1 in
snd_pcm_plug_hw_params (pcm=0x80dc9d0,
params=0xbfffe9c8) at pcm_plug.c:882
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x4052e0d0 in
sndrv_pcm_hw_params (pcm=0x80dc9d0, params=0xbfffe9c8)
at pcm_params.c:2260
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x4051f80d in
snd_pcm_hw_params (pcm=0x80dc9d0, params=0xbfffe9c8) at
pcm.c:784
==> params:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: [4000 4000]
PERIOD_TIME: (166 2048000]
PERIOD_SIZE: 8192
PERIOD_BYTES: 8192
PERIODS: 2
BUFFER_TIME: (331 4096000]
BUFFER_SIZE: 16384
BUFFER_BYTES: 16384
TICK_TIME: 1000
U24_3LE U24_3BE S20_3LE S20_3BE U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE
U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: [4000 4294967295)
PERIOD_TIME: (62 2048000]
PERIOD_SIZE: (0 4294967295)
PERIOD_BYTES: (0 4294967295)
PERIODS: (0 4294967295]
BUFFER_TIME: [1 4294967295]
BUFFER_SIZE: [1 4294967294]
BUFFER_BYTES: [1 4294967295]
TICK_TIME: 1000
==> sparams:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 8000
PERIOD_TIME: [1000 2048000]
PERIOD_SIZE: [8 16384]
PERIOD_BYTES: [32 65536]
PERIODS: [1 1024]
BUFFER_TIME: [1000 2048000]
BUFFER_SIZE: [8 16384]
BUFFER_BYTES: [32 65536]
TICK_TIME: 1000
3BE U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: [4000 4294967295)
PERIOD_TIME: (62 2048000]
PERIOD_SIZE: (0 4294967295)
PERIOD_BYTES: (0 4294967295)
PERIODS: (0 4294967295]
BUFFER_TIME: [1 4294967295]
BUFFER_SIZE: [1 4294967294]
BUFFER_BYTES: [1 4294967295]
TICK_TIME: 1000

Note how rate is 4000 vs 8000 while buffer size is 16384 vs 16384 but it
then requests 32768 for the rate conversion which fails.
The code should have picked a rate of 8000 so no rate conversion is
necessary.

GStreamer works around this now, so it's not an issue for us anymore.

----------------------------------------------------------------------
 tiwai - 01-13-05 17:14 
----------------------------------------------------------------------
Let's move to FIXED.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-04 15:30 Benjamin Otte  New Issue                                    
03-05-04 11:01 perex          Status                   new => assigned     
03-05-04 11:01 perex          Assigned To               => perex           
03-05-04 12:43 perex          Note Added: 0000498                          
03-05-04 12:43 perex          Category                 hw specific configuration
=> pcm - digital audio
03-05-04 19:44 tiwai          Note Added: 0000512                          
03-23-04 15:52 perex          Status                   assigned => resolved
03-23-04 15:52 perex          Resolution               open => suspended   
03-23-04 15:52 perex          Note Added: 0000660                          
04-16-04 04:11 joshuadf       Issue Monitored: joshuadf                    
04-16-04 04:24 joshuadf       Note Added: 0000826                          
04-19-04 13:06 Benjamin Otte  Status                   resolved => feedback
04-19-04 13:06 Benjamin Otte  Resolution               suspended => reopened
04-19-04 13:06 Benjamin Otte  Note Added: 0000854                          
04-19-04 15:09 perex          Status                   feedback => assigned
04-19-04 15:26 perex          File Added: plug-hw-param.patch                   

04-19-04 15:27 perex          Note Added: 0000856                          
04-19-04 21:29 noaq           Note Added: 0000864                          
04-20-04 00:30 sxpert         Note Added: 0000868                          
04-23-04 00:11 benw           Issue Monitored: benw                        
04-25-04 12:03 noaq           Note Added: 0000938                          
04-25-04 12:09 perex          Note Added: 0000939                          
04-25-04 12:15 noaq           Note Added: 0000940                          
06-09-04 20:04 Benjamin Otte  Note Added: 0001297                          
01-13-05 17:14 tiwai          Status                   assigned => resolved
01-13-05 17:14 tiwai          Resolution               reopened => fixed   
01-13-05 17:14 tiwai          Note Added: 0003189                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
