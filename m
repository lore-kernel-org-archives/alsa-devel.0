From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000998]: access to second playback
	hangs
Date: Fri, 14 Jul 2006 15:54:37 +0200
Message-ID: <3ed977c24de5a01439299fe89c22c932@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B969F13D
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 15:54:37 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=998> 
======================================================================
Reported By:                allefant
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   998
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.10-6
======================================================================
Date Submitted:             03-19-2005 00:16 CET
Last Modified:              07-14-2006 15:54 CEST
======================================================================
Summary:                    access to second playback hangs
Description: 
This is haunting my since about half a year, since I got this card. Every
time the second playback device is accessed, there's a complete hardware
freeze. Disabling the second playback device makes it work. I know, this
isn't the best report, since I didn't compile the latest version and did
not much testing (no fun getting constant HW freezes) - but anyway, I
thought I report it here, maybe my workaround can help someone who googles
for this problems at least (or, maybe someone can give me even a hint how
to fix it).
======================================================================

----------------------------------------------------------------------
 allefant - 04-06-05 12:49 
----------------------------------------------------------------------
Hm, should I re-submit it as bug for 1.0.9rc2? I can't figure out how to
change the version field..

----------------------------------------------------------------------
 Raymond - 07-14-06 15:54 
----------------------------------------------------------------------
The driver only allow either playback on second subdevice or capture but
not both together.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 00:16 allefant       New Issue                                    
03-19-05 00:16 allefant       Distribution              => Debian sid      
03-19-05 00:16 allefant       Kernel Version            => 2.6.10-6        
04-06-05 00:30 allefant       Note Added: 0004344                          
04-06-05 12:34 allefant       Note Added: 0004345                          
04-06-05 12:49 allefant       Note Added: 0004346                          
07-14-06 15:54 Raymond        Note Added: 0010999                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
