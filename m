From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 1/3] ASoC: tlv320aic32x4: Change name of
	probe function
Date: Mon, 18 Apr 2016 17:24:04 -0700
Message-ID: <1461025446-7693-2-git-send-email-nh6z@nh6z.net>
References: <1461025446-7693-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 00127265375
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 02:24:19 +0200 (CEST)
In-Reply-To: <1461025446-7693-1-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The codec's probe function is named aic32x4_probe.  This is going to
conflict with later work to implement SPI support and separate out I2S
into its own file.  In line with other drivers in the tree, this function
is renamed to aic32x4_codec_probe instead.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index f2d3191..9d5b08b 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -596,7 +596,7 @@ static struct snd_soc_dai_driver aic32x4_dai = {
 	.symmetric_rates = 1,
 };
 
-static int aic32x4_probe(struct snd_soc_codec *codec)
+static int aic32x4_codec_probe(struct snd_soc_codec *codec)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 	u32 tmp_reg;
@@ -655,7 +655,7 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
-	.probe = aic32x4_probe,
+	.probe = aic32x4_codec_probe,
 	.set_bias_level = aic32x4_set_bias_level,
 	.suspend_bias_off = true,
 
-- 
2.5.0
