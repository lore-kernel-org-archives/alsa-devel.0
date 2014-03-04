From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: 88pm860: Fix IO setup
Date: Tue,  4 Mar 2014 09:39:24 +0100
Message-ID: <1393922364-31624-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C28F26571D
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 09:39:09 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

The 88pm860 is a MFD device and the CODEC driver is using the regmap struct of
the parent device, hence automatic IO setup will not work and we need to
manually call snd_soc_codec_set_cache_io(). The issue was introduced in commit
f9ded3b2e7 ("ASoC: 88pm860x: Use regmap for I/O").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/88pm860x-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 697d24b..8703244 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1328,6 +1328,9 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 	pm860x->codec = codec;
 
 	codec->control_data = pm860x->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < 4; i++) {
 		ret = request_threaded_irq(pm860x->irq[i], NULL,
-- 
1.8.0
