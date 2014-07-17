From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Remove unused 'r' variable from
	dapm_connect_dai_link_widgets()
Date: Thu, 17 Jul 2014 09:15:34 +0200
Message-ID: <1405581334-18158-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 47584265521
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 09:15:31 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

It was accidentally added in commit 44ba2641 ("ASoC: dapm: Add support for DAI
multicodec").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9a047f3..8cb68a38 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3399,11 +3399,8 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dapm_widget *sink, *source;
-	struct snd_soc_dapm_route r;
 	int i;
 
-	memset(&r, 0, sizeof(r));
-
 	for (i = 0; i < rtd->num_codecs; i++) {
 		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 
-- 
1.8.0
