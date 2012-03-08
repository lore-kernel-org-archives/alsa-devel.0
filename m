From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period size
	larger than FIFO
Date: Fri,  9 Mar 2012 01:19:17 +0200
Message-ID: <1331248757-3408-4-git-send-email-notasas@gmail.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9112B10BB88
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 00:19:33 +0100 (CET)
Received: by werg1 with SMTP id g1so789854wer.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 15:19:32 -0800 (PST)
In-Reply-To: <1331248757-3408-1-git-send-email-notasas@gmail.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

With a program operating in minimum sized periods, first write
will cause a transfer that will fill mcbsp FIFO quickly, and there
will be no more data to DMA before program manages to do another
write. As the core considers this as underflow condition, we may
get many underflows at the start.
Increase minimum period size by half to deal with this problem.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap-mcbsp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index b9d1272..b373a0b 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -108,6 +108,17 @@ static int omap_mcbsp_hwrule_min_period_size(struct snd_pcm_hw_params *params,
 	size = mcbsp->pdata->buffer_size;
 
 	frames.min = size / channels->min;
+
+	/*
+	 * If period is not larger than FIFO, it may be transfered faster than
+	 * program operating in period sizes is able to send 2 periods, so
+	 * underrun condition can be triggered at the beginning of stream.
+	 * This is because underrun is triggered as soon as DMA has no more
+	 * data to send, and we get this from the start if period is too small.
+	 * To deal with this, set period larger than FIFO size.
+	 */
+	frames.min = frames.min + frames.min / 2;
+
 	frames.integer = 1;
 	return snd_interval_refine(period_size, &frames);
 }
-- 
1.7.0.4
