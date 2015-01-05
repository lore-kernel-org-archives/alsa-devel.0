From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/8] ASoC: alc5632: Constify struct
 regmap_config and snd_soc_codec_driver
Date: Mon, 05 Jan 2015 10:18:21 +0100
Message-ID: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB22260561
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 10:18:48 +0100 (CET)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NHP00KC561T8U40@mailout2.w1.samsung.com> for
 alsa-devel@alsa-project.org; Mon, 05 Jan 2015 09:22:41 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make struct
snd_soc_codec_driver const as well (snd_soc_register_codec() accepts
pointer to const).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 sound/soc/codecs/alc5632.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index d1fdbc266631..07630260e1ba 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1066,7 +1066,7 @@ static int alc5632_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_device_alc5632 = {
+static const struct snd_soc_codec_driver soc_codec_device_alc5632 = {
 	.probe = alc5632_probe,
 	.resume = alc5632_resume,
 	.set_bias_level = alc5632_set_bias_level,
@@ -1080,7 +1080,7 @@ static struct snd_soc_codec_driver soc_codec_device_alc5632 = {
 	.num_dapm_routes = ARRAY_SIZE(alc5632_dapm_routes),
 };
 
-static struct regmap_config alc5632_regmap = {
+static const struct regmap_config alc5632_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
 
-- 
1.9.1
