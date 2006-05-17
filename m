From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002127]: speaker mute on sony vaio vgn-a497xp
Date: Wed, 17 May 2006 13:08:00 +0200
Message-ID: <109223f661124548c61f4fad768b8edd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28E071A2
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 13:08:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2127> 
======================================================================
Reported By:                febelus
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2127
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               fedora core 5
Kernel Version:             2.6.16-1.2096_FC5
======================================================================
Date Submitted:             05-15-2006 17:37 CEST
Last Modified:              05-17-2006 13:07 CEST
======================================================================
Summary:                    speaker mute on sony vaio vgn-a497xp
Description: 
i've install fc5 on my sony vaio vgn-a497xp and i've unmute all channell
with alsamixer but the speaker are mute.
======================================================================

----------------------------------------------------------------------
 febelus - 05-17-06 09:50 
----------------------------------------------------------------------
i unmute the mixer and raise to max all channell volumes!!!!i've try alsa
1.0.11 but nothingh...

----------------------------------------------------------------------
 tiwai - 05-17-06 13:07 
----------------------------------------------------------------------
Did you install ALSA 1.0.11 _drivers_ ?  Some VAIO laptops don't work well
with ALSA drivers in 2.6.16.x kernel tree.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-15-06 17:37 febelus        New Issue                                    
05-15-06 17:37 febelus        File Added: scsound.log                      
05-15-06 17:37 febelus        Distribution              => fedora core 5   
05-15-06 17:37 febelus        Kernel Version            => 2.6.16-1.2096_FC5
05-17-06 02:10 rlrevell       Note Added: 0009843                          
05-17-06 02:12 rlrevell       Note Added: 0009844                          
05-17-06 09:50 febelus        Note Added: 0009845                          
05-17-06 13:07 tiwai          Note Added: 0009847                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
