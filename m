From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: tegra_wm9712: Use card DAPM context
	to access widgets
Date: Fri,  3 Apr 2015 13:04:08 +0200
Message-ID: <1428059048-32315-4-git-send-email-lars@metafoo.de>
References: <1428059048-32315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-122.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D50265862
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2015 13:04:18 +0200 (CEST)
In-Reply-To: <1428059048-32315-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Lucas Stach <dev@lynxeye.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/tegra/tegra_wm9712.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.c
index 2868b48..6492f81 100644
--- a/sound/soc/tegra/tegra_wm9712.c
+++ b/sound/soc/tegra/tegra_wm9712.c
@@ -46,11 +46,7 @@ static const struct snd_soc_dapm_widget tegra_wm9712_dapm_widgets[] = {
 
 static int tegra_wm9712_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	return snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
+	return snd_soc_dapm_force_enable_pin(&rtd->card->dapm, "Mic Bias");
 }
 
 static struct snd_soc_dai_link tegra_wm9712_dai = {
-- 
1.8.0
