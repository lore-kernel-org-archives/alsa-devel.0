From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Add devicetree-bindings for
	dmic, jack-detect" to the asoc tree
Date: Fri, 11 May 2018 03:53:18 +0100 (BST)
Message-ID: <20180511025318.B315A44007E@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2819095765984933592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 59049267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 05:01:21 +0200 (CEST)
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
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============2819095765984933592==
Content-Type: text/plain

The patch

   ASoC: rt5640: Add devicetree-bindings for dmic, jack-detect

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

>From e9e7a3bdcdf41efe9137dcf225b021e0b6fd2dc3 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:47 +0200
Subject: [PATCH] ASoC: rt5640: Add devicetree-bindings for dmic, jack-detect

Add devicetree-bindings for the dmic, jack-detect source and overcurrent-
detect threshold settings.

The dmic bindings mirror the existing bindings for the rt5645.
The jd-src and ovcd bindings mirror the existing bindings for the rt5651.

Cc devicetree@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/rt5640.txt      | 35 +++++++++++++++++++
 include/dt-bindings/sound/rt5640.h            | 25 +++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 include/dt-bindings/sound/rt5640.h

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index 57fe64643050..e40e4893eed8 100644
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -22,6 +22,41 @@ Optional properties:
 
 - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
 
+- realtek,dmic1-data-pin
+  0: dmic1 is not used
+  1: using IN1P pin as dmic1 data pin
+  2: using GPIO3 pin as dmic1 data pin
+
+- realtek,dmic2-data-pin
+  0: dmic2 is not used
+  1: using IN1N pin as dmic2 data pin
+  2: using GPIO4 pin as dmic2 data pin
+
+- realtek,jack-detect-source
+  u32. Valid values:
+  0: jack-detect is not used
+  1: Use GPIO1 for jack-detect
+  2: Use JD1_IN4P for jack-detect
+  3: Use JD2_IN4N for jack-detect
+  4: Use GPIO2 for jack-detect
+  5: Use GPIO3 for jack-detect
+  6: Use GPIO4 for jack-detect
+
+- realtek,jack-detect-not-inverted
+  bool. Normal jack-detect switches give an inverted signal, set this bool
+  in the rare case you've a jack-detect switch which is not inverted.
+
+- realtek,over-current-threshold-microamp
+  u32, micbias over-current detection threshold in µA, valid values are
+  600, 1500 and 2000µA.
+
+- realtek,over-current-scale-factor
+  u32, micbias over-current detection scale-factor, valid values are:
+  0: Scale current by 0.5
+  1: Scale current by 0.75
+  2: Scale current by 1.0
+  3: Scale current by 1.5
+
 Pins on the device (for linking into audio routes) for RT5639/RT5640:
 
   * DMIC1
diff --git a/include/dt-bindings/sound/rt5640.h b/include/dt-bindings/sound/rt5640.h
new file mode 100644
index 000000000000..154c9b4414f2
--- /dev/null
+++ b/include/dt-bindings/sound/rt5640.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_RT5640_H
+#define __DT_RT5640_H
+
+#define RT5640_DMIC1_DATA_PIN_NONE	0
+#define RT5640_DMIC1_DATA_PIN_IN1P	1
+#define RT5640_DMIC1_DATA_PIN_GPIO3	2
+
+#define RT5640_DMIC2_DATA_PIN_NONE	0
+#define RT5640_DMIC2_DATA_PIN_IN1N	1
+#define RT5640_DMIC2_DATA_PIN_GPIO4	2
+
+#define RT5640_JD_SRC_GPIO1		1
+#define RT5640_JD_SRC_JD1_IN4P		2
+#define RT5640_JD_SRC_JD2_IN4N		3
+#define RT5640_JD_SRC_GPIO2		4
+#define RT5640_JD_SRC_GPIO3		5
+#define RT5640_JD_SRC_GPIO4		6
+
+#define RT5640_OVCD_SF_0P5		0
+#define RT5640_OVCD_SF_0P75		1
+#define RT5640_OVCD_SF_1P0		2
+#define RT5640_OVCD_SF_1P5		3
+
+#endif /* __DT_RT5640_H */
-- 
2.17.0


--===============2819095765984933592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2819095765984933592==--
