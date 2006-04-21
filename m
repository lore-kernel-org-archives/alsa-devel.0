From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002052]: Usiung onboard Intel ICH4 AC'97 Audio results in no audio until switch is turned off
Date: Fri, 21 Apr 2006 16:31:29 +0200
Message-ID: <5c39c84b9a7811a4af136927f42e0fc7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 060F717B
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2006 16:31:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2052> 
======================================================================
Reported By:                n0yd
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2052
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-21-2006 16:20 CEST
Last Modified:              04-21-2006 16:31 CEST
======================================================================
Summary:                    Usiung onboard Intel ICH4 AC'97 Audio results in no
audio until switch is turned off
Description: 
Using the Intel ICH4/AC'97 sound (usually built on laptops) what happens is
the sound will not work until the user goes into alsamixer (or the mixer
of their choice) and switches off the "External Amplifier" switch
======================================================================

----------------------------------------------------------------------
 tiwai - 04-21-06 16:31 
----------------------------------------------------------------------
Try ac97_quirk=inv_eapd module option for snd-intel8x0 driver.

If this helps, show the output of "lspci -nv" (for class 0401) to enable
it as default for your device.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 16:20 n0yd           New Issue                                    
04-21-06 16:20 n0yd           Kernel Version            => 2.6.15          
04-21-06 16:31 tiwai          Note Added: 0009413                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
