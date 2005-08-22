From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001356]: Compile errors with 10.
Date: Mon, 22 Aug 2005 07:49:54 +0200
Message-ID: <773b11bae70ba49fbffbbea9d147b404@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD68D1FD
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2005 07:49:54 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-22-2005 00:01 CEST
Last Modified:              08-22-2005 07:49 CEST
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
 ammiellodebar - 08-22-05 00:02 
----------------------------------------------------------------------
10.0.10rc1 that is... it got cut off somehow

----------------------------------------------------------------------
 rlrevell - 08-22-05 07:49 
----------------------------------------------------------------------
2.6.8.1 is really old.  Does it work with the latest 2.6.12 kernel?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 00:01 ammiellodebar  New Issue                                    
08-22-05 00:01 ammiellodebar  Issue Monitored: ammiellodebar                    
08-22-05 00:02 ammiellodebar  Note Added: 0005888                          
08-22-05 07:49 rlrevell       Note Added: 0005889                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
