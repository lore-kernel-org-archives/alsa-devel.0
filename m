From: Stuart Longland <redhatter@gentoo.org>
Subject: [PATCH] ASoC: Update Freescale i.MX SSI driver
Date: Sat, 22 May 2010 22:01:25 +1000
Message-ID: <20100522120124.GD18017@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6F9B5245FA
	for <alsa-devel@alsa-project.org>;
	Sat, 22 May 2010 14:01:31 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OFnOP-0006xm-VP
	for alsa-devel@alsa-project.org; Sat, 22 May 2010 22:01:26 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OFnOP-0006xe-KU
	for alsa-devel@alsa-project.org; Sat, 22 May 2010 22:01:25 +1000
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,
	Attached is a patch that corrects the i.MX SSI driver so that it
compiles against the latest ASoC tree.  I'm able to compile the driver
with this patch, but haven't done any testing beyond this point... the
update is quite na=EFve, based on changes I had seen to other drivers.

	I hope to give it a try on Monday, but in the meantime, here's
the patch for others to try.
--=20
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-ASoC-Update-Freescale-i.MX-SSI-driver-DMA-parameter-.patch"

>From 138287fab450440726d6497d2d9ffd3645a0469b Mon Sep 17 00:00:00 2001
From: Stuart Longland <redhatter@gentoo.org>
Date: Sat, 22 May 2010 21:10:02 +1000
Subject: [PATCH] ASoC: Update Freescale i.MX SSI driver DMA parameter handling

This updates the i.MX SSI driver to make it compatible with the ASoC tree
following the move of DMA parameters from the DAI to the audio substream
object.

Signed-off-by: Stuart Longland <redhatter@gentoo.org>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 2b31ac6..05f19c9 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -73,7 +73,8 @@ static void snd_imx_dma_err_callback(int channel, void *data, int err)
 {
 	struct snd_pcm_substream *substream = data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params = rtd->dai->cpu_dai->dma_data;
+	struct imx_pcm_dma_params *dma_params = 
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	int ret;
@@ -102,7 +103,7 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	int ret;
 
-	dma_params = snd_soc_get_dma_data(rtd->dai->cpu_dai, substream);
+	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
 	iprtd->dma = imx_dma_request_by_prio(DRV_NAME, DMA_PRIO_HIGH);
 	if (iprtd->dma < 0) {
@@ -212,7 +213,7 @@ static int snd_imx_pcm_prepare(struct snd_pcm_substream *substream)
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	int err;
 
-	dma_params = snd_soc_get_dma_data(rtd->dai->cpu_dai, substream);
+	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
 	iprtd->substream = substream;
 	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
-- 
1.6.4


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--2fHTh5uZTiUOsy+g--
