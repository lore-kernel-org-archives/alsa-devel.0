From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: fix some pointer error handling"
	to the asoc tree
Date: Fri, 20 Jan 2017 13:37:03 +0000
Message-ID: <E1cUZNH-0000ep-Re@debutante>
References: <20170120130752.29107-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DAB162654AD
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 14:37:18 +0100 (CET)
In-Reply-To: <20170120130752.29107-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: fix some pointer error handling

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 639467c8f26d834c934215e8b59129ce442475fe Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Jan 2017 14:07:52 +0100
Subject: [PATCH] ASoC: dapm: fix some pointer error handling

commit 66feeec9322132689d42723df2537d60f96f8e44
"RFC: ASoC: dapm: handle probe deferrals"
forgot a to update some two sites where the call
was used. The static codechecks quickly found them.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 66feeec93221 ("RFC: ASoC: dapm: handle probe deferrals")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b218cc7bd994..dcef67a9bd48 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3935,6 +3935,16 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 			template.name);
 
 		w = snd_soc_dapm_new_control_unlocked(dapm, &template);
+		if (IS_ERR(w)) {
+			int ret = PTR_ERR(w);
+
+			/* Do not nag about probe deferrals */
+			if (ret != -EPROBE_DEFER)
+				dev_err(dapm->dev,
+				"ASoC: Failed to create %s widget (%d)\n",
+				dai->driver->playback.stream_name, ret);
+			return ret;
+		}
 		if (!w) {
 			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->playback.stream_name);
@@ -3954,6 +3964,16 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 			template.name);
 
 		w = snd_soc_dapm_new_control_unlocked(dapm, &template);
+		if (IS_ERR(w)) {
+			int ret = PTR_ERR(w);
+
+			/* Do not nag about probe deferrals */
+			if (ret != -EPROBE_DEFER)
+				dev_err(dapm->dev,
+				"ASoC: Failed to create %s widget (%d)\n",
+				dai->driver->playback.stream_name, ret);
+			return ret;
+		}
 		if (!w) {
 			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->capture.stream_name);
-- 
2.11.0
