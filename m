From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: Tegra: Harmony: Remove redundant !!
Date: Mon, 31 Jan 2011 11:00:17 -0700
Message-ID: <1296496817-10128-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BA2A410388C
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 19:00:27 +0100 (CET)
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

gpio_set_value* should accept logic values not just 0 or 1. The WM8903 GPIO
driver has been fixed to work this way, so remove the redundant !!
previously required when it didn't accept values >1.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index d1faa63..11e2cb8 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -132,7 +132,7 @@ static int harmony_event_int_spk(struct snd_soc_dapm_widget *w,
 	struct harmony_audio_platform_data *pdata = harmony->pdata;
 
 	gpio_set_value_cansleep(pdata->gpio_spkr_en,
-				!!SND_SOC_DAPM_EVENT_ON(event));
+				SND_SOC_DAPM_EVENT_ON(event));
 
 	return 0;
 }
-- 
1.7.1
