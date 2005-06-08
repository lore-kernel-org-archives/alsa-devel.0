From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000881]: Distorted sound with enabled dmix plugin
Date: Wed, 8 Jun 2005 21:27:34 +0200
Message-ID: <04c60004f988112af298349896a71e52@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 284A9196
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 21:27:35 +0200 (MEST)
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
Last Modified:              06-08-2005 21:27 CEST
======================================================================
Summary:                    Distorted sound with enabled dmix plugin
Description: 
After 10-20 minutes listening music with xmms or beep-media-player I hear
distorted sound. Appear noise.
This problem is appear when enabled dmix plugin through configuration file
~/.asoundrc.
======================================================================

----------------------------------------------------------------------
 Xero - 06-08-05 21:13 
----------------------------------------------------------------------
how much bigger is much bigger? I'm running at the standard 1024/8192 for
period/buffer size. If that really is the problem then it's still odd that
this would happen at 96000 but not 88200, which is why I think it's more
related to sample rate conversion...I've attached my config file at 96000
for reference.  When in 88200 the only change is just that, 88200 instead
of 96000 in the rate section.

----------------------------------------------------------------------
 tiwai - 06-08-05 21:27 
----------------------------------------------------------------------
8192 buffer size corresponds to less than 0.1 second in 88.4/96kHz.  So,
the probability of XRUN is fairly high, I guess.

And, yes, the rate plugin is another cause of trouble.  This requires
another transport layer which copies the data asynchronously.  But the
biggest problem of the current rate plugin is that the drift of the
interrupt timing and the period position in the rate plugin buffer.  Since
44.1 and 48 can't be aligned in integer, the real and virtual period sizes
conflict.  This result in the irregular period updates.

Unfortunately, the problem of rate plugin above is _very_ hard to fix
(because of the principal definition of ALSA PCM).

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
06-08-05 21:13 Xero           Note Added: 0004973                          
06-08-05 21:27 tiwai          Note Added: 0004974                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
