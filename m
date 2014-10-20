From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/12] ASoC: ak4671: Cleanup manual bias level
	transitions
Date: Mon, 20 Oct 2014 10:56:32 +0200
Message-ID: <1413795399-29952-5-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AF682606DA
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:45 +0200 (CEST)
In-Reply-To: <1413795399-29952-1-git-send-email-lars@metafoo.de>
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
Cc: Johannes Stezenbach <js@sig21.net>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Sven Brandau <brandau@gmx.de>, alsa-devel@alsa-project.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>
List-Id: alsa-devel@alsa-project.org

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ak4671.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 998fa0c..686cacb 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -611,20 +611,7 @@ static struct snd_soc_dai_driver ak4671_dai = {
 	.ops = &ak4671_dai_ops,
 };
 
-static int ak4671_probe(struct snd_soc_codec *codec)
-{
-	return ak4671_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-}
-
-static int ak4671_remove(struct snd_soc_codec *codec)
-{
-	ak4671_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
-	.probe = ak4671_probe,
-	.remove = ak4671_remove,
 	.set_bias_level = ak4671_set_bias_level,
 	.controls = ak4671_snd_controls,
 	.num_controls = ARRAY_SIZE(ak4671_snd_controls),
-- 
1.8.0
