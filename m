From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000472]: Built-in soundcard on Soltek SL-75DRV5 motherboard works only with ac97_quirk=0 option.
Date: Sun, 29 Aug 2004 21:34:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040829193450.6B53839004@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C285B239
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 21:34:50 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 80ECE1C4BF
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 21:34:50 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000472
======================================================================
Reported By:                Dawid Gajownik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     472
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8-1.521
======================================================================
Date Submitted:             08-29-2004 21:34 CEST
Last Modified:              08-29-2004 21:34 CEST
======================================================================
Summary:                    Built-in soundcard on Soltek SL-75DRV5 motherboard works only with ac97_quirk=0 option.
Description: 
Built-in soundcard on Soltek SL-75DRV5 motherboard works only with
ac97_quirk=0 option. This mobo has VIA VT8233A southbridge (snd-via82xx
ALSA kernel module).

Is there any possibility, that it would be set up automatically by the
alsa driver? (I'm not a programmer, but I've seen some ac97_quirk
structure in via82xx.c source file).
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 21:34 Dawid Gajownik New Bug                                      
08-29-04 21:34 Dawid Gajownik Distribution              => Fedora Core 2   
08-29-04 21:34 Dawid Gajownik Kernel Version            => 2.6.8-1.521     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
