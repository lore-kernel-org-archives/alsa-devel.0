From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fix section mismatch in the sound_core
Date: Sun, 7 Sep 2008 17:24:33 +0200
Message-ID: <20080907172433.3be17e29.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id D5E7B245D0
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Sep 2008 17:17:31 +0200 (CEST)
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 291F5296795
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Sep 2008 17:17:29 +0200 (CEST)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id DFED11324FA
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Sep 2008 17:17:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The __exit cleanup_oss_soundcore() is called from 
the __init init_soundcore(). This causes section mismatch
and breaks kernel's linking on sparc64.

Remove the __exit attribute from the cleanup_oss_soundcore().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Patch against 2.6.27-rc5-mm1.

diff -urp linux-ref/sound/sound_core.c linux-2.6.26/sound/sound_core.c
--- linux-ref/sound/sound_core.c	2008-09-07 18:54:22.800008536 -0400
+++ linux-2.6.26/sound/sound_core.c	2008-09-07 18:55:56.805521447 -0400
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_SOUND_OSS_CORE
 static int __init init_oss_soundcore(void);
-static void __exit cleanup_oss_soundcore(void);
+static void cleanup_oss_soundcore(void);
 #else
 static inline int init_oss_soundcore(void)	{ return 0; }
 static inline void cleanup_oss_soundcore(void)	{ }
@@ -573,7 +573,7 @@ int soundcore_open(struct inode *inode, 
 
 MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
 
-static void __exit cleanup_oss_soundcore(void)
+static void cleanup_oss_soundcore(void)
 {
 	/* We have nothing to really do here - we know the lists must be
 	   empty */

----------------------------------------------------------------------
Tanie polaczenia z Polska i ze swiatem
Sprawdz >>  http://link.interia.pl/f1f00 
