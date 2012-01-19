From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Don't tell applications about msbits
	unless we're ignoring input
Date: Thu, 19 Jan 2012 18:04:50 +0000
Message-ID: <1326996290-15956-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39DD42436F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:04:54 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On the off chance that an application both pays attention and gets
confused.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 77c40ee..9f6e55b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -85,9 +85,11 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
-		ret = snd_pcm_hw_constraint_msbits(substream->runtime,
-						   0, sample_sizes[i],
-						   bits);
+		if (bits >= sample_sizes)
+			continue;
+
+		ret = snd_pcm_hw_constraint_msbits(substream->runtime, 0,
+						   sample_sizes[i], bits);
 		if (ret != 0)
 			dev_warn(dai->dev,
 				 "Failed to set MSB %d/%d: %d\n",
-- 
1.7.7.3
