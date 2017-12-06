From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas6424: add bindings for TAS6424" to
	the asoc tree
Date: Wed,  6 Dec 2017 12:58:14 +0000 (GMT)
Message-ID: <20171206125814.9224B44006B@finisterre.ee.mobilebroadband>
References: <20171205155412.20137-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 251F626792C
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 13:58:16 +0100 (CET)
In-Reply-To: <20171205155412.20137-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Stecklein <m-stecklein@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Andrew F . Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas6424: add bindings for TAS6424

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

>From 2e662342962863bb6044ad581d7cc03795da4e9d Mon Sep 17 00:00:00 2001
From: Michael Stecklein <m-stecklein@ti.com>
Date: Tue, 5 Dec 2017 09:54:11 -0600
Subject: [PATCH] ASoC: tas6424: add bindings for TAS6424

Add the bindings for the TAS6424 digital amplifier.

Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/ti,tas6424.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
new file mode 100644
index 000000000000..1c4ada0eef4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -0,0 +1,20 @@
+Texas Instruments TAS6424 Quad-Channel Audio amplifier
+
+The TAS6424 serial control bus communicates through I2C protocols.
+
+Required properties:
+	- compatible: "ti,tas6424" - TAS6424
+	- reg: I2C slave address
+	- sound-dai-cells: must be equal to 0
+
+Example:
+
+tas6424: tas6424@6a {
+	compatible = "ti,tas6424";
+	reg = <0x6a>;
+
+	#sound-dai-cells = <0>;
+};
+
+For more product information please see the link below:
+http://www.ti.com/product/TAS6424-Q1
-- 
2.15.0
