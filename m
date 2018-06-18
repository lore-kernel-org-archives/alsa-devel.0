From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: TSCS42xx: Add headphone auto switching"
	to the asoc tree
Date: Mon, 18 Jun 2018 12:59:52 +0100
Message-ID: <E1fUsp6-0008RD-6w@debutante>
References: <cec911cd9111bb4ae25bb9ec2df3af134bc49c58.1528143829.git.steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F11CB2675D5
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 13:59:55 +0200 (CEST)
In-Reply-To: <cec911cd9111bb4ae25bb9ec2df3af134bc49c58.1528143829.git.steven.eckhoff.opensource@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: TSCS42xx: Add headphone auto switching

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

>From 53af408cd9f2d1c66bc081c1d82797bfe44af3e5 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Mon, 4 Jun 2018 15:47:02 -0500
Subject: [PATCH] ASoC: TSCS42xx: Add headphone auto switching

Add headphone auto switching controls

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 6 ++++++
 sound/soc/codecs/tscs42xx.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 5d596e4dab0c..7396a6e5277e 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -647,6 +647,12 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Mic Bias */
 	SOC_SINGLE("Mic Bias Boost Switch", 0x71, 0x07, 1, 0),
 
+	/* Headphone Auto Switching */
+	SOC_SINGLE("Headphone Auto Switching Switch",
+			R_CTL, FB_CTL_HPSWEN, 1, 0),
+	SOC_SINGLE("Headphone Detect Polarity Toggle Switch",
+			R_CTL, FB_CTL_HPSWPOL, 1, 0),
+
 	/* Coefficient Ram */
 	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
 	COEFF_RAM_CTL("Cascade1L BiQuad2", BIQUAD_SIZE, 0x05),
diff --git a/sound/soc/codecs/tscs42xx.h b/sound/soc/codecs/tscs42xx.h
index 814c8f3c4a68..6b3a21081635 100644
--- a/sound/soc/codecs/tscs42xx.h
+++ b/sound/soc/codecs/tscs42xx.h
@@ -34,6 +34,7 @@ enum {
 #define R_DACSR         0x19
 #define R_PWRM1         0x1A
 #define R_PWRM2         0x1B
+#define R_CTL		0x1C
 #define R_CONFIG0       0x1F
 #define R_CONFIG1       0x20
 #define R_DMICCTL       0x24
@@ -1110,6 +1111,13 @@ enum {
 #define RV_PWRM2_VREF_DISABLE \
 	 RV(FV_PWRM2_VREF_DISABLE, FB_PWRM2_VREF)
 
+/******************************
+ *      R_CTL (0x1C)          *
+ ******************************/
+
+/* Fiel Offsets */
+#define FB_CTL_HPSWEN                        7
+#define FB_CTL_HPSWPOL                       6
 
 /******************************
  *      R_CONFIG0 (0x1F)      *
-- 
2.17.1
