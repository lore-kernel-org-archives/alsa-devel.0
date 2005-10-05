From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000943]: cmipci freezes the whole system
Date: Wed, 5 Oct 2005 18:58:23 +0200
Message-ID: <5bc3dfc59dabf9ce40c1be3bae5a57ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15EC61B7
	for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2005 18:58:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=943> 
======================================================================
Reported By:                aisotton
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   943
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sid (Unstable)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-25-2005 16:06 CET
Last Modified:              10-05-2005 18:58 CEST
======================================================================
Summary:                    cmipci freezes the whole system
Description: 
Hi,

I have a Terratec Aureon 5.1 PCI sound card, and an on-board 3Com 3c940
gigabit ethernet controller (the board is an Asus A7V600). The sound
card uses the cmipci module, and the ethernet card the sk98lin module.

Playing sound and using the network at the same time freezes the sytem
after a short time (generally 15-30 seconds); nothing is logged or
displayed (I checked syslog, kern.log and /var/log/messages), it just
freezes everything, forcing a reset of the machine (and after the
subsequent reboot my mouse isn't recognized any more, but I don't think
that matters).

I am using that network card since more than a year, and it never gave a
problem; thus I think the bug is in the cmipci driver (the system never
froze before I installed the sound card).

I did a memtest, but my memory seems to be ok.

This happens with all kernels I tested, specifically:

Debian kernel-image-2.6.10-1-k7-4
Debian kernel-image-2.6.9-2-k7-5
Debian kernel-image-2.6.8-2-k7-13
Debian kernel-image-2.6.10-1-k7-4 with PREEMPT deactivated
Vanilla kernel 2.6.10, compiled with the same options as Debian
kernel-image-2.6.10-1-k7-4.


======================================================================

----------------------------------------------------------------------
 runderwo - 09-24-05 18:12 
----------------------------------------------------------------------
This is terrible.  Okay, is there any way you can do the following.  First,
lspci -xxx and save the results in Linux.  Then, go to Windows and use a
PCI dumper to dump the PCI configuration area there.  Post the results. 
Also note whether or not the card works in Windows.  I know not everybody
has access to windows so this is directed at those of you who have a
windows installation to play with.

----------------------------------------------------------------------
 tiwai - 10-05-05 18:58 
----------------------------------------------------------------------
The stability depends quite much on the board and BIOS.
In some cases, BIOS update solves the problems.

Also, try the latest ALSA CVS version since legacy MIDI port is removed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-05 16:06 aisotton       New Issue                                    
02-25-05 16:06 aisotton       Distribution              => Debian Sid (Unstable)
02-25-05 16:06 aisotton       Kernel Version            => 2.6.10          
02-25-05 16:07 aisotton       Note Added: 0003734                          
02-25-05 21:57 runderwo       Note Added: 0003736                          
02-26-05 02:33 aisotton       Note Added: 0003737                          
06-11-05 23:46 sbambach       Note Added: 0004996                          
06-11-05 23:48 sbambach       Note Added: 0004997                          
06-11-05 23:48 sbambach       Issue Monitored: sbambach                    
06-14-05 21:23 graf_eichbaum  Issue Monitored: graf_eichbaum                    
09-16-05 15:27 mitch_f        Note Added: 0006244                          
09-22-05 19:40 mitch_f        Note Added: 0006357                          
09-22-05 19:51 sbambach       Note Added: 0006358                          
09-22-05 19:52 sbambach       Note Edited: 0006358                         
09-22-05 20:16 runderwo       Note Added: 0006360                          
09-24-05 14:17 mitch_f        Note Added: 0006369                          
09-24-05 18:12 runderwo       Note Added: 0006375                          
10-05-05 18:58 tiwai          Note Added: 0006437                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
