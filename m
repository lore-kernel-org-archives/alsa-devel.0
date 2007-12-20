From: forumjunk@comcast.net
Subject: Re: snd-hda-intel support for SPDIF-in wiht vt1708
	card?
Date: Thu, 20 Dec 2007 00:37:46 +0000
Message-ID: <122020070037.26835.4769B95A000149C6000068D3220702293305029A06039A9D0100@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 97175246A8
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 01:37:50 +0100 (CET)
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


For VIA platforms, to avoid the driver compile error in pci.h, reconfigure your kernel to remove SMP support, and set the architecture type to PC-compatible.

(you already know this, I'm sure):
Recompile the kernel (as a paranoid, I always trash /lib/modules/<kernel_version> before making modules_install). Install the kernel, of course, and reconfigure your boot loader and/or initrd and reboot.

There are still several fixes that need to be made to get all of this to compile cleanly, but I haven't got the permanent fixes nailed down yet. I'm almost positive that these are alsa-driver configure errors or omissions. I can't (yet) find a kernel config that will avoid them. The fixes below are harmless, and they will allow you to get the driver compiled.

Add this definition to the top section of acore/memory_wrapper.c after the line that reads #include <linux/version.h>

#define VMALLOC_VMADDR(x)   ((unsigned long)(x))

Change these lines (45 and 46 or close to that) of acore/memory_wrapper.c from:

        pmd = pmd_offset(pgd, lpage);
        pte = pte_offset(pmd, lpage);

to

        pmd = pmd_offset((pud_t *)pgd, lpage);
        pte = pte_offset_kernel(pmd, lpage);

The driver will then compile cleanly (at least with no errors or warnings relating to any of these changes)

I will work more as time allows to find or create configure tests to make sure that the correct versions of these functions get included or patched.
