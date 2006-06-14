From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working
	on recent versions
Date: Wed, 14 Jun 2006 22:32:09 +0200
Message-ID: <df312651699da182b2173c1a1bb2dd8d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB2CC19D
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jun 2006 22:32:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
======================================================================
Reported By:                nikke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2159
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-24-2006 23:44 CEST
Last Modified:              06-14-2006 22:32 CEST
======================================================================
Summary:                    ac3 passthrough not working on recent versions
Description: 
Using the following AC3 passthrough with mplayer works:
Linux 2.4.31
alsa-driver 1.0.8-7 (debian stable packaged)

Using Linux 2.6.15 (both with alsa-driver 1.10rc3 that ships with the
kernel and
alsa-driver 1.0.11) it doesn't work. The reciever just says "unlock" and
stays quiet.

The only change is booting with different kernels, no other config or
hardware is touched, so this must be a driver regression.

The card is YMF-754 based, connected with coax spdif to my HK reciever.

If you need more info, just tell me and I'll dig it up.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-02-06 04:25 
----------------------------------------------------------------------
You may need to revert some patch related to SPDIF to find out the cause


http://hg-mirror.alsa-project.org/alsa-kernel?fl=25ac64e78c4c;file=pci/ymfpci/ymfpci_main.c;style=gitweb



----------------------------------------------------------------------
 nikke - 06-14-06 22:32 
----------------------------------------------------------------------
I tried using a debian 2.6.8 kernel, and then AC3 passthrough works.
/proc/asound/version says ALSA 1.0.4 ...

Using a 2.6.14 kernel did not work (ALSA 1.0.10rc1).

So, any possibility of getting a list of what patches has been added to
ymfpci between v 1.0.4 (that works) and v 1.0.10rc1? It would help
narrowing down the candidates quite a bit...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 23:44 nikke          New Issue                                    
05-24-06 23:44 nikke          Distribution              => Debian          
05-24-06 23:44 nikke          Kernel Version            => 2.6.15          
05-24-06 23:47 nikke          Issue Monitored: nikke                       
06-02-06 04:23 Raymond        Note Added: 0010045                          
06-02-06 04:25 Raymond        Note Edited: 0010045                         
06-12-06 13:14 Mimosius       Issue Monitored: Mimosius                    
06-14-06 22:32 nikke          Note Added: 0010216                          
======================================================================
