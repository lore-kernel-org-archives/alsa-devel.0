From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Support leaving paths enabled over
	system suspend
Date: Sun,  9 May 2010 13:08:37 +0100
Message-ID: <1273406918-17007-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A06E24591
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 14:08:42 +0200 (CEST)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Some devices can usefully run audio while the Linux system is suspended.
One of the most common examples is smartphone systems, which are normally
designed to allow audio to be run between the baseband and the CODEC
without passing through the CPU and so can suspend the CPU when on a
voice call for additional power savings.

Support such systems by providing an API snd_soc_dapm_ignore_suspend().
This can be used to mark DAPM endpoints as not being sensitive to
system suspend. When the system is being suspended paths between
endpoints which are marked as ignoring suspend will be kept active.
Both source and sink must be marked, and there must already be an
active path between the two endpoints prior to suspend.

When paths are active over suspend the bias management will hold the
device bias in the ON state. This is used to avoid suspending the
CODEC while it is still in use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-core.c     |   32 ++++++++++++++++++++++++++++----
 sound/soc/soc-dapm.c     |   31 ++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 55c6d3d..66ff4c1 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -341,6 +341,7 @@ int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin);
 int snd_soc_dapm_sync(struct snd_soc_codec *codec);
 int snd_soc_dapm_force_enable_pin(struct snd_soc_codec *codec,
 				  const char *pin);
+int snd_soc_dapm_ignore_suspend(struct snd_soc_codec *codec, const char *pin);
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
@@ -428,6 +429,7 @@ struct snd_soc_dapm_widget {
 	unsigned char new:1;			/* cnew complete */
 	unsigned char ext:1;			/* has external widgets */
 	unsigned char force:1;			/* force state */
+	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9573976..8661e5b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -927,8 +927,19 @@ static int soc_suspend(struct device *dev)
 				SND_SOC_DAPM_STREAM_SUSPEND);
 	}
 
-	if (codec_dev->suspend)
-		codec_dev->suspend(pdev, PMSG_SUSPEND);
+	/* If there are paths active then the CODEC will be held with
+	 * bias _ON and should not be suspended. */
+	if (codec_dev->suspend) {
+		switch (codec->bias_level) {
+		case SND_SOC_BIAS_STANDBY:
+		case SND_SOC_BIAS_OFF:
+			codec_dev->suspend(pdev, PMSG_SUSPEND);
+			break;
+		default:
+			dev_dbg(socdev->dev, "CODEC is on over suspend\n");
+			break;
+		}
+	}
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
@@ -975,8 +986,21 @@ static void soc_resume_deferred(struct work_struct *work)
 			cpu_dai->resume(cpu_dai);
 	}
 
-	if (codec_dev->resume)
-		codec_dev->resume(pdev);
+	/* If the CODEC was idle over suspend then it will have been
+	 * left with bias OFF or STANDBY and suspended so we must now
+	 * resume.  Otherwise the suspend was suppressed.
+	 */
+	if (codec_dev->resume) {
+		switch (codec->bias_level) {
+		case SND_SOC_BIAS_STANDBY:
+		case SND_SOC_BIAS_OFF:
+			codec_dev->resume(pdev);
+			break;
+		default:
+			dev_dbg(socdev->dev, "CODEC was on over suspend\n");
+			break;
+		}
+	}
 
 	for (i = 0; i < codec->num_dai; i++) {
 		char *stream = codec->dai[i].playback.stream_name;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8c8b291..fefb6c4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -441,7 +441,9 @@ static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 	switch (snd_power_get_state(codec->card)) {
 	case SNDRV_CTL_POWER_D3hot:
 	case SNDRV_CTL_POWER_D3cold:
-		return 0;
+		if (widget->ignore_suspend)
+			pr_debug("%s ignoring suspend\n", widget->name);
+		return widget->ignore_suspend;
 	default:
 		return 1;
 	}
@@ -2137,6 +2139,33 @@ int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin)
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_status);
 
 /**
+ * snd_soc_dapm_ignore_suspend - ignore suspend status for DAPM endpoint
+ * @codec: audio codec
+ * @pin: audio signal pin endpoint (or start point)
+ *
+ * Mark the given endpoint or pin as ignoring suspend.  When the
+ * system is disabled a path between two endpoints flagged as ignoring
+ * suspend will not be disabled.  The path must already be enabled via
+ * normal means at suspend time, it will not be turned on if it was not
+ * already enabled.
+ */
+int snd_soc_dapm_ignore_suspend(struct snd_soc_codec *codec, const char *pin)
+{
+	struct snd_soc_dapm_widget *w;
+
+	list_for_each_entry(w, &codec->dapm_widgets, list) {
+		if (!strcmp(w->name, pin)) {
+			w->ignore_suspend = 1;
+			return 0;
+		}
+	}
+
+	pr_err("Unknown DAPM pin: %s\n", pin);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
+
+/**
  * snd_soc_dapm_free - free dapm resources
  * @socdev: SoC device
  *
-- 
1.7.0.5
