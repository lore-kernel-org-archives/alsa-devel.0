From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000366]: driver hangs when trying to load a soundfont >8MB
Date: Tue,  7 Sep 2004 09:37:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907073705.2FAF9D00D@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8C622273
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 09:37:05 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000366
======================================================================
Reported By:                deathpudding
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     366
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-05-2004 09:43 CEST
Last Modified:              09-07-2004 09:37 CEST
======================================================================
Summary:                    driver hangs when trying to load a soundfont >8MB
Description: 
The alsa driver and the applications using it hang, unkillable and unable
to be unloaded, when I try to load a soundfont larger than 8MB. This
sometimes results in the appearance of a page fault message when shutting
down. The shutdown is never completed because the disk cannot be
unmounted, presumably because the alsa driver is still frozen while trying
load the soundfont from it.

I found a thread in the alsa-devel archives discussing this problem:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg12386.html

I see that the discussed patch has been applied, but I still have this
problem. I haven't tested with versions prior to 1.0.4 because they did
not compile with the later library version, but I do know that it was
working not too long ago (with kernel 2.6.x).
======================================================================

----------------------------------------------------------------------
 vlajsa - 07-10-2004 20:39 CEST 
----------------------------------------------------------------------
To add to this report! Sfxload don't work with alsa 1.0.5, too!

----------------------------------------------------------------------
 deathpudding - 07-10-2004 21:45 CEST 
----------------------------------------------------------------------
I marked this as a 1.0.5a bug, but it doesn't look like it showed up in the
report.

----------------------------------------------------------------------
 pzad - 07-12-2004 13:31 CEST 
----------------------------------------------------------------------
I tested this with 32 MB soundfont what I have and it worked.
If this is free soundfont can you give link to it ????

----------------------------------------------------------------------
 deathpudding - 07-12-2004 23:03 CEST 
----------------------------------------------------------------------
I've tried it with multiple soundfonts, but here are two examples:

http://www.hammersound.net/cgi-bin/soundlink.pl?action=view_download_page;ID=116;SoundFont_Filename_Selected=mustheory2.sfArk
http://bennetng.kc-studio.com/bennetng_AnotherGS_v2-0.exe

Unfortunately the first requires the sfArk program, and the second is a
self-extracting sfArk. Both should work under Wine, at least.

edited on: 07-12-04 23:03

----------------------------------------------------------------------
 vlajsa - 08-03-2004 17:11 CEST 
----------------------------------------------------------------------
Hmm... I really don't know how I've missed this one! When playing some
music with xmms through alsa plugin, the song continues to the end, and
then silently driver hangs! Of course this happenes when trying to load
soundfont while playing some song! Hope this can help!!

I'm sure I can find sone fonts that dont need wine to use them. If you
want me to do that, let me know!

----------------------------------------------------------------------
 pzad - 09-07-2004 09:37 CEST 
----------------------------------------------------------------------
Sorry, I can not reproduce this with alsa 1.0.6a + Audigy + kernel 2.6.5.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-05-04 09:43 deathpudding   New Bug                                      
07-05-04 09:43 deathpudding   Kernel Version            => 2.6.7           
07-10-04 20:39 vlajsa         Bugnote Added: 0001404                       
07-10-04 21:45 deathpudding   Bugnote Added: 0001405                       
07-12-04 13:31 pzad           Bugnote Added: 0001409                       
07-12-04 23:02 deathpudding   Bugnote Added: 0001411                       
07-12-04 23:03 deathpudding   Bugnote Edited: 0001411                      
08-03-04 17:11 vlajsa         Bugnote Added: 0001528                       
09-07-04 09:37 pzad           Bugnote Added: 0001703                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
