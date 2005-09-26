From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001447]: SPDIF IN>OUT Loop missing
Date: Mon, 26 Sep 2005 11:10:23 +0200
Message-ID: <2e3debdd53223a880455867c246ed827@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EFBE0171
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 11:10:23 +0200 (MEST)
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
Last Modified:              09-26-2005 11:10 CEST
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

----------------------------------------------------------------------
 Clemens Ladisch - 09-26-05 11:10 
----------------------------------------------------------------------
Please use a[0] instead of *a when accessing an array.
There is a double semicolon.
You don't really need separate variables for ref, shift, and mask; similar
code in other functions was just copied from generic code that read these
values from the mixer element.

Please provide a patch description and Signed-off-by line.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 20:47 Mimosius       New Issue                                    
09-23-05 20:47 Mimosius       File Added: ymfpci_spdifloop.diff                 
  
09-23-05 20:47 Mimosius       Issue Monitored: Mimosius                    
09-26-05 11:10 Clemens LadischNote Added: 0006392                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
