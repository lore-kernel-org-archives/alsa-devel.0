From: naveenkrishna.ch <naveenkrishna.ch@gmail.com>
Subject: patch 1/1: ASoC, DMA crash with application- resolved
Date: Sun, 21 Dec 2008 12:52:43 +0530
Message-ID: <ef0d8a250812202322i3fe62ed2n2d1e09ab830e27dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 226CA1037E3
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 08:22:44 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so556007ywk.2
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 23:22:44 -0800 (PST)
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
To: alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Hi ALSA SOC,

I am using a OMAP3 + TWL4030 combination with ASoC

in the sound/soc/omap/omap-pcm.c
DMA channels are being freed after unlinking in the omap_pcm_hw_free
function

Which is causing a crash during applications
So, stopping the DMA channels before unlinking resolves the issue.

here is the patch that solves the issue

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index e9084fd..679e384 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -116,6 +116,7 @@ static int omap_pcm_hw_free(struct snd_pcm_substream
*substream)
        if (prtd->dma_data == NULL)
                return 0;

+       omap_stop_dma(prtd->dma_ch);
        if (!cpu_is_omap1510())
                omap_dma_unlink_lch(prtd->dma_ch, prtd->dma_ch);
        omap_free_dma(prtd->dma_ch);


Is this ok or is there any better way out
-- 
Thanks,

(: Naveen Krishna Ch :)
