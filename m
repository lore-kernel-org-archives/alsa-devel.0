From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: tegra: Remove unused variable
Date: Tue,  6 Mar 2012 12:13:07 -0700
Message-ID: <1331061187-25893-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D718243BF
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 20:13:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@wwwdotorg.org>

Fixes the following warning:

sound/soc/tegra/tegra_alc5632.c: In function 'tegra_alc5632_asoc_init':
sound/soc/tegra/tegra_alc5632.c:118:6: warning: unused variable 'ret' [-Wunused-variable]

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 sound/soc/tegra/tegra_alc5632.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 2a27725..e45ccd8 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -115,7 +115,6 @@ static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct device_node *np = codec->card->dev->of_node;
 	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(codec->card);
-	int ret;
 
 	snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
 			 &tegra_alc5632_hs_jack);
-- 
1.7.0.4
