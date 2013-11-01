From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v3] ASoC: Add pinctrl PM to components of
	active DAIs
Date: Fri, 1 Nov 2013 20:16:15 +0800
Message-ID: <1383308175-5053-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 9613526504F
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 13:16:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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
Changelog:
v3:
 * Add pinctrl_pm() for codec_dai/codec
 * Add more proper active check for each pinctrl_pm_select_xx()
v2:
 * Add cpu_dai->active check

 sound/soc/soc-core.c | 33 +++++++++++++++++++++++++++++++++
 sound/soc/soc-pcm.c  | 10 ++++++++++
 2 files changed, 43 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bdc1d74..4e53d87 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -662,6 +662,8 @@ int snd_soc_suspend(struct device *dev)
 				codec->cache_sync = 1;
 				if (codec->using_regmap)
 					regcache_mark_dirty(codec->control_data);
+				/* deactivate pins to sleep state */
+				pinctrl_pm_select_sleep_state(codec->dev);
 				break;
 			default:
 				dev_dbg(codec->dev,
@@ -679,6 +681,9 @@ int snd_soc_suspend(struct device *dev)
 
 		if (cpu_dai->driver->suspend && cpu_dai->driver->ac97_control)
 			cpu_dai->driver->suspend(cpu_dai);
+
+		/* deactivate pins to sleep state */
+		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 	}
 
 	if (card->suspend_post)
@@ -807,6 +812,16 @@ int snd_soc_resume(struct device *dev)
 	if (list_empty(&card->codec_dev_list))
 		return 0;
 
+	/* activate pins from sleep state */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
+		if (cpu_dai->active)
+			pinctrl_pm_select_default_state(cpu_dai->dev);
+		if (codec_dai->active)
+			pinctrl_pm_select_default_state(codec_dai->dev);
+	}
+
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
 	 * problem and may take a substantial amount of time to resume
@@ -1929,6 +1944,14 @@ int snd_soc_poweroff(struct device *dev)
 
 	snd_soc_dapm_shutdown(card);
 
+	/* deactivate pins to sleep state */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
+		pinctrl_pm_select_sleep_state(codec_dai->dev);
+		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_poweroff);
@@ -3767,6 +3790,16 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (ret != 0)
 		soc_cleanup_card_debugfs(card);
 
+	/* deactivate pins to sleep state */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
+		if (!codec_dai->active)
+			pinctrl_pm_select_sleep_state(codec_dai->dev);
+		if (!cpu_dai->active)
+			pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_card);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d81b792..1f0aeea 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -183,6 +183,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_dai_driver *codec_dai_drv = codec_dai->driver;
 	int ret = 0;
 
+	pinctrl_pm_select_default_state(cpu_dai->dev);
+	pinctrl_pm_select_default_state(codec_dai->dev);
 	pm_runtime_get_sync(cpu_dai->dev);
 	pm_runtime_get_sync(codec_dai->dev);
 	pm_runtime_get_sync(platform->dev);
@@ -317,6 +319,10 @@ out:
 	pm_runtime_put(platform->dev);
 	pm_runtime_put(codec_dai->dev);
 	pm_runtime_put(cpu_dai->dev);
+	if (!codec_dai->active)
+		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	if (!cpu_dai->active)
+		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
 	return ret;
 }
@@ -426,6 +432,10 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	pm_runtime_put(platform->dev);
 	pm_runtime_put(codec_dai->dev);
 	pm_runtime_put(cpu_dai->dev);
+	if (!codec_dai->active)
+		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	if (!cpu_dai->active)
+		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
 	return 0;
 }
-- 
1.8.4
