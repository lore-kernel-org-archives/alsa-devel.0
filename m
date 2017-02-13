From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Update binding documentation
	to include A31" to the asoc tree
Date: Mon, 13 Feb 2017 18:53:54 +0000
Message-ID: <E1cdLl4-00011Z-FN@debutante>
References: <20170202092422.5588-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8992299638091194426=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0B4A266ABF
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 19:54:19 +0100 (CET)
In-Reply-To: <20170202092422.5588-2-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============8992299638091194426==
Content-Type: text/plain

The patch

   ASoC: sun4i-i2s: Update binding documentation to include A31

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

>From f55d404f49194563974f5462f9f4bd7cbc48d9c6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Fri, 10 Feb 2017 11:00:46 +0100
Subject: [PATCH] ASoC: sun4i-i2s: Update binding documentation to include A31
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new compatible for sun4i-i2s driver to handle some
SoCs that have a reset line that must be asserted/deasserted.

This new compatible, "allwinner,sun6i-a31-i2s", requires the
property "resets" which should be a phandle to the reset line.
Except these differences, the compatible is identical to previous one
which will not handle a reset line.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun4i-i2s.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 7b526ec64991..f4adc58f82ba 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible: should be one of the followings
    - "allwinner,sun4i-a10-i2s"
+   - "allwinner,sun6i-a31-i2s"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
@@ -19,6 +20,10 @@ Required properties:
    - "mod" : module clock for the I2S controller
 - #sound-dai-cells : Must be equal to 0
 
+Required properties for the following compatibles:
+	- "allwinner,sun6i-a31-i2s"
+- resets: phandle to the reset line for this codec
+
 Example:
 
 i2s0: i2s@01c22400 {
-- 
2.11.0


--===============8992299638091194426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8992299638091194426==--
