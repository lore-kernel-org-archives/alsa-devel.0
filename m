From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002169]: Generic codec - wrong
	connection list handling
Date: Sun, 28 May 2006 20:08:16 +0200
Message-ID: <ca2c13f355c97733a741eefc40990bef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 483D1186
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 20:08:16 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2169> 
======================================================================
Reported By:                pototskiy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2169
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-28-2006 20:08 CEST
Last Modified:              05-28-2006 20:08 CEST
======================================================================
Summary:                    Generic codec - wrong connection list handling
Description: 
module: hda_generic.c
function: add_new_node

"nconns" bytes copyed insted of "sizeof(hda_nid_t) * nconns"
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-06 20:08 pototskiy      New Issue                                    
======================================================================
