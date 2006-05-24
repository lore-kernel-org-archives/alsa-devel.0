From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002156]: Geode support still not ported from OSS
Date: Wed, 24 May 2006 09:50:48 +0200
Message-ID: <41970255344236c2fd5a4b0e0f7c9847@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E24A4198
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 09:50:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2156> 
======================================================================
Reported By:                Quietti
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2156
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-24-2006 09:50 CEST
Last Modified:              05-24-2006 09:50 CEST
======================================================================
Summary:                    Geode support still not ported from OSS
Description: 
According to http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/1636.html
the Geode series all provide a sb16-compatible card. Yet, I notice that
the OSS "sb" module works, while the ALSA "snd-sb16" module doesn't.

Meanwhle, documentation for the more recent Geode SCx200 hardware suggests
an AC97-compatible chip. I notice that e.g. the snd-via82xx driver offer
both AC97 support and a Soundblaster compatibility mode, but that doesn't
work with this Geode either.

Feel free to reassing this to the appropriate driver, if this has been
ported already, or if a documented solution exists.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 09:50 Quietti        New Issue                                    
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
