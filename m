From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001830]: Does pcm_multi allow a virtual Surround51 with a 4 channels analog and 2 channels digital ?
Date: Sun, 12 Feb 2006 13:04:45 +0100
Message-ID: <ecac2eb2f3e01af354319fd5c4c907f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6DBAB17B
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2006 13:04:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1830> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1830
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-08-2006 13:37 CET
Last Modified:              02-12-2006 13:04 CET
======================================================================
Summary:                    Does pcm_multi allow a virtual Surround51 with a 4
channels analog and 2 channels digital ?
Description: 
Do pcm_multi limit to bind stereo channels only ?
======================================================================

----------------------------------------------------------------------
 Raymond - 02-12-06 13:04 
----------------------------------------------------------------------
It seem that the option -t of speaker-test behave different for multi type

AU8830.pcm.surround51.0 {
        @args [ CARD ]
        @args.CARD {
                type string
        }
        type multi
        slaves [
                {
                        pcm {
                                @func concat
                                strings [
                                        "cards.AU8830.pcm.front.0:CARD="
$CARD
                                ]
                        }
                        channels 4
                }
                {
                        pcm {
                                @func concat
                                strings [
                                        "cards.AU8830.pcm.front.0:CARD="
$CARD
                                ]
                        }
                        channels 2
                }
        ]
        bindings [
                { slave 0 channel 0 }
                { slave 0 channel 1 }
                { slave 0 channel 2 }
                { slave 0 channel 3 }
                { slave 1 channel 0 }
                { slave 1 channel 1 }
        ]



speaker-test -D surround51 -c 6
 
speaker-test 1.0.11rc2
 
Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
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
 4 - Center
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
 5 - LFE
Time per period = 17.831381
 0 - Front Left
 4 - Center
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
 5 - LFE
Time per period = 17.981657
 0 - Front Left


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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-06 13:37 Raymond        New Issue                                    
02-12-06 13:04 Raymond        Note Added: 0008026                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
