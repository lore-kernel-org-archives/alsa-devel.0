From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000185]: Audigy2 SPDIF CDROM data noise after stop
Date: Fri,  3 Sep 2004 23:19:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040903211900.572982D0C0@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 504CA2B8
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 23:19:36 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id ACA411F332
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 23:19:00 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000185
======================================================================
Reported By:                pavouk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     185
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrake 10.0
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-04-2004 21:07 CEST
Last Modified:              09-03-2004 23:19 CEST
======================================================================
Summary:                    Audigy2 SPDIF CDROM data noise after stop
Description: 
My DVDROM DV-5700B is connected through digital SPDIF input to Audigy2 PCI
card. When I play AudioCD, that after STOP or end of CD is heard from
speakers loud purl or something like data noise. Same hardware with
Soundblaster Live! card works great.
This problem was visible with older kernel and Alsa versions too.
======================================================================

----------------------------------------------------------------------
 pavouk - 09-03-2004 23:19 CEST 
----------------------------------------------------------------------
Some behavior with OSS emu10k1 driver. But with KX project drivers on win98
it works great. Probably there doesn't work AUTOMUTE function on SPDIF
input.
Tested with kernel 2.6.8.1.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-04-04 21:07 pavouk         New Bug                                      
04-04-04 21:07 pavouk         Distribution              => Mandrake 10.0   
04-04-04 21:07 pavouk         Kernel Version            => 2.6.5           
09-03-04 23:19 pavouk         Bugnote Added: 0001698                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
