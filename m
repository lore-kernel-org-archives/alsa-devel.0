From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000388]: pci ali5451 suspend/resume
Date: Fri, 24 Sep 2004 13:33:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113353.067F8101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 59FDA263
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:35:38 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000388
======================================================================
Reported By:                Nemaru
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     388
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-15-2004 07:24 CEST
Last Modified:              09-24-2004 13:33 CEST
======================================================================
Summary:                    pci ali5451 suspend/resume
Description: 
Please ignore, if you are the already solved problem.

It is the problem of Kernel-2.6.7 ali5451 sound driver
& suspend/resume.

ali_suspend/ali_resume of ali5451 driver has not set
card->power_state.
Therefore, resume processing is not performed by the
following codes.
power->state should be set up in pci/ali5451.c?
or
power->state should be set up in core/init.c (and core/control.c)?
by snd_power_change_state().

-----------------------------------------------------------
sound/core/init.c
snd_card_pci_resume(struct pci_dev *dev)
{
    .....
    if (card->power_state == SNDRV_CTL_POWER_D0)
        return 0;
-----------------------------------------------------------

======================================================================

----------------------------------------------------------------------
 tiwai - 07-15-2004 11:22 CEST 
----------------------------------------------------------------------
Thanks, I fixed the code on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-15-04 07:24 Nemaru         New Bug                                      
07-15-04 11:22 tiwai          Bugnote Added: 0001425                       
07-15-04 11:22 tiwai          Assigned To               => tiwai           
07-15-04 11:22 tiwai          Resolution               open => fixed       
07-15-04 11:22 tiwai          Status                   new => resolved     
09-24-04 13:33 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
