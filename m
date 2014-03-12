From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 12/12] ASoC: Remove name_prefix unset during
	DAI link init hack
Date: Wed, 12 Mar 2014 15:27:40 +0100
Message-ID: <1394634460-15889-13-git-send-email-lars@metafoo.de>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 53B3126500B
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:27 +0100 (CET)
In-Reply-To: <1394634460-15889-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Before we had card level support for DAPM and controls machine drivers would
register their controls and DAPM elements with the CODEC. This required us to
temporarily unset the name_prefix of a CODEC during the rtd init callback to
avoid the machine level controls getting the CODEC's prefix. Now that all
machine drivers properly register their machine level controls and DAPM elements
with the card rather than with the CODEC we can drop the hack that sets the
CODEC's name_prefix to NULL while calling the DAI link or AUX dev init callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fe1df50..30d5df0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1246,7 +1246,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link = NULL;
 	struct snd_soc_aux_dev *aux_dev = NULL;
 	struct snd_soc_pcm_runtime *rtd;
-	const char *temp, *name;
+	const char *name;
 	int ret = 0;
 
 	if (!dailess) {
@@ -1260,10 +1260,6 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	}
 	rtd->card = card;
 
-	/* machine controls, routes and widgets are not prefixed */
-	temp = codec->name_prefix;
-	codec->name_prefix = NULL;
-
 	/* do machine specific initialization */
 	if (!dailess && dai_link->init)
 		ret = dai_link->init(rtd);
@@ -1273,7 +1269,6 @@ static int soc_post_component_init(struct snd_soc_card *card,
 		dev_err(card->dev, "ASoC: failed to init %s: %d\n", name, ret);
 		return ret;
 	}
-	codec->name_prefix = temp;
 
 	/* register the rtd device */
 	rtd->codec = codec;
-- 
1.8.0
