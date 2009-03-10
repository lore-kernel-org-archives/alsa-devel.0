From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH 1/4] ALSA: ASoC: Davinci: Fix SFFSDR FPGA
	module codec FS bug
Date: Mon,  9 Mar 2009 23:32:06 -0400
Message-ID: <1236655929-31688-2-git-send-email-hugo@hugovil.com>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 917ED2445F
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 04:32:32 +0100 (CET)
In-Reply-To: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

This prevented the FPGA from properly configuring the codec FS when
the SFFSDR FPGA was compiled as a module.

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
---
 sound/soc/davinci/davinci-sffsdr.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 74f1eb3..1d10957 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -25,10 +25,10 @@
 
 #include <asm/dma.h>
 #include <asm/mach-types.h>
-#ifdef CONFIG_SFFSDR_FPGA
-#include <asm/plat-sffsdr/sffsdr-fpga.h>
-#endif
 
+#if defined(CONFIG_SFFSDR_FPGA) || defined(CONFIG_SFFSDR_FPGA_MODULE)
+#include <mach/sffsdr-fpga.h>
+#endif
 #include <mach/asp.h>
 #include <mach/edma.h>
 
@@ -48,7 +48,7 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 	/* Fsref can be 32000, 44100 or 48000. */
 	fs = params_rate(params);
 
-#ifndef CONFIG_SFFSDR_FPGA
+#if !defined(CONFIG_SFFSDR_FPGA) && !defined(CONFIG_SFFSDR_FPGA_MODULE)
 	/* Without the FPGA module, the Fs is fixed at 44100 Hz */
 	if (fs != 44100) {
 		pr_debug("warning: only 44.1 kHz is supported without SFFSDR FPGA module\n");
@@ -68,10 +68,10 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 
 	pr_debug("sffsdr_hw_params: rate = %d Hz\n", fs);
 
-#ifndef CONFIG_SFFSDR_FPGA
-	return 0;
-#else
+#if defined(CONFIG_SFFSDR_FPGA) || defined(CONFIG_SFFSDR_FPGA_MODULE)
 	return sffsdr_fpga_set_codec_fs(fs);
+#else
+	return 0;
 #endif
 }
 
-- 
1.5.5
