From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002101]: Sony Vaio VGN-S3HP internal speakers stopped working (+fix)
Date: Sun, 7 May 2006 14:07:16 +0200
Message-ID: <40a5bc15863fb095746a4e9e787b170c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8FA80192
	for <alsa-devel@alsa-project.org>; Sun,  7 May 2006 14:07:16 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2101> 
======================================================================
Reported By:                rjb
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2101
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.17-rc3
======================================================================
Date Submitted:             05-07-2006 14:07 CEST
Last Modified:              05-07-2006 14:07 CEST
======================================================================
Summary:                    Sony Vaio VGN-S3HP internal speakers stopped working
(+fix)
Description: 
On the Sony Vaio VGN-S3HP the internal speakers stopped working
since kernel 2.6.16. The headphones do work. The alsamixer shows
that the Front slider is missing. On 2.6.15-rc7 everything was ok.
The problem is still there on ALSA driver 1.0.11.

I inserted an additional entry for the Vaio in alc260_cfg_tbl of
alsa-kernel/pci/hda/patch_realtek.c. This solves the problem for me.
Now, everything works as expected. The speakers work unless headphones
are plugged in, and the volume of the speakers and headphones can be
adjusted individually.

Patch attached.

Cheers,
Ronald
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-06 14:07 rjb            New Issue                                    
05-07-06 14:07 rjb            File Added: patch_for_vaio_vgn_s3hp.txt           
        
05-07-06 14:07 rjb            Distribution              => Gentoo          
05-07-06 14:07 rjb            Kernel Version            => 2.6.17-rc3      
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
