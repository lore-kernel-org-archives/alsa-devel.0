From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001549]: Any chance for SPDIF support soon with the ALC880?
Date: Fri, 18 Nov 2005 18:32:41 +0100
Message-ID: <fdfd42094e7227d01322d373a7ae69cd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8B0CB187
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2005 18:32:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1549> 
======================================================================
Reported By:                dvlierop
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1549
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-12-2005 11:05 CET
Last Modified:              11-18-2005 18:32 CET
======================================================================
Summary:                    Any chance for SPDIF support soon with the ALC880?
Description: 
On my Shuttle ST20G5 I don't get any digital output at all so I guess It's
not supported. Any outlook for SPDIF support? (or is it already included
and is something wrong with my system?)

Specs: Shuttle ST20G5 barebone with Realtek ALC880, AMD Athlon 64 3000+
======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 11:07 
----------------------------------------------------------------------
SPDIF is supported with ALC880. Try these options for snd-hda-codec
module:

model="5stack-digout"
model="3stack-digout"

Please, report also contents from /proc/asound/card0/codec#0 file.

----------------------------------------------------------------------
 dvlierop - 11-18-05 18:32 
----------------------------------------------------------------------
Thanks, that did the trick! Maybe I should have read the documentation more
carefully...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 11:05 dvlierop       New Issue                                    
11-14-05 11:07 perex          Note Added: 0006715                          
11-14-05 11:07 perex          Assigned To              tiwai => perex      
11-14-05 11:07 perex          Status                   assigned => feedback
11-18-05 18:32 dvlierop       Note Added: 0006755                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
