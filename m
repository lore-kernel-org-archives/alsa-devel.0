From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000548]: Format not supported by Webcam
Date: Tue, 28 Sep 2004 16:13:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928141328.CF75239006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0D96F277
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 16:13:29 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000548
======================================================================
Reported By:                djtm
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     548
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8.1-ck6
======================================================================
Date Submitted:             09-28-2004 15:57 CEST
Last Modified:              09-28-2004 16:13 CEST
======================================================================
Summary:                    Format not supported by Webcam
Description: 
1 [webcam         ]: USB-Audio - USB Device 0x46d:0x8b4
                     USB Device 0x46d:0x8b4 at usb-0000:00:02.1-2, full
speed

Only supports: 16_le, 44100, mono.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 09-28-2004 16:13 CEST 
----------------------------------------------------------------------
Please show the contents of /proc/asound/card0/stream0.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-28-04 15:57 djtm           New Bug                                      
09-28-04 15:57 djtm           Distribution              => Debian          
09-28-04 15:57 djtm           Kernel Version            => 2.6.8.1-ck6     
09-28-04 16:13 Clemens LadischBugnote Added: 0001950                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
