From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002146]: No sound for 'SigmaTel ID 7634' Codec
Date: Tue, 23 May 2006 21:25:08 +0200
Message-ID: <3ccbbbd7c8070c61133cdd6084f3f32f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F63B162
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 21:25:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2146> 
======================================================================
Reported By:                ig88b
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2146
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-gentoo-r3
======================================================================
Date Submitted:             05-23-2006 03:17 CEST
Last Modified:              05-23-2006 21:25 CEST
======================================================================
Summary:                    No sound for 'SigmaTel ID 7634' Codec
Description: 
No sound in the same manner as
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2115

However, none of the 'model=' options work for me and this appears to be a
different (unsupported?) codec.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-23-06 17:30 
----------------------------------------------------------------------
The codec looks rather similar to STAC9200.  Try patch_stac9200 instead.

----------------------------------------------------------------------
 ig88b - 05-23-06 21:25 
----------------------------------------------------------------------
I tried patch_stac9200 and got the exact same error

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 03:17 ig88b          New Issue                                    
05-23-06 03:17 ig88b          Distribution              => Gentoo          
05-23-06 03:17 ig88b          Kernel Version            => 2.6.16-gentoo-r3
05-23-06 03:56 ig88b          Issue Monitored: ig88b                       
05-23-06 15:06 tiwai          Note Added: 0009935                          
05-23-06 16:57 ig88b          Note Added: 0009939                          
05-23-06 17:30 tiwai          Note Added: 0009942                          
05-23-06 21:25 ig88b          Note Added: 0009951                          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
