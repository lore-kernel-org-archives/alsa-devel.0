From: noreply@alsa-project.org
Subject: [ALSA - driver 0000007]: alsa-kernel/pci does NOT contain bt87x driver
Date: Wed, 28 Jan 2004 11:34:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040128103440.B42D030001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA07970
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2004 11:34:42 +0100
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


The following bug has been RESOLVED.
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000007
======================================================================
Reporter:                   yahoo
Handler:                    tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     7
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not a bug
======================================================================
Date Submitted:             01-28-2004 05:01 CET
Last Modified:              01-28-2004 11:34 CET
======================================================================
Summary:                    alsa-kernel/pci does NOT contain bt87x driver
Description: 
alsa-kernel/pci does NOT contain bt87x driver it is however 
present in alsa-driver/pci.
======================================================================

----------------------------------------------------------------------
 alexzapatka - 01-28-2004 06:46 CET 
----------------------------------------------------------------------
got tired of having to compile the kernel then recompile ALSA just for this
driver, so here is a quick patch to add it. one file contains the latest
ALSA bk patch from the ftp.alsa-project.org site
(alsa-bk-2004-01-25-plus-bt87x-audio.patch.bz2), the other is just the
patch that assumes you have ALREADY installed the latest bkpatch from the
site (alsa-bt87x-audio.patch.bz2), it probably wont work unless you have
2.6's alsa upgraded to 1.0.1 atleast, but who knows?

----------------------------------------------------------------------
 alexzapatka - 01-28-2004 06:52 CET 
----------------------------------------------------------------------
sorry... get the ones marked "new"... typo in the last ones...

----------------------------------------------------------------------
 tiwai - 01-28-2004 11:34 CET 
----------------------------------------------------------------------
it's intentional.

a new driver always goes to alsa-driver tree first for tests.
it will be moved to alsa-kernel tree, eventually submitted to
2.6 kernel.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-28-04 05:01 yahoo          New Bug                                      
01-28-04 06:43 alexzapatka    File Added: alsa-bk-2004-01-25-plus-bt87x-audio.patch.bz2                    
01-28-04 06:43 alexzapatka    File Added: alsa-bt87x-audio.patch.bz2                    
01-28-04 06:46 alexzapatka    Bugnote Added: 0000011                       
01-28-04 06:52 alexzapatka    Bugnote Added: 0000012                       
01-28-04 06:55 alexzapatka    File Added: alsa-bk-2004-01-25-plus-bt87x-audio.patch.new.bz2                    
01-28-04 06:57 alexzapatka    File Added: alsa-bk-2004-01-25-plus-bt87x-audio.patch.new.bz2                    
01-28-04 11:34 tiwai          Bugnote Added: 0000014                       
01-28-04 11:34 tiwai          Assigned To               => tiwai           
01-28-04 11:34 tiwai          Resolution               open => not a bug   
01-28-04 11:34 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
