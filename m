From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002339]: No sound with ALC260 chip
Date: Sun, 6 Aug 2006 23:58:41 +0200
Message-ID: <fc60f1746cea23dbaa8d1f06698d582a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9CC8D19E
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 23:58:41 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2339> 
======================================================================
Reported By:                Lubomir
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2339
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.17-gentoo-r4
======================================================================
Date Submitted:             08-06-2006 23:58 CEST
Last Modified:              08-06-2006 23:58 CEST
======================================================================
Summary:                    No sound with ALC260 chip
Description: 
I own an Acer c204 and am the only one person who use linux on it. I can
not get sound out of my headphone or the normal speaker. At the moment i
use gentoo with alsa 1.0.12RC1. I have installed alsa-driver, alsa-lib,
alsa-tools and alsa-utils. Everything have version 1.0.12RC1. I have
unmuted Headphone, PCM and Front(but i have tested unmuting the other
things). Here is the output of amixer ->
http://rafb.net/paste/results/meVPag95.html . I have tested running that
-> speaker-test -c2 -Dplug:front  and changing the settings in alsamixer.
I could not get any sound. 
I also tried over 20 linux live cds. I never had any sound.
I asked in the alsa-user and alsa-dev mailing list. Here the result ->
http://rafb.net/paste/results/CH6eGG56.html
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-06-06 23:58 Lubomir        New Issue                                    
08-06-06 23:58 Lubomir        Distribution              => Gentoo Linux    
08-06-06 23:58 Lubomir        Kernel Version            => 2.6.17-gentoo-r4
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
