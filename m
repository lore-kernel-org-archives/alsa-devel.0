From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001551]: No mute switch to mixer channel
Date: Sat, 6 May 2006 01:22:33 +0200
Message-ID: <091d5f609104a8a1bb5fbc34f0607284@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D529616D
	for <alsa-devel@alsa-project.org>; Sat,  6 May 2006 01:22:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1551> 
======================================================================
Reported By:                Shogun
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1551
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.13-gentoo-r3
======================================================================
Date Submitted:             11-13-2005 13:16 CET
Last Modified:              05-06-2006 01:22 CEST
======================================================================
Summary:                    No mute switch to mixer channel
Description: 
I have a SoundBlaster Audigy 2 ZS (without LiveDrive)...
When I load the modules the sound works perfectly, but in the mixer (both
alsa-mixer and kmix) I can't see any mute switch for the mixer
channel...The only channel which has the switch is the Headphone...

I don't know if previous version worked...
======================================================================

----------------------------------------------------------------------
 Shogun - 11-13-05 14:05 
----------------------------------------------------------------------
I forgot to mention that this issue is also present in 1.0.8 and in
1.0.10rc3...

----------------------------------------------------------------------
 Shogun - 05-06-06 01:22 
----------------------------------------------------------------------
Still here with kernel 2.6.16 and ALSA 1.0.11...
What's wrong guys? Why doesn't the mixer works?

As I read in source code, the master mute has no effect on the card...so I
think it's not supported...but is there any way to accomplish a standard
behaviour?

Thanks...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 13:16 Shogun         New Issue                                    
11-13-05 13:16 Shogun         Distribution              => Gentoo Linux 2005.1
11-13-05 13:16 Shogun         Kernel Version            => 2.6.13-gentoo-r3
11-13-05 14:05 Shogun         Note Added: 0006691                          
05-06-06 01:22 Shogun         Note Added: 0009634                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
