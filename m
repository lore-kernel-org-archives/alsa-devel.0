From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001567]: alsa-lib's default config assumes existence of audio group
Date: Wed, 16 Nov 2005 17:42:54 +0100
Message-ID: <908105bc42989a27c5b810efe41d5fff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E7DF21CC
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 17:42:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1567> 
======================================================================
Reported By:                thimm
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1567
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-16-2005 17:42 CET
Last Modified:              11-16-2005 17:42 CET
======================================================================
Summary:                    alsa-lib's default config assumes existence of audio
group
Description: 
The defaut setting for dmix.conf and other config files contain

ipc_gid audio

This group is not defined on Red Hat/Fedora Core.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-16-05 17:42 thimm          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
