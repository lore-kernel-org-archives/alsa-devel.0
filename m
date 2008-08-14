From: "nguyen tritai" <nguyentritai@gmail.com>
Subject: Alsa-driver compile fail on Ubuntu powerpc
Date: Thu, 14 Aug 2008 16:25:24 +0700
Message-ID: <ce83e6480808140225q7481c888qb47b7008b1ba862d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id A05421038B4
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 11:25:26 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so266820rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2008 02:25:25 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm trying to bring up audio on powerpc AMCC 440EPX board with the soundcard
Sound Blaster Audigy CA0106.
The board is runing Ubuntu 7.04.
I configured: ./configure --with-cards=3Dca0106 --with-sequencer=3Dyes
--with-kernel=3D/usr/src/linux
Then I make and get issue:

make[2]: Leaving directory `/root/alsa-driver-1.0.17/usb'
make[2]: Entering directory `/root/alsa-driver-1.0.17/misc'
make[2]: Leaving directory `/root/alsa-driver-1.0.17/misc'
make[1]: Leaving directory `/root/alsa-driver-1.0.17'
make -C /usr/src/linux SUBDIRS=3D/root/alsa-driver-1.0.17  CPP=3D"gcc -E"
CC=3D"gcc" modules
make[1]: Entering directory `/usr/src/linux'
  CC [M]  /root/alsa-driver-1.0.17/acore/memory_wrapper.o
make[1]: Leaving directory `/usr/src/linux'
root@sequoia:~/alsa-driver-1.0.17# vim log
In file included from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
/root/alsa-driver-1.0.17/include/adriver.h:278:1: warning: "GFP_DMA32"
redefined
In file included from include/linux/slab.h:14,
                 from include/linux/percpu.h:5,
                 from include/linux/rcupdate.h:41,
                 from include/linux/pid.h:4,
                 from include/linux/sched.h:76,
                 from /root/alsa-driver-1.0.17/include/asm/elf.h:5,
                 from include/linux/elf.h:7,
                 from include/linux/module.h:14,
                 from /root/alsa-driver-1.0.17/include/adriver.h:26,
                 from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
include/linux/gfp.h:105:1: warning: this is the location of the previous
definition
In file included from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
/root/alsa-driver-1.0.17/include/adriver.h:828: error: static declaration of
=E2jiffies_to_msecs=E2 follows non-static declaration
include/linux/jiffies.h:270: error: previous declaration of
=E2jiffies_to_msecs=E2 was here
/root/alsa-driver-1.0.17/include/adriver.h:847: error: static declaration of
=E2msecs_to_jiffies=E2 follows non-static declaration
include/linux/jiffies.h:272: error: previous declaration of
=E2msecs_to_jiffies=E2 was here
In file included from /root/alsa-driver-1.0.17/include/adriver.h:944,
                 from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
include/linux/pci.h:594: error: expected identifier or =E2(=E2 before numer=
ic
constant
In file included from /root/alsa-driver-1.0.17/include/asm/pci.h:8,
                 from include/linux/pci.h:945,
                 from /root/alsa-driver-1.0.17/include/adriver.h:944,
                 from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
include/linux/mm.h:235: error: conflicting types for
=E2snd_compat_vmalloc_to_page=E2
/root/alsa-driver-1.0.17/include/adriver.h:748: error: previous declaration
of =E2snd_compat_vmalloc_to_page=E2 was here
In file included from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
/root/alsa-driver-1.0.17/include/adriver.h: In function
=E2snd_pci_orig_save_state=E2:
/root/alsa-driver-1.0.17/include/adriver.h:1186: error: too many arguments
to function =E2pci_save_state=E2
/root/alsa-driver-1.0.17/include/adriver.h: In function
=E2snd_pci_orig_restore_state=E2:
/root/alsa-driver-1.0.17/include/adriver.h:1190: error: too many arguments
to function =E2pci_restore_state=E2
In file included from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
/root/alsa-driver-1.0.17/include/adriver.h:1552:1: warning: "page_to_pfn"
redefined
In file included from /root/alsa-driver-1.0.17/include/asm/page.h:150,
                 from /root/alsa-driver-1.0.17/include/asm/thread_info.h:30,
                 from include/linux/thread_info.h:35,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from /root/alsa-driver-1.0.17/include/adriver.h:26,
                 from /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
include/asm-generic/memory_model.h:79:1: warning: this is the location of
the previous definition
/root/alsa-driver-1.0.17/acore/memory_wrapper.c: In function
=E2snd_compat_vmalloc_to_page=E2:
/root/alsa-driver-1.0.17/acore/memory_wrapper.c:44: error: implicit
declaration of function =E2VMALLOC_VMADDR=E2
/root/alsa-driver-1.0.17/acore/memory_wrapper.c:50: error: implicit
declaration of function =E2pte_offset=E2
/root/alsa-driver-1.0.17/acore/memory_wrapper.c:50: warning: assignment
makes pointer from integer without a cast
make[3]: *** [/root/alsa-driver-1.0.17/acore/memory_wrapper.o] Error 1
make[2]: *** [/root/alsa-driver-1.0.17/acore] Error 2
make[1]: *** [_module_/root/alsa-driver-1.0.17] Error 2


The issue looks like an error in alsa-driver source code.
I searched the error information and It seems there're lots of people having
the same issue but no helpful answers.

Do anyone knows how to pass the issue?

Thanks,

TaiNguyen
