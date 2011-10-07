From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v3 03/10] ASoC: wm8731: Convert to
	snd_soc_cache_sync
Date: Fri, 07 Oct 2011 21:39:09 +0800
Message-ID: <1317994749.9906.7.camel@phoenix>
References: <1317994508.9906.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DA4DB246B6
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 15:39:16 +0200 (CEST)
Received: by yxk8 with SMTP id 8so4229021yxk.38
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 06:39:16 -0700 (PDT)
In-Reply-To: <1317994508.9906.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris@alsa-project.org, Richard Purdie <rpurdie@rpsys.net>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Convert to snd_soc_cache_sync for sync reg_cache with the hardware.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8731.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index f76b6fc..7e5ec03 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -427,9 +427,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
+	int ret;
 	u16 reg;
 
 	switch (level) {
@@ -444,16 +442,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 			if (ret != 0)
 				return ret;
 
-			/* Sync reg_cache with the hardware */
-			for (i = 0; i < ARRAY_SIZE(wm8731_reg); i++) {
-				if (cache[i] == wm8731_reg[i])
-					continue;
-
-				data[0] = (i << 1) | ((cache[i] >> 8)
-						      & 0x0001);
-				data[1] = cache[i] & 0x00ff;
-				codec->hw_write(codec->control_data, data, 2);
-			}
+			snd_soc_cache_sync(codec);
 		}
 
 		/* Clear PWROFF, gate CLKOUT, everything else as-is */
-- 
1.7.4.1
