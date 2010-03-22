From: "Christian Steffen" <c-steffen@web.de>
Subject: Compiling older alsa version (1.0.15) on newer kernel
	(2.6.32.10) - errors ?
Date: Mon, 22 Mar 2010 18:01:43 +0100
Message-ID: <001f01cac9e1$59b3ca60$0d1b5f20$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 08E0D10385E
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 18:01:45 +0100 (CET)
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 86C1114FD909F
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 18:01:44 +0100 (CET)
Received: from [78.48.182.192] (helo=Crusoe)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #4) id 1Ntl0a-0001TW-00
	for alsa-devel@alsa-project.org; Mon, 22 Mar 2010 18:01:44 +0100
Content-Language: de
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

Hi there,

I want to compile some new alsa drivers for a MID device running ubuntu,
because actual sound drivers on the device make some cracking noise all the
time.
The device (o2 Joggler) comes with an intel Poulsbo chipset (Sigmatel 9202).
The original software on the device (a small linux with no big
functionality) runs the alsa driver 1.0.15.

That's the version, we have existig patches for. See those links: (Patches
0010 and 0014)
 
http://software.intel.com/en-us/articles/patches-for-moblin-kernel-on-menlow
/

http://www.soulinfo.com/~hugang/tmp/ubuntu-hardy%2Btuxonice/debian/binary-cu
stom.d/lpia/patchset/


It looks like these patches aren't still concluded in the newest
alsa-drivers, therefore I'd like to use and compile version 1.0.15.

But this seems not working with newer kernels.

Here are the error messages I'm getting:
 
make -C /root/Desktop/linux-2.6.32.10
SUBDIRS=/root/Downloads/alsa-driver-1.0.15  CPP="gcc -E" CC="gcc" modules
make[1]: Betrete Verzeichnis '/root/Desktop/linux-2.6.32.10'
scripts/Makefile.build:49: *** CFLAGS was changed in
"/root/Downloads/alsa-driver-1.0.15/acore/Makefile". Fix it to use
EXTRA_CFLAGS.  Schluss.
make[2]: *** [/root/Downloads/alsa-driver-1.0.15/acore] Fehler 2
make[1]: *** [_module_/root/Downloads/alsa-driver-1.0.15] Fehler 2
make[1]: Verlasse Verzeichnis '/root/Desktop/linux-2.6.32.10'
make: *** [compile] Fehler 2

 
and still 1.0.16 which has corrected the EXTRA_CFLAGS, gives me this list of
errors:

 
make[1]: Betrete Verzeichnis '/root/Desktop/linux-2.6.32.10'
  CC [M]  /root/Downloads/alsa-driver-1.0.16/acore/hwdep.o
In file included from /root/Downloads/alsa-driver-1.0.16/acore/hwdep.c:1:
/root/Downloads/alsa-driver-1.0.16/include/adriver.h:823: error: static
declaration of 'jiffies_to_msecs' follows non-static declaration
include/linux/jiffies.h:296: note: previous declaration of
'jiffies_to_msecs' was here
/root/Downloads/alsa-driver-1.0.16/include/adriver.h:842: error: static
declaration of 'msecs_to_jiffies' follows non-static declaration
include/linux/jiffies.h:298: note: previous declaration of
'msecs_to_jiffies' was here
In file included from
/root/Downloads/alsa-driver-1.0.16/include/adriver.h:940,
                 from /root/Downloads/alsa-driver-1.0.16/acore/hwdep.c:1:
include/linux/pci.h:714: error: expected identifier or '(' before numeric
constant
In file included from
/root/Desktop/linux-2.6.32.10/arch/x86/include/asm/pci.h:4,
                 from include/linux/pci.h:1126,
                 from
/root/Downloads/alsa-driver-1.0.16/include/adriver.h:940,
                 from /root/Downloads/alsa-driver-1.0.16/acore/hwdep.c:1:
include/linux/mm.h:269: error: conflicting types for
'snd_compat_vmalloc_to_page'
/root/Downloads/alsa-driver-1.0.16/include/adriver.h:744: note: previous
declaration of 'snd_compat_vmalloc_to_page' was here
In file included from /root/Downloads/alsa-driver-1.0.16/acore/hwdep.c:1:
/root/Downloads/alsa-driver-1.0.16/include/adriver.h: In function
'snd_pci_orig_save_state':
/root/Downloads/alsa-driver-1.0.16/include/adriver.h:1182: error: too many
arguments to function 'pci_save_state'
/root/Downloads/alsa-driver-1.0.16/include/adriver.h: In function
'snd_pci_orig_restore_state':
/root/Downloads/alsa-driver-1.0.16/include/adriver.h:1186: error: too many
arguments to function 'pci_restore_state'
make[3]: *** [/root/Downloads/alsa-driver-1.0.16/acore/hwdep.o] Fehler 1
make[2]: *** [/root/Downloads/alsa-driver-1.0.16/acore] Fehler 2
make[1]: *** [_module_/root/Downloads/alsa-driver-1.0.16] Fehler 2
make[1]: Verlasse Verzeichnis '/root/Desktop/linux-2.6.32.10'
make: *** [compile] Fehler 2

 

--------------------------

Is there any possibitliy to compile version 1.0.15 with a new kernel?

Or the second way - is it difficult to apply those patches on a newer alsa
driver?

I tried to apply them "manually" on a new alsa driver, but without success.
 

I thank you for any help on this!

 
Best,
Christian
