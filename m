From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000051]: system crashes running aplay as unprivileged user on a US428. No sound except very occasional <.5 sec bursts
Date: Fri,  1 Oct 2004 01:28:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040930232825.38F2518007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1985427B
	for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2004 01:29:22 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000051
======================================================================
Reported By:                marqrdt
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Bug ID:                     51
Category:                   USB - usb-usx2y
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:              2.4.22-1.2115.nptl (stock Fedora kernel)
======================================================================
Date Submitted:             02-11-2004 15:39 CET
Last Modified:              10-01-2004 01:28 CEST
======================================================================
Summary:                    system crashes running aplay as unprivileged user on a US428. No sound except very occasional <.5 sec bursts
Description: 
running the following command will cause a system crash +50% of the time:
aplay -v -D plug:hw:USX2Y music/wav/chant-reverb.wav

It runs file using the ALSA driver for the internal ALI5451 card.

Also, no sound comes out of the US428 except for very occasional <.5
bursts (never more than once per sound file). Headphones hooked to phone
jack, ext. speaker hooked to line-out.
No audio capture.
======================================================================

----------------------------------------------------------------------
 karsten - 02-11-2004 20:09 CET 
----------------------------------------------------------------------
On my two UHCI-1.1 USB pcs
aplay -v -D plug:hw:USX2Y some.wav
just runs fine.
Having heared of one other case of problems with an OHCI pc, I suspect
also here the OHCI-USB makes the bug apear.
I don't have access to any OHCI-USB controller. So to let me see more
you'd have to give me an OHCI controller pci-card.
Also you could build alsa-driver with "--with-debug=full" and post your
dmesg outputs here if the thing doesn't crash....

----------------------------------------------------------------------
 piem - 03-18-2004 14:13 CET 
----------------------------------------------------------------------
the _bad_ compatibility (if any?) of the us-242 with the OHCI controller is
mentionned in its manual. what does the us-428 manual say about that ?

cheers

----------------------------------------------------------------------
 karsten - 10-01-2004 01:28 CEST 
----------------------------------------------------------------------
please recheck snd-usb-usx2y version 0.8.0, which I posted to the
alsa-devel list.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-11-04 15:39 marqrdt        New Bug                                      
02-11-04 17:27 marqrdt        Bug Monitored: marqrdt                       
02-11-04 20:09 karsten        Bugnote Added: 0000221                       
03-18-04 14:13 piem           Bugnote Added: 0000641                       
10-01-04 01:28 karsten        Bugnote Added: 0001991                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
