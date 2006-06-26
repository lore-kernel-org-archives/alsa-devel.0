From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002198]: No sound out of the built in
	speakers, but from headphones on a Apple MacBook Pro
Date: Mon, 26 Jun 2006 16:08:47 +0200
Message-ID: <ed9ddd07580bdd8928c4e55f4f14b336@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C5071A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 16:08:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2198> 
======================================================================
Reported By:                enlighter
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2198
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.16.16
======================================================================
Date Submitted:             06-09-2006 12:09 CEST
Last Modified:              06-26-2006 16:08 CEST
======================================================================
Summary:                    No sound out of the built in speakers, but from
headphones on a Apple MacBook Pro
Description: 
Hi,

this error occours on all macbook pros! (see www.mactel-linux.org). Sound
comes only out of the headphones or out of line-out, but the internal
speakers keep mute. I cannot unmute them using the mixer (alsamixer,
kmix). I also tried a rc version of linux-2.6.17 with the same result.

I also tried to load the snd-hda-intel module with "model=laptop" and
"model=laptop-eapd".
======================================================================

----------------------------------------------------------------------
 enlighter - 06-25-06 20:17 
----------------------------------------------------------------------
No luck using linux-2.6.17-git6.

----------------------------------------------------------------------
 tiwai - 06-26-06 16:08 
----------------------------------------------------------------------
Don't specify any model option for STAC codecs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-06 12:09 enlighter      New Issue                                    
06-09-06 12:09 enlighter      Distribution              => Gentoo Linux    
06-09-06 12:09 enlighter      Kernel Version            => 2.6.16.16       
06-14-06 09:47 enlighter      Issue Monitored: enlighter                    
06-18-06 09:27 enlighter      Note Added: 0010297                          
06-18-06 09:29 enlighter      Note Added: 0010298                          
06-25-06 20:17 enlighter      Note Added: 0010518                          
06-26-06 16:08 tiwai          Note Added: 0010541                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
