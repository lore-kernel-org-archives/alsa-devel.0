From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000860]: Wrong detection of opl3 device
Date: Sat, 29 Jan 2005 18:20:54 +0100
Message-ID: <8bfa82297ebf39a1035a93cbabcc69ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4062622E
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2005 18:20:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=860> 
======================================================================
Reported By:                theli
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   860
Category:                   ISA - als100
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.10-ck4
======================================================================
Date Submitted:             01-29-2005 18:20 CET
Last Modified:              01-29-2005 18:20 CET
======================================================================
Summary:                    Wrong detection of opl3 device
Description: 
driver als100.c has
        acard->devmpu = pnp_request_card_device(card, id->devs[1].id,
acard->dev);
        acard->devopl = pnp_request_card_device(card, id->devs[2].id,
acard->devmpu);
in "static int __devinit snd_card_als100_pnp".

so search for opl device starts from devmpu...
and in my MF1000 opl device is 00:01.03
and opl3 is 00:01.01 so it can't be found that way ...
and devopl is NULL :(

but opl3 works when changed above code to 

        acard->devmpu = pnp_request_card_device(card, id->devs[1].id,
acard->dev);
        acard->devopl = pnp_request_card_device(card, id->devs[2].id,
acard->dev);

(search of opl3 starts from acard->dev )
and that should work in any case

PS: sorry for my english.
PPS: don't even know does anyone else use such old sound card.
PPPS: was fighting with alsa for weeks trying to get opl3 working before
decided to look in sources.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-05 18:20 theli          New Issue                                    
01-29-05 18:20 theli          Kernel Version            => 2.6.10-ck4      
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
