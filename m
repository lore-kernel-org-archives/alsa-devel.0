From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 18/21] ASoC: Remove unused struct
	wm2000_setup_data
Date: Sat,  3 Dec 2011 21:33:26 +0000
Message-ID: <1322948009-27658-18-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DEA7103856
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:43 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm2000.h b/sound/soc/codecs/wm2000.h
index 0b6f056..28a51ed 100644
--- a/sound/soc/codecs/wm2000.h
+++ b/sound/soc/codecs/wm2000.h
@@ -9,11 +9,6 @@
 #ifndef _WM2000_H
 #define _WM2000_H
 
-struct wm2000_setup_data {
-	unsigned short i2c_address;
-	int mclk_div;   /* Set to a non-zero value if MCLK_DIV_2 required */
-};
-
 extern int wm2000_add_controls(struct snd_soc_codec *codec);
 
 #define WM2000_REG_SYS_START	    0x8000
-- 
1.7.7.3
