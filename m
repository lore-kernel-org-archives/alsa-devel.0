From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001447]: SPDIF IN>OUT Loop missing
Date: Fri, 23 Sep 2005 20:47:21 +0200
Message-ID: <7fc4461619c191f0bb04290892177782@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16D18148
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 20:47:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1447> 
======================================================================
Reported By:                Mimosius
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1447
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-23-2005 20:47 CEST
Last Modified:              09-23-2005 20:47 CEST
======================================================================
Summary:                    SPDIF IN>OUT Loop missing
Description: 
Hi,

I'm using a Hoontech Digital-XG and I was missing the capability to loop
the digital signal from SPDIF-in to SPDIF- out, so I modified the
ymfpci_main.c, adding an extra mixer switch (patch against latest CVS
version included). Would anyone of the developers verify this patch and
add this feature to the ymfpci module?

Regards,
Glen Masgai
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 20:47 Mimosius       New Issue                                    
09-23-05 20:47 Mimosius       File Added: ymfpci_spdifloop.diff                 
  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
