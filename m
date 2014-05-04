From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Make soc_find_matching_codec() static
Date: Sun,  4 May 2014 19:18:30 +0200
Message-ID: <1399223910-28710-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 02F6B261A66
 for <alsa-devel@alsa-project.org>; Sun,  4 May 2014 19:18:31 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>
List-Id: alsa-devel@alsa-project.org

The function is only used locally, make it static.

Fixes the following warning from sparse:
	sound/soc/soc-core.c:1644:22: warning: symbol 'soc_find_matching_codec' was not declared. Should it be static?

Fixes: 3ca041ed ("ASoC: dt: Allow Aux Codecs to be specified using DT")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ff2b32f..e14bc6c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1641,7 +1641,8 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
-struct snd_soc_codec *soc_find_matching_codec(struct snd_soc_card *card, int num)
+static struct snd_soc_codec *soc_find_matching_codec(struct snd_soc_card *card,
+	int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_codec *codec;
-- 
1.8.0
