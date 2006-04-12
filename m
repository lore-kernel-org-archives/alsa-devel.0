From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001643]: Microphone is muted and no mic option available
Date: Wed, 12 Apr 2006 17:42:14 +0200
Message-ID: <2cb36e7b2826983cf7b78f225679aa02@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DA13125
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 17:42:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1643> 
======================================================================
Reported By:                MACHINE
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1643
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             12-12-2005 04:12 CET
Last Modified:              04-12-2006 17:42 CEST
======================================================================
Summary:                    Microphone is muted and no mic option available
Description: 
This issue exists since I bought this notebook, and it was never solved
since ALSA 1.0.9, no matter what kernel I use.

The only mixer option related to microphone is "Input Source", and there
is a "Front Mic", but useless.

in 'alsamixer -V capture', the only three columns are IEC958, Capture, and
Capture (not a typo!)

I unmuted everything and push every volumes to 100%. Everything works
fine, except microphone.

Hardware has no problem (checked by Windows2000).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001847 hda-intel on acer laptop (travelmate 30...
======================================================================

----------------------------------------------------------------------
 MACHINE - 04-12-06 11:36 
----------------------------------------------------------------------
I've tried 1.0.11_rc5 today.
Now the card(HDA/Sigmatel) records, however it records a lit bit crappy.

I did a test that I say "A..B..C..D..E..F..G". The wave file is attached.


nwang@travelmate ~ $ arecord -v test.wav
Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Plug PCM: Rate conversion PCM (48000, sformat=U8)
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 8
  buffer_size  : 2000
  period_size  : 1000
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1000
  xfer_align   : 1000
  start_threshold  : 1
  stop_threshold   : 2000
  silence_threshold: 0
  silence_size : 0
  boundary     : 262144000
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0*0.5 + 1*0.5
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 8
  buffer_size  : 12000
  period_size  : 6000
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 6000
  xfer_align   : 6000
  start_threshold  : 6
  stop_threshold   : 12000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
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
  buffer_size  : 12000
  period_size  : 6000
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 6000
  xfer_align   : 6000
  start_threshold  : 6
  stop_threshold   : 12000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
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
  tick_time    : 1000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 6000
  xfer_align   : 6000
  start_threshold  : 1
  stop_threshold   : 1572864000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
Aborted by signal &#20013;&#26029;...
nwang@travelmate ~ $ aplay test.wav
Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

----------------------------------------------------------------------
 rlrevell - 04-12-06 17:42 
----------------------------------------------------------------------
$ arecord -v test.wav
Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

Yes, 8-bit, 8KHz .wav files sound crappy.

Try arecord -f cd

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-05 04:12 MACHINE        New Issue                                    
12-12-05 04:12 MACHINE        File Added: alsa                             
12-12-05 04:12 MACHINE        Distribution              => Gentoo          
12-12-05 04:12 MACHINE        Kernel Version            => 2.6.14.3        
02-16-06 17:56 lrupn          Issue Monitored: lrupn                       
02-16-06 21:45 lrupn          Note Added: 0008102                          
02-18-06 01:32 rlrevell       Relationship added       has duplicate 0001847
02-18-06 08:27 cartman        Issue Monitored: cartman                     
04-12-06 11:33 MACHINE        File Added: test.wav                         
04-12-06 11:36 MACHINE        Note Added: 0009242                          
04-12-06 17:42 rlrevell       Note Added: 0009247                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
