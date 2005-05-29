From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000881]: Distorted sound with enabled dmix plugin
Date: Sun, 29 May 2005 08:29:17 +0200
Message-ID: <6f78c3ec2ab59c160c6b5163573e67be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F5001C6
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 08:29:17 +0200 (MEST)
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
Last Modified:              05-29-2005 08:29 CEST
======================================================================
Summary:                    Distorted sound with enabled dmix plugin
Description: 
After 10-20 minutes listening music with xmms or beep-media-player I hear
distorted sound. Appear noise.
This problem is appear when enabled dmix plugin through configuration file
~/.asoundrc.
======================================================================

----------------------------------------------------------------------
 Xero - 05-29-05 08:23 
----------------------------------------------------------------------
I had this problem. It was fixed by running my card at a rate that is a
multiple of 44100. Dmix by default converts to 48000, and thus it occurs
in that case. I was running dmix at 96000, and it occured, I run it at
88200 and now it hasn't happened, well not atleast in the past day. It
seems you already have rate 44100 set though, so I suppose it's possible
we ran into different problems, unless you were playing mp3/oggs/etcs that
aren't 44100 perhaps?

btw I believe this is the same bug:
http://bugs.xmms.org/show_bug.cgi?id=1916

----------------------------------------------------------------------
 Xero - 05-29-05 08:29 
----------------------------------------------------------------------
hrm I should mention that I had upgraded to alsa 1.0.9 as well so that
MIGHT have been what fixed it, I see there was some commits made on the
19th. I was using 1.0.9rc3...I've switched back to 96000 and am going to
see if this happens again...

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
03-11-05 13:06 tvignaud       Note Added: 0003887                          
03-11-05 16:17 tiwai          Note Added: 0003891                          
03-23-05 20:46 tiwai          Note Added: 0004187                          
03-23-05 20:47 tiwai          File Added: dmix-slowptr.diff                    
03-25-05 14:56 tvignaud       Note Added: 0004206                          
03-29-05 16:21 tiwai          Note Added: 0004246                          
04-04-05 16:15 yure           Note Added: 0004327                          
04-29-05 09:07 mandreiana     Issue Monitored: mandreiana                    
05-29-05 08:23 Xero           Note Added: 0004781                          
05-29-05 08:29 Xero           Note Added: 0004782                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
