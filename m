From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l51: fix mclk support" to the asoc
	tree
Date: Fri, 19 Oct 2018 17:06:28 +0100 (BST)
Message-ID: <20181019160628.151BC1122548@debutante.sirena.org.uk>
References: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3062D26795C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 18:06:30 +0200 (CEST)
In-Reply-To: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l51: fix mclk support

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

>From 318e741ee13b5a72f3051d9bb6852b1f4d02d0bb Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 19 Oct 2018 17:56:35 +0200
Subject: [PATCH] ASoC: cs42l51: fix mclk support

The MCLK clock is made optional for cs42l51 codec.
However, ASoC DAPM clock supply widget, expects the clock to be defined
unconditionally.
Register MCLK DAPM conditionally in codec driver,
depending on clock presence in DT.

Fixes: 5e8d63a726f8 ("ASoC: cs42l51: add mclk support")
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index eb40bff54cec..fd2bd74024c1 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -21,6 +21,7 @@
  *  - master mode *NOT* supported
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -41,6 +42,7 @@ enum master_slave_mode {
 
 struct cs42l51_private {
 	unsigned int mclk;
+	struct clk *mclk_handle;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
 };
@@ -492,9 +494,13 @@ static int cs42l51_component_probe(struct snd_soc_component *component)
 {
 	int ret, reg;
 	struct snd_soc_dapm_context *dapm;
+	struct cs42l51_private *cs42l51;
 
+	cs42l51 = snd_soc_component_get_drvdata(component);
 	dapm = snd_soc_component_get_dapm(component);
-	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
+
+	if (cs42l51->mclk_handle)
+		snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
 
 	/*
 	 * DAC configuration
@@ -548,6 +554,13 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	dev_set_drvdata(dev, cs42l51);
 
+	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
+	if (IS_ERR(cs42l51->mclk_handle)) {
+		if (PTR_ERR(cs42l51->mclk_handle) != -ENOENT)
+			return PTR_ERR(cs42l51->mclk_handle);
+		cs42l51->mclk_handle = NULL;
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
-- 
2.19.0.rc2
