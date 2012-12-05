From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] ALSA: ASoC: McASP: remove unused variables
Date: Wed,  5 Dec 2012 16:37:40 +0100
Message-ID: <1354721862-10318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id DE4A02650D4
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 16:37:54 +0100 (CET)
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
Cc: khilman@ti.com, mporter@ti.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, vaibhav.bedia@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

codec_fmt and sample_rate variables are unused in both snd_platform_data
and davinci_audio_dev, so drop them.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 include/linux/platform_data/davinci_asp.h | 1 -
 sound/soc/davinci/davinci-mcasp.c         | 1 -
 sound/soc/davinci/davinci-mcasp.h         | 2 --
 3 files changed, 4 deletions(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index f3d6e4f..8db5ae0 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -23,7 +23,6 @@ struct snd_platform_data {
 	u32 rx_dma_offset;
 	int asp_chan_q;	/* event queue number for ASP channel */
 	int ram_chan_q;	/* event queue number for RAM channel */
-	unsigned int codec_fmt;
 	/*
 	 * Allowing this is more efficient and eliminates left and right swaps
 	 * caused by underruns, but will swap the left and right channels
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 46350b8..023a70d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1174,7 +1174,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dev->tdm_slots = pdata->tdm_slots;
 	dev->num_serializer = pdata->num_serializer;
 	dev->serial_dir = pdata->serial_dir;
-	dev->codec_fmt = pdata->codec_fmt;
 	dev->version = pdata->version;
 	dev->txnumevt = pdata->txnumevt;
 	dev->rxnumevt = pdata->rxnumevt;
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 156f15f..a42b5d9 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -40,9 +40,7 @@ enum {
 struct davinci_audio_dev {
 	struct davinci_pcm_dma_params dma_params[2];
 	void __iomem *base;
-	int sample_rate;
 	struct device *dev;
-	unsigned int codec_fmt;
 
 	/* McASP specific data */
 	int	tdm_slots;
-- 
1.7.11.7
