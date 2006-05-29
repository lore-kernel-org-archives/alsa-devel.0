From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation
	for ati-ixp chipset.
Date: Mon, 29 May 2006 03:13:46 +0200
Message-ID: <287c0010ac10026d406750ff8f2e416e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6DDDB13E
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 03:13:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2147> 
======================================================================
Reported By:                Gene Heskett
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2147
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               FC5, uptodate
Kernel Version:             2.6.16-1.2111_FC5
======================================================================
Date Submitted:             05-23-2006 03:52 CEST
Last Modified:              05-29-2006 03:13 CEST
======================================================================
Summary:                    lack of full duplex operation for ati-ixp chipset.
Description: 
skype, ekiga, audacity, and generally any program that needs to both
transmit and receive, using isolated paths, fails in playback when
recording.  In skype, I sound great at the far end, but reception may or
may not work, with emphasis on the not.  What I hear in the phones, or in
the speakers, sounds like what you would get if you took a sentence of
spoken words, break it up into say 5ms pieces, and play them at maybe 10
of these little snippets per second, so that the resultant sound is broken
up to the point of no comprehension, and stretched in time by a
considerable amount.

In audacity, simultanious playback, or play one track while recording
another, likewise fails in that only very short snippets of the played
track are output to the phones or speakers.

Likewise, ekiga suffers from this same effect, I'm told I sound great on
teh other end, but I can't hear more than half a word occasionally.
======================================================================

----------------------------------------------------------------------
 Gene Heskett - 05-28-06 13:17 
----------------------------------------------------------------------
re 00010000 (Raymond)
That may be true for other distros, but FC5 has only the speaker-test
subdir at that location, with everything else in /etc/alsa.

As for the audacity mono problem, I've already run into that, and as far
as the configure option given, this is an rpm, so I have no idea howto
enforce that without installing from the src rpm.  If this is causing an
alsa/audacity then we should be pulling the packager into this
discussion.

As for applying the -v option to aplay, it does this:
[root@diablo ~]# aplay -v foo.wav
Playing WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Plug PCM: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'ATI IXP' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 4000
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
[root@diablo ~]#

NDI if the above is correct. I do not see the device default listed above.
But it sounds fine.  If its supposed to show 'default' then what file do I
check to ascertain that its correct, bearing in mind this IS an uptodate
as of 6 hours ago fedora core 5 install, and the files are not in what you
seem to think is the std location.

-- 
Cheers, Gene

----------------------------------------------------------------------
 Raymond - 05-29-06 03:13 
----------------------------------------------------------------------
audacity 1.2.x - portaudio (Portable Real-Time Audio Library) use "plughw"
or "hw" for playback and capture, if you are using a sound card which does
not support hardware mixing, you have to stop the other application first
in order to use audacity.

If you want to run audacity and other applications concurrently , you will
need a sound card which support hardware mixing

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 03:52 Gene Heskett   New Issue                                    
05-23-06 03:52 Gene Heskett   Distribution              => FC5, uptodate   
05-23-06 03:52 Gene Heskett   Kernel Version            => 2.6.16-1.2111_FC5
05-23-06 15:01 tiwai          Note Added: 0009934                          
05-23-06 16:46 Gene Heskett   Note Added: 0009938                          
05-23-06 17:24 tiwai          Note Added: 0009941                          
05-23-06 18:07 Gene Heskett   Note Added: 0009943                          
05-23-06 19:14 tiwai          Note Added: 0009947                          
05-28-06 03:08 Gene Heskett   Note Added: 0009985                          
05-28-06 03:20 Gene Heskett   Note Added: 0009986                          
05-28-06 03:22 rlrevell       Note Added: 0009987                          
05-28-06 03:58 Raymond        Note Added: 0009988                          
05-28-06 04:04 Raymond        Note Edited: 0009988                         
05-28-06 04:05 Raymond        Note Edited: 0009988                         
05-28-06 04:24 rlrevell       Note Added: 0009989                          
05-28-06 04:51 Gene Heskett   Note Added: 0009990                          
05-28-06 05:10 rlrevell       Note Added: 0009991                          
05-28-06 05:27 Gene Heskett   Note Added: 0009992                          
05-28-06 05:34 rlrevell       Note Added: 0009993                          
05-28-06 05:37 Gene Heskett   Note Added: 0009994                          
05-28-06 06:13 rlrevell       Note Added: 0009995                          
05-28-06 06:29 Gene Heskett   Note Added: 0009998                          
05-28-06 06:35 rlrevell       Note Added: 0009999                          
05-28-06 08:22 Raymond        Note Added: 0010000                          
05-28-06 08:32 Raymond        Note Added: 0010001                          
05-28-06 13:17 Gene Heskett   Note Added: 0010002                          
05-29-06 03:13 Raymond        Note Added: 0010005                          
======================================================================
