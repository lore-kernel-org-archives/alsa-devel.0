From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000696]: Doom 3 crashes when using alsa
Date: Wed, 22 Mar 2006 03:39:23 +0100
Message-ID: <08de99ac2dec87c1c92e96101cb8b137@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B46A81A0
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:39:23 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.9
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-01-2004 20:18 CET
Last Modified:              03-22-2006 03:39 CET
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
 jdthood - 09-22-05 15:21 
----------------------------------------------------------------------
Does Doom3 work properly with the latest ALSA intel8x0 driver?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:39 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-04 20:18 Mo6eB          New Issue                                    
12-01-04 20:18 Mo6eB          Distribution              => Gentoo          
12-01-04 20:18 Mo6eB          Kernel Version            => 2.6.9           
12-01-04 23:26 tiwai          Note Added: 0002671                          
03-19-05 16:32 jdthood        Note Added: 0004055                          
09-22-05 15:21 jdthood        Note Added: 0006349                          
03-22-06 03:39 rlrevell       Status                   new => closed       
03-22-06 03:39 rlrevell       Note Added: 0008828                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
