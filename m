From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000623]: No volume control on SPDIF on cmedia CMI8738-MC6
Date: Wed, 10 Nov 2004 03:56:44 +0100
Message-ID: <1058f4402b35947ac3f743b2eb674376@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 80E992D1
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 03:56:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=623> 
======================================================================
Reported By:                mtempels
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   623
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Linux 4.10
Kernel Version:             Linux bubbles 2.6.8.1-3-386
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue Oct 12 12:41:57 BST
2004 i686 GNU/Linux
======================================================================
Date Submitted:             11-02-2004 11:24 CET
Last Modified:              11-10-2004 03:56 CET
======================================================================
Summary:                    No volume control on SPDIF on cmedia CMI8738-MC6
Description: 
There is no way to control the output volume on the SPDIF/out on my CMI8738
soundcard. It can just be switched on or off..
======================================================================

----------------------------------------------------------------------
 mtempels - 11-09-04 20:15 
----------------------------------------------------------------------
I see..

I wish i had the knowledge to do so.. Thanks for thw information!

Cheers

Matthijs

----------------------------------------------------------------------
 cltien - 11-10-04 03:56 
----------------------------------------------------------------------
I once added S/W volume control as in our Windows driver, but it was
rejected since ALSA team don't want DMA buffer modified by driver. I
changed the core/pcm_lib.c to multiply all PCM data with a factor, so you
can also change the PCM sent through S/PDIF. However, AC3/DTS stream
cannot be done in this way.

ChenLi Tien

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-04 11:24 mtempels       New Issue                                    
11-02-04 11:24 mtempels       Distribution              => Ubuntu Linux 4.10
11-02-04 11:24 mtempels       Kernel Version            => Linux bubbles
2.6.8.1-3-386 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue Oct
12 12:41:57 BST 2004 i686 GNU/Linux
11-09-04 18:56 tiwai          Note Added: 0002337                          
11-09-04 19:01 mtempels       Note Added: 0002340                          
11-09-04 19:18 tiwai          Note Added: 0002342                          
11-09-04 20:15 mtempels       Note Added: 0002352                          
11-10-04 03:56 cltien         Note Added: 0002355                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
