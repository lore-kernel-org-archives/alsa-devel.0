From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000451]: Corruption in /etc/asound.state causes alsa to hang when restoring mixer levels during reboot.
Date: Wed, 18 Aug 2004 10:00:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818080012.4352D1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9CD04279
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 10:00:12 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 5503C18D28
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 10:00:12 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000451
======================================================================
Reported By:                cuardin
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     451
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-18-2004 10:00 CEST
Last Modified:              08-18-2004 10:00 CEST
======================================================================
Summary:                    Corruption in /etc/asound.state causes alsa to hang when restoring mixer levels during reboot.
Description: 
If the file /etc/asound.state is corrupted, for example due to a
file-system corruption after a hard-reboot, the boot process will halt
when attempting to restore the mixer settings. Pressing Ctrl-C will resume
the boot process. 

Upon shutdown, the process will halt when attempting to store mixer
settings requiring a hard reboot.

A work-around is to delete the offending file. 
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 10:00 cuardin        New Bug                                      
08-18-04 10:00 cuardin        File Added: asound.state                     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
