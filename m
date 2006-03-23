From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001949]: pcm.jack config in alsa-plugins/doc/README-jack
Date: Thu, 23 Mar 2006 03:44:19 +0100
Message-ID: <f1b52649ecd190f3b99cde0cc3bbf682@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB3831AE
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 03:44:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1949> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1949
Category:                   PCM - jack
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-21-2006 06:18 CET
Last Modified:              03-23-2006 03:44 CET
======================================================================
Summary:                    pcm.jack config in alsa-plugins/doc/README-jack
Description: 
In  alsa-plugins/doc/README-jack

   pcm.jack {
		type jack
		playback_ports {
			0 alsa_pcm:playback_1
			1 alsa_pcm:playback_1
		}
		capture_ports {
			0 alsa_pcm:capture_1
			1 alsa_pcm:pcapture_1
		}
	}

There are four entries in Writable clients in qjackctl (jack-0.100.0) 

playback_1
playback_2
playback_3
playback_4

two entries in Readable clients

capture_1
capture_2

======================================================================

----------------------------------------------------------------------
 tiwai - 03-22-06 18:47 
----------------------------------------------------------------------
Try -Dplug:jack
The jack plugin requires a conversion from/to float.

----------------------------------------------------------------------
 Raymond - 03-23-06 03:44 
----------------------------------------------------------------------
No sound heard.

Do plugins auto connect to jack server ?

 aplay -v -Dplug:jack outls.wav
Playing WAVE 'outls.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 22050
  exact rate   : 22050 (22050/1)
  msbits       : 16
  buffer_size  : 11025
  period_size  : 2756
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 2756
  xfer_align   : 2756
  start_threshold  : 11024
  stop_threshold   : 11025
  silence_threshold: 0
  silence_size : 0
  boundary     : 722534400
Slave: Linear Integer <-> Linear Float conversion PCM (FLOAT_LE)
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 6000
  xfer_align   : 6000
  start_threshold  : 24000
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
Slave: ALSA <-> JACK PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 6000
  xfer_align   : 6000
  start_threshold  : 24000
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-06 06:18 Raymond        New Issue                                    
03-21-06 07:42 Raymond        Note Added: 0008738                          
03-22-06 16:54 Raymond        Note Added: 0008863                          
03-22-06 17:02 Raymond        Note Edited: 0008863                         
03-22-06 18:47 tiwai          Note Added: 0008865                          
03-23-06 03:44 Raymond        Note Added: 0008878                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
