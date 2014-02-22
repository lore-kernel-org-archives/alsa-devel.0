From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: wm8962: Replace codec->control_data
	with wm8962->regmap
Date: Sat, 22 Feb 2014 18:32:05 +0100
Message-ID: <1393090325-10712-2-git-send-email-lars@metafoo.de>
References: <1393090325-10712-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-131.synserver.de
 [212.40.185.131])
 by alsa0.perex.cz (Postfix) with ESMTP id CF33D261B28
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2014 18:31:47 +0100 (CET)
In-Reply-To: <1393090325-10712-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

With the ongoing component-ization of the ASoC framework and the continuing
migration to using regmap for IO the control_data field of the snd_soc_codec
struct will eventually be removed. Prepare the wm8962 driver for this by using
wm8962->regmap instead of accessing the CODEC's control_data field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8962.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 3be4633..b6086d2 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1479,7 +1479,9 @@ static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 
 static int wm8962_dsp2_write_config(struct snd_soc_codec *codec)
 {
-	return regcache_sync_region(codec->control_data,
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+
+	return regcache_sync_region(wm8962->regmap,
 				    WM8962_HDBASS_AI_1, WM8962_MAX_REGISTER);
 }
 
-- 
1.8.0
