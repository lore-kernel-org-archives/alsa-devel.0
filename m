From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: tegra: Fix unused variable warning
Date: Wed, 23 Aug 2017 08:03:43 +0200
Message-ID: <20170823060343.25275-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BBA52266834
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 08:03:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fixes: 2a8bd83af30e ("ASoC: tegra: Remove superfluous snd_soc_jack_free_gpios() call")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/tegra/tegra_wm8903.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index ce498cc0914b..05f95944669a 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -203,7 +203,6 @@ static int tegra_wm8903_remove(struct snd_soc_card *card)
 		snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
 
 	wm8903_mic_detect(codec, NULL, 0, 0);
 
-- 
2.14.0
