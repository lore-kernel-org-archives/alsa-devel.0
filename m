From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: set idle_bias_off=1 for all platform
	DAPM contexts
Date: Thu,  5 Apr 2012 12:28:01 -0600
Message-ID: <1333650481-19469-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9915710402A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 20:28:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

The ASoC core currently defaults to using STANDBY rather than OFF for
idle ASoC platform devices, which causes a permanent pm_runtime_get() on
them. This keeps the device active unnecessarily. This can be especially
problematic when the ASoC platform device and DAI device are the same
device.

The distinction between OFF and STANDBY is likely not relevant for ASoC
platform drivers, since they aren't analog devices. So, solve this issue
by hard-coding idle_bias_off = 1 for all ASoC platform devices. If this
turns out to be a problem, this value could be sourced from the
snd_soc_platform_driver, similarly to soc_probe_codec().

Note: Prior to this change, this caused a large (10) runtime_active count
for the Tegra I2S controller even when not in use, and a leak in that
value as streams were started and stopped. This change probably hides a
bug.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8a17048..63e6114 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1072,6 +1072,8 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
 	}
 
+	platform->dapm.idle_bias_off = 1;
+
 	if (driver->probe) {
 		ret = driver->probe(platform);
 		if (ret < 0) {
-- 
1.7.0.4
