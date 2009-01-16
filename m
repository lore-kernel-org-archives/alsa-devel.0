From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: DaVinci: Fix SFFSDR compilation
	error.
Date: Fri, 16 Jan 2009 17:15:12 +0000
Message-ID: <1232126115-1966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090116171347.GA1912@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0281C24395
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 18:15:16 +0100 (CET)
In-Reply-To: <20090116171347.GA1912@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Hugo Villeneuve <hugo@hugovil.com>
List-Id: alsa-devel@alsa-project.org

From: Hugo Villeneuve <hugo@hugovil.com>

Remove dependency on sffsdr_fpga_set_codec_fs() when the
SFFSDR FPGA module is not selected.

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/davinci/davinci-sffsdr.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 4935d1b..50baef1 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -25,7 +25,9 @@
 
 #include <asm/dma.h>
 #include <asm/mach-types.h>
+#ifdef CONFIG_SFFSDR_FPGA
 #include <asm/plat-sffsdr/sffsdr-fpga.h>
+#endif
 
 #include <mach/mcbsp.h>
 #include <mach/edma.h>
@@ -43,6 +45,17 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 	int fs;
 	int ret = 0;
 
+	/* Fsref can be 32000, 44100 or 48000. */
+	fs = params_rate(params);
+
+#ifndef CONFIG_SFFSDR_FPGA
+	/* Without the FPGA module, the Fs is fixed at 44100 Hz */
+	if (fs != 44100) {
+		pr_debug("warning: only 44.1 kHz is supported without SFFSDR FPGA module\n");
+		return -EINVAL;
+	}
+#endif
+
 	/* Set cpu DAI configuration:
 	 * CLKX and CLKR are the inputs for the Sample Rate Generator.
 	 * FSX and FSR are outputs, driven by the sample Rate Generator. */
@@ -53,12 +66,13 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* Fsref can be 32000, 44100 or 48000. */
-	fs = params_rate(params);
-
 	pr_debug("sffsdr_hw_params: rate = %d Hz\n", fs);
 
+#ifndef CONFIG_SFFSDR_FPGA
+	return 0;
+#else
 	return sffsdr_fpga_set_codec_fs(fs);
+#endif
 }
 
 static struct snd_soc_ops sffsdr_ops = {
-- 
1.5.6.5
