From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: How to build alsa-driver for sparc?
Date: Tue, 28 Sep 2004 01:25:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928002520.GA8552@palantir8>
References: <20040927191437.GA436@palantir8> <s5hllev1nxa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mra04.ex.eclipse.net.uk (mra04.ex.eclipse.net.uk [212.104.129.139])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A34C52E7
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 02:25:23 +0200 (MEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id D10A6133756
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 01:19:45 +0100 (BST)
Received: from mra04.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra04.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10959-01-6 for <alsa-devel@alsa-project.org>;
 Tue, 28 Sep 2004 01:19:45 +0100 (BST)
Received: from palantir8.mph.eclipse.net (unknown [81.168.73.77])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id 308C4133AA9
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 01:19:45 +0100 (BST)
Received: from mhabets by palantir8.mph.eclipse.net with local (Exim 3.36 #1 (Debian))
	id 1CC5o1-0004AA-00
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 01:25:21 +0100
Content-Disposition: inline
In-Reply-To: <s5hllev1nxa.wl@alsa2.suse.de>
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

Takashi,

Yes this works (and in record-breaking time!), but revealed another problem
when running configure:

checking for which soundcards to compile driver for... ./configure: line 8479: ((: ( test y = y -o y = m ) ||
      ( test  = y -o  = m ): missing `)' (error token is "y = y -o y = m ) ||
      ( test  = y -o  = m )")
./configure: line 8491: ((: ( test y = y -o y = m ) ||
      ( test  = y -o  = m ): missing `)' (error token is "y = y -o y = m ) ||
      ( test  = y -o  = m )")
./configure: line 8502: ((: ( test y = y -o y = m ) ||
      ( test  = y -o  = m ): missing `)' (error token is "y = y -o y = m ) ||
      ( test  = y -o  = m )")
all

configure has:
  if test "$card" = "all" -o "$card" = "sun-amd7930"; then
    if ((( test "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC32" = "m" ) ||
      ( test "$CONFIG_SPARC64" = "y" -o "$CONFIG_SPARC64" = "m" ))) &&
      ( test "$CONFIG_SBUS" = "y" -o "$CONFIG_SBUS" = "m" ); then

The "((" puts bash into math mode... The first patch attached circumvents
this problem.
After that it turned out CONFIG_SBUS was not set either in toplevel.config,
and the 2nd patch is my attempt to resolve that.

Thanks!
Martin

        Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--- alsa-driver-1.0.7rc1/utils/mod-deps.c.orig	2004-09-28 00:46:20.791040341 +0100
+++ alsa-driver-1.0.7rc1/utils/mod-deps.c	2004-09-28 00:47:02.581559194 +0100
@@ -929,10 +929,10 @@
 			if (cond->not)
 				printf(" ! ");
 			for (j = 0; j < cond->left; j++)
-				printf("(");
+				printf("( ");
 			printf("( test \"$CONFIG_%s\" = \"y\" -o \"$CONFIG_%s\" = \"m\" )", cond->name, cond->name);
 			for (j = 0; j < cond->right; j++)
-				printf(")");
+				printf(" )");
 			put_if = 1;
 			cond_prev = cond;
 		}
--- alsa-driver-1.0.7rc1/configure.in.orig	2004-09-28 01:13:47.546782281 +0100
+++ alsa-driver-1.0.7rc1/configure.in	2004-09-28 01:13:21.190059795 +0100
@@ -683,6 +683,9 @@
 CONFIG_ISA=probe
 fi
 
+dnl Check for SBUS support...
+CHECK_KERNEL_CONFIG(CONFIG_SBUS, [SBUS support in kernel])
+
 dnl Check processor type...
 AC_MSG_CHECKING(for processor type)
 CONFIG_X86=
@@ -1042,6 +1045,7 @@
 AC_SUBST(CONFIG_PPC)
 AC_SUBST(CONFIG_SPARC32)
 AC_SUBST(CONFIG_SPARC64)
+AC_SUBST(CONFIG_SBUS)
 AC_SUBST(CONFIG_ISA)
 AC_SUBST(CONFIG_PARISC)
 AC_SUBST(CONFIG_SND_BIT32_EMUL)


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
