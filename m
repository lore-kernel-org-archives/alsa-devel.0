From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: da732x: Remove unnecessary
	idle_bias_off initialization
Date: Tue,  9 Sep 2014 20:42:43 +0200
Message-ID: <1410288165-32127-4-git-send-email-lars@metafoo.de>
References: <1410288165-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 711AA265338
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 20:42:47 +0200 (CEST)
In-Reply-To: <1410288165-32127-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

idle_bias_off is false by default, no need to set it explicitly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/da732x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 2fae31c..edcbfea 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1511,12 +1511,9 @@ static int da732x_set_bias_level(struct snd_soc_codec *codec,
 static int da732x_probe(struct snd_soc_codec *codec)
 {
 	struct da732x_priv *da732x = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	da732x->codec = codec;
 
-	dapm->idle_bias_off = false;
-
 	da732x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
-- 
1.8.0
