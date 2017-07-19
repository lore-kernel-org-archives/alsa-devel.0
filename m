From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Refactor code to avoid
	comparison unsigned >= 0" to the asoc tree
Date: Wed, 19 Jul 2017 12:27:06 +0100
Message-ID: <E1dXn8E-0002as-86@debutante>
References: <20170718173419.65980-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6838253512684247799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1C3266998
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 13:27:16 +0200 (CEST)
In-Reply-To: <20170718173419.65980-3-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

--===============6838253512684247799==
Content-Type: text/plain

The patch

   ASoC: rt5677: Refactor code to avoid comparison unsigned >= 0

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d4e753d3aa2c278cb1f7b4a61987c4037316e0fd Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 18 Jul 2017 20:34:18 +0300
Subject: [PATCH] ASoC: rt5677: Refactor code to avoid comparison unsigned >= 0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rt5677_to_irq() has couple of redundant conditionals, one of which
compares unsigned variable to be great than or equal to zero which
is always true as compiler notices:

sound/soc/codecs/rt5677.c: In function ‘rt5677_to_irq’:
sound/soc/codecs/rt5677.c:4626:13: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]

Refactor the code by removing redundant conditionals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 50 ++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 0f9642c2198a..a3cce57739c3 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4625,35 +4625,27 @@ static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 	struct regmap_irq_chip_data *data = rt5677->irq_data;
 	int irq;
 
-	if (offset >= RT5677_GPIO1 && offset <= RT5677_GPIO3) {
-		if ((rt5677->pdata.jd1_gpio == 1 && offset == RT5677_GPIO1) ||
-			(rt5677->pdata.jd1_gpio == 2 &&
-				offset == RT5677_GPIO2) ||
-			(rt5677->pdata.jd1_gpio == 3 &&
-				offset == RT5677_GPIO3)) {
-			irq = RT5677_IRQ_JD1;
-		} else {
-			return -ENXIO;
-		}
-	}
-
-	if (offset >= RT5677_GPIO4 && offset <= RT5677_GPIO6) {
-		if ((rt5677->pdata.jd2_gpio == 1 && offset == RT5677_GPIO4) ||
-			(rt5677->pdata.jd2_gpio == 2 &&
-				offset == RT5677_GPIO5) ||
-			(rt5677->pdata.jd2_gpio == 3 &&
-				offset == RT5677_GPIO6)) {
-			irq = RT5677_IRQ_JD2;
-		} else if ((rt5677->pdata.jd3_gpio == 1 &&
-				offset == RT5677_GPIO4) ||
-			(rt5677->pdata.jd3_gpio == 2 &&
-				offset == RT5677_GPIO5) ||
-			(rt5677->pdata.jd3_gpio == 3 &&
-				offset == RT5677_GPIO6)) {
-			irq = RT5677_IRQ_JD3;
-		} else {
-			return -ENXIO;
-		}
+	if ((rt5677->pdata.jd1_gpio == 1 && offset == RT5677_GPIO1) ||
+		(rt5677->pdata.jd1_gpio == 2 &&
+			offset == RT5677_GPIO2) ||
+		(rt5677->pdata.jd1_gpio == 3 &&
+			offset == RT5677_GPIO3)) {
+		irq = RT5677_IRQ_JD1;
+	} else if ((rt5677->pdata.jd2_gpio == 1 && offset == RT5677_GPIO4) ||
+		(rt5677->pdata.jd2_gpio == 2 &&
+			offset == RT5677_GPIO5) ||
+		(rt5677->pdata.jd2_gpio == 3 &&
+			offset == RT5677_GPIO6)) {
+		irq = RT5677_IRQ_JD2;
+	} else if ((rt5677->pdata.jd3_gpio == 1 &&
+			offset == RT5677_GPIO4) ||
+		(rt5677->pdata.jd3_gpio == 2 &&
+			offset == RT5677_GPIO5) ||
+		(rt5677->pdata.jd3_gpio == 3 &&
+			offset == RT5677_GPIO6)) {
+		irq = RT5677_IRQ_JD3;
+	} else {
+		return -ENXIO;
 	}
 
 	return regmap_irq_get_virq(data, irq);
-- 
2.13.2


--===============6838253512684247799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6838253512684247799==--
