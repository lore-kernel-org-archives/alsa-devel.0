From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000470]: Inverted master volume control on TerraTec Aureon 7.1 Space
Date: Sun, 29 Aug 2004 00:43:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040828224342.25E392F001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7789D250
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 00:43:42 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 3593E1BE0F
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 00:43:42 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000470
======================================================================
Reported By:                ungod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     470
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux 3.1
Kernel Version:             2.6.9-rc1
======================================================================
Date Submitted:             08-29-2004 00:43 CEST
Last Modified:              08-29-2004 00:43 CEST
======================================================================
Summary:                    Inverted master volume control on TerraTec Aureon 7.1 Space
Description: 
It seems that the master volume control on (at least some) TerraTec Aureon
7.1 Space cards are inverted, thus setting the volume to 100 in alsamixer
practically mutes the sound.
The front volume control (and probably the rest) operates correctly.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 00:43 ungod          New Bug                                      
08-29-04 00:43 ungod          Distribution              => Debian GNU/Linux 3.1
08-29-04 00:43 ungod          Kernel Version            => 2.6.9-rc1       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
