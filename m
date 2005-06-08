From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000881]: Distorted sound with enabled dmix plugin
Date: Wed, 8 Jun 2005 16:08:37 +0200
Message-ID: <886b9eb721d5fb444cecbe146b7f7c12@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0FDD11F2
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 16:08:37 +0200 (MEST)
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
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2005 12:25 CET
Last Modified:              06-08-2005 16:08 CEST
======================================================================
Summary:                    Distorted sound with enabled dmix plugin
Description: 
After 10-20 minutes listening music with xmms or beep-media-player I hear
distorted sound. Appear noise.
This problem is appear when enabled dmix plugin through configuration file
~/.asoundrc.
======================================================================

----------------------------------------------------------------------
 Xero - 06-03-05 07:40 
----------------------------------------------------------------------
this doesn't happen as much with alsa 1.0.9 but still happens occasionally.
I also would get random clicks and pops which was pretty annoying by
itself. I still haven't had this issue when running at a sample rate that
is a multiple of 44100...my card is an echo mia midi btw...

----------------------------------------------------------------------
 tiwai - 06-08-05 16:08 
----------------------------------------------------------------------
I guess it's rather a problem with a specific driver.  The dmix is very
sensitive to the accuracy of DMA pointer.  If the driver returns a wrong
DMA pointer, it may result in noises.

Also, for 96kHz, you'd need much bigger buffer and period sizes than 48k. 
Otherwise usual xruns can happen.  I suspect xruns rather the existing
dmix bugs...

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
06-03-05 07:40 Xero           Note Added: 0004882                          
06-08-05 16:08 tiwai          Note Added: 0004944                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
