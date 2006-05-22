From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002132]: No sound from speakers
Date: Mon, 22 May 2006 02:53:51 +0200
Message-ID: <1ed4cc057370a5fb5341c03f765472ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0D0122C
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2006 02:53:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2132> 
======================================================================
Reported By:                bzbarsky
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2132
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-17-2006 19:54 CEST
Last Modified:              05-22-2006 02:53 CEST
======================================================================
Summary:                    No sound from speakers
Description: 
Alsa seems to detect the sound card, but when I try to actually play
something there is no sound from the speakers.
======================================================================

----------------------------------------------------------------------
 Raymond - 05-21-06 03:48 
----------------------------------------------------------------------
"Phone" is normal, but "Caller ID" and "off hook" ctrl only exist in modem
(MC97)

What is the model of the motherboard ?

Please post the output of

cat /proc/asound/card0/codec97#0/ac97#0-0

cat /proc/asound/card0/codec97#0/ac97#0-0+regs



----------------------------------------------------------------------
 bzbarsky - 05-22-06 02:53 
----------------------------------------------------------------------
The motherboard is a Tyan board; I believe it's an S1854A (Trinity 400). 
I've attached the two files.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-17-06 19:54 bzbarsky       New Issue                                    
05-17-06 19:54 bzbarsky       File Added: lspci.txt                        
05-17-06 19:54 bzbarsky       Distribution              => Fedora Core 4   
05-17-06 19:54 bzbarsky       Kernel Version            => 2.6.15          
05-17-06 19:55 bzbarsky       File Added: lspci-n.txt                      
05-17-06 19:55 bzbarsky       Issue Monitored: bzbarsky                    
05-17-06 19:56 bzbarsky       File Added: scsound.log                      
05-17-06 19:57 bzbarsky       Note Added: 0009857                          
05-20-06 05:31 Raymond        Note Added: 0009882                          
05-20-06 21:43 bzbarsky       Note Added: 0009893                          
05-21-06 03:41 Raymond        Note Added: 0009894                          
05-21-06 03:48 Raymond        Note Edited: 0009894                         
05-22-06 02:47 bzbarsky       File Added: ac97#0-0                         
05-22-06 02:48 bzbarsky       File Added: ac97#0-0+regs                    
05-22-06 02:53 bzbarsky       Note Added: 0009901                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
