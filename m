From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002193]: kernel module fails to load
	for AD1986A chipset on ASUS A8N-VM
Date: Fri, 9 Jun 2006 04:06:38 +0200
Message-ID: <0c1cda4f9e4877edfaede50a224a0e6f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8A143175
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 04:06:38 +0200 (MEST)
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
Last Modified:              06-09-2006 04:06 CEST
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
 rbenech - 06-09-06 03:51 
----------------------------------------------------------------------
attached README.SuSE for reference.  It explains how alsa is configured on
SuSE.  It looks like since the Yast configuration tool won't complete
(because module won't load), none of these files are being created.  Now
to figure out how to get those kernel modules (they appear to come from
the kernel package)...

----------------------------------------------------------------------
 rlrevell - 06-09-06 04:06 
----------------------------------------------------------------------
It should be part of the kernel.

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
======================================================================
