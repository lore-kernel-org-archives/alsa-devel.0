From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001189]: Aureon 7.1 Universe needs
	manual rate in .asoundrc when changing internal clock
Date: Sat, 15 Jul 2006 22:08:03 +0200
Message-ID: <e0015d566db1668f6aa98b564e67ce2b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 93100164
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 22:08:03 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1189> 
======================================================================
Reported By:                BrianMeidell
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1189
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.11-gentoo-r3
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             06-13-2005 22:33 CEST
Last Modified:              07-15-2006 22:08 CEST
======================================================================
Summary:                    Aureon 7.1 Universe needs manual rate in .asoundrc
when changing internal clock
Description: 
When changing the master internal clock rate on my aureon 7.1 universe, I
also need to manually set the rate in .asoundrc for the device and match
it to the alsamixer setting, otherwise it defaults to what sounds like
44.1 KHz.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-15-05 14:39 
----------------------------------------------------------------------
Turn off "Multi Track Rate Locking" switch if it's on?  Otherwise the
hardware won't follow the sample rate the app sets.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-13-05 22:33 BrianMeidell   New Issue                                    
06-13-05 22:33 BrianMeidell   Distribution              => Gentoo          
06-13-05 22:33 BrianMeidell   Kernel Version            => 2.6.11-gentoo-r3
06-13-05 22:35 BrianMeidell   Issue Monitored: BrianMeidell                    
06-15-05 14:39 tiwai          Note Added: 0005025                          
07-15-06 22:08 Adrian Bunk    Status                   new => closed       
07-15-06 22:08 Adrian Bunk    Resolution               open => not an issue
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
