From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: lk-maintainers3.txt
Date: Tue, 12 Feb 2002 09:39:38 -0200
Message-ID: <200202120739.g1C7dZt06127@Port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Received: from Port.imtp.ilyichevsk.odessa.ua (167.imtp.Ilyichevsk.Odessa.UA [195.66.192.167] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA18068
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 08:41:40 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>, Gerd Knorr <kraxel@bytesex.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, video4linux list <video4linux-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am planning to post a file appended below to lkml roughly once a week.
I have added these two entries:

ALSA development <alsa-devel@alsa-project.org> [12 feb 2002]
Jaroslav Kysela <perex@perex.cz> [12 feb 2002]
	Advanced Linux Sound Architecture
	ALSA patches are available at
	ftp://ftp.alsa-project.org/pub/kernel-patches/*

video4linux list <video4linux-list@redhat.com> [12 feb 2002]
Gerd Knorr <kraxel@bytesex.org> [12 feb 2002]
	video4linux


If you think they need to be changed, send me updated ones.
If you don't want them to be posted, let me know too.


lk-maintainers3.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
After recent discussion on Linux development practices I think it may be
worthy to have list of lk maintainers. Unlike one included into kernel
source, this document is meant to be monthly (weekly?) mailed to lkml
and to be modified whenever new victim wishes to be listed in it
or someone can no longer devote his time to maintainer work.

This is a draft. I picked some names and addresses and made entried for t=
hem.
If you want to be in this list, mail me your corrected entry.

Please indicate what kind of reports you wish to receive and what kind
of reports you DON'T want to see.

I want these entries to sound like "Hey, I am working on these parts of t=
he
kernel, if you have something, send it to me not to Linus". With precise
indication of those parts and your level of involvement:

If you don't want to be in this list, mail me too - I'll remove your entr=
y.

Note that English isn't my native language, feel free to correct any mist=
akes.
--
vda

* * * * DRAFT * * * *
IF you want your entry added/updated/removed, contact me
--
vda

------- cut here ------ cut here ------ cut here ------ cut here ------

So, you are new to Linux kernel hacking and want to submit a kernel bug
report or a patch but don't know how to do it and _where_ to report it?
Then save this file for future reference.

Preparing bug report:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Compile problems: report GCC output and result of "grep '^CONFIG_' .confi=
g"
Oops: decode it with ksymoops
Unkillable process: Alt-SysRq-T and ksymoops relevant part
Yes it means you should have ksymoops installed and tested,
which is easy to get wrong. I've done that too often.

More info in the FAQ at http://www.tux.org/lkml/

Sending bug report/patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* Some device drivers have active developers, try to contact them first.
* Otherwise find a subsystem maintainer to which your report pertains
  and send report to his address.
* Small fixes and device driver updates are best directed to subsystem
  maintainers and "small bits" integrators.
* It never hurts to CC: Linux kernel mailing list, but without specific
  maintainer address in TO: field there is high probability that your
  patch won't be noticed. You have been warned.
* Do not send it to all addresses at once! This will annoy lots of people
  and isn't useful at all. It's a spam.
* Do NOT send small fixes to Linus, he just can't handle _everything_.
  He will eventually receive it from maintainers/integrators, send it
  their way.
* If your patch is something big and new, announce it on lkml and try
  to attract testers. After it has been tested and discussed, you can
  expect Linus to consider inclusion in mainline.


		Current Linux kernel people

Note that this list is sorted in reversed date order, most recent
entries first. This means than entries at bottom can be outdated :-(


Linux kernel mailing list <linux-kernel@vger.kernel.org>
	Post anything related to Linux kernel here, but nothing else :-)

Neil Brown <neilb@cse.unsw.edu.au> [08 feb 2002]
	I am interested in any issues with the code in:
	NFS server    (fs/nfsd/*)
	software RAID (drivers/md/{md,raid,linear}*)
	or related include files.

Maksim Krasnyanskiy <maxk@qualcomm.com> [08 feb 2002]
	I'm author and maintainer of the Bluetooth subsystem
	and Universal TUN/TAP device driver.
	These days mostly working on Bluetooth stuff.

Rik van Riel <riel@conectiva.com.br> [07 feb 2002]
	Send me VM related stuff, please CC to linux-mm@kvack.org

Geert Uytterhoeven <geert@linux-m68k.org> [07 feb 2002]
	I work on the frame buffer subsystem, the m68k port (Amiga part),
	and the PPC port (CHRP LongTrail part).
	Unfortunately I barely have spare time to really work on these
	things. My job is not Linux-related (so far :-). I can not
	promise anything about my maintainership performance.

H. Peter Anvin <hpa@zytor.com> [07 feb 2002]
	i386 boot and feature code, i386 boot protocol, autofs3,
	compressed iso9660 (but I'll accept all iso9660-related
	changes.)  kernel.org site manager; please contact me
	for sponsorship-related issues.

kernel.org admins <ftpadmin@kernel.org> [07 feb 2002]
	Kernel.org sysadmins.  Contact us if you notice something breaks,
	or if you want a change make sure you give us at least 1-2 weeks.
	Please note that we got a lot of feature requests, a lot of
	which conflict or simply aren't practical; we don't have time to
	respond to all requests.

Greg KH <greg@kroah.com> [07 feb 2002]
	I am USB and PCI Hotplug maintainer.

Trond Myklebust <trond.myklebust@fys.uio.no> [07 feb 2002]
	I am NFS client maintainer.

James Simmons <jsimmons@transvirtual.com> [07 feb 2002]
	Console and framebuffer sybsustems.
	I also play around with the input layer.

Richard Gooch <rgooch@atnf.csiro.au> [07 feb 2002]
	I maintain devfs. I want people to Cc: me when reporting devfs
	problems, since I don't read all messages on linux-kernel.
	Send devfs related patches to me directly, rather than
	bypassing me and sending to Linus/Marcelo/Alan/Dave etc.

Russell King <rmk@arm.linux.org.uk> [06 feb 2002]
	ARM architecture maintainer.  Please send all ARM patches through
	the patch system at http://www.arm.linux.org.uk/developer/patches/
	New serial drivers maintainer for 2.5.  Submit patches to
	rmk+serial@arm.linux.org.uk

Andrew Morton <akpm@zip.com.au> [05 feb 2002]
	I'm receptive to any reproducible bug anywhere in the 2.4 kernel.
	Specialising in ext2, ext3 and network drivers.
	Not thinking about 2.5.x at this time.

Petr Vandrovec <vandrove@vc.cvut.cz> [05 feb 2002]
	ncpfs filesystem, matrox framebuffer driver, problems related
	to VMware - in all of 2.2.x, 2.4.x and 2.5.x.

Reiserfs developers list <reiserfs-dev@namesys.com> [05 feb 2002]
	Send all reiserfs-related stuff here including but not limited to bug
	reports, fixes, suggestions.

Oleg Drokin <green@linuxhacker.ru> [05 feb 2002]
	SA11x0 USB-ethernet and SA11x0 watchdog are mine.

Vojtech Pavlik <vojtech@ucw.cz> [05 feb 2002]
	Feel free to send me bug reports and patches to input device drivers
	(drivers/input/*, drivers/char/joystick/*)
	I also want to receive bug reports and patches for following
	USB drivers: printer, acm, catc, hid*, usbmouse, usbkbd, wacom.
	All other (not in the list) USB driver changes should go to USB
	maintainer (hopefully there is one listed here :-).
	Also CC me if you are posting VIA IDE driver related message
	(although I am not IDE subsystem maintainer).

=3D=3D=3D=3D=3D=3D=3D These entries are suggested by lkml folks =3D=3D=3D=
=3D=3D=3D=3D=3D

David S. Miller <davem@redhat.com> [07 feb 2002]
	I am Sparc64 and networking core maintainer.

=3D=3D=3D=3D=3D=3D=3D These ones I made myself =3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D I am waiting confirmation from these people =3D=3D=3D=
=3D=3D=3D=3D=3D

ALSA development <alsa-devel@alsa-project.org> [12 feb 2002]
Jaroslav Kysela <perex@perex.cz> [12 feb 2002]
	Advanced Linux Sound Architecture
	ALSA patches are available at
	ftp://ftp.alsa-project.org/pub/kernel-patches/*

video4linux list <video4linux-list@redhat.com> [12 feb 2002]
Gerd Knorr <kraxel@bytesex.org> [12 feb 2002]
	video4linux

Tim Waugh <twaugh@redhat.com> [08 feb 2002]
	> Who is maintaining the linux iomega stuff?
	For 2.4.x, me (in theory). I don't have time for 2.5.x at the moment.

Alan Cox <alan@lxorguk.ukuu.org.uk> [5 feb 2002]
	I am 2.2 maintainer.
	I collect various bits and pieces for inclusion in 2.4.
	You may send unmaintained driver fixes/updates to me.

Alexander Viro <viro@math.psu.edu> [5 feb 2002]
	I am NOT a fs subsystem maintainer. But I won't kill
	you if you send me some generic fs bug reports and (hopefully) patches.

Andre Hedrick <andre@linux-ide.org> [5 feb 2002]
	I am IDE guy.

Andrea Arcangeli <andrea@suse.de> [5 feb 2002]
	Send VM related bug reports and patches to me.

Arnaldo Carvalho de Melo <acme@conectiva.com.br> [5 feb 2002]
	?

Dave Jones <davej@suse.de> [5 feb 2002]
	I collect various bits and pieces for inclusion in 2.5,
	espesially small and trivial ones and driver updates. Do not bother
	Linus with them. I'll feed them to Linus when (and if) they
	are proved to be worthy.

Eric S. Raymond <esr@thyrsus.com> [5 feb 2002]
	Send kernel configuration bug reports and suggestions to me.
	Also I'll be more than happy to accept help enties for kernel config
	options for Configure.help.

G=E9rard Roudier <groudier@free.fr> [5 feb 2002]
	I am SCSI guy.

Hans Reiser <reiser@namesys.com> [5 feb 2002]
	ReiserFS is my favorite toy.

Ingo Molnar <mingo@elte.hu> [5 feb 2002]
	New scheduler in 2.5 and Tux are mine.

Jeff Garzik <jgarzik@mandrakesoft.com> [5 feb 2002]
	?

Jens Axboe <axboe@suse.de> [5 feb 2002]
	I am block device subsystem maintainer.

Keith Owens <kaos@ocs.com.au> [5 feb 2002]
	ksymoops, kbuild, .. .. .. .. .  are mine.

Linus Torvalds <torvalds@transmeta.com> [5 feb 2002]
	Do not send anything to me unless it is for 2.5, well tested,
	discussed on lkml and is used by significant number of people.
	In general it is a bad idea to send me small fixes and driver
	updates, send them to subsystem maintainers and/or
	"small stuff" integrator (currently Dave Jones, see his entry)
	Sorry, I can't do everything.

Marcelo Tosatti <marcelo@conectiva.com.br> [5 feb 2002]
	Do not send anything to me unless it is for 2.4 and well tested.
	If you are sending me small fixes and driver updates, send
	a copy to subsystem maintainers and/or "small stuff" integrator
	(currently Alan Cox, see his entry).

Robert Love <rml@tech9.net> [5 feb 2002]
	Preemptible kernel is mine.

Rusty Russell <rusty@rustcorp.com.au> [5 feb 2002]
	?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
