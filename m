From: <zhaoming.zeng@freescale.com>
Subject: [PATCH] ASoC: remove unnecessary header including in
	SGTL5000 codec driver
Date: Mon, 28 Feb 2011 03:45:21 +0800
Message-ID: <1298835921-16428-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 608FA1037EE
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 04:45:34 +0100 (CET)
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
Cc: Zeng Zhaoming <b32542@freescale.com>, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, timur.tabi@gmail.com, zengzm.kernel@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Zeng Zhaoming <b32542@freescale.com>

Remove unnecessary headers:
 - mach/hardware.h in sgtl5000.c
 - linux/i2c.h in sgtl5000.h

Signed-off-by: Zeng Zhaoming <b32542@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |    1 -
 sound/soc/codecs/sgtl5000.h |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 9eb206e..b528f97 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -27,7 +27,6 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
-#include <mach/hardware.h>
 
 #include "sgtl5000.h"
 
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index c29312a..eec3ab3 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -11,8 +11,6 @@
 #ifndef _SGTL5000_H
 #define _SGTL5000_H
 
-#include <linux/i2c.h>
-
 /*
  * Register values.
  */
-- 
1.7.0.4
