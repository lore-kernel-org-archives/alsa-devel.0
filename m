From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: byt-rt5640: Register microphone
	routes with the card DAPM context
Date: Thu,  1 Jan 2015 11:23:45 +0100
Message-ID: <1420107825-28506-2-git-send-email-lars@metafoo.de>
References: <1420107825-28506-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id D1FF826049E
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 11:23:48 +0100 (CET)
In-Reply-To: <1420107825-28506-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Board level DAPM elements should be registered with the card's DAPM context
rather than the CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/byt-rt5640.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index a51856e..354eaad 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -132,7 +132,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
 	struct snd_soc_codec *codec = runtime->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_card *card = runtime->card;
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
@@ -161,7 +160,7 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic1_map);
 	}
 
-	ret = snd_soc_dapm_add_routes(dapm, custom_map, num_routes);
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
 	if (ret)
 		return ret;
 
-- 
1.8.0
