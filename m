From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Return -ENOTSUPP instead of
	-EINVAL if mute is not supported
Date: Fri, 13 Apr 2012 19:22:25 +0100
Message-ID: <1334341345-19274-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5DD9104501
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 20:22:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This helps us ignore errors in callers if the operation failed due to not
being available as opposed to an error.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1ff0161..b957e68 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3090,7 +3090,7 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
 	if (dai->driver && dai->driver->ops->digital_mute)
 		return dai->driver->ops->digital_mute(dai, mute);
 	else
-		return -EINVAL;
+		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
-- 
1.7.9.1
