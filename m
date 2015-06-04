From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 23/23] ASoC: tas2552: Code,
	define alignment changes for uniformity
Date: Thu, 4 Jun 2015 16:04:35 +0300
Message-ID: <1433423075-14142-24-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A2462665B3
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:05:32 +0200 (CEST)
In-Reply-To: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Align the numbers in the header file to the same column.
At the same time change the wrapping of CFG_2 register write in the probe
function to be uniform with the other calls.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c |  4 ++--
 sound/soc/codecs/tas2552.h | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index fe8a988e0a4a..21d8e1d764a2 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -607,8 +607,8 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, TAS2552_BOOST_APT_CTRL, TAS2552_APT_DELAY_200 |
 						     TAS2552_APT_THRESH_20_17);
 
-	snd_soc_write(codec, TAS2552_CFG_2, TAS2552_BOOST_EN |
-				  TAS2552_APT_EN | TAS2552_LIM_EN);
+	snd_soc_write(codec, TAS2552_CFG_2, TAS2552_BOOST_EN | TAS2552_APT_EN |
+					    TAS2552_LIM_EN);
 
 	return 0;
 
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 364c6dd8e79b..13f8d1be1e06 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -19,7 +19,7 @@
 #define __TAS2552_H__
 
 /* Register Address Map */
-#define TAS2552_DEVICE_STATUS	0x00
+#define TAS2552_DEVICE_STATUS		0x00
 #define TAS2552_CFG_1			0x01
 #define TAS2552_CFG_2			0x02
 #define TAS2552_CFG_3			0x03
@@ -33,12 +33,12 @@
 #define TAS2552_BTIP			0x0b
 #define TAS2552_BTS_CTRL		0x0c
 #define TAS2552_RESERVED_0D		0x0d
-#define TAS2552_LIMIT_RATE_HYS	0x0e
-#define TAS2552_LIMIT_RELEASE	0x0f
-#define TAS2552_LIMIT_INT_COUNT	0x10
+#define TAS2552_LIMIT_RATE_HYS		0x0e
+#define TAS2552_LIMIT_RELEASE		0x0f
+#define TAS2552_LIMIT_INT_COUNT		0x10
 #define TAS2552_PDM_CFG			0x11
 #define TAS2552_PGA_GAIN		0x12
-#define TAS2552_EDGE_RATE_CTRL	0x13
+#define TAS2552_EDGE_RATE_CTRL		0x13
 #define TAS2552_BOOST_APT_CTRL		0x14
 #define TAS2552_VER_NUM			0x16
 #define TAS2552_VBAT_DATA		0x19
-- 
2.4.2
