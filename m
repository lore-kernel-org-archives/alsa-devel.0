From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002067]: ALSA-libs 1.0.11 causes aRts to crash with a overload
Date: Thu, 27 Apr 2006 15:54:10 +0200
Message-ID: <e11130d0e1ec634e0468f418465594d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1998215A
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 15:54:10 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2067> 
======================================================================
Reported By:                MysticMgcn
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   2067
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-25-2006 06:26 CEST
Last Modified:              04-27-2006 15:54 CEST
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

----------------------------------------------------------------------
 tiwai - 04-27-06 15:54 
----------------------------------------------------------------------
Fixed on Hg repo.

Another workaround is to set up dxs_support module option properly (very
likely dxs_support=5).  You must have a kernel warning message like
"via82xx: Assuming DXS channels with 48k fixed sample rate" since your
hardware is unknown for the driver to work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 06:26 MysticMgcn     New Issue                                    
04-27-06 00:25 theoffset      Issue Monitored: theoffset                    
04-27-06 00:36 theoffset      Note Added: 0009528                          
04-27-06 15:54 tiwai          Status                   new => resolved     
04-27-06 15:54 tiwai          Resolution               open => fixed       
04-27-06 15:54 tiwai          Assigned To               => tiwai           
04-27-06 15:54 tiwai          Note Added: 0009530                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
