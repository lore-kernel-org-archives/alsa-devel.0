From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001787]: Terratec Aureon Universe - No
	sound on first startup, sound after reboot
Date: Thu, 29 Jun 2006 00:34:53 +0200
Message-ID: <f25ac47cb4ddf67cc171921f2a1456e9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 814A0273
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 00:34:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1787> 
======================================================================
Reported By:                paskharen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1787
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.12
======================================================================
Date Submitted:             01-27-2006 19:58 CET
Last Modified:              06-29-2006 00:34 CEST
======================================================================
Summary:                    Terratec Aureon Universe - No sound on first
startup, sound after reboot
Description: 
When I first start the computer, you can hear no sound. If I turn all
volume to max and press my ear against the speaker I can hear the correct
sounds/music very faintly. After a reboot sound is fine.
======================================================================

----------------------------------------------------------------------
 paskharen - 04-08-06 16:58 
----------------------------------------------------------------------
I have now, it doesn't help. I tried with alsa 1.0.11-rc4 and not cvs but I
didn't think that would matter.

----------------------------------------------------------------------
 calestyo - 06-29-06 00:34 
----------------------------------------------------------------------
I have the same problem. At first boot I cannot change external amplifier
switch (btw: what is it good for?) and the sound is very very silent. This
also resolves if i mute/unmute the AC97 mixer element.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-06 19:58 paskharen      New Issue                                    
01-27-06 19:58 paskharen      Distribution              => Ubuntu          
01-27-06 19:58 paskharen      Kernel Version            => 2.6.12          
01-28-06 18:02 ungod          Note Added: 0007829                          
01-30-06 19:38 paskharen      Note Added: 0007841                          
02-08-06 23:48 paskharen      Note Added: 0007968                          
04-03-06 15:47 ungod          Note Added: 0009099                          
04-08-06 16:58 paskharen      Note Added: 0009172                          
06-29-06 00:34 calestyo       Note Added: 0010629                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
