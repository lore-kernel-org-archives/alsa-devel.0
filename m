From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: [PATCH] Fix build error with strict mm checking
Date: Wed, 13 Jun 2007 00:18:57 +0100
Message-ID: <20070612231857.GB8953@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mra01.ch.as12513.net (mra01.ch.as12513.net [82.153.254.69])
	by alsa0.perex.cz (Postfix) with ESMTP id D983A10383B
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2007 01:18:59 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Turning on STRICT_MM_TYPECHECKS in include/asm/page.h causes a
build error for sparc32. This patch against 2.6.21 fixes this.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
--- linux/sound/core/sgbuf.c.orig	2007-06-06 23:53:34.000000000 +0100
+++ linux/sound/core/sgbuf.c	2007-06-06 23:54:45.000000000 +0100
@@ -96,7 +96,7 @@ void *snd_malloc_sgbuf_pages(struct devi
 	}
 
 	sgbuf->size = size;
-	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
+	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, __pgprot(PAGE_KERNEL));
 	if (! dmab->area)
 		goto _failed;
 	return dmab->area;
