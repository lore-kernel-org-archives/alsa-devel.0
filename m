From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000393]: ali5451 driver & suspend/resume
Date: Fri, 24 Sep 2004 13:33:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113315.6310E101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2624D203
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:34:34 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000393
======================================================================
Reported By:                Nemaru
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     393
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-16-2004 10:52 CEST
Last Modified:              09-24-2004 13:33 CEST
======================================================================
Summary:                    ali5451 driver & suspend/resume
Description: 
In alsa/alsa-kernel/core/init.c(Revision 1.48)
I found pci_restore_state to snd_card_pci_resume().
However, there is no pci_save_state in snd_card_pci_suspend().
There is no pci_save_state also in alsa/alsa-kernel/pci/ali5451.c(Revision
1.55).
Does pci_save_state fall out and become precocious?

In alsa/alsa-kernel/pci/ali5451.c(Revision 1.55).
Although snd_power_change_state (card and SNDRV_CTL_POWER_D3hot) was found
to ali_suspend, there is no snd_power_change_state (card and
SNDRV_CTL_POWER_D0) in ali_resume.
Does snd_power_change_state (card and SNDRV_CTL_POWER_D0) fall out and
become precocious?

======================================================================

----------------------------------------------------------------------
 tiwai - 07-16-2004 11:50 CEST 
----------------------------------------------------------------------
The missing snd_change_power_state() is fixed on CVS.

You don't need pci_save_state().  It's called internally in the
pci core driver on the recent kernel.  For older kernels, init.c
is patched in alsa-driver tree.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-16-04 10:52 Nemaru         New Bug                                      
07-16-04 11:50 tiwai          Bugnote Added: 0001439                       
07-16-04 11:50 tiwai          Assigned To               => tiwai           
07-16-04 11:50 tiwai          Resolution               open => fixed       
07-16-04 11:50 tiwai          Status                   new => resolved     
09-24-04 13:33 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
