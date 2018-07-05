From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa-ssp: add support for an external
	clock in devicetree" to the asoc tree
Date: Thu, 05 Jul 2018 11:08:35 +0100
Message-ID: <E1fb1Bj-0002sd-KD@debutante>
References: <20180702151100.28999-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C9DD8267214
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 12:08:39 +0200 (CEST)
In-Reply-To: <20180702151100.28999-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, robh+dt@kernel.org, broonie@kernel.org, robert.jarzmik@free.fr
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa-ssp: add support for an external clock in devicetree

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

>From 90eb6b59d311e6facd040124cb5b659a865125b8 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Mon, 2 Jul 2018 17:11:00 +0200
Subject: [PATCH] ASoC: pxa-ssp: add support for an external clock in
 devicetree

Allow setting a clock called 'extclk' in the device of the ssp-dai
device. If specified, this clock will be set to the mclk rate from the
DAI's .set_sysclk() callback. The DAI will also configure itself to
use that external clock.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/mrvl,pxa-ssp.txt           |  8 ++++++
 sound/soc/pxa/pxa-ssp.c                       | 25 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
index 74c9ba6c2823..93b982e9419f 100644
--- a/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
+++ b/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
@@ -5,6 +5,14 @@ Required properties:
 	compatible	Must be "mrvl,pxa-ssp-dai"
 	port		A phandle reference to a PXA ssp upstream device
 
+Optional properties:
+
+	clock-names
+	clocks		Through "clock-names" and "clocks", external clocks
+			can be configured. If a clock names "extclk" exists,
+			it will be set to the mclk rate of the audio stream
+			and be used as clock provider of the DAI.
+
 Example:
 
 	/* upstream device */
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index ff1e0bd8d407..69033e1a84e6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -41,6 +41,7 @@
  */
 struct ssp_priv {
 	struct ssp_device *ssp;
+	struct clk *extclk;
 	unsigned long ssp_clk;
 	unsigned int sysclk;
 	unsigned int dai_fmt;
@@ -205,6 +206,21 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
 		~(SSCR0_ECS | SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 
+	if (priv->extclk) {
+		int ret;
+
+		/*
+		 * For DT based boards, if an extclk is given, use it
+		 * here and configure PXA_SSP_CLK_EXT.
+		 */
+
+		ret = clk_set_rate(priv->extclk, freq);
+		if (ret < 0)
+			return ret;
+
+		clk_id = PXA_SSP_CLK_EXT;
+	}
+
 	dev_dbg(&ssp->pdev->dev,
 		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
 		cpu_dai->id, clk_id, freq);
@@ -774,6 +790,15 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 			ret = -ENODEV;
 			goto err_priv;
 		}
+
+		priv->extclk = devm_clk_get(dev, "extclk");
+		if (IS_ERR(priv->extclk)) {
+			ret = PTR_ERR(priv->extclk);
+			if (ret == -EPROBE_DEFER)
+				return ret;
+
+			priv->extclk = NULL;
+		}
 	} else {
 		priv->ssp = pxa_ssp_request(dai->id + 1, "SoC audio");
 		if (priv->ssp == NULL) {
-- 
2.18.0.rc2
