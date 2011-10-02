From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Remove unused srate variable in
 tegra_spdif_hw_params
Date: Sun, 02 Oct 2011 21:07:02 +0800
Message-ID: <1317560822.21926.4.camel@phoenix>
References: <1317560756.21926.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 87FC1244F4
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 15:07:09 +0200 (CEST)
Received: by pzd13 with SMTP id 13so9360735pzd.2
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 06:07:08 -0700 (PDT)
In-Reply-To: <1317560756.21926.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/tegra/tegra_spdif.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_spdif.c b/sound/soc/tegra/tegra_spdif.c
index 1bd07d1..dd11d0c 100644
--- a/sound/soc/tegra/tegra_spdif.c
+++ b/sound/soc/tegra/tegra_spdif.c
@@ -127,7 +127,7 @@ static int tegra_spdif_hw_params(struct snd_pcm_substream *substream,
 {
 	struct device *dev = substream->pcm->card->dev;
 	struct tegra_spdif *spdif = snd_soc_dai_get_drvdata(dai);
-	int ret, srate, spdifclock;
+	int ret, spdifclock;
 
 	spdif->reg_ctrl &= ~TEGRA_SPDIF_CTRL_PACK;
 	spdif->reg_ctrl &= ~TEGRA_SPDIF_CTRL_BIT_MODE_MASK;
@@ -140,7 +140,6 @@ static int tegra_spdif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	srate = params_rate(params);
 	switch (params_rate(params)) {
 	case 32000:
 		spdifclock = 4096000;
-- 
1.7.4.1
