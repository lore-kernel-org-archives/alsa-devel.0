From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: disable crosstalk by default
Date: Thu, 23 Nov 2017 11:19:23 +0800
Message-ID: <1511407163-9667-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C60142671E7
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 04:19:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, wuchengli@google.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The driver makes the crosstalk funciton disabled by default
which can simplify the codec function. The platform may not
need this funciton and reduce the potential risk. Therefore,
We change the property "nuvoton,crosstalk-bypass" to
"nuvoton,crosstalk-enable". The crosstalk measurement is enabled
if the property is set. Otherwise, it is disabled. Besides,
add more condition in the entry point of the crosstalk sequence
to disable the function completely.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 Documentation/devicetree/bindings/sound/nau8825.txt |  4 ++--
 sound/soc/codecs/nau8825.c                          | 21 +++++++++++++--------
 sound/soc/codecs/nau8825.h                          |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
index 2f5e973..d16d968 100644
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
index 714ce17..2d6c536 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -792,6 +792,10 @@ static void nau8825_xtalk_work(struct work_struct *work)
 	struct nau8825 *nau8825 = container_of(
 		work, struct nau8825, xtalk_work);
 
+	/* block when crosstalk disabled */
+	if (!nau8825->xtalk_enable)
+		return;
+
 	nau8825_xtalk_measure(nau8825);
 	/* To determine the cross talk side tone gain when reach
 	 * the impedance measure state.
@@ -815,11 +819,12 @@ static void nau8825_xtalk_work(struct work_struct *work)
 
 static void nau8825_xtalk_cancel(struct nau8825 *nau8825)
 {
-	/* If the xtalk_protect is true, that means the process is still
-	 * on going. The driver forces to cancel the cross talk task and
+	/* If the crosstalk is eanbled and the process is on going,
+	 * the driver forces to cancel the cross talk task and
 	 * restores the configuration to original status.
 	 */
-	if (nau8825->xtalk_protect) {
+	if (nau8825->xtalk_enable && nau8825->xtalk_protect &&
+		nau8825->xtalk_state != NAU8825_XTALK_DONE) {
 		cancel_work_sync(&nau8825->xtalk_work);
 		nau8825_xtalk_clean(nau8825);
 	}
@@ -1686,7 +1691,7 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	} else if (active_irq & NAU8825_HEADSET_COMPLETION_IRQ) {
 		if (nau8825_is_jack_inserted(regmap)) {
 			event |= nau8825_jack_insert(nau8825);
-			if (!nau8825->xtalk_bypass && !nau8825->high_imped) {
+			if (nau8825->xtalk_enable && !nau8825->high_imped) {
 				/* Apply the cross talk suppression in the
 				 * headset without high impedance.
 				 */
@@ -2440,8 +2445,8 @@ static void nau8825_print_device_properties(struct nau8825 *nau8825)
 			nau8825->jack_insert_debounce);
 	dev_dbg(dev, "jack-eject-debounce:  %d\n",
 			nau8825->jack_eject_debounce);
-	dev_dbg(dev, "crosstalk-bypass:     %d\n",
-			nau8825->xtalk_bypass);
+	dev_dbg(dev, "crosstalk-enable:     %d\n",
+			nau8825->xtalk_enable);
 }
 
 static int nau8825_read_device_properties(struct device *dev,
@@ -2506,8 +2511,8 @@ static int nau8825_read_device_properties(struct device *dev,
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
index 8aee5c86..199d6ea 100644
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
2.6.4
