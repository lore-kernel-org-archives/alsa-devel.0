From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002281]: No sound with Realtek ALC880
Date: Thu, 20 Jul 2006 14:25:16 +0200
Message-ID: <f0cad8c816c95bdcee072b841881ccbc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 782FC22F
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 14:25:16 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2281> 
======================================================================
Reported By:                andy_w
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2281
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               no special distribution - Linux From Scratch (but
also tested with Mandrake)
Kernel Version:             2.6.16.20
======================================================================
Date Submitted:             07-14-2006 18:17 CEST
Last Modified:              07-20-2006 14:25 CEST
======================================================================
Summary:                    No sound with Realtek ALC880
Description: 
Got a notebook with Intel 945GM + ICH7-M and Realtek HDA. The driver
snd-hda-intel from alsa-driver-1.0.12rc1 can be loaded without errors.
Everything look's good but there is no sound output. Mixer and various
sound-apps work ok they can access /dev/dsp, ... volumes are set to 100%
but there is no hearable sound.
======================================================================

----------------------------------------------------------------------
 andy_w - 07-20-06 14:25 
----------------------------------------------------------------------
Sorry, i was wrong - my notebook doesn't have a realtek hda chipset.
The chipset is from CLEVO with the PCI subdevice 0x0660 which isn't
supported by alsa.

I've added the line

/* Clevo m665n */
        { .pci_subvendor = 0x1558, .pci_subdevice = 0x0660, .config =
ALC880_CLEVO },

to

/* Clevo m520G NB */
        { .pci_subvendor = 0x1558, .pci_subdevice = 0x0520, .config =
ALC880_CLEVO },

to patch_realtek.c and now it work's fine. I know it's a quick'n dirty
hack but it work's for me.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-14-06 18:17 andy_w         New Issue                                    
07-14-06 18:17 andy_w         Distribution              => no special
distribution - Linux From Scratch (but also tested with Mandrake)
07-14-06 18:17 andy_w         Kernel Version            => 2.6.16.20       
07-20-06 14:25 andy_w         Note Added: 0011123                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
