From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001369]: Rear left/right channels
	swapped with center/lfe
Date: Sat, 22 Jul 2006 08:16:49 +0200
Message-ID: <8d20a7a824c03d5f40fd775ce7abe3e3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7AD10183
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 08:16:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1369> 
======================================================================
Reported By:                ukr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1369
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4 (but latest stable versions of kernel,
alsa-driver and alsa-lib installed as mentioned earlier)
Kernel Version:             Linux 2.6.12.5 (compiled with SMP support with gcc
4.0)
======================================================================
Date Submitted:             08-25-2005 11:00 CEST
Last Modified:              07-22-2006 08:16 CEST
======================================================================
Summary:                    Rear left/right channels swapped with center/lfe
Description: 
The rear left and right channel outputs have been swapped with center and
lfe respectively. speaker-test (alsa-utils-1.0.9) confirms this. I'm using
alsa-lib-1.0.9 with alsa-driver-1.0.9b.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001501 intel8x0 surround channels missing and ...
======================================================================

----------------------------------------------------------------------
 ukr - 07-22-06 08:16 
----------------------------------------------------------------------
Hi,

I'm using Linux 2.6.17-1.2157_FC5smp with 1.0.11rc2, and still facing the
same problem. speaker-test and all applications output rear-left on
center, rear-right on LFE, and vice-versa (channels 2, 3 swapped with 4,
5). However, alsamixer correctly adjusts volumes for all channels;
changing volume of rear left/right or center/lfe correctly changes volume
on the corresponding speaker.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-25-05 11:00 ukr            New Issue                                    
08-25-05 11:00 ukr            File Added: asound.state                     
08-25-05 11:00 ukr            Distribution              => Fedora Core 4 (but
latest stable versions of kernel, alsa-driver and alsa-lib installed as
mentioned earlier)
08-25-05 11:00 ukr            Kernel Version            => Linux 2.6.12.5
(compiled with SMP support with gcc 4.0)
11-01-05 15:35 jdthood        Relationship added       related to 0001501  
11-06-05 10:12 densg          Issue Monitored: densg                       
07-22-06 08:16 ukr            Note Added: 0011167                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
