From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: How to build alsa-driver for sparc?
Date: Mon, 27 Sep 2004 20:14:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040927191437.GA436@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mra02.ex.eclipse.net.uk (mra02.ex.eclipse.net.uk [212.104.129.89])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A9DA42BF
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 21:14:40 +0200 (MEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra02.ex.eclipse.net.uk (Postfix) with ESMTP id CF832406952
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 20:09:13 +0100 (BST)
Received: from mra02.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra02.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 02172-01-39 for <alsa-devel@alsa-project.org>;
 Mon, 27 Sep 2004 20:09:13 +0100 (BST)
Received: from palantir8.mph.eclipse.net (unknown [81.168.73.77])
	by mra02.ex.eclipse.net.uk (Postfix) with ESMTP id CCA8B406910
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 20:09:12 +0100 (BST)
Received: from mhabets by palantir8.mph.eclipse.net with local (Exim 3.36 #1 (Debian))
	id 1CC0xK-0002GA-00
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 20:14:38 +0100
Content-Disposition: inline
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

I'm trying to build alsa-driver-1.0.7rc1 for SPARC32, but have
found that CONFIG_SPARC32 is not set in toplevel.config.
After initial failure, I have tried the steps from cvscompile, and rebuild
utils/mod-deps.

After I hand-edit toplevel.config and apply the patch attached, it does
start building. But the whole generation of toplevel.config leaves my
wondering how to make it work properly.

Any hints?
-- 
Martin
---------------------------------------------------------------------------
30 years from now GNU/Linux will be as redundant a term as UNIX/MERT is 
today. - Martin Habets
---------------------------------------------------------------------------

--- alsa-driver-1.0.7rc1/Makefile.orig	2004-09-27 17:34:05.000000000 +0100
+++ alsa-driver-1.0.7rc1/Makefile	2004-09-27 17:35:21.000000000 +0100
@@ -65,6 +65,12 @@
 ifeq (y,$(CONFIG_PARISC))
 SUBDIRS  += parisc
 endif
+ifeq (y,$(CONFIG_SPARC32))
+SUBDIRS  += sparc
+endif
+ifeq (y,$(CONFIG_SPARC64))
+SUBDIRS  += sparc
+endif
 CSUBDIRS += include test utils
 
 KCONFIG_FILES = $(shell find $(SND_TOPDIR) -name Kconfig) $(shell find $(SND_TOPDIR)/alsa-kernel/ -name Kconfig)


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
