From: Mark Cooke <mpc@star.sr.bham.ac.uk>
Subject: CVS: kcalloc change missing symbols on 2.4.27rc2
Date: Wed, 30 Jun 2004 10:39:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088588353.4173.19.camel@sage.kitchen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7aLj+kGHuJ1Q28d561fy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sun13.bham.ac.uk (sun13.bham.ac.uk [147.188.128.145])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7204E26B
	for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2004 11:39:15 +0200 (MEST)
Received: from [147.188.128.127] (helo=bham.ac.uk)
	by sun13.bham.ac.uk with esmtp (Exim 4.10)
	id 1BfbYg-00051D-00
	for alsa-devel@alsa-project.org; Wed, 30 Jun 2004 10:39:14 +0100
Received: from pc1.sr.bham.ac.uk ([147.188.32.218])
	by bham.ac.uk with esmtp (Exim 4.24)
	id 1BfbYg-0002Jg-Ld
	for alsa-devel@alsa-project.org; Wed, 30 Jun 2004 10:39:14 +0100
Received: from 82-36-98-143.cable.ubr01.king.blueyonder.co.uk (82-36-98-143.cable.ubr01.king.blueyonder.co.uk [82.36.98.143])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by pc1.sr.bham.ac.uk (Postfix) with ESMTP id 5001423C859
	for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2004 10:39:14 +0100 (BST)
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


--=-7aLj+kGHuJ1Q28d561fy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

Synced up to CVS this morning, and after building successfully:

/lib/modules/2.4.26-27rc2.nt.mc1/kernel/sound/acore/snd.o: unresolved
symbol snd_compat_kcalloc_Rc0712957
/lib/modules/2.4.26-27rc2.nt.mc1/kernel/sound/acore/snd.o: insmod
/lib/modules/2.4.26-27rc2.nt.mc1/kernel/sound/acore/snd.o failed
/lib/modules/2.4.26-27rc2.nt.mc1/kernel/sound/acore/snd.o: insmod
sound-slot-0 failed

Both CONFIG_SND_DEBUG_MEMORY and CONFIG_HAVE_KCALLOC are not defined for
my compile.

I believe misc.c has incorrect #ifdef protection for defining
snd_compat_kcalloc:

>From adriver.h:

/* kcalloc */
#ifndef CONFIG_HAVE_KCALLOC
#ifndef CONFIG_SND_DEBUG_MEMORY
void *snd_compat_kcalloc(size_t n, size_t size, int gfp_flags);
#define kcalloc(n,s,f) snd_compat_kcalloc(n,s,f)
#endif
#endif

>From misc.c:

#ifndef CONFIG_HAVE_KCALLOC
#ifdef CONFIG_SND_DEBUG_MEMORY
/* Don't put this to wrappers.c.  We need to call the kmalloc wrapper
here. */void *snd_compat_kcalloc(size_t n, size_t size, int flags)
{
}
#endif
#endif

Mark

-- 
Mark Cooke <mpc@star.sr.bham.ac.uk>

--=-7aLj+kGHuJ1Q28d561fy
Content-Disposition: attachment; filename=kc.diff
Content-Type: text/x-patch; name=kc.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: acore/misc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/misc.c,v
retrieving revision 1.24
diff -u -r1.24 misc.c
--- acore/misc.c	29 Jun 2004 15:58:54 -0000	1.24
+++ acore/misc.c	30 Jun 2004 09:36:15 -0000
@@ -239,7 +239,7 @@
 #endif
 
 #ifndef CONFIG_HAVE_KCALLOC
-#ifdef CONFIG_SND_DEBUG_MEMORY
+#ifndef CONFIG_SND_DEBUG_MEMORY
 /* Don't put this to wrappers.c.  We need to call the kmalloc wrapper here. */
 void *snd_compat_kcalloc(size_t n, size_t size, int flags)
 {

--=-7aLj+kGHuJ1Q28d561fy--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
