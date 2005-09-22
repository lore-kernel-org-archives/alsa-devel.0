From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000978]: intel8x0 sound does not work on 2.6.10 kernel with alsa 1.0.8
Date: Thu, 22 Sep 2005 15:03:08 +0200
Message-ID: <164cec3c1def7c6f48d118d4bcd860a1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 55045152
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 15:03:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=978> 
======================================================================
Reported By:                johnz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   978
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC3
Kernel Version:             kernel-2.6.10-1.770_14.rhfc3.at
======================================================================
Date Submitted:             03-10-2005 06:37 CET
Last Modified:              09-22-2005 15:03 CEST
======================================================================
Summary:                    intel8x0 sound does not work on 2.6.10 kernel with
alsa 1.0.8
Description: 
On an ASRock motherboard with SIS 7012 sound controller, the Sound works on
kernel-2.6.9-1.681_FC3. (The mixer controls don't work. Only the PCM mute
mixer control works; volume sliders have no effect.)  There is no sound
when I boot the same system with kernel-2.6.10-1.770_14.rhfc3.at or other
2.6.10 kernels with 1.0.8 alsa.
======================================================================

----------------------------------------------------------------------
 johnz - 03-11-05 03:19 
----------------------------------------------------------------------
not sure I'll be able to do this, but will try.  Has anyone built an RPM
for Fedora core?

----------------------------------------------------------------------
 jdthood - 09-22-05 15:03 
----------------------------------------------------------------------
Submitter: Has the problem been fixed in the latest ALSA release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-05 06:37 johnz          New Issue                                    
03-10-05 06:37 johnz          File Added: asound.state                     
03-10-05 06:37 johnz          Distribution              => FC3             
03-10-05 06:37 johnz          Kernel Version            =>
kernel-2.6.10-1.770_14.rhfc3.at
03-10-05 06:39 johnz          Issue Monitored: johnz                       
03-10-05 06:43 johnz          File Added: lsmod                            
03-10-05 14:39 tiwai          Note Added: 0003853                          
03-11-05 03:19 johnz          Note Added: 0003879                          
09-22-05 15:03 jdthood        Note Added: 0006342                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
