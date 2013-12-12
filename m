From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: wm5102: Use async writes
Date: Thu, 12 Dec 2013 11:07:39 +0000
Message-ID: <1386846461-32325-2-git-send-email-broonie@kernel.org>
References: <1386846461-32325-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 34B512608D0
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 12:07:46 +0100 (CET)
In-Reply-To: <1386846461-32325-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

When writing the patch write to the device asynchronously, allowing better
performance when used with a bus like SPI which supports this by
minimising the need to context switch back to the driver to get the
next bit of data.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm5102.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a08e8bf6d07c..ce9c8e14d4bd 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -601,8 +601,8 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		if (patch)
 			for (i = 0; i < patch_size; i++)
-				regmap_write(regmap, patch[i].reg,
-					     patch[i].def);
+				regmap_write_async(regmap, patch[i].reg,
+						   patch[i].def);
 		break;
 
 	default:
-- 
1.8.5.1
