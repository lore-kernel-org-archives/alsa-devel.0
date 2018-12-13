From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-toddr: add support for
	spdifin backend" to the asoc tree
Date: Thu, 13 Dec 2018 12:08:45 +0000 (GMT)
Message-ID: <20181213120845.5A29511254D1@debutante.sirena.org.uk>
References: <20181211134713.4908-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 364F4267C06
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 13:08:45 +0100 (CET)
In-Reply-To: <20181211134713.4908-2-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: axg-toddr: add support for spdifin backend

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 984463a94d5cb23120bfe7d689077b940c25128b Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 11 Dec 2018 14:47:10 +0100
Subject: [PATCH] ASoC: meson: axg-toddr: add support for spdifin backend

add IEC958_SUBFRAME_LE to the list of format accepted by the fifo frontend.

As opposed to what was initially noted in the toddr dai driver, the spdifin
does not place the msb at bit 28, it just output a whole spdif subframe.

Placing the msb at bit 28 in the toddr driver just filters out the parity,
user, channel status and validity bits. It is better to just provide the
whole spdif subframe to the userspace and let the iec958 plugin deal with
it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.h  |  3 ++-
 sound/soc/meson/axg-toddr.c | 15 +++++----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index cb6c4013ca33..d9f516cfbeda 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -25,7 +25,8 @@ struct snd_soc_pcm_runtime;
 					 SNDRV_PCM_FMTBIT_S16_LE |	\
 					 SNDRV_PCM_FMTBIT_S20_LE |	\
 					 SNDRV_PCM_FMTBIT_S24_LE |	\
-					 SNDRV_PCM_FMTBIT_S32_LE)
+					 SNDRV_PCM_FMTBIT_S32_LE |	\
+					 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
 #define AXG_FIFO_BURST			8
 #define AXG_FIFO_MIN_CNT		64
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index c2c9bb312586..0e9ca3882ae5 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -25,6 +25,8 @@
 #define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
 #define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
 
+#define TODDR_MSB_POS	31
+
 static int axg_toddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
 			     struct snd_soc_dai *dai)
 {
@@ -36,14 +38,7 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
 	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
-	unsigned int type, width, msb = 31;
-
-	/*
-	 * NOTE:
-	 * Almost all backend will place the MSB at bit 31, except SPDIF Input
-	 * which will put it at index 28. When adding support for the SPDIF
-	 * Input, we'll need to find which type of backend we are connected to.
-	 */
+	unsigned int type, width;
 
 	switch (params_physical_width(params)) {
 	case 8:
@@ -66,8 +61,8 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 			   CTRL0_TODDR_MSB_POS_MASK |
 			   CTRL0_TODDR_LSB_POS_MASK,
 			   CTRL0_TODDR_TYPE(type) |
-			   CTRL0_TODDR_MSB_POS(msb) |
-			   CTRL0_TODDR_LSB_POS(msb - (width - 1)));
+			   CTRL0_TODDR_MSB_POS(TODDR_MSB_POS) |
+			   CTRL0_TODDR_LSB_POS(TODDR_MSB_POS - (width - 1)));
 
 	return 0;
 }
-- 
2.19.0.rc2
