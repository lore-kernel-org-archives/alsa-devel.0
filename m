From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000059]: On au8820 left and right channels are swapped
Date: Thu, 30 Mar 2006 10:31:32 +0200
Message-ID: <4c9d461a0cddee62203e9dbf97d189db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F408194
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 10:31:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59> 
======================================================================
Reported By:                kernel_bug
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   59
Category:                   PCI - au88x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     confirmed
Distribution:               
Kernel Version:             2.6.2
======================================================================
Date Submitted:             02-13-2004 11:40 CET
Last Modified:              03-30-2006 10:31 CEST
======================================================================
Summary:                    On au8820 left and right channels are swapped
Description: 
In most cases, left and right channels are swapped. But in approx. 5% cases
all OK. Looks like the matter is somewhere in byte alignment...
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000949 Randomly, left and right tracks are swaped
======================================================================

----------------------------------------------------------------------
 Raymond - 02-17-06 09:21 
----------------------------------------------------------------------
Using outls.wav and outrs.wav from Vortex driver CD

aplay -D hw:0,0 outls.wav
aplay -D hw:0,0 outrs.wav

Can you try alsa-1.0.11rc3 with/without au88x0_surround40.patch from
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726 ?

----------------------------------------------------------------------
 Raymond - 03-30-06 10:31 
----------------------------------------------------------------------
Try the following patch to see if there is a SDAC bit detect problem on
those stereo AC97 codec manufactured before AC97 2.1 spec , since we can
assume all au8820 have stereo codec.

Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_mixer.c,v
retrieving revision 1.6
diff -u -r1.6 au88x0_mixer.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c	17 Nov 2005
14:55:19
-0000	1.6
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0_mixer.c	30 Mar 2006
08:25:42
-0000
 <at>  <at>  -28,6 +28,10  <at>  <at> 
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
02-13-04 11:40 kernel_bug     New Issue                                    
02-21-04 15:40 kernel_bug     Note Added: 0000280                          
03-02-04 02:56 Tim            Note Added: 0000429                          
04-09-04 11:54 kernel_bug     Note Added: 0000774                          
04-09-04 18:35 mjander        Note Added: 0000777                          
04-17-04 18:59 mjander        Status                   assigned => closed  
04-17-04 18:59 mjander        Note Added: 0000849                          
04-26-04 17:04 kernel_bug     Status                   closed => feedback  
04-26-04 17:04 kernel_bug     Resolution               open => reopened    
04-26-04 17:04 kernel_bug     Note Added: 0000953                          
04-26-04 23:27 mjander        Note Added: 0000956                          
03-10-05 15:31 jdthood        Note Added: 0003866                          
03-10-05 16:44 mjander        Note Added: 0003867                          
03-10-05 21:25 kernel_bug     Note Added: 0003873                          
03-22-05 22:33 jdthood        Relationship added       related to 0000949  
03-28-05 04:27 jdthood        Note Added: 0004235                          
03-28-05 04:27 jdthood        Status                   feedback => assigned
03-28-05 04:29 jdthood        Status                   assigned => confirmed
08-26-05 14:50 Raymond        Note Added: 0005951                          
08-26-05 15:12 kernel_bug     Note Added: 0005955                          
08-26-05 16:07 Raymond        Note Added: 0005956                          
08-26-05 17:38 kernel_bug     File Added: asound.state                     
08-26-05 17:41 kernel_bug     Note Added: 0005957                          
08-27-05 04:43 Raymond        Note Added: 0005959                          
01-06-06 18:15 Raymond        Note Added: 0007491                          
01-09-06 17:02 Raymond        Note Edited: 0007491                         
02-17-06 09:21 Raymond        Note Added: 0008106                          
03-30-06 10:31 Raymond        Note Added: 0009027                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
