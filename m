From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ASoC: dapm: fix some pointer error handling
Date: Fri, 20 Jan 2017 14:07:52 +0100
Message-ID: <20170120130752.29107-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f48.google.com (mail-lf0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D244E265A82
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 14:08:01 +0100 (CET)
Received: by mail-lf0-f48.google.com with SMTP id z134so57854970lff.3
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 05:08:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

commit 66feeec9322132689d42723df2537d60f96f8e44
"RFC: ASoC: dapm: handle probe deferrals"
forgot a to update some two sites where the call
was used. The static codechecks quickly found them.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 66feeec93221 ("RFC: ASoC: dapm: handle probe deferrals")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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
2.9.3
