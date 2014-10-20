From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/12] ASoC: sta529: Cleanup manual bias level
	transitions
Date: Mon, 20 Oct 2014 10:56:38 +0200
Message-ID: <1413795399-29952-11-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 58EFD26056C
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:50 +0200 (CEST)
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

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sta529.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 89c748d..b0f436d 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -319,41 +319,10 @@ static struct snd_soc_dai_driver sta529_dai = {
 	.ops	= &sta529_dai_ops,
 };
 
-static int sta529_probe(struct snd_soc_codec *codec)
-{
-	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-/* power down chip */
-static int sta529_remove(struct snd_soc_codec *codec)
-{
-	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int sta529_suspend(struct snd_soc_codec *codec)
-{
-	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int sta529_resume(struct snd_soc_codec *codec)
-{
-	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
 static const struct snd_soc_codec_driver sta529_codec_driver = {
-	.probe = sta529_probe,
-	.remove = sta529_remove,
 	.set_bias_level = sta529_set_bias_level,
-	.suspend = sta529_suspend,
-	.resume = sta529_resume,
+	.suspend_bias_off = true,
+
 	.controls = sta529_snd_controls,
 	.num_controls = ARRAY_SIZE(sta529_snd_controls),
 };
-- 
1.8.0
