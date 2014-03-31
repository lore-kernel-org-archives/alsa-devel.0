From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: alc5632: fix uninit var in
	alc5632_probe()
Date: Mon, 31 Mar 2014 12:25:24 -0600
Message-ID: <1396290324-6334-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FA89265176
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 20:35:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

alc5632_probe() returns ret, yet it is not initialized or set anywhere.
This ends up causing the function to appear to fail, and audio not to
work on the Toshiba AC100, with my compiler at least.

This function used to set ret in all cases, but recent cleanup removed
that.

Cc: Xiubo Li <Li.Xiubo@freescale.com>
Fixes: 5d6be5aa6bec ("ASoC: codec: Simplify ASoC probe code.")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/alc5632.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index ec071a6306ef..3ee8d4e41a99 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1061,7 +1061,6 @@ static int alc5632_resume(struct snd_soc_codec *codec)
 static int alc5632_probe(struct snd_soc_codec *codec)
 {
 	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
-	int ret;
 
 	/* power on device  */
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -1075,7 +1074,7 @@ static int alc5632_probe(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 /* power down chip */
-- 
1.8.1.5
