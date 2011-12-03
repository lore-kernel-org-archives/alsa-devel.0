From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 17/21] ASoC: Convert WM8728 to table based
	control init
Date: Sat,  3 Dec 2011 21:33:25 +0000
Message-ID: <1322948009-27658-17-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DAE3243E9
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:40 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8728.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 085c2f8..eabf929 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -243,9 +243,6 @@ static int wm8728_probe(struct snd_soc_codec *codec)
 	/* power on device */
 	wm8728_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, wm8728_snd_controls,
-				ARRAY_SIZE(wm8728_snd_controls));
-
 	return ret;
 }
 
@@ -264,6 +261,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
 	.reg_cache_size = ARRAY_SIZE(wm8728_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8728_reg_defaults,
+	.controls = wm8728_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8728_snd_controls),
 	.dapm_widgets = wm8728_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm8728_dapm_widgets),
 	.dapm_routes = wm8728_intercon,
-- 
1.7.7.3
