From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 5/8] ASoC: cs42l73: Constify struct
 regmap_config and snd_soc_codec_driver
Date: Mon, 05 Jan 2015 10:18:25 +0100
Message-ID: <1420449508-10701-5-git-send-email-k.kozlowski@samsung.com>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F36B260A5B
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 10:18:49 +0100 (CET)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NHP0059E61YQS80@mailout1.w1.samsung.com> for
 alsa-devel@alsa-project.org; Mon, 05 Jan 2015 09:22:46 +0000 (GMT)
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
 sound/soc/codecs/cs42l73.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 7c55537c69cf..8ecedba79606 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1347,7 +1347,7 @@ static int cs42l73_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cs42l73 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs42l73 = {
 	.probe = cs42l73_probe,
 	.set_bias_level = cs42l73_set_bias_level,
 	.suspend_bias_off = true,
@@ -1361,7 +1361,7 @@ static struct snd_soc_codec_driver soc_codec_dev_cs42l73 = {
 	.num_controls = ARRAY_SIZE(cs42l73_snd_controls),
 };
 
-static struct regmap_config cs42l73_regmap = {
+static const struct regmap_config cs42l73_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-- 
1.9.1
