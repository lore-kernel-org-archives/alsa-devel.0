From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v3 04/15] ASoC: dmaengine-pcm: Fix pcm_request_chan function
 name
Date: Sun, 14 Apr 2013 13:42:48 +0200
Message-ID: <1365939779-4507-5-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1365939779-4507-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Markus Pargmann <mpa-rffoE+Jg25C1LGEWPFfZhQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Pargmann <mpa-rffoE+Jg25C1LGEWPFfZhQ@public.gmane.org>

dmaengine_pcm.c implements snd_dmaengine_pcm_request_channel. This
function fixes all function calls to the shorter
snd_dmaengine_pcm_request_chan.

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 include/sound/dmaengine_pcm.h         | 2 +-
 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 sound/soc/spear/spear_pcm.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b346098..b7dbec0 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -47,7 +47,7 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
 int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream);
 
-struct dma_chan *snd_dmaengine_pcm_request_chan(dma_filter_fn filter_fn,
+struct dma_chan *snd_dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
 	void *filter_data);
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index f752577..9480087 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -117,7 +117,7 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	if (pcm->config->compat_request_channel)
 	    return pcm->config->compat_request_channel(rtd, substream);
 
-	return snd_dmaengine_pcm_request_chan(pcm->config->compat_filter_fn,
+	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
 }
 
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index a8222ae..10fc7c9 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -38,7 +38,7 @@ static struct dma_chan *spear_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	return snd_dmaengine_pcm_request_chan(dma_data->filter, dma_data);
+	return snd_dmaengine_pcm_request_channel(dma_data->filter, dma_data);
 }
 
 static const struct snd_dmaengine_pcm_config spear_dmaengine_pcm_config = {
-- 
1.8.1.5
