From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000775]: Truble with build of alsa 1.0.8rc1 on 2.6.10!
Date: Mon, 3 Jan 2005 12:13:18 +0100
Message-ID: <33a0568382862d9b6a75e7339ab3c55d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D1EBE2B6
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 12:13:18 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=775> 
======================================================================
Reported By:                cyclon
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   775
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-02-2005 11:03 CET
Last Modified:              01-03-2005 12:13 CET
======================================================================
Summary:                    Truble with build of alsa 1.0.8rc1 on 2.6.10!
Description: 
  LD [M]  /root/alsa-driver-1.0.8rc1/pci/nm256/snd-nm256.o
  CC [M]  /root/alsa-driver-1.0.8rc1/pci/pcxhr/pcxhr.o
  CC [M]  /root/alsa-driver-1.0.8rc1/pci/pcxhr/pcxhr_hwdep.o
In file included from
/root/alsa-driver-1.0.8rc1/pci/pcxhr/pcxhr_hwdep.c:25:
include/linux/firmware.h:11: warning: `struct device' declared inside
parameterlist
include/linux/firmware.h:11: warning: its scope is only this definition or
declaration, which is probably not what you want
include/linux/firmware.h:15: warning: `struct device' declared inside
parameterlist
/root/alsa-driver-1.0.8rc1/pci/pcxhr/pcxhr_hwdep.c: In function
`pcxhr_setup_firmware':
/root/alsa-driver-1.0.8rc1/pci/pcxhr/pcxhr_hwdep.c:212: error:
dereferencing pointer to incomplete type
make[5]: *** [/root/alsa-driver-1.0.8rc1/pci/pcxhr/pcxhr_hwdep.o] Error 1
make[4]: *** [/root/alsa-driver-1.0.8rc1/pci/pcxhr] Error 2
make[3]: *** [/root/alsa-driver-1.0.8rc1/pci] Error 2
make[2]: *** [_module_/root/alsa-driver-1.0.8rc1] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10-gentoo-r1-na'
make: *** [compile] Error 2


======================================================================

----------------------------------------------------------------------
 tiwai - 01-03-05 12:13 
----------------------------------------------------------------------
Already fixed in CVS.

You can avoid by adding --with-debug option to configure, too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 11:03 cyclon         New Issue                                    
01-03-05 12:13 tiwai          Status                   assigned => resolved
01-03-05 12:13 tiwai          Resolution               open => fixed       
01-03-05 12:13 tiwai          Note Added: 0003056                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
