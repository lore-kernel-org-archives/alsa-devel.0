From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001356]: Compile errors with 10.
Date: Tue, 23 Aug 2005 14:28:55 +0200
Message-ID: <5ffc5e74f1f4668f43f777ec6cbaf8d3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87AA5156
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2005 14:28:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1356> 
======================================================================
Reported By:                ammiellodebar
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1356
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
Date Submitted:             08-22-2005 00:01 CEST
Last Modified:              08-23-2005 14:28 CEST
======================================================================
Summary:                    Compile errors with 10.
Description: 
In file included from
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/                
                                                                    
pci/ac97/ac97_bus.c:1:
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97/../../alsa-ke
                                                                          
         
rnel/pci/ac97/ac97_bus.c:28: error: parse error before "pm_message_t"
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97/../../alsa-ke
                                                                          
         
rnel/pci/ac97/ac97_bus.c:29: warning: function declaration isn't a
prototype
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97/../../alsa-ke
                                                                          
         
rnel/pci/ac97/ac97_bus.c: In function `ac97_bus_suspend':
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97/../../alsa-ke
                                                                          
         
rnel/pci/ac97/ac97_bus.c:32: error: `dev' undeclared (first use in this
function                                                                  
                  
)
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97/../../alsa-ke
                                                                          
         
rnel/pci/ac97/ac97_bus.c:32: error: (Each undeclared identifier is
reported only                                                             
                       
 once
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97/../../alsa-ke
                                                                          
         
rnel/pci/ac97/ac97_bus.c:32: error: for each function it appears in.)
/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97/../../alsa-ke
                                                                          
         
rnel/pci/ac97/ac97_bus.c:33: error: `state' undeclared (first use in this
functi                                                                    
                
on)
make[4]: ***
[/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97       
                                                                          
  
/ac97_bus.o] Error 1
make[3]: ***
[/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci/ac97       
                                                                          
  
] Error 2
make[2]: ***
[/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1/pci] Err       
                                                                          
  
or 2
make[1]: ***
[_module_/var/abs/multimedia/alsa-driver/src/alsa-driver-1.0.10rc1]       
                                                                          
  
 Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.8.1'
make: *** [compile] Error 2
======================================================================

----------------------------------------------------------------------
 ammiellodebar - 08-22-05 18:30 
----------------------------------------------------------------------
thanks for the patch! Works perfect! w00t!

----------------------------------------------------------------------
 perex - 08-23-05 14:28 
----------------------------------------------------------------------
ok, closing this bug, fixed in CVS

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 00:01 ammiellodebar  New Issue                                    
08-22-05 00:01 ammiellodebar  Issue Monitored: ammiellodebar                    
08-22-05 00:02 ammiellodebar  Note Added: 0005888                          
08-22-05 07:49 rlrevell       Note Added: 0005889                          
08-22-05 12:29 perex          Note Added: 0005892                          
08-22-05 12:29 perex          Status                   assigned => feedback
08-22-05 18:14 ammiellodebar  Note Added: 0005899                          
08-22-05 18:30 ammiellodebar  Note Added: 0005900                          
08-23-05 14:28 perex          Status                   feedback => resolved
08-23-05 14:28 perex          Resolution               open => fixed       
08-23-05 14:28 perex          Note Added: 0005903                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
