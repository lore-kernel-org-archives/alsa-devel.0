From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000470]: Inverted master volume control on TerraTec Aureon 7.1 Space
Date: Mon, 13 Sep 2004 16:04:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913140411.1CA3F1200A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8FE562A7
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 16:04:11 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000470
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     470
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian GNU/Linux 3.1
Kernel Version:             2.6.9-rc1
Resolution:                 fixed
======================================================================
Date Submitted:             08-29-2004 00:43 CEST
Last Modified:              09-13-2004 16:04 CEST
======================================================================
Summary:                    Inverted master volume control on TerraTec Aureon 7.1 Space
Description: 
It seems that the master volume control on (at least some) TerraTec Aureon
7.1 Space cards are inverted, thus setting the volume to 100 in alsamixer
practically mutes the sound.
The front volume control (and probably the rest) operates correctly.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-2004 16:04 CEST 
----------------------------------------------------------------------
Already fixed on cvs (1.0.7rc1).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 00:43 ungod          New Bug                                      
08-29-04 00:43 ungod          Distribution              => Debian GNU/Linux 3.1
08-29-04 00:43 ungod          Kernel Version            => 2.6.9-rc1       
09-13-04 16:04 tiwai          Bugnote Added: 0001750                       
09-13-04 16:04 tiwai          Assigned To               => tiwai           
09-13-04 16:04 tiwai          Resolution               open => fixed       
09-13-04 16:04 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
