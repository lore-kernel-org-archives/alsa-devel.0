From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000641]: Bug in WM8770 init on aureon
Date: Thu, 11 Nov 2004 00:03:36 +0100
Message-ID: <e3781e92dc476519c4c0ebdaa03ff613@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6051223B
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2004 00:03:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=641> 
======================================================================
Reported By:                ungod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   641
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-11-2004 00:03 CET
Last Modified:              11-11-2004 00:03 CET
======================================================================
Summary:                    Bug in WM8770 init on aureon
Description: 
On aureon cards the ADC on WM8770 is initialized to AIN6L/AIN5R, although
the comment states AC'97.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-04 00:03 ungod          New Issue                                    
11-11-04 00:03 ungod          File Added: aureon-wm-init-fix.diff               
    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
