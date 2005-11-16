From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001562]: Problem setting the capture port with sset
Date: Wed, 16 Nov 2005 03:47:57 +0100
Message-ID: <e1ccdd3dfb9e4d5c5722e811eff73662@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA5DB1AB
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 03:47:57 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1562> 
======================================================================
Reported By:                SFairchild
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1562
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-16-2005 03:47 CET
Last Modified:              11-16-2005 03:47 CET
======================================================================
Summary:                    Problem setting the capture port with sset
Description: 
The following does not work for me.
amixer -c 0 sset Line,0 cap

Nor does trying to set it in alsamixer work either.

It reports that capture has been set on the Line input source but it has
not.
I was using 1.0.9b yesterday and it only set the left audio channel.  I am
now on 1.0.10 and now nothing is happening.

The following works however but its not as easy to use since it needs a
number rather than a name and presumably isn't very portable.
amixer -c 0 cset iface=MIXER,name='Capture Source' 4

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-16-05 03:47 SFairchild     New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
