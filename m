From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000881]: Distorted sound with enabled dmix plugin
Date: Mon, 28 Feb 2005 15:26:02 +0100
Message-ID: <a3218fbc2e5b46baebba105943b41193@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BFAE6226
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2005 15:26:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=881> 
======================================================================
Reported By:                yure
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   881
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2005 12:25 CET
Last Modified:              02-28-2005 15:26 CET
======================================================================
Summary:                    Distorted sound with enabled dmix plugin
Description: 
After 10-20 minutes listening music with xmms or beep-media-player I hear
distorted sound. Appear noise.
This problem is appear when enabled dmix plugin through configuration file
~/.asoundrc.
======================================================================

----------------------------------------------------------------------
 yure - 02-28-05 15:22 
----------------------------------------------------------------------
Patch bmp-0.9.7-alsa-fixes.patch (34,761 bytes) doesn't fix problem.
I performed 3 tests: 
1. 8 instances of bmp player. One of them periodically has distorted
sound.
2. From xmms I have same problem.
3. 8 instances of aplay. I don't have any problem with sound. But I have
warnings:
Playing WAVE '01.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
underrun!!! (at least 0.028 ms long)
underrun!!! (at least 0.008 ms long)
underrun!!! (at least 0.004 ms long)
underrun!!! (at least 0.007 ms long)

While I perform all tests I started archive operation.

----------------------------------------------------------------------
 warly - 02-28-05 15:26 
----------------------------------------------------------------------
I have a similar problem using alsa (1.0.8) with xmms (1.2.10) and
xmms-alsa.

The files are ogg vorbis, and the problem does not appear if I use ogg123
-d alsa09

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 12:25 yure           New Issue                                    
02-04-05 10:39 yure           Note Added: 0003497                          
02-04-05 10:39 yure           Issue Monitored: yure                        
02-04-05 14:53 tiwai          Note Added: 0003506                          
02-04-05 15:30 yure           Note Added: 0003508                          
02-04-05 15:36 yure           Note Added: 0003509                          
02-23-05 13:35 yure           Note Added: 0003711                          
02-23-05 19:23 tiwai          Note Added: 0003713                          
02-23-05 19:23 tiwai          File Added: pcm-silent-fix.diff                   

02-23-05 19:24 tiwai          Note Added: 0003714                          
02-23-05 19:33 tiwai          Note Added: 0003715                          
02-24-05 22:09 tiwai          Note Added: 0003729                          
02-24-05 22:09 tiwai          File Added: bmp-0.9.7-alsa-fixes.patch            
       
02-25-05 10:36 yure           Note Added: 0003732                          
02-28-05 15:00 tvignaud       Note Added: 0003744                          
02-28-05 15:22 yure           Note Added: 0003745                          
02-28-05 15:26 warly          Note Added: 0003746                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
