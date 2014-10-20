From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/12] ASoC: ak4642: Cleanup manual bias level
	transitions
Date: Mon, 20 Oct 2014 10:56:31 +0200
Message-ID: <1413795399-29952-4-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BCF0260644
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:44 +0200 (CEST)
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
 sound/soc/codecs/ak4642.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 0417125..dde8b49 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -491,23 +491,7 @@ static int ak4642_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-
-static int ak4642_probe(struct snd_soc_codec *codec)
-{
-	ak4642_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-static int ak4642_remove(struct snd_soc_codec *codec)
-{
-	ak4642_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
-	.probe			= ak4642_probe,
-	.remove			= ak4642_remove,
 	.resume			= ak4642_resume,
 	.set_bias_level		= ak4642_set_bias_level,
 	.controls		= ak4642_snd_controls,
-- 
1.8.0
