From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002173]: alsamixer ignores errors from
	setting mixer controls
Date: Tue, 30 May 2006 16:06:11 +0200
Message-ID: <9cc62f234830b8d10c1395d27b9ddb2c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C70AA14F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 16:06:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2173> 
======================================================================
Reported By:                Johannes Berg
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2173
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-30-2006 16:06 CEST
Last Modified:              05-30-2006 16:06 CEST
======================================================================
Summary:                    alsamixer ignores errors from setting mixer controls
Description: 
I have a driver that, under special circumstances, returns -EBUSY from a
_put call for a control.
alsamixer, however, ignores that and displays the control as toggled
anyway, which is misleading.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-06 16:06 Johannes Berg  New Issue                                    
======================================================================
