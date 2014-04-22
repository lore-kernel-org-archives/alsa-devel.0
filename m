From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: qi_lb60: Set .dai_fmt instead of
	calling snd_soc_set_dai_fmt()
Date: Tue, 22 Apr 2014 22:46:33 +0200
Message-ID: <1398199596-23649-3-git-send-email-lars@metafoo.de>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-072.synserver.de (smtp-out-121.synserver.de
 [212.40.185.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B47B265010
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 22:46:48 +0200 (CEST)
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Rather than calling snd_soc_set_dai_fmt(), just set the dai_fmt field in the
dai_link struct. Both have the same effect, but the later is a bit shorter and
also allows us to remove the now unused init callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 8dd3568..72ce103 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -46,26 +46,6 @@ static const struct snd_soc_dapm_route qi_lb60_routes[] = {
 	{"Speaker", NULL, "ROUT"},
 };
 
-#define QI_LB60_DAIFMT (SND_SOC_DAIFMT_I2S | \
-			SND_SOC_DAIFMT_NB_NF | \
-			SND_SOC_DAIFMT_CBM_CFM)
-
-static int qi_lb60_codec_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	ret = snd_soc_dai_set_fmt(cpu_dai, QI_LB60_DAIFMT);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cpu dai format: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static struct snd_soc_dai_link qi_lb60_dai = {
 	.name = "jz4740",
 	.stream_name = "jz4740",
@@ -73,7 +53,8 @@ static struct snd_soc_dai_link qi_lb60_dai = {
 	.platform_name = "jz4740-i2s",
 	.codec_dai_name = "jz4740-hifi",
 	.codec_name = "jz4740-codec",
-	.init = qi_lb60_codec_init,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM,
 };
 
 static struct snd_soc_card qi_lb60 = {
-- 
1.8.0
