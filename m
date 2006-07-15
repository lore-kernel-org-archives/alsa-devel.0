From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000403]: intel8x0 driver swaps channels
Date: Sat, 15 Jul 2006 07:49:48 +0200
Message-ID: <e508ad20abf4a1f18abb67d28db2d6c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF3D6226
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 07:49:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=403> 
======================================================================
Reported By:                phox
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   403
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.7-gentoo-r11
======================================================================
Date Submitted:             07-22-2004 22:27 CEST
Last Modified:              07-15-2006 07:49 CEST
======================================================================
Summary:                    intel8x0 driver swaps channels
Description: 
While using this driver rather successfully with my AD1981B codec/AMD8111
'southbridge', I have been experiencing random channel swaps at the start
of a PCM audio stream (usually using ALSA directly but recently this
happened with Quake 3 + OSS, unless Q3 suddenly has ALSA support that I
don't know about).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000949 Randomly, left and right tracks are swaped
======================================================================

----------------------------------------------------------------------
 phox - 07-15-06 07:49 
----------------------------------------------------------------------
Unfortunately I'm not running that board anymore, so I can't test.  If I
get my hands on it again for a while (which I may well) I will try to find
time to test.  This does seem to follow AMD8111 southbridges around.  What
hardware were attempts at reproducing made on?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-04 22:27 phox           New Issue                                    
07-22-04 22:27 phox           Distribution              => Gentoo          
07-22-04 22:27 phox           Kernel Version            => 2.6.7-gentoo-r11
07-22-04 22:54 eradicator     Issue Monitored: eradicator                    
03-04-05 19:30 NorbertB       Issue Monitored: NorbertB                    
03-22-05 22:30 jdthood        Relationship added       duplicate of 0000949
07-15-06 07:49 phox           Note Added: 0011018                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
