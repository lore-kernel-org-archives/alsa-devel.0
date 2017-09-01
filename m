From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: make clock direction configurable in
	asoc-simple" to the asoc tree
Date: Fri, 01 Sep 2017 11:47:12 +0100
Message-ID: <E1dnjTk-00061n-7K@debutante>
References: <20170817134236.a89f513737877efd7c176a3c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BB9472676D8
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 12:47:18 +0200 (CEST)
In-Reply-To: <20170817134236.a89f513737877efd7c176a3c@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: trini@konsulko.com, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Mark Brown <broonie@kernel.org>, Vitaly Wool <vitaly.wool@konsulko.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: make clock direction configurable in asoc-simple

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

>From a728f56094e7cf60a1dc0642fe86901d1a4dfb4e Mon Sep 17 00:00:00 2001
From: Vitaly Wool <vitalywool@gmail.com>
Date: Thu, 17 Aug 2017 13:42:36 +0200
Subject: [PATCH] ASoC: make clock direction configurable in asoc-simple

Some CPU drivers (e. g. davinci-mcasp) may require the system clock to
be configured as OUT, while there's no good way currently to set
SND_SOC_CLK_OUT in simple-soc driver if the clock is fixed-rate.

This patch makes asoc_simple_card_init_dai() initialize clock to
SND_SOCK_CLK_OUT if explicitly stated in the relevant dts file. This
change is transparent and doesn't change the default behavior.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 3 +++
 include/sound/simple_card_utils.h                       | 1 +
 sound/soc/generic/simple-card-utils.c                   | 9 +++++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c7a93931fad2..166f2290233b 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -86,6 +86,9 @@ Optional CPU/CODEC subnodes properties:
 					  in dai startup() and disabled with
 					  clk_disable_unprepare() in dai
 					  shutdown().
+- system-clock-direction-out		: specifies clock direction as 'out' on
+					  initialization. It is useful for some aCPUs with
+					  fixed clocks.
 
 Example 1 - single DAI link:
 
diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 42c6a6ac3ce6..7e25afce6566 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -15,6 +15,7 @@
 struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
+	int clk_direction;
 	int slots;
 	int slot_width;
 	unsigned int tx_slot_mask;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 26d64fa40c9c..af44c8c52a19 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -196,7 +196,11 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			simple_dai->sysclk = clk_get_rate(clk);
 	}
 
-	dev_dbg(dev, "%s : sysclk = %d\n", name, simple_dai->sysclk);
+	if (of_property_read_bool(node, "system-clock-direction-out"))
+		simple_dai->clk_direction = SND_SOC_CLOCK_OUT;
+
+	dev_dbg(dev, "%s : sysclk = %d, direction %d\n", name,
+		simple_dai->sysclk, simple_dai->clk_direction);
 
 	return 0;
 }
@@ -310,7 +314,8 @@ int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 	int ret;
 
 	if (simple_dai->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk, 0);
+		ret = snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk,
+					     simple_dai->clk_direction);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_sysclk error\n");
 			return ret;
-- 
2.14.1
