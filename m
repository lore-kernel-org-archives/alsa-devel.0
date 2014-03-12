From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 04/12] ASoC: omap-abe-twl6040: Register
	machine level DMIC DAPM routes with the card
Date: Wed, 12 Mar 2014 15:27:32 +0100
Message-ID: <1394634460-15889-5-git-send-email-lars@metafoo.de>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id D6D9F264F0F
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:14 +0100 (CET)
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

Machine level DAPM widgets and routes should be registered in the card's DAPM
context, rather than in the CODEC's context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1:
	* Only register DMIC DAPM routes with the card, do not join the two routes
	  tables into one.
---
 sound/soc/omap/omap-abe-twl6040.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index ebb1390..024dafc 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -203,8 +203,7 @@ static const struct snd_soc_dapm_route dmic_audio_map[] = {
 
 static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
 
 	return snd_soc_dapm_add_routes(dapm, dmic_audio_map,
 				ARRAY_SIZE(dmic_audio_map));
-- 
1.8.0
