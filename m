From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000366]: driver hangs when trying to load a soundfont >8MB
Date: Wed,  8 Sep 2004 01:38:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907233841.9D46BE01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DF332279
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 01:38:41 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000366
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
Last Modified:              09-08-2004 01:38 CEST
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

----------------------------------------------------------------------
 deathpudding - 09-07-2004 10:31 CEST 
----------------------------------------------------------------------
I tried again with kernel 2.6.8.1, alsa 1.0.6a and SB Live!. This time,
instead of alsa hanging, several of my unrelated running processes were
killed. I at least got some debug output, which I've attached to the
report as a text file. The file only contains the message for asfxload -
the other killed processes had similar messages but without page faults.

----------------------------------------------------------------------
 vlajsa - 09-07-2004 18:25 CEST 
----------------------------------------------------------------------
hmm,
somewhere on the rosegarden-user list I've heared that problem will be
gone after kernel patching (with mm# patch from Andrew Morton, I think).
But I didn't try this becouse of fedora_core2 kernel, which is not easyly
patchable, and I cann't download complete kernel sources.. something's
wrong with my provider!

deathpudding, are you able to do this test?

here's the patch url:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm4/2.6.8.1-mm4.bz2

edited on: 09-07-04 18:25

----------------------------------------------------------------------
 deathpudding - 09-08-2004 01:38 CEST 
----------------------------------------------------------------------
I tried the -mm4 patch, but it didn't make a difference.

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
09-07-04 10:26 deathpudding   File Added: alsacrash.txt                    
09-07-04 10:31 deathpudding   Bugnote Added: 0001705                       
09-07-04 18:21 vlajsa         Bugnote Added: 0001724                       
09-07-04 18:25 vlajsa         Bugnote Edited: 0001724                      
09-08-04 01:38 deathpudding   Bugnote Added: 0001725                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
