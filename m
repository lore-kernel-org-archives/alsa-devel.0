From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] sound: rtctimer.c needs module.h
Date: Fri, 29 Jul 2011 21:14:12 -0700
Message-ID: <20110729211412.f064a06c.rdunlap@xenotime.net>
References: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, akpm <akpm@linux-foundation.org>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

rtctimer.c uses interfaces from linux/module.h, so it should
include that file.  This fixes build errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/core/rtctimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20110729.orig/sound/core/rtctimer.c
+++ linux-next-20110729/sound/core/rtctimer.c
@@ -22,7 +22,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/moduleparam.h>
+#include <linux/module.h>
 #include <linux/log2.h>
 #include <sound/core.h>
 #include <sound/timer.h>
