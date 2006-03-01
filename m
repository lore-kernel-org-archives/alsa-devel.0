From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001882]: Use ESC key to stop the speaker-test instead of using ctrl-C
Date: Wed, 1 Mar 2006 18:01:33 +0100
Message-ID: <d8960d3cc4feee3e2a44f7d4414548c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D06B21C9
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 18:01:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1882> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1882
Category:                   speakertest
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-27-2006 03:57 CET
Last Modified:              03-01-2006 18:01 CET
======================================================================
Summary:                    Use ESC key to stop the speaker-test instead of
using ctrl-C
Description: 
Is it possible to use ESC key to stop the speaker-test instead of abort the
test by using control-C ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726
======================================================================

----------------------------------------------------------------------
 Raymond - 03-01-06 09:53 
----------------------------------------------------------------------
It seem that -t wav does not work for -D surround51 -c 6

speaker-test -D surround51 -t wav -c 6
 
speaker-test 1.0.11rc2
 
Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 8192
Period size range from 1 to 512
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 512
was set buffer_size = 8192
Cannot open WAV file /usr/share/sounds/alsa/Center.wavLFE.wav





./speaker-test -c 4 -D surround40 -t wav
 
speaker-test 1.0.11rc2
 
Playback device is surround40
Stream parameters are 48000Hz, S16_LE, 4 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 8192
Period size range from 1 to 512
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 512
was set buffer_size = 8192
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
Time per period = 5.723369
 0 - Front Left



----------------------------------------------------------------------
 rlrevell - 03-01-06 18:01 
----------------------------------------------------------------------
That's not what -t does in speaker-test

Usage: speaker-test [OPTION]... 
-h,--help       help
-D,--device     playback device
-r,--rate       stream rate in Hz
-c,--channels   count of channels in stream
-f,--frequency  sine wave frequency in Hz
-F,--format     sample format
-b,--buffer     ring buffer size in us
-p,--period     period size in us
-t,--test       1=use pink noise, 2=use sine wave
-s,--speaker    single speaker test. Values 1=Left or 2=right

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-06 03:57 Raymond        New Issue                                    
02-27-06 04:01 rlrevell       Note Added: 0008212                          
03-01-06 09:51 Raymond        Note Added: 0008277                          
03-01-06 09:53 Raymond        Note Edited: 0008277                         
03-01-06 18:01 rlrevell       Note Added: 0008284                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
