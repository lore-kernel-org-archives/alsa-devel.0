From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2] ASoC: Add pinctrl PM to components of
	active DAIs
Date: Tue, 29 Oct 2013 11:12:54 +0800
Message-ID: <1383016374-30919-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46A4A2652BE
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 04:12:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's quite popular that more drivers are using pinctrl PM, for example:
(Documentation/devicetree/bindings/arm/primecell.txt). Just like what
runtime PM does, it would de-active and en-active pin group depending
on whether it's being used or not.

And this pinctrl PM might be also beneficial to cpu dai drivers because
they might have actual pinctrl so as to sleep their pins and wake them
up as needed.

To achieve this goal, this patch sets pins to the default state during
resume or startup; While during suspend and shutdown, it would set pins
to the sleep state.

As pinctrl PM would return zero if there is no such pinctrl sleep state
settings, this patch would not break current ASoC subsystem directly.

[ However, there is still an exception that the patch can not handle,
that is, when cpu dai driver does not have pinctrl property but another
device has it. (The AUDMUX <-> SSI on Freescale i.MX6 series for example.
SSI as a cpu dai doesn't contain pinctrl property while AUDMUX, an Audio
Multiplexer, has it). In this case, this kind of cpu dai driver needs to
find a way to obtain the pinctrl property as its own, by moving property
from AUDMUX to SSI, or creating a pins link/dependency between these two
devices, or using a more decent way after we figure it out. ]

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
Changelog
v1->v2:
 * Use proper verbs in comments.
 * Add 'dai->active' condition for resume case.

---
 sound/soc/soc-core.c | 29 +++++++++++++++++++++++++++++
 sound/soc/soc-pcm.c  |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4280c70..5c972ac 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -684,6 +684,13 @@ int snd_soc_suspend(struct device *dev)
 	if (card->suspend_post)
 		card->suspend_post(card);
 
+	/* deactivate pins to sleep state */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_suspend);
@@ -807,6 +814,14 @@ int snd_soc_resume(struct device *dev)
 	if (list_empty(&card->codec_dev_list))
 		return 0;
 
+	/* activate pins from sleep state */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		if (cpu_dai->active)
+			pinctrl_pm_select_default_state(cpu_dai->dev);
+	}
+
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
 	 * problem and may take a substantial amount of time to resume
@@ -1929,6 +1944,13 @@ int snd_soc_poweroff(struct device *dev)
 
 	snd_soc_dapm_shutdown(card);
 
+	/* deactivate pins to sleep state */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_poweroff);
@@ -3766,6 +3788,13 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (ret != 0)
 		soc_cleanup_card_debugfs(card);
 
+	/* deactivate pins to sleep state */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_card);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 330c9a6..05bdba0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -183,6 +183,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_dai_driver *codec_dai_drv = codec_dai->driver;
 	int ret = 0;
 
+	pinctrl_pm_select_default_state(cpu_dai->dev);
 	pm_runtime_get_sync(cpu_dai->dev);
 	pm_runtime_get_sync(codec_dai->dev);
 	pm_runtime_get_sync(platform->dev);
@@ -317,6 +318,7 @@ out:
 	pm_runtime_put(platform->dev);
 	pm_runtime_put(codec_dai->dev);
 	pm_runtime_put(cpu_dai->dev);
+	pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
 	return ret;
 }
@@ -426,6 +428,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	pm_runtime_put(platform->dev);
 	pm_runtime_put(codec_dai->dev);
 	pm_runtime_put(cpu_dai->dev);
+	pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
 	return 0;
 }
-- 
1.8.4
