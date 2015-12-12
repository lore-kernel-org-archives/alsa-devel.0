From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img: Add binding document for Pistachio
	internal DAC" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:26 +0000
Message-ID: <E1a7tGA-0002dJ-Ch@finisterre>
References: <1448299499-18435-2-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79984260A56
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:34 +0100 (CET)
In-Reply-To: <1448299499-18435-2-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Damien.Horsley" <Damien.Horsley@imgtec.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: img: Add binding document for Pistachio internal DAC

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

>From 7274d07c4f797a9a2daf479bf58663fd885ab3bf Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Thu, 10 Dec 2015 14:40:11 +0000
Subject: [PATCH] ASoC: img: Add binding document for Pistachio internal DAC

Add binding document for Pistachio Internal DAC

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/img,pistachio-internal-dac.txt      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt

diff --git a/Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt b/Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt
new file mode 100644
index 0000000..4cc18fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt
@@ -0,0 +1,18 @@
+Pistachio internal DAC DT bindings
+
+Required properties:
+
+  - compatible: "img,pistachio-internal-dac"
+
+  - img,cr-top : Must contain a phandle to the top level control syscon
+		 node which contains the internal dac control registers
+
+  - VDD-supply : Digital power supply regulator (+1.8V or +3.3V)
+
+Examples:
+
+internal_dac: internal-dac {
+	compatible = "img,pistachio-internal-dac";
+	img,cr-top = <&cr_top>;
+	VDD-supply = <&supply3v3>;
+};
-- 
2.6.4
