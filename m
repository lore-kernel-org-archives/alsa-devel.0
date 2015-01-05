From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 4/8] ASoC: cs42l56: Constify struct
 regmap_config and snd_soc_codec_driver
Date: Mon, 05 Jan 2015 10:18:24 +0100
Message-ID: <1420449508-10701-4-git-send-email-k.kozlowski@samsung.com>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 70A392608EA
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 10:18:49 +0100 (CET)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NHP00EM661UF760@mailout3.w1.samsung.com> for
 alsa-devel@alsa-project.org; Mon, 05 Jan 2015 09:22:42 +0000 (GMT)
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
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make struct
snd_soc_codec_driver const as well (snd_soc_register_codec() accepts
pointer to const).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Brian Austin <brian.austin@cirrus.com>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs42l56.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 2ddc7ac10ad7..cbc654fe48c7 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1164,7 +1164,7 @@ static int cs42l56_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cs42l56 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs42l56 = {
 	.probe = cs42l56_probe,
 	.remove = cs42l56_remove,
 	.set_bias_level = cs42l56_set_bias_level,
@@ -1179,7 +1179,7 @@ static struct snd_soc_codec_driver soc_codec_dev_cs42l56 = {
 	.num_controls = ARRAY_SIZE(cs42l56_snd_controls),
 };
 
-static struct regmap_config cs42l56_regmap = {
+static const struct regmap_config cs42l56_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-- 
1.9.1
