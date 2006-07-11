From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002273]: no hwmixing on hda-intel and
	ICH7 chipset
Date: Tue, 11 Jul 2006 17:28:37 +0200
Message-ID: <e0193d8704942197bb31b05de947296b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 14C6824B
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 17:28:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2273> 
======================================================================
Reported By:                swar0g
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2273
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian unstable
Kernel Version:             2.6.17.1
======================================================================
Date Submitted:             07-11-2006 16:51 CEST
Last Modified:              07-11-2006 17:28 CEST
======================================================================
Summary:                    no hwmixing on hda-intel and ICH7 chipset
Description: 
Sound works, but only one application can use the soundcard at the same
time.


Same problem with earlier alsa versions (e.g. alsa driver 1.0.11)



======================================================================

----------------------------------------------------------------------
 rlrevell - 07-11-06 17:28 
----------------------------------------------------------------------
How are you testing it?  This device has no hardware mixing, it requires
software mixing (dmix) which should be enabled automatically.

Try running two "aplay file.wav" processes at the same time, does that
work?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-06 16:51 swar0g         New Issue                                    
07-11-06 16:51 swar0g         Distribution              => debian unstable 
07-11-06 16:51 swar0g         Kernel Version            => 2.6.17.1        
07-11-06 17:28 rlrevell       Note Added: 0010976                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
