From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001949]: pcm.jack config in alsa-plugins/doc/README-jack
Date: Thu, 13 Apr 2006 14:50:15 +0200
Message-ID: <c0781241f03dcbdce763e89c21e991c3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E57A212B
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 14:50:15 +0200 (MEST)
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
Last Modified:              04-13-2006 14:50 CEST
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
 Raymond - 04-12-06 16:10 
----------------------------------------------------------------------
It seem that speaker-test run much faster when using plug:jack than hw:0,0

> speaker-test -c 2 -Dplug:jack
 
speaker-test 1.0.11rc5
 
Playback device is plug:jack
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 524288
Period size range from 16 to 8192
Using max buffer size 524288
Periods = 4
was set period_size = 8192
was set buffer_size = 524288
 0 - Front Left
 1 - Front Right
Time per period = 0.054775
 0 - Front Left
 1 - Front Right
Time per period = 0.064070
 0 - Front Left
 1 - Front Right
Time per period = 0.079937
 0 - Front Left
 1 - Front Right
Time per period = 0.063401
 0 - Front Left
 1 - Front Right
Time per period = 0.063787
 0 - Front Left
 1 - Front Right
Time per period = 0.063419
 0 - Front Left
 1 - Front Right
Time per period = 0.048568
 0 - Front Left
 1 - Front Right
Time per period = 0.083251
 0 - Front Left
 1 - Front Right
Time per period = 0.049356
 0 - Front Left
 1 - Front Right
Time per period = 0.047705
 0 - Front Left
 1 - Front Right
Time per period = 0.063587
 0 - Front Left
 1 - Front Right


> speaker-test -c 2 -Dhw:0,0
 
speaker-test 1.0.11rc5
 
Playback device is hw:0,0
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 16384
Period size range from 1 to 1024
Using max buffer size 16384
Periods = 4
was set period_size = 1024
was set buffer_size = 16384
 0 - Front Left
 1 - Front Right
Time per period = 5.632776
 0 - Front Left
 1 - Front Right
Time per period = 5.972448
 0 - Front Left

----------------------------------------------------------------------
 Raymond - 04-13-06 14:50 
----------------------------------------------------------------------
http://sourceforge.net/mailarchive/forum.php?thread_id=10159370&forum_id=33141

The patch fixed the hang problem, aplay now aborted (as expected) instead
of hang

aplay  -Dplug:jack outls.wav
Playing WAVE 'outls.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
cannot connect alsa-jack.jackP.4775.0:out_001
 to alsa_pcm:playback_2
aplay: pcm_write:1257: write error: Input/output error

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-06 06:18 Raymond        New Issue                                    
03-21-06 07:42 Raymond        Note Added: 0008738                          
03-22-06 16:54 Raymond        Note Added: 0008863                          
03-22-06 17:02 Raymond        Note Edited: 0008863                         
03-22-06 18:47 tiwai          Note Added: 0008865                          
03-23-06 03:44 Raymond        Note Added: 0008878                          
03-23-06 05:51 Raymond        Note Edited: 0008878                         
03-23-06 15:17 Raymond        Note Added: 0008882                          
03-23-06 15:19 Raymond        Note Edited: 0008882                         
03-23-06 15:20 Raymond        Note Edited: 0008882                         
03-23-06 16:48 Raymond        Note Added: 0008889                          
04-12-06 16:10 Raymond        Note Added: 0009245                          
04-13-06 14:50 Raymond        Note Added: 0009260                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
