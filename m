From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: gcc 3.x build issue? (was: cat /proc/asound/version: "No such device": HELP!!)
Date: Mon, 17 Feb 2003 20:11:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030217191113.GA1853@rhlx01.fht-esslingen.de>
References: <20030214111459.GA19210@rhlx01.fht-esslingen.de> <3E512D55.1030002@tin.it>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E512D55.1030002@tin.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Andrea Venturi (personale)" <andrea.venturi@tin.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 17, 2003 at 07:43:33PM +0100, Andrea Venturi (personale) wrote:
> Andreas Mohr wrote:
> >Hi all,
> >
> >I'm almost at my wits end ("ARGH!").
> >Everything used to work pretty well... until I messed with my system once
> >again (upgrading some packages and doing other things, or so I think).
> >
> >After having installed the 0.9rc7 Debian package (or around that time
> >at least) and having rebuilt ALSA, I didn't manage to start ALSA properly
> >any more:
> 
> hi,
> i incurred in the same problem since two days, when i decided to upgrade 
> my alsa driver from 0.9rc6 to 0.9rc7
Ah, finally! It's quite reassuring to know that I'm not alone in suffering
this severe problem :-)

> some info:
> 
> i use a toshiba s3000-214 with an intel8x0 audio device
> 
> with 0.9rc6 alsa was running fine
> 
> i run debian unstable.
> 
> 
> these are the relevant (!) package:
> 
> andrea@nb-venturi:~$ dpkg -l | grep alsa-
> ii  alsa-base      0.9.0rc7-2     ALSA driver common files
> ii  alsa-headers   0.9.0rc7-2     ALSA driver header files
> rc  alsa-modules-2 0.9+0beta10+5+ Advanced Linux Sound Architecture 
> (drivers)
> ii  alsa-source    0.9.0rc7-2     ALSA driver source
> ii  alsa-utils     0.9.0rc7-1     Advanced Linux Sound Architecture (utils)
> 
> andrea@nb-venturi:~$ dpkg -l | grep gcc
> ii  gcc            3.2.2-0        The GNU C compiler.
> ii  gcc-2.95       2.95.4-15      The GNU C compiler.
> ii  gcc-3.0        3.0.4-13       The GNU C compiler.
> ii  gcc-3.0-base   3.0.4-14       The GNU Compiler Collection (base package)
> ii  gcc-3.2        3.2.3-0pre1    The GNU C compiler
> ii  gcc-3.2-base   3.2.3-0pre1    The GNU Compiler Collection (base package)
> ii  libgcc1        3.2.3-0pre1    GCC support library
> rc  libstlport4.5g 4.5.3-4        gcc3-version STLport C++ class library
> ii  libstlport4.5g 4.5.3-5cjh2    STLport C++ class library compiled 
> with gcc3
> 
> under /usr/src there was:
> 
> andrea@nb-venturi:~$ ls -l /usr/src/
> totale 31756
> -rw-r--r--    1 root     root      2157649 2003-02-07 12:16 
> alsa-driver.tar.gz
> 
> that is the debian way to put source tarball to upgrade some driver..
> 
> i compiled the usual stuff /usr/src/modules/alsa-driver
> 
> ad i installed all the modules with "make install"
> 
> than, at next reboot, the /etc/init.d/alsa script failed to run because 
> there was a small glitch at line 93: a missing double-quote around 
> $alsa_version
> 
> the i had to add /etc/modutils/alsa with all the aliases for the modules 
> and i was up & running, or, at least, i was thinking.. :-(
> 
> the snd-intel8x0 goes up, from dmesg:
> 
> PCI: Found IRQ 10 for device 00:1f.5
> PCI: Sharing IRQ 10 with 00:1f.3
> PCI: Sharing IRQ 10 with 00:1f.6
> PCI: Sharing IRQ 10 with 02:01.0
> PCI: Sharing IRQ 10 with 02:04.1
> PCI: Setting latency timer of device 00:1f.5 to 64
> intel8x0: clocking to 48000
> 
> but, if i try a "cat /proc/asound/version"
> 
> i get an oopps
> =====================================
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 
> 00000000
>  printing eip:
> c0115073
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0115073>]    Tainted: PF
> EFLAGS: 00010097
> eax: d2960584   ebx: d2960584   ecx: 00000000   edx: 00000003
> esi: d2960588   edi: 00000001   ebp: c3391f30   esp: c3391f18
> ds: 0018   es: 0018   ss: 0018
> Process esd (pid: 4150, stackpage=c3391000)
> Stack: cfe75960 c888b540 d296054c d2960588 00000286 00000003 c888b540 
> d9b56451
>        c142f360 00000286 cc0385a0 d2960400 cc0385a0 d2960400 d9b5835d 
> d2960400
>        c888b540 00000000 cc0385c0 c888b540 ca4e1060 c142f360 ca3ac3a0 
> c0133444
> Call Trace:    [<d9b56451>] [<d9b5835d>] [<c0133444>] [<c0132495>] 
> [<c01324e3>]
>   [<c0108547>]
> 
> Code: 8b 01 85 45 fc 74 4c 31 c0 9c 5e fa c7 01 00 00 00 00 83 79
> ======================================
Hmm, interesting. I assume your problem is very "similar"
(mine just printed: "No such device").
I just did what I had announced (recompile ALSA using older gcc versions
installed on the system).
root@note:/usr/src/system/CVS/alsa/alsa-driver# dpkg -l|grep gcc
ii  altgcc         2.7.2.3-2      Alternate gcc package for the libc5 environm
ii  gcc            3.2.2-0        The GNU C compiler.
ii  gcc-2.95       2.95.4-15      The GNU C compiler.
ii  gcc-3.0        3.0.4-0pre0201 The GNU C compiler.
ii  gcc-3.0-base   3.0.4-14       The GNU Compiler Collection (base package)
ii  gcc-3.2        3.2.2-0pre8    The GNU C compiler
ii  gcc-3.2-base   3.2.2-0pre8    The GNU Compiler Collection (base package)
ii  gcc272         2.7.2.3-18     The GNU C compiler.
ii  libgcc1        3.2.3-0pre1    GCC support library

Using gcc-3.0 in Makefile.conf: failed.
Using gcc-2.95 in Makefile.conf: SUCCESS!!

Sounds as if there might be a pretty severe gcc 3.x ALSA build problem...
As I've got quite some time now, I'll try to nail it down somewhat.
Any further helpful comments strongly appreciated...

Needless to say I'll concentrate on the info.c /proc support area...
Maybe the various /proc parsing handlers inside that file get corrupted
by some gcc optimization somehow...
I'll add some traces to that file to find out more.

Andreas Mohr


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
