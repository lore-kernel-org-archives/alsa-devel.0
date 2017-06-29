From: John Hsu <supercraig0719@gmail.com>
Subject: [PATCH] ASoC: nau8825: change crosstalk-bypass
	property to bool type
Date: Thu, 29 Jun 2017 11:41:30 +0800
Message-ID: <1498707690-3978-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C31626720E
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 05:41:44 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id z6so11350938pfk.3
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 20:41:44 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, John Hsu <supercraig0719@gmail.com>, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The property type of "nuvoton,crosstalk-bypass" changes to boolean.
The document is updated as well.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
---
 Documentation/devicetree/bindings/sound/nau8825.txt | 3 +++
 sound/soc/codecs/nau8825.c                          | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
index d337423..2f5e973 100644
--- a/Documentation/devicetree/bindings/sound/nau8825.txt
+++ b/Documentation/devicetree/bindings/sound/nau8825.txt
@@ -69,6 +69,8 @@ Optional properties:
   - nuvoton,jack-insert-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
   - nuvoton,jack-eject-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
 
+  - nuvoton,crosstalk-bypass: make crosstalk function bypass if set.
+
   - clocks: list of phandle and clock specifier pairs according to common clock bindings for the
       clocks described in clock-names
   - clock-names: should include "mclk" for the MCLK master clock
@@ -96,6 +98,7 @@ Example:
       nuvoton,short-key-debounce = <2>;
       nuvoton,jack-insert-debounce = <7>;
       nuvoton,jack-eject-debounce = <7>;
+      nuvoton,crosstalk-bypass;
 
       clock-names = "mclk";
       clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index a8c7a55..46a30ea 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2440,6 +2440,8 @@ static void nau8825_print_device_properties(struct nau8825 *nau8825)
 			nau8825->jack_insert_debounce);
 	dev_dbg(dev, "jack-eject-debounce:  %d\n",
 			nau8825->jack_eject_debounce);
+	dev_dbg(dev, "crosstalk-bypass:     %d\n",
+			nau8825->xtalk_bypass);
 }
 
 static int nau8825_read_device_properties(struct device *dev,
@@ -2504,10 +2506,8 @@ static int nau8825_read_device_properties(struct device *dev,
 		&nau8825->jack_eject_debounce);
 	if (ret)
 		nau8825->jack_eject_debounce = 0;
-	ret = device_property_read_u32(dev, "nuvoton,crosstalk-bypass",
-		&nau8825->xtalk_bypass);
-	if (ret)
-		nau8825->xtalk_bypass = 1;
+	nau8825->xtalk_bypass = device_property_read_bool(dev,
+		"nuvoton,crosstalk-bypass");
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
 	if (PTR_ERR(nau8825->mclk) == -EPROBE_DEFER) {
-- 
2.6.4
