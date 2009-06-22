From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC CODEC power management on reboot
Date: Mon, 22 Jun 2009 13:18:26 +0100
Message-ID: <20090622121823.GA4495@sirena.org.uk>
References: <20090622111323.GM14476@trinity.fluff.org>
	<20090622113249.GA15884@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CDF0A24400
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 14:18:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090622113249.GA15884@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 22, 2009 at 12:32:50PM +0100, Mark Brown wrote:
> On Mon, Jun 22, 2009 at 12:13:23PM +0100, Ben Dooks wrote:

> > Should the ASoC (possibly DAPM) layer sort out powering down the CODEC
> > before reboot, or should it be down to the codec or the mapping driver
> > to do this?

> Core.

Please try this (completely untested) patch:

>From 506921be0ce5b96c3761c771a9356f2c53bd6628 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 22 Jun 2009 13:16:51 +0100
Subject: [PATCH] ASoC: Add a shutdown callback

Ensure that the audio subsystem is powered down cleanly when the system
shuts down by providing a shutdown operation. This ensures that all the
components have been returned to an off state cleanly which should avoid
audio issues from partially charged capacitors or noise on digital inputs
if the system is restarted quickly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-core.c     |   16 ++++++++++++++++
 sound/soc/soc-dapm.c     |   29 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index ec8a45f..35814ce 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -279,6 +279,7 @@ int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
 	int event);
+void snd_soc_dapm_shutdown(struct snd_soc_device *socdev);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4414117..55d45c4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1020,6 +1020,21 @@ static int soc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void soc_shutdown(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = socdev->card;
+
+	if (!card->instantiated)
+		return;
+
+	/* Flush out pmdown_time work - we actually do want to run it
+	 * now, we're shutting down so no imminent restart. */
+	run_delayed_work(&card->delayed_work);
+
+	snd_soc_dapm_shutdown(socdev);
+}
+
 /* ASoC platform driver */
 static struct platform_driver soc_driver = {
 	.driver		= {
@@ -1030,6 +1045,7 @@ static struct platform_driver soc_driver = {
 	.remove		= soc_remove,
 	.suspend	= soc_suspend,
 	.resume		= soc_resume,
+	.shutdown	= soc_shutdown,
 };
 
 /* create a new pcm */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6534359..b9129ef 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2032,6 +2032,35 @@ void snd_soc_dapm_free(struct snd_soc_device *socdev)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
+/*
+ * snd_soc_dapm_shutdown - callback for system shutdown
+ */
+void snd_soc_dapm_shutdown(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_dapm_widget *w;
+	LIST_HEAD(down_list);
+	int powerdown = 0;
+
+	list_for_each_entry(w, &codec->dapm_widgets, list) {
+		if (w->power) {
+			dapm_seq_insert(w, &down_list, dapm_down_seq);
+			powerdown = 1;
+		}
+	}
+
+	/* If there were no widgets to power down we're already in
+	 * standby.
+	 */
+	if (powerdown) {
+		snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_PREPARE);
+		dapm_seq_run(codec, &down_list, 0, dapm_down_seq);
+		snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_STANDBY);
+	}
+
+	snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_OFF);
+}
+
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood, lrg@slimlogic.co.uk");
 MODULE_DESCRIPTION("Dynamic Audio Power Management core for ALSA SoC");
-- 
1.6.3.1
