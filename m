From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: change crosstalk-bypass
	property to bool type" to the asoc tree
Date: Fri, 30 Jun 2017 12:59:14 +0100
Message-ID: <E1dQuZu-000812-SN@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C40BD26752C
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:24 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, John Hsu <KCHSU0@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: change crosstalk-bypass property to bool type

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

>From fc3ba81a5adac413312019413c91b1e6a5d8d1fa Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Thu, 29 Jun 2017 11:41:30 +0800
Subject: [PATCH] ASoC: nau8825: change crosstalk-bypass property to bool type

The property type of "nuvoton,crosstalk-bypass" changes to boolean.
The document is updated as well.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/nau8825.txt | 3 +++
 sound/soc/codecs/nau8825.c                          | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
index d3374231c871..2f5e973285a6 100644
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
index 80bae481e75d..46a30eaa7ace 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2506,10 +2506,8 @@ static int nau8825_read_device_properties(struct device *dev,
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
2.13.2
