From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 5/6] ASoC: Harmony: Call snd_soc_dapm_nc_pin
Date: Thu,  3 Feb 2011 13:56:17 -0700
Message-ID: <1296766578-13988-5-git-send-email-swarren@nvidia.com>
References: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 86245103A66
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:56:29 +0100 (CET)
In-Reply-To: <1296766578-13988-1-git-send-email-swarren@nvidia.com>
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

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index 799b1ef..8ed88e3 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -205,6 +205,12 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 
 	gpio_direction_output(pdata->gpio_spkr_en, 0);
 
+	/* Not connected */
+	snd_soc_dapm_nc_pin(dapm, "IN3L");
+	snd_soc_dapm_nc_pin(dapm, "IN3R");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUTL");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUTR");
+
 	ret = snd_soc_add_controls(codec, harmony_controls,
 				   ARRAY_SIZE(harmony_controls));
 	if (ret < 0)
-- 
1.7.1
