From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001543]: m-audio quattro Sample format non available
Date: Mon, 14 Nov 2005 12:11:12 +0100
Message-ID: <7dbc65f8b730662c1ee551261afa3e72@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE4C51A6
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 12:11:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1543> 
======================================================================
Reported By:                timb
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - lib
Issue ID:                   1543
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-11-2005 07:17 CET
Last Modified:              11-14-2005 12:11 CET
======================================================================
Summary:                    m-audio quattro Sample format non available
Description: 
Using the asound.conf for the quattro from the alsa site, the q4 device
works for testing aplay and arecord, but q4b gives problems:

aplay -Dq4b /rough/demo2/floor.wav                  
Playing WAVE '/rough/demo2/floor.wav' : Signed 16 bit Little Endian, Rate
44100 Hz, Stereo
aplay: set_params:887: Channels count non available,


arecord -Dq4b -f cd -twav -d 10 /rough/arecordtest.wav
arecord: set_params:882: Sample format non available


======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 12:11 
----------------------------------------------------------------------
I don't see your q4b configuration, but you probably don't use the plug
layer there. Use '-Dplug:q4b' as device for aplay/arecord.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-05 07:17 timb           New Issue                                    
11-11-05 07:17 timb           Distribution              => debian          
11-11-05 07:17 timb           Kernel Version            => 2.4.27, 2.6.x   
11-11-05 07:30 timb           Issue Monitored: timb                        
11-14-05 12:09 perex          Project                  ALSA - driver => ALSA -
lib
11-14-05 12:10 perex          Category                 USB - usb-audio => 1_pcm
- digital audio
11-14-05 12:11 perex          Status                   assigned => resolved
11-14-05 12:11 perex          Resolution               open => fixed       
11-14-05 12:11 perex          Note Added: 0006721                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
