From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000544]: Sound freezes (but can be restarted OK) after kernel locked for a long time
Date: Sat,  9 Oct 2004 20:02:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041009180201.30CD63E00F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A6CCA291
	for <alsa-devel@alsa-project.org>; Sat,  9 Oct 2004 20:02:01 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000544
======================================================================
Reported By:                sasa
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     544
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-26-2004 10:44 CEST
Last Modified:              10-09-2004 20:02 CEST
======================================================================
Summary:                    Sound freezes (but can be restarted OK) after kernel locked for a long time
Description: 
When doing an intensive task that locks the kernel (such as fixating
CD-ROM, initializing Lucent modem chipset) when even the mouse pointer
stops moving for half a second or so, sound from xmms stops playing until
I press stop and play again.
Interesting thing is that this only happens when MMAP is on. When I turn
it off, the sound freezes for a second and after that continues.
======================================================================

----------------------------------------------------------------------
 sasa - 09-26-2004 10:58 CEST 
----------------------------------------------------------------------
Sorry, mistake - it occurs when MMAP is ON.
Additional info:
Also I should note that I am using NVidia NForce chipset (Asus A7N8X-E D.
motherboard) and I am using
acpi=noirq pci=noacpi
in order to boot my system. And there is sometimes a lost interrupt 11
(used by IDE and soundcard as well but the lost interrupt is thown during
IDE initilization so it is probably caused by IDE).

----------------------------------------------------------------------
 lee - 09-26-2004 12:03 CEST 
----------------------------------------------------------------------
Sounds like an XMMS bug.  Does the same thing happen with aplay?

----------------------------------------------------------------------
 sasa - 09-26-2004 12:25 CEST 
----------------------------------------------------------------------
I cannot reproduce it with aplay. You are probably right, it is a XMMS
bug.
Thanks.

----------------------------------------------------------------------
 jtimonen - 10-09-2004 20:02 CEST 
----------------------------------------------------------------------
I can confirm this bug exists also with nforce2 chipset + xmms-1.2.10-r6
(gentoo). No other applications suffer from this.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-26-04 10:44 sasa           New Bug                                      
09-26-04 10:58 sasa           Bugnote Added: 0001916                       
09-26-04 10:59 sasa           Bug Monitored: sasa                          
09-26-04 12:03 lee            Bugnote Added: 0001918                       
09-26-04 12:25 sasa           Bugnote Added: 0001919                       
10-09-04 20:02 jtimonen       Bugnote Added: 0002062                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
