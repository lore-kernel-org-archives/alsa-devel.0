From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000696]: Doom 3 crashes when using alsa
Date: Thu, 22 Sep 2005 15:21:13 +0200
Message-ID: <faac4faecc033fde288f4a3a09f69a62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8078152
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 15:21:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=696> 
======================================================================
Reported By:                Mo6eB
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   696
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-01-2004 20:18 CET
Last Modified:              09-22-2005 15:21 CEST
======================================================================
Summary:                    Doom 3 crashes when using alsa
Description: 
Doom 3 crashes with the following error message:
snd_pcm_writei short write: 4095 out of 4096
snd_pcm_writei short write: 4095 out of 4096
doom.x86: pcm.c:5957: snd_pcm_mmap_commit: Assertion `frames <=
snd_pcm_mmap_avail(pcm)' failed.
signal caught: Aborted

======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 16:32 
----------------------------------------------------------------------
Submitter: Any progress with this problem?

----------------------------------------------------------------------
 jdthood - 09-22-05 15:21 
----------------------------------------------------------------------
Does Doom3 work properly with the latest ALSA intel8x0 driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-04 20:18 Mo6eB          New Issue                                    
12-01-04 20:18 Mo6eB          Distribution              => Gentoo          
12-01-04 20:18 Mo6eB          Kernel Version            => 2.6.9           
12-01-04 23:26 tiwai          Note Added: 0002671                          
03-19-05 16:32 jdthood        Note Added: 0004055                          
09-22-05 15:21 jdthood        Note Added: 0006349                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
