From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: omap3pandora: Use card DAPM context
	to access widgets
Date: Mon,  6 Jul 2015 15:38:08 +0200
Message-ID: <1436189891-15343-3-git-send-email-lars@metafoo.de>
References: <1436189891-15343-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 855ED260631
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:38:21 +0200 (CEST)
In-Reply-To: <1436189891-15343-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Yang A Fang <yang.a.fang@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Kevin Cernekee <cernekee@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap3pandora.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 076bec6..732e749 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -154,8 +154,7 @@ static const struct snd_soc_dapm_route omap3pandora_map[] = {
 
 static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
 
 	/* All TWL4030 output pins are floating */
 	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
@@ -174,8 +173,7 @@ static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 
 static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
 
 	/* Not comnnected */
 	snd_soc_dapm_nc_pin(dapm, "HSMIC");
-- 
2.1.4
