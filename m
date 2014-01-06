From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/6] ASoC: generic-dmaengine-pcm: Check
	NO_RESIDUE flag at runtime
Date: Mon,  6 Jan 2014 11:45:59 +0100
Message-ID: <1389005162-5223-4-git-send-email-lars@metafoo.de>
References: <1389005162-5223-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-023.synserver.de
 [212.40.185.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 502F52616FA
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 11:45:50 +0100 (CET)
In-Reply-To: <1389005162-5223-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently we have two different snd_soc_platform_driver structs in the generic
dmaengine PCM driver. One for dmaengine drivers that support residue reporting
and one for those which do not. When registering the PCM component we check
whether the NO_RESIDUE flag is set or not and use the corresponding
snd_soc_platform_driver. This patch modifies the driver to only have one
snd_soc_platform_driver struct where the pointer() callback checks the
NO_RESIDUE flag at runtime. This allows us to set the NO_RESIDUE flag after the
PCM component has been registered. This becomes necessary when querying whether
the dmaengine driver supports residue reporting from the dmaengine driver itself
since the DMA channel might only be requested after the PCM component has been
registered.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
New in v2
---
 sound/soc/soc-generic-dmaengine-pcm.c | 39 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 2a6c569..4e2bed8 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -248,6 +248,18 @@ err_free:
 	return ret;
 }
 
+static snd_pcm_uframes_t dmaengine_pcm_pointer(
+	struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+
+	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
+		return snd_dmaengine_pcm_pointer_no_residue(substream);
+	else
+		return snd_dmaengine_pcm_pointer(substream);
+}
+
 static const struct snd_pcm_ops dmaengine_pcm_ops = {
 	.open		= dmaengine_pcm_open,
 	.close		= snd_dmaengine_pcm_close,
@@ -255,7 +267,7 @@ static const struct snd_pcm_ops dmaengine_pcm_ops = {
 	.hw_params	= dmaengine_pcm_hw_params,
 	.hw_free	= snd_pcm_lib_free_pages,
 	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer,
+	.pointer	= dmaengine_pcm_pointer,
 };
 
 static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
@@ -265,23 +277,6 @@ static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 };
 
-static const struct snd_pcm_ops dmaengine_no_residue_pcm_ops = {
-	.open		= dmaengine_pcm_open,
-	.close		= snd_dmaengine_pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= dmaengine_pcm_hw_params,
-	.hw_free	= snd_pcm_lib_free_pages,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
-};
-
-static const struct snd_soc_platform_driver dmaengine_no_residue_pcm_platform = {
-	.ops		= &dmaengine_no_residue_pcm_ops,
-	.pcm_new	= dmaengine_pcm_new,
-	.pcm_free	= dmaengine_pcm_free,
-	.probe_order	= SND_SOC_COMP_ORDER_LATE,
-};
-
 static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
@@ -374,12 +369,8 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (ret)
 		goto err_free_dma;
 
-	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
-		ret = snd_soc_add_platform(dev, &pcm->platform,
-				&dmaengine_no_residue_pcm_platform);
-	else
-		ret = snd_soc_add_platform(dev, &pcm->platform,
-				&dmaengine_pcm_platform);
+	ret = snd_soc_add_platform(dev, &pcm->platform,
+		&dmaengine_pcm_platform);
 	if (ret)
 		goto err_free_dma;
 
-- 
1.8.0
