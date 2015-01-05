From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 7/8] ASoC: wm8988: Constify struct
 regmap_config and snd_soc_codec_driver
Date: Mon, 05 Jan 2015 10:18:27 +0100
Message-ID: <1420449508-10701-7-git-send-email-k.kozlowski@samsung.com>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C4FD2608CF
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 10:18:48 +0100 (CET)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NHP00GQT61T5M60@mailout4.w1.samsung.com> for
 alsa-devel@alsa-project.org; Mon, 05 Jan 2015 09:22:41 +0000 (GMT)
In-reply-to: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
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
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make struct
snd_soc_codec_driver const as well (snd_soc_register_codec() accepts
pointer to const).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: patches@opensource.wolfsonmicro.com
---
 sound/soc/codecs/wm8988.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index e418199155a8..d320c5251856 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -813,7 +813,7 @@ static int wm8988_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
 	.probe =	wm8988_probe,
 	.set_bias_level = wm8988_set_bias_level,
 	.suspend_bias_off = true,
@@ -826,7 +826,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8988_dapm_routes),
 };
 
-static struct regmap_config wm8988_regmap = {
+static const struct regmap_config wm8988_regmap = {
 	.reg_bits = 7,
 	.val_bits = 9,
 
-- 
1.9.1
