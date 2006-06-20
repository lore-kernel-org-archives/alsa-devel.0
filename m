From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002213]: hda-intel: no sound on nForce
	ALC880 (10de:026c)
Date: Tue, 20 Jun 2006 19:56:26 +0200
Message-ID: <2d915a00a44cf4f6f71e1e9f49b8ab92@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C160176
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 19:56:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2213> 
======================================================================
Reported By:                gmaynard
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2213
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.16.20
======================================================================
Date Submitted:             06-16-2006 20:55 CEST
Last Modified:              06-20-2006 19:56 CEST
======================================================================
Summary:                    hda-intel: no sound on nForce ALC880 (10de:026c)
Description: 
aplay says: "underrun!!! (at least 0.033 ms long)" continuously.  First
sound played causes:

  hda-intel: Invalid position buffer, using LPIB read method instead.

in kmsg.  Dumping the results of azx_pcm_pointer shows pos to always be 0,
even after that.  No change with model, position_fix, single_cmd
parameters, or either 2.6.12rc3 and 2.6.16.20 kernels (always using ALSA
1.0.11).

(The motherboard is Gigabyte "GA-K8N51PVM9-RH", nForce 430 based.)

Similar to #2174, but that has no mention of aplay messages or kernel
logs, and is Intel.

======================================================================

----------------------------------------------------------------------
 tiwai - 06-20-06 19:56 
----------------------------------------------------------------------
It's likely a hardware or a BIOS problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-06 20:55 gmaynard       New Issue                                    
06-16-06 20:55 gmaynard       Kernel Version            => 2.6.16.20       
06-16-06 20:55 gmaynard       File Added: codec#0                          
06-16-06 20:55 gmaynard       File Added: lspci                            
06-20-06 19:56 tiwai          Note Added: 0010352                          
======================================================================
