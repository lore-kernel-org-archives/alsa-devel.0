From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001276]: Audigy 2 ZS [SB0350] - Only static noise when playing any sound.
Date: Fri, 22 Jul 2005 22:13:38 +0200
Message-ID: <a03bae77fd52f1c2169dfe9589d5f675@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A7FFB192
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2005 22:13:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1276> 
======================================================================
Reported By:                colding
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1276
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo AMD64 2005.0
Kernel Version:             Linux omc-2 2.6.12-gentoo-r6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP Fri Jul 22 20:12:38
CEST 2005 x86_64 AMD Opteron(tm) Processor 252 AuthenticAMD GNU/Linux
======================================================================
Date Submitted:             07-22-2005 22:13 CEST
Last Modified:              07-22-2005 22:13 CEST
======================================================================
Summary:                    Audigy 2 ZS [SB0350] - Only static noise when
playing any sound.
Description: 
I have a Audigy 2 ZS [SB0350] sound card installed in my dual 252 Opteron.
I have enabled ALSA and OSS emulation in the kernel. I have tried as
compiled in, no modules, and as module. The card is correctly detected on
boot-up
and apparently activated. 

Everything seems to be configured correctly according to the alsa guide
for Gentoo and all I could find at alsa-project and for Gnome. 

The problem is that I am only hearing cyclically repeating clicks, with
weak static noise in-between, when I am trying to play music. I have a
set of analog 2.1 speakers (Altec Lansing FX-6021) connected to the
analog output jack (Line Out 1) on the card.

It seems that my problems are the same as in this former post to the
list:

http://sourceforge.net/mailarchive/message.php?msg_id=11662616

That thread concluded with no solution but to revert to OSS.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 22:13 colding        New Issue                                    
07-22-05 22:13 colding        Distribution              => Gentoo AMD64 2005.0
07-22-05 22:13 colding        Kernel Version            => Linux omc-2
2.6.12-gentoo-r6 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP
Fri Jul 22 20:12:38 CEST 2005 x86_64 AMD Opteron(tm) Processor 252 AuthenticAMD
GNU/Linux
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
