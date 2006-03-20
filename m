From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001947]: Out-of-tree kernel drivers break when nodevfs patches are applied
Date: Tue, 21 Mar 2006 00:14:02 +0100
Message-ID: <695514664b70d7b4556dae40c8dacd03@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A24561FF
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 00:14:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1947> 
======================================================================
Reported By:                avuton
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1947
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-21-2006 00:14 CET
Last Modified:              03-21-2006 00:14 CET
======================================================================
Summary:                    Out-of-tree kernel drivers break when nodevfs
patches are applied
Description: 
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/

The patches to remove devfs will probably make it into the kernel sooner
or later, but they do break the out-of-tree kernel drivers. I get the
following warning.

WARNING: //lib/modules/2.6.16/alsa-driver/acore/snd.ko needs unknown
symbol devfs_mk_dir
WARNING: //lib/modules/2.6.16/alsa-driver/acore/snd.ko needs unknown
symbol devfs_mk_cdev
WARNING: //lib/modules/2.6.16/alsa-driver/acore/snd.ko needs unknown
symbol devfs_remove   
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-06 00:14 avuton         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
