From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000630]: Too strict max periods constraints for dmix plugin
Date: Fri, 5 Nov 2004 11:31:49 +0100
Message-ID: <7ef92a2491b7a98ce060d0057dd03ade@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A5DE8251
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2004 11:31:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=630> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   630
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-05-2004 11:31 CET
Last Modified:              11-05-2004 11:31 CET
======================================================================
Summary:                    Too strict max periods constraints for dmix plugin
Description: 
See Debian bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=233200
(http://bugs.debian.org/233200).

The submitter reports:
> I encountered a problem with alsa-oss with some OSS only apps: they try
to limit the maximum number of fragments to a lower value than the number
of periods configured for dmix (the minimum number which provides smooth
playback with all ALSA apps), which fails.

The submitter also provides a patch.  The patch doesn't apply any longer
to alsa-oss.c but the code that it patches now appears in pcm.c.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-04 11:31 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
