From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000366]: driver hangs when trying to load a soundfont >8MB
Date: Wed, 22 Sep 2004 18:12:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040922161220.7EA343200A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DA823368
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 18:12:20 +0200 (MEST)
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
Status:                     resolved
Distribution:               
Kernel Version:             2.6.7
Resolution:                 fixed
======================================================================
Date Submitted:             07-05-2004 09:43 CEST
Last Modified:              09-22-2004 18:12 CEST
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

----------------------------------------------------------------------
 tiwai - 09-08-2004 17:06 CEST 
----------------------------------------------------------------------
This should not happen on the ALSA CVS version because it now has
__GFP_NORETRY unconditionally.  If still gets wrong, it must be a
kernel bug.

----------------------------------------------------------------------
 deathpudding - 09-09-2004 03:46 CEST 
----------------------------------------------------------------------
I tried 1.0.7rc1, which uses the NORETRY flag, and the soundfont loads
without hanging/killing processes. But it doesn't load the entire
soundfont, probably stopping when it runs out of memory. Only one
instrument played when I played a test midi file. I don't understand why
it thinks there isn't enough memory.

----------------------------------------------------------------------
 deathpudding - 09-09-2004 03:49 CEST 
----------------------------------------------------------------------
ah, it's using dma_alloc, and the txt I attached says there was only 32kb
DMA memory free.

----------------------------------------------------------------------
 deathpudding - 09-09-2004 04:30 CEST 
----------------------------------------------------------------------
and also that there was 16MB of DMA memory total, while the soundfont is
32MB...

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:45 CEST 
----------------------------------------------------------------------
This should NOT happen.  snd-page-alloc has a wrapper for
dma_alloc_coherent() to allocate the pages from __GFP_KERNEL
as much as possible.  It means, that this hack isn't working
on your environment.

Check whether the codepath goes through dma_alloc_coherent wrapper
in memalloc.c (e.g. adding prink's there).

----------------------------------------------------------------------
 deathpudding - 09-14-2004 02:43 CEST 
----------------------------------------------------------------------
The hack is indeed used. Something very strange showed up when I tested it,
though: when I put a printk() in the beginning of
snd_dma_hack_alloc_coherent(), the soundfont loaded completely and the
midi file played correctly. But, when I removed the printk(), it broke as
I described earlier. I recompiled the driver several times both ways to
make sure it wasn't a fluke. Then I replaced the printk() with a small
delay:
int x = 1000000; while (x--);
and this also worked. Judging only from this information, it seems like
multiple calls to dma_alloc_coherent made too quickly somehow interfere
with each other.

----------------------------------------------------------------------
 tiwai - 09-21-2004 12:41 CEST 
----------------------------------------------------------------------
This is really weird.  Anyway, it's beyond the scope of ALSA...

----------------------------------------------------------------------
 vlajsa - 09-22-2004 12:05 CEST 
----------------------------------------------------------------------
This is even wierder! Upgrading to 2.6.9-rc2 with mm1 patch solved the
problem! At least for me!

----------------------------------------------------------------------
 tiwai - 09-22-2004 18:12 CEST 
----------------------------------------------------------------------
Ok, then close this bug now.

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
09-08-04 17:06 tiwai          Bugnote Added: 0001732                       
09-09-04 03:46 deathpudding   Bugnote Added: 0001740                       
09-09-04 03:49 deathpudding   Bugnote Added: 0001741                       
09-09-04 04:30 deathpudding   Bugnote Added: 0001742                       
09-13-04 15:45 tiwai          Bugnote Added: 0001748                       
09-14-04 02:43 deathpudding   Bugnote Added: 0001756                       
09-21-04 12:41 tiwai          Bugnote Added: 0001800                       
09-22-04 12:05 vlajsa         Bugnote Added: 0001811                       
09-22-04 18:12 tiwai          Bugnote Added: 0001813                       
09-22-04 18:12 tiwai          Resolution               open => fixed       
09-22-04 18:12 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
