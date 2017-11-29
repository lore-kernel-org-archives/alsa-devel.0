From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: disable crosstalk by default"
	to the asoc tree
Date: Wed, 29 Nov 2017 10:57:41 +0000
Message-ID: <E1eK03h-00062p-73@debutante>
References: <1511518107-7488-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A19F2678D4
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:57:57 +0100 (CET)
In-Reply-To: <1511518107-7488-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, wuchengli@google.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, broonie@kernel.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: disable crosstalk by default

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

>From 226d7449135ffc62866c06d73b28cac90b3f31e4 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 24 Nov 2017 18:08:26 +0800
Subject: [PATCH] ASoC: nau8825: disable crosstalk by default

The driver makes the crosstalk funciton disabled by default
which can simplify the codec function. The platform may not
need this funciton and reduce the potential risk. Therefore,
We change the property "nuvoton,crosstalk-bypass" to
"nuvoton,crosstalk-enable". The crosstalk measurement is enabled
if the property is set. Otherwise, it is disabled. Besides,
add more condition in the entry point of the crosstalk sequence
to disable the function completely.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/nau8825.txt          |  4 ++--
 sound/soc/codecs/nau8825.c                         | 23 ++++++++++++----------
 sound/soc/codecs/nau8825.h                         |  2 +-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
index 2f5e973285a6..d16d96839bcb 100644
--- a/Documentation/devicetree/bindings/sound/nau8825.txt
+++ b/Documentation/devicetree/bindings/sound/nau8825.txt
@@ -69,7 +69,7 @@ Optional properties:
   - nuvoton,jack-insert-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
   - nuvoton,jack-eject-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
 
-  - nuvoton,crosstalk-bypass: make crosstalk function bypass if set.
+  - nuvoton,crosstalk-enable: make crosstalk function enable if set.
 
   - clocks: list of phandle and clock specifier pairs according to common clock bindings for the
       clocks described in clock-names
@@ -98,7 +98,7 @@ Example:
       nuvoton,short-key-debounce = <2>;
       nuvoton,jack-insert-debounce = <7>;
       nuvoton,jack-eject-debounce = <7>;
-      nuvoton,crosstalk-bypass;
+      nuvoton,crosstalk-enable;
 
       clock-names = "mclk";
       clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 714ce17da717..d3c1a02f1e15 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -815,11 +815,12 @@ static void nau8825_xtalk_work(struct work_struct *work)
 
 static void nau8825_xtalk_cancel(struct nau8825 *nau8825)
 {
-	/* If the xtalk_protect is true, that means the process is still
-	 * on going. The driver forces to cancel the cross talk task and
+	/* If the crosstalk is eanbled and the process is on going,
+	 * the driver forces to cancel the crosstalk task and
 	 * restores the configuration to original status.
 	 */
-	if (nau8825->xtalk_protect) {
+	if (nau8825->xtalk_enable && nau8825->xtalk_state !=
+		NAU8825_XTALK_DONE) {
 		cancel_work_sync(&nau8825->xtalk_work);
 		nau8825_xtalk_clean(nau8825);
 	}
@@ -1686,7 +1687,7 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	} else if (active_irq & NAU8825_HEADSET_COMPLETION_IRQ) {
 		if (nau8825_is_jack_inserted(regmap)) {
 			event |= nau8825_jack_insert(nau8825);
-			if (!nau8825->xtalk_bypass && !nau8825->high_imped) {
+			if (nau8825->xtalk_enable && !nau8825->high_imped) {
 				/* Apply the cross talk suppression in the
 				 * headset without high impedance.
 				 */
@@ -1732,8 +1733,10 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 			nau8825->xtalk_event_mask = event_mask;
 		}
 	} else if (active_irq & NAU8825_IMPEDANCE_MEAS_IRQ) {
-		schedule_work(&nau8825->xtalk_work);
-		clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
+		if (nau8825->xtalk_enable) {
+			schedule_work(&nau8825->xtalk_work);
+			clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
+		}
 	} else if ((active_irq & NAU8825_JACK_INSERTION_IRQ_MASK) ==
 		NAU8825_JACK_INSERTION_DETECTED) {
 		/* One more step to check GPIO status directly. Thus, the
@@ -2440,8 +2443,8 @@ static void nau8825_print_device_properties(struct nau8825 *nau8825)
 			nau8825->jack_insert_debounce);
 	dev_dbg(dev, "jack-eject-debounce:  %d\n",
 			nau8825->jack_eject_debounce);
-	dev_dbg(dev, "crosstalk-bypass:     %d\n",
-			nau8825->xtalk_bypass);
+	dev_dbg(dev, "crosstalk-enable:     %d\n",
+			nau8825->xtalk_enable);
 }
 
 static int nau8825_read_device_properties(struct device *dev,
@@ -2506,8 +2509,8 @@ static int nau8825_read_device_properties(struct device *dev,
 		&nau8825->jack_eject_debounce);
 	if (ret)
 		nau8825->jack_eject_debounce = 0;
-	nau8825->xtalk_bypass = device_property_read_bool(dev,
-		"nuvoton,crosstalk-bypass");
+	nau8825->xtalk_enable = device_property_read_bool(dev,
+		"nuvoton,crosstalk-enable");
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
 	if (PTR_ERR(nau8825->mclk) == -EPROBE_DEFER) {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 8aee5c8647ae..199d6ea4dcdc 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -476,7 +476,7 @@ struct nau8825 {
 	int xtalk_event_mask;
 	bool xtalk_protect;
 	int imp_rms[NAU8825_XTALK_IMM];
-	int xtalk_bypass;
+	int xtalk_enable;
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
-- 
2.15.0
