From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000343]: au8820 hangs the system at some occasions
Date: Thu, 30 Mar 2006 10:29:28 +0200
Message-ID: <bcdd555da267ad3c37161c3eff3fd6a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8D74A194
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 10:29:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=343> 
======================================================================
Reported By:                sandman
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   343
Category:                   PCI - au88x0
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     acknowledged
Distribution:               RedHat 9
Kernel Version:             2.6.7
======================================================================
Date Submitted:             06-23-2004 07:20 CEST
Last Modified:              03-30-2006 10:29 CEST
======================================================================
Summary:                    au8820 hangs the system at some occasions
Description: 
At some occasions the system hangs without any means
to recover other than reset button. No mouse, no pings and
even the alt-SysRq feature doesn't help.
As a result I reboot the system a few times a day (sometimes).
The problem is present in 2.6.5, 2.6.6 and 2.6.7 kernels at
least. 
======================================================================

----------------------------------------------------------------------
 Raymond - 03-23-06 11:00 
----------------------------------------------------------------------
ponchick report oops with au8830 mpu401 on his SMP
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1833

Why aplaymidi do not report any error if no mpu401 is connected ?

aplaymidi -p 16:0 test.mid



dmesg

ALSA ../../alsa-kernel/drivers/mpu401/mpu401_uart.c:222: cmd: 0xff failed
at 0xe1daa800 (status = 0x80, data = 0xd1)

http://www.alsa-project.org/

3. SMP and thread-safe design.



----------------------------------------------------------------------
 Raymond - 03-30-06 10:29 
----------------------------------------------------------------------
Try the following patch to see if there is a SDAC bit detect problem on
those stereo AC97 codec manufactured before AC97 2.1 spec , since we can
assume all au8820 have stereo codec.


Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_mixer.c,v
retrieving revision 1.6
diff -u -r1.6 au88x0_mixer.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c	17 Nov 2005 14:55:19
-0000	1.6
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c	30 Mar 2006 08:25:42
-0000
@@ -28,6 +28,10 @@
 	ac97.private_data = vortex;
 	ac97.scaps = AC97_SCAP_NO_SPDIF;
 	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
-	vortex->isquad = ((vortex->codec == NULL) ?  0 :
(vortex->codec->ext_id&0x80));
+#ifdef CHIP_AU8820
+	vortex->isquad = 0;
+#else
+	vortex->isquad = ((vortex->codec == NULL) ?  0 : (vortex->codec->ext_id
& AC97_EI_SDAC));
+#endif
 	return err;
 }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-04 07:20 sandman        New Issue                                    
06-23-04 07:20 sandman        Distribution              => RedHat 9        
06-23-04 07:20 sandman        Kernel Version            => 2.6.7           
04-07-05 21:04 jdthood        Note Added: 0004370                          
04-12-05 20:26 alien999999999 Issue Monitored: alien999999999                   

04-19-05 09:47 sandman        Note Added: 0004519                          
04-19-05 10:03 jdthood        Status                   assigned => acknowledged
08-25-05 18:51 Raymond        Note Added: 0005942                          
03-22-06 03:01 rlrevell       Note Added: 0008789                          
03-22-06 18:05 sandman        Note Added: 0008864                          
03-23-06 08:59 Raymond        Note Added: 0008879                          
03-23-06 09:05 Raymond        Note Edited: 0008879                         
03-23-06 09:21 Raymond        Note Edited: 0008879                         
03-23-06 11:00 Raymond        Note Edited: 0008879                         
03-30-06 10:29 Raymond        Note Added: 0009025                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
