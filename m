From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002193]: kernel module fails to load
	for AD1986A chipset on ASUS A8N-VM
Date: Sat, 15 Jul 2006 00:32:31 +0200
Message-ID: <67e2ede16b69f7070127c5cddf30333e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C36EF21D
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 00:32:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2193> 
======================================================================
Reported By:                rbenech
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2193
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               OpenSuSE
Kernel Version:             2.6.16.13-4-smp
======================================================================
Date Submitted:             06-08-2006 03:09 CEST
Last Modified:              07-15-2006 00:32 CEST
======================================================================
Summary:                    kernel module fails to load for AD1986A chipset on
ASUS A8N-VM
Description: 
With alsa-1.0.11-32, SuSE 10.1 Yast Hardware Sound detects hardware as
"MCP51 High Definition Audio" but cannot complete setup.  With SuSE10
(<alsa-1.0.11rc3), yast would not detect any card.

Similar to fixed issue #0001793. Dupe of issue #0001632, but
miscategorized/flamed.

Tried all 'model=' and 'position_fix=' options I could find in other
issues. Nothing allowed kernel module to load.

I also tried OSS, module also failed to load...
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-10-06 19:03 
----------------------------------------------------------------------
You should not need to know the driver, your distro should detect it.

If it's failing try "snd-hda-intel"

----------------------------------------------------------------------
 rbenech - 07-15-06 00:32 
----------------------------------------------------------------------
I finally got it working after re-installing the stock kernel package with
SuSE's YaST.  Technically, I installed the single processor kernel, then
re-installed the SMP kernel. Rebooted the machine, and used Yast to
configure the card (it was detected).  Everything that I tried so far
works! You may close this issue.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-06 03:09 rbenech        New Issue                                    
06-08-06 03:09 rbenech        Distribution              => OpenSuSE        
06-08-06 03:09 rbenech        Kernel Version            => 2.6.16.13-4-smp 
06-08-06 03:53 rlrevell       Note Added: 0010106                          
06-09-06 02:34 rbenech        Note Added: 0010120                          
06-09-06 02:41 rlrevell       Note Added: 0010121                          
06-09-06 02:51 rbenech        Note Added: 0010122                          
06-09-06 02:57 rlrevell       Note Added: 0010123                          
06-09-06 03:25 rbenech        Note Added: 0010124                          
06-09-06 03:43 rbenech        Note Added: 0010127                          
06-09-06 03:50 rbenech        File Added: README.SuSE                      
06-09-06 03:51 rbenech        Note Added: 0010128                          
06-09-06 04:06 rlrevell       Note Added: 0010129                          
06-10-06 01:42 heavytull      Note Added: 0010143                          
06-10-06 19:03 rlrevell       Note Added: 0010148                          
07-15-06 00:32 rbenech        Note Added: 0011011                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
