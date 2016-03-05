From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ads117x: Add bindings documentation for
	TI ADS117x ADC" to the asoc tree
Date: Sat, 05 Mar 2016 21:24:43 +0900
Message-ID: <E1acBGF-0003EU-VL@finisterre>
References: <1454686334-9668-2-git-send-email-florian.vaussard@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33EC12606F7
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:55 +0100 (CET)
In-Reply-To: <1454686334-9668-2-git-send-email-florian.vaussard@heig-vd.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Vaussard <florian.vaussard@heig-vd.ch>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ads117x: Add bindings documentation for TI ADS117x ADC

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

>From c9146fae4e88fa9864c4a7087289523b96cdbf2d Mon Sep 17 00:00:00 2001
From: Florian Vaussard <florian.vaussard@gmail.com>
Date: Fri, 5 Feb 2016 16:32:13 +0100
Subject: [PATCH] ASoC: ads117x: Add bindings documentation for TI ADS117x ADC

Currently the binding is only made of the compatible string.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ti,ads117x.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ads117x.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,ads117x.txt b/Documentation/devicetree/bindings/sound/ti,ads117x.txt
new file mode 100644
index 000000000000..7db19b50865a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,ads117x.txt
@@ -0,0 +1,11 @@
+Texas Intstruments ADS117x ADC
+
+Required properties:
+
+  - compatible : "ti,ads1174" or "ti,ads1178"
+
+Example:
+
+ads1178 {
+	compatible = "ti,ads1178";
+};
-- 
2.7.0
