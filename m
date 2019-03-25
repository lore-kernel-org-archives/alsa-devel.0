From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Move aosr and dosr
	setting to separate functions" to the asoc tree
Date: Mon, 25 Mar 2019 16:11:32 +0000 (GMT)
Message-ID: <20190325161132.0E67A11288F1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 316D9F89717
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 17:11:33 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Move aosr and dosr setting to separate functions

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

>From fbafbf6517274a797e6e6508c18dd8dba5920c89 Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Thu, 21 Mar 2019 17:58:50 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Move aosr and dosr setting to separate
 functions

Move these to separate helper functions.  This looks cleaner and fits
better with the new clock setting in CCF.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index c3e9f65b26a7..bf3a80237b03 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -718,6 +718,20 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int aic32x4_set_aosr(struct snd_soc_component *component, u8 aosr)
+{
+	return snd_soc_component_write(component, AIC32X4_AOSR, aosr);
+}
+
+static int aic32x4_set_dosr(struct snd_soc_component *component, u16 dosr)
+{
+	snd_soc_component_write(component, AIC32X4_DOSRMSB, dosr >> 8);
+	snd_soc_component_write(component, AIC32X4_DOSRLSB,
+		      (dosr & 0xff));
+
+	return 0;
+}
+
 static int aic32x4_set_processing_blocks(struct snd_soc_component *component,
 						u8 r_block, u8 p_block)
 {
@@ -763,14 +777,10 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	clk_set_rate(clocks[4].clk, aic32x4_divs[i].mdac_rate);
 	clk_set_rate(clocks[5].clk, aic32x4_divs[i].bdiv_rate);
 
-	aic32x4_set_processing_blocks(component, aic32x4_divs[i].r_block, aic32x4_divs[i].p_block);
+	aic32x4_set_aosr(component, aic32x4_divs[i].aosr);
+	aic32x4_set_dosr(component, aic32x4_divs[i].dosr);
 
-	/* DOSR MSB & LSB values */
-	snd_soc_component_write(component, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
-	snd_soc_component_write(component, AIC32X4_DOSRLSB, (aic32x4_divs[i].dosr & 0xff));
-
-	/* AOSR value */
-	snd_soc_component_write(component, AIC32X4_AOSR, aic32x4_divs[i].aosr);
+	aic32x4_set_processing_blocks(component, aic32x4_divs[i].r_block, aic32x4_divs[i].p_block);
 
 	return 0;
 }
-- 
2.20.1
