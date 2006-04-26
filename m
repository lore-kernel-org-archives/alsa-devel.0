From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002067]: ALSA-libs 1.0.11 causes aRts to crash with a overload
Date: Thu, 27 Apr 2006 00:36:14 +0200
Message-ID: <8c8f26d48a27e614a7d66c4a5a2d987e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E97E815C
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 00:36:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2067> 
======================================================================
Reported By:                MysticMgcn
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2067
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-25-2006 06:26 CEST
Last Modified:              04-27-2006 00:36 CEST
======================================================================
Summary:                    ALSA-libs 1.0.11 causes aRts to crash with a
overload
Description: 
Upgrading to ALSA-libs 1.0.11 running Slackware Linux current using kernel
2.6.16.9 and KDE 3.5 with aRts 1.5.2 causes aRts to give a CPU overload
error every time a sound tries to be played. The audio controller in use
is VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev
50) using the snd-via82xx.

======================================================================

----------------------------------------------------------------------
 theoffset - 04-27-06 00:36 
----------------------------------------------------------------------
I'm having the same issue with Alsa-libs, 1.0.11, Kernel 2.6.16.11.
Alsa is compiled as modules from the Kernel sources.
aRts is 1.5.2
KDE is 3.5
if I run "top" from a terminal I can see aRts eating the CPU, this didn't
happen when using 1.0.11rc4.
It lasts a while running, and then pop-ups an error message saying 
"Sound server fatal error
cpu overload, aborting"
Audio card acording to lspci:
"00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: Elitegroup Computer Systems: Unknown device 0f60
        Flags: medium devsel, IRQ 19
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2"

I'm using snd_via82xx driver too.

Maybe I should report this in KDE too? I don't think I have to, since this
didn't happen in the last Alsalib RC, but it could be their fault and
something triggered this...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 06:26 MysticMgcn     New Issue                                    
04-27-06 00:25 theoffset      Issue Monitored: theoffset                    
04-27-06 00:36 theoffset      Note Added: 0009528                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
