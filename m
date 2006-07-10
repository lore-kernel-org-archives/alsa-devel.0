From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002201]: Duplicate of Issue 0001622 -
	Sound freezes after less a second of play
Date: Mon, 10 Jul 2006 18:10:19 +0200
Message-ID: <b3bcbc32df897a7072cbe6151f1272c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D2AAD167
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 18:10:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2201> 
======================================================================
Reported By:                ggeorgak
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2201
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               OpenSuSE
Kernel Version:             2.6.16.13-4-smp
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-12-2006 02:55 CEST
Last Modified:              07-10-2006 18:10 CEST
======================================================================
Summary:                    Duplicate of Issue 0001622 - Sound freezes after
less a second of play
Description: 
It's a duplicate of issue 0001622, though that issue is marked as resolved
and the patch is upstreamed to newer versions of alsa (1.0.9 mentioned
there). Again the motheroboard is Asus A8V-MX with onboard Realtek AC97
sound chip. Glady I will provide any information asked.
======================================================================

----------------------------------------------------------------------
 ggeorgak - 06-12-06 04:46 
----------------------------------------------------------------------
You mean it's still problematic from 1.0.9 because I have the release
candidate 3 version? Any rpm repositories that you know of?

----------------------------------------------------------------------
 rlrevell - 06-12-06 04:51 
----------------------------------------------------------------------
Yes, the bug was fixed between 1.0.11-rc3 and 1.0.11.

Sorry, I don't know any RPM repositories.  You may have to wait for your
distro to release an ALSA 1.0.11 package.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 02:55 ggeorgak       New Issue                                    
06-12-06 02:55 ggeorgak       Distribution              => OpenSuSE        
06-12-06 02:55 ggeorgak       Kernel Version            => 2.6.16.13-4-smp 
06-12-06 02:56 ggeorgak       Issue Monitored: ggeorgak                    
06-12-06 03:07 rlrevell       Note Added: 0010156                          
06-12-06 04:15 ggeorgak       Note Added: 0010159                          
06-12-06 04:34 rlrevell       Note Added: 0010160                          
06-12-06 04:46 ggeorgak       Note Added: 0010162                          
06-12-06 04:51 rlrevell       Note Added: 0010163                          
07-10-06 18:10 Adrian Bunk    Status                   new => resolved     
07-10-06 18:10 Adrian Bunk    Resolution               open => fixed       
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
