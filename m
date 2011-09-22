From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 10/10] ASoC/MFD: twl6040: Combine bit
	definitions for Headset control registers
Date: Thu, 22 Sep 2011 11:05:54 +0300
Message-ID: <1316678754-11935-11-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id DA6B9103AFC
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:38 +0200 (CEST)
Received: by bkbzs8 with SMTP id zs8so2925657bkb.13
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:36 -0700 (PDT)
In-Reply-To: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Use one set of defines for the HS bits, since they are identical in both
control register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 include/linux/mfd/twl6040.h |   11 +++--------
 sound/soc/codecs/twl6040.c  |    2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 47470ca..d9e05ea 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -120,15 +120,10 @@
 #define TWL6040_LPLLFIN			0x08
 #define TWL6040_HPLLSEL			0x10
 
-/* HSLCTL (0x10) fields */
+/* HSLCTL/R (0x10/0x11) fields */
 
-#define TWL6040_HSDACMODEL		0x02
-#define TWL6040_HSDRVMODEL		0x08
-
-/* HSRCTL (0x11) fields */
-
-#define TWL6040_HSDACMODER		0x02
-#define TWL6040_HSDRVMODER		0x08
+#define TWL6040_HSDACMODE		(1 << 1)
+#define TWL6040_HSDRVMODE		(1 << 3)
 
 /* VIBCTLL (0x18) fields */
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 760701e..68e52c9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -642,7 +642,7 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 {
 	int hslctl, hsrctl;
-	int mask = TWL6040_HSDRVMODEL | TWL6040_HSDACMODEL;
+	int mask = TWL6040_HSDRVMODE | TWL6040_HSDACMODE;
 
 	hslctl = twl6040_read_reg_cache(codec, TWL6040_REG_HSLCTL);
 	hsrctl = twl6040_read_reg_cache(codec, TWL6040_REG_HSRCTL);
-- 
1.7.6.1
