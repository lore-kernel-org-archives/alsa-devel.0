From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/6] ASoC: dapm: Fix potential NULL pointer
	dereference
Date: Wed, 21 Nov 2012 14:36:59 +0530
Message-ID: <1353488819-13902-6-git-send-email-sachin.kamat@linaro.org>
References: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C596F265CC3
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:13:30 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so2642606pbb.38
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 01:13:30 -0800 (PST)
In-Reply-To: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, sachin.kamat@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

'w' should not be dereferenced when it is NULL.

Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Build tested and based on linux-next 20121115.
---
 sound/soc/soc-dapm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6e35bca..5bde5d4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3326,9 +3326,9 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 		if (!w) {
 			dev_err(dapm->dev, "Failed to create %s widget\n",
 				dai->driver->playback.stream_name);
+		} else {
+			w->priv = dai;
 		}
-
-		w->priv = dai;
 		dai->playback_widget = w;
 	}
 
@@ -3344,9 +3344,9 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 		if (!w) {
 			dev_err(dapm->dev, "Failed to create %s widget\n",
 				dai->driver->capture.stream_name);
+		} else {
+			w->priv = dai;
 		}
-
-		w->priv = dai;
 		dai->capture_widget = w;
 	}
 
-- 
1.7.4.1
