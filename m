From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000446]: System freezes everytime when I start recording.
Date: Mon, 16 Aug 2004 22:24:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040816202452.A19AC1102E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1E7E51A1
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2004 22:25:40 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 712B01708A
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2004 22:24:53 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000446
======================================================================
Reported By:                Marc_R
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     446
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux / DeMuDi
Kernel Version:             every kernel I tried 2.4.x / 2.6.x
======================================================================
Date Submitted:             08-16-2004 22:24 CEST
Last Modified:              08-16-2004 22:24 CEST
======================================================================
Summary:                    System freezes everytime when I start recording.
Description: 
I have a Terratec 128i PCI soundcard which works great as long as I don't
record something.
I tried recording from cd, microphone, and mix via arecord and Audacity.
The capture devices were set correctly.
As soon as the recording begins, the system freezes immediately. Even the
Magic SysRq doesn't work so I have to reset the PC.
I had this problem with every Linux-kernel version I tried from 2.4.x to
2.6.8.1.
I even installed DeMuDi but had the same problem there.

After some more testing I found out that recording works more or less,
when I unload the usb-module (uhci_hcd). But I have to unload it when X is
not running (?!), otherwise the system still crashes.

I then borrowed another soundcard (SB 128) and got it working with no
problems. So it seems that there is some bug in the recording part of the
es1938-driver...

If there's additional information needed, please ask.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-16-04 22:24 Marc_R         New Bug                                      
08-16-04 22:24 Marc_R         Distribution              => Debian GNU/Linux / DeMuDi
08-16-04 22:24 Marc_R         Kernel Version            => every kernel I tried 2.4.x / 2.6.x
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
