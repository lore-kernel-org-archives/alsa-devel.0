From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000448]: System hangs up
Date: Mon, 10 Jul 2006 17:58:01 +0200
Message-ID: <276ddd44278392dc8d0585f9f1f6e5ca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 13827244
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 17:58:02 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=448> 
======================================================================
Reported By:                zadnica
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   448
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             08-17-2004 13:02 CEST
Last Modified:              07-10-2006 17:58 CEST
======================================================================
Summary:                    System hangs up
Description: 
Systems hangs up, when modules snd-via82xx is loaded. When I using OSS
module via82cxxx_audio everything works fine.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-06-04 18:29 
----------------------------------------------------------------------
Hmm, then I'd say it's a bug of BIOS.

We can add a workaround code, of course, although it's really
ugly and I'd like to avoid it as much as possible...

----------------------------------------------------------------------
 jdthood - 04-09-05 14:23 
----------------------------------------------------------------------
sventura: Was this bug fixed or worked around in a later ALSA release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-04 13:02 zadnica        New Issue                                    
08-22-04 09:51 sventura       Note Added: 0001607                          
08-22-04 09:52 sventura       File Added: myvia82xx.tar.gz                    
08-23-04 14:59 tiwai          Note Added: 0001611                          
08-23-04 14:59 tiwai          File Added: via-crash-fix.dif                    
09-06-04 18:25 sventura       Note Added: 0001700                          
09-06-04 18:26 sventura       Note Edited: 0001700                         
09-06-04 18:27 sventura       Note Edited: 0001700                         
09-06-04 18:29 tiwai          Note Added: 0001701                          
09-06-04 18:40 sventura       File Added: via-bug448-fix.diff                   

04-09-05 14:23 jdthood        Note Added: 0004395                          
07-10-06 17:58 Adrian Bunk    Status                   new => resolved     
07-10-06 17:58 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
