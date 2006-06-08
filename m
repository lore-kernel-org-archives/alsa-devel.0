From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002193]: kernel module fails to load
	for AD1986A chipset on ASUS A8N-VM
Date: Thu, 8 Jun 2006 03:53:20 +0200
Message-ID: <aeaeb0e00e9830a64239b199189384fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E2FA6165
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 03:53:20 +0200 (MEST)
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
Last Modified:              06-08-2006 03:53 CEST
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
 rlrevell - 06-08-06 03:53 
----------------------------------------------------------------------
What error do you get from modprobe when the module fails to load?  It
should be loadable even if the hardware is not recognized.

What happens if you don't use yast and just do "modprobe snd-hda-intel" as
root?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-06 03:09 rbenech        New Issue                                    
06-08-06 03:09 rbenech        Distribution              => OpenSuSE        
06-08-06 03:09 rbenech        Kernel Version            => 2.6.16.13-4-smp 
06-08-06 03:53 rlrevell       Note Added: 0010106                          
======================================================================
