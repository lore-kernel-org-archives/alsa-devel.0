Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6500C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 06:23:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8630A61B62
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 06:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8630A61B62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43FA618A3;
	Thu, 18 Nov 2021 07:22:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43FA618A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637216584;
	bh=ETdg/kHQIIdnA6Apr3tNx/zGzy58bfAyeLlGOhcC874=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pjobi8n9/pWMG5IgsLshJCXtx+dG5RGs8jgVHOHsVR5tWhPchLqqVAIMZYKCvcwQ7
	 UdBzwdkC/8Q+3LFEmiwD6/7Fo+kM5cnneBoD4pp8gMqSoHGT8oCqs5OsrTpLkFXoS6
	 4+mGAl5ffikQz8FOfJVJfnWt8PXJn4ZrgM+JgEoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAD69F8010B;
	Thu, 18 Nov 2021 07:22:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A681F80115; Thu, 18 Nov 2021 07:22:11 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2720DF80115
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 07:22:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2720DF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="PvpSdbtQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=q9zYad4IkVx8WQ5GILNcaiEsJwNxxgcbDaRqT7OPn10=; b=PvpSdbtQw9PNk+TIuIy4KalS3p
 6kF6M10JOGUqUXOKvozEyDzDlLuQfrFZdOkJfDWZB59TzVxWfrdAgoqN3Qbh+z0Gk0TaUcGyELDEX
 xE/NhkZnw/W1eAZIYxG7jFz4E4wEvlUKG84OBjlhqiLhFJ/UYjOmDkQq7qQhbuIL1suWB3qP+tlYJ
 5q7IEZ0Tnob+d8r6HTcAr1/C73Yl/Z7b/4SteTmbchEEd4jZrndGlBNIpkk/izsbqsET6ET0MclRS
 NCYib63P1yp8KLqmj5VQZFoS88njTBL2zEB9FpxZfngOqOxvsY8UGlHVtadx/fnusssXw+syj4I89
 c0eB8Qmw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnanr-006yRc-3n; Thu, 18 Nov 2021 06:21:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sound/oss/dmasound: fix build when some drivers are =m and
 others are =y
Date: Wed, 17 Nov 2021 22:21:46 -0800
Message-Id: <20211118062146.11850-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 Takashi Iwai <tiwai@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

When CONFIG_DMASOUND_ATARI=y and CONFIG_DMASOUND_Q40=m,
dmasound_atari.o is built first (listed first in the Makefile),
so dmasound_core.o is built as builtin, not for use by loadable
modules. Then dmasound_q40.o is built and linked with the
already-built dmasound_core.o, but the latter does not support
use by loadable modules. This causes the missing symbol to be
undefined.

Fixes this build error:
ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_q40.ko] undefined!

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # "forever"
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
There may be some Makefile solution to this but I don't know what
it is. I didn't want to spend lots of time on these old drivers.

 sound/oss/dmasound/Makefile         |    6 +++---
 sound/oss/dmasound/dmasound_atari.c |    2 +-
 sound/oss/dmasound/dmasound_core.c  |   16 ----------------
 sound/oss/dmasound/dmasound_paula.c |    2 +-
 sound/oss/dmasound/dmasound_q40.c   |    2 +-
 5 files changed, 6 insertions(+), 22 deletions(-)

--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_atari.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_atari.c
@@ -27,7 +27,7 @@
 #include <asm/atariints.h>
 #include <asm/atari_stram.h>
 
-#include "dmasound.h"
+#include "dmasound_core.c"
 
 #define DMASOUND_ATARI_REVISION 0
 #define DMASOUND_ATARI_EDITION 3
--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_paula.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_paula.c
@@ -30,7 +30,7 @@
 #include <asm/amigaints.h>
 #include <asm/machdep.h>
 
-#include "dmasound.h"
+#include "dmasound_core.c"
 
 #define DMASOUND_PAULA_REVISION 0
 #define DMASOUND_PAULA_EDITION 4
--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_q40.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_q40.c
@@ -25,7 +25,7 @@
 #include <asm/q40ints.h>
 #include <asm/q40_master.h>
 
-#include "dmasound.h"
+#include "dmasound_core.c"
 
 #define DMASOUND_Q40_REVISION 0
 #define DMASOUND_Q40_EDITION 3
--- linux-next-20211117.orig/sound/oss/dmasound/Makefile
+++ linux-next-20211117/sound/oss/dmasound/Makefile
@@ -3,6 +3,6 @@
 # Makefile for the DMA sound driver
 #
 
-obj-$(CONFIG_DMASOUND_ATARI)	+= dmasound_core.o dmasound_atari.o
-obj-$(CONFIG_DMASOUND_PAULA)	+= dmasound_core.o dmasound_paula.o
-obj-$(CONFIG_DMASOUND_Q40)	+= dmasound_core.o dmasound_q40.o
+obj-$(CONFIG_DMASOUND_ATARI)	+= dmasound_atari.o
+obj-$(CONFIG_DMASOUND_PAULA)	+= dmasound_paula.o
+obj-$(CONFIG_DMASOUND_Q40)	+= dmasound_q40.o
--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_core.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_core.c
@@ -1570,19 +1570,3 @@ char dmasound_alaw2dma8[] = {
 	3,	3,	3,	3,	3,	3,	3,	3
 };
 #endif /* HAS_8BIT_TABLES */
-
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(dmasound);
-EXPORT_SYMBOL(dmasound_init);
-#ifdef MODULE
-EXPORT_SYMBOL(dmasound_deinit);
-#endif
-EXPORT_SYMBOL(dmasound_write_sq);
-EXPORT_SYMBOL(dmasound_catchRadius);
-#ifdef HAS_8BIT_TABLES
-EXPORT_SYMBOL(dmasound_ulaw2dma8);
-EXPORT_SYMBOL(dmasound_alaw2dma8);
-#endif
