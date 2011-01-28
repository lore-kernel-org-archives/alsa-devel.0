From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 4/7] ASoC: Tegra: Harmony: Fix indentation
	issue.
Date: Fri, 28 Jan 2011 14:26:38 -0700
Message-ID: <1296250001-6348-4-git-send-email-swarren@nvidia.com>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F1402442E
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 22:27:00 +0100 (CET)
In-Reply-To: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Indent with TABs not spaces.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index 0f5a481..b5311a3 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -104,11 +104,12 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (mclk_change) {
-	    err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk, SND_SOC_CLOCK_IN);
-	    if (err < 0) {
-		    pr_err(PREFIX "codec_dai clock not set\n");
-		    return err;
-	    }
+		err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+					     SND_SOC_CLOCK_IN);
+		if (err < 0) {
+			pr_err(PREFIX "codec_dai clock not set\n");
+			return err;
+		}
 	}
 
 	return 0;
-- 
1.7.1
