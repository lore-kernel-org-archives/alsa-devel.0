From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix section mismatch warnings in WM8994
Date: Mon,  7 Mar 2011 16:43:01 +0000
Message-ID: <1299516181-23724-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B52A11037F5
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 17:42:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Annoying as the __devinitdata is actually correct.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994-tables.c |    2 +-
 sound/soc/codecs/wm8994.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994-tables.c b/sound/soc/codecs/wm8994-tables.c
index 61dfd91..a87adbd 100644
--- a/sound/soc/codecs/wm8994-tables.c
+++ b/sound/soc/codecs/wm8994-tables.c
@@ -1573,7 +1573,7 @@ const struct wm8994_access_mask wm8994_access_masks[WM8994_CACHE_SIZE] = {
 	{ 0x03C3, 0x03C3 }, /* R1569  - Sidetone */
 };
 
-const __devinitdata u16 wm8994_reg_defaults[WM8994_CACHE_SIZE] = {
+const u16 wm8994_reg_defaults[WM8994_CACHE_SIZE] = {
 	0x8994,     /* R0     - Software Reset */
 	0x0000,     /* R1     - Power Management (1) */
 	0x6000,     /* R2     - Power Management (2) */
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 0c355bf..999b885 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -43,6 +43,6 @@ struct wm8994_access_mask {
 };
 
 extern const struct wm8994_access_mask wm8994_access_masks[WM8994_CACHE_SIZE];
-extern const __devinitdata  u16 wm8994_reg_defaults[WM8994_CACHE_SIZE];
+extern const u16 wm8994_reg_defaults[WM8994_CACHE_SIZE];
 
 #endif
-- 
1.7.2.3
