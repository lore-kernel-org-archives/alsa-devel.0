From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000456]: Sound only through internal speaker, not Line Out port
Date: Fri, 20 Aug 2004 00:13:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040819221358.830141102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C5DDD241
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2004 00:13:58 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 92F1F194EA
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2004 00:13:58 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000456
======================================================================
Reported By:                octothorpe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     456
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.7-1.494.2.2 (with compiled ALSA 1.0.6a overriding the standard ALSA 1.0.4)
======================================================================
Date Submitted:             08-20-2004 00:13 CEST
Last Modified:              08-20-2004 00:13 CEST
======================================================================
Summary:                    Sound only through internal speaker, not Line Out port
Description: 
I have a IBM NetVista 6579-PDU with an Intel 82801BA-ICH2 controller and
AD1885 AC97 codec.  With Windows when you plug external speakers into the
Line Out port the internal speaker is silenced and you get stereo sound
out the external speakers.

With Linux and ALSA 1.0.4 or 1.0.6a plugging in the external speakers has
no effect.  You still only get sound out the built-in internal speaker. 
None of the mixer controls will fix it.

I traced the problem down to some code in ac97_patch.c that unilaterally
disabled the Jack Sense logic on the AD1885.  IBM obviously knew about
this logic and hooked up the jack sense connections and depended upon the
"side effects" documented in the Analog Devices documentation (they list
it under "Enhanced Features").

I fixed the problem by making the two jack-sense disable bits configurable
items that I can turn off for my hardware.  Now my Linux sound works just
as well as Windows.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-20-04 00:13 octothorpe     New Bug                                      
08-20-04 00:13 octothorpe     File Added: alsa-diffs                       
08-20-04 00:13 octothorpe     Distribution              => Fedora Core 2   
08-20-04 00:13 octothorpe     Kernel Version            => 2.6.7-1.494.2.2 (with compiled ALSA 1.0.6a overriding the standard ALSA 1.0.4)
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
