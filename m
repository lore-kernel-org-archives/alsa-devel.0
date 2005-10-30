From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001320]: CA0106 with Soundblaster 24-bit live does not allow recording
Date: Sun, 30 Oct 2005 20:58:01 +0100
Message-ID: <4c573d1882ee4e576e441bdbd6185c87@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1134A170
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 20:58:02 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1320> 
======================================================================
Reported By:                ammiellodebar
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1320
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Arch Linux
Kernel Version:             
======================================================================
Date Submitted:             08-08-2005 06:03 CEST
Last Modified:              10-30-2005 20:58 CET
======================================================================
Summary:                    CA0106 with Soundblaster 24-bit live does not allow
recording
Description: 
When I use the line in on the card, it will not capture unless i crank up
the mixer to near peak, and then its garbled and distorted sound, my
capture is up all the way and i know its not a dumb mistake of mine


======================================================================

----------------------------------------------------------------------
 qqtortqq - 10-30-05 03:54 
----------------------------------------------------------------------
Passthrough works great starting with the latest version's RC1.  I have 5
jacks on my card, one is a line AND mic input, next is stereo out, then
rear out, then center/sub out, then SPDIF out.  I think that is the order.

----------------------------------------------------------------------
 jcdutton - 10-30-05 20:58 
----------------------------------------------------------------------
Ok, you have a card I do not recognise.
Can you post the output of:
lspci -vn | grep -1 0401
cat /proc/asound/version
cat /proc/asound/cards

I also need what model number is written on the sound card.
e.g. SB0410

Then, also point me to a url that shows a picture of the card.
This sounds like an Audigy LS, but I might be wrong.


Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 06:03 ammiellodebar  New Issue                                    
08-08-05 06:03 ammiellodebar  Distribution              => Arch Linux      
08-09-05 04:13 ammiellodebar  Note Added: 0005717                          
08-12-05 23:11 jcdutton       Note Added: 0005791                          
08-12-05 23:11 jcdutton       Status                   assigned => feedback
08-13-05 03:40 ammiellodebar  Note Added: 0005800                          
08-21-05 23:56 ammiellodebar  Note Added: 0005887                          
08-21-05 23:56 ammiellodebar  Note Edited: 0005717                         
09-10-05 10:36 jcdutton       Note Added: 0006108                          
09-10-05 18:15 ammiellodebar  Note Added: 0006124                          
09-15-05 06:37 qqtortqq       Note Added: 0006192                          
09-15-05 06:51 qqtortqq       Issue Monitored: qqtortqq                    
10-12-05 06:45 qqtortqq       Note Added: 0006461                          
10-23-05 19:37 jcdutton       Note Added: 0006513                          
10-30-05 03:54 qqtortqq       Note Added: 0006572                          
10-30-05 20:57 jcdutton       Status                   feedback => assigned
10-30-05 20:58 jcdutton       Note Added: 0006575                          
10-30-05 20:58 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
