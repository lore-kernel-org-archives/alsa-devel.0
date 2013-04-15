From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/17] ASoC: dmaengine-pcm: Add support for
	platforms which can't report residue
Date: Mon, 15 Apr 2013 19:19:55 +0200
Message-ID: <1366046404-8759-9-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FF8F265250
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:19 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Unfortunately there are still quite a few platforms with a dmaengine driver
which do not support reporting the number of bytes left to transfer. If we want
to support these platforms in the generic dmaengine PCM driver we have.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h         |  5 +++++
 sound/soc/soc-generic-dmaengine-pcm.c | 23 ++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 1a7897a..e705286 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -86,6 +86,11 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  * makes sense if SND_DMAENGINE_PCM_FLAG_COMPAT is set as well.
  */
 #define SND_DMAENGINE_PCM_FLAG_NO_DT BIT(1)
+/*
+ * The platforms dmaengine driver does not support reporting the ammount of
+ * bytes that are still left to transfer.
+ */
+#define SND_DMAENGINE_PCM_FLAG_NO_RESIDUE BIT(2)
 
 /**
  * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index d6e6380..ae0c37e 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -193,6 +193,23 @@ static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 };
 
+static const struct snd_pcm_ops dmaengine_no_residue_pcm_ops = {
+	.open		= dmaengine_pcm_open,
+	.close		= snd_dmaengine_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= snd_pcm_lib_free_pages,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
+};
+
+static const struct snd_soc_platform_driver dmaengine_no_residue_pcm_platform = {
+	.ops		= &dmaengine_no_residue_pcm_ops,
+	.pcm_new	= dmaengine_pcm_new,
+	.pcm_free	= dmaengine_pcm_free,
+	.probe_order	= SND_SOC_COMP_ORDER_LATE,
+};
+
 static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
@@ -226,7 +243,11 @@ int snd_dmaengine_pcm_register(struct device *dev,
 		}
 	}
 
-	return snd_soc_add_platform(dev, &pcm->platform,
+	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
+		return snd_soc_add_platform(dev, &pcm->platform,
+				&dmaengine_no_residue_pcm_platform);
+	else
+		return snd_soc_add_platform(dev, &pcm->platform,
 				&dmaengine_pcm_platform);
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
-- 
1.8.0
