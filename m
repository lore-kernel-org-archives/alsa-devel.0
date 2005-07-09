From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001244]: error with firmware with echo layla20
Date: Sat, 9 Jul 2005 02:22:38 +0200
Message-ID: <1582228b1f6357b819be4222b9a2ee32@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 749F716A
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 02:22:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1244> 
======================================================================
Reported By:                hennewou
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1244
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.11
======================================================================
Date Submitted:             07-09-2005 02:22 CEST
Last Modified:              07-09-2005 02:22 CEST
======================================================================
Summary:                    error with firmware with echo layla20
Description: 

I get this error when loading snd-layla20 card:

ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 177
ALSA /usr/src/modules/alsa-driver/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla20: probe of 0000:02:0d.0 failed with error -2

I compiled an alsa driver for layla20 (I had to patch the alsa-driver tree
a year ago for linux-2.4.25, and that worked (and still does).


(By the way, For some reason I can only compile snd-layla20 according to
debian package manager (apt-get install alsa-source ....) . With the
original alsa-driver-1.0.9a.tar.bz2, the echoaudio modules refuse to
compile.)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-05 02:22 hennewou       New Issue                                    
07-09-05 02:22 hennewou       Distribution              => Debian          
07-09-05 02:22 hennewou       Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
