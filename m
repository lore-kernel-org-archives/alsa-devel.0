From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Add adau17x1 bindings
	document" to the asoc tree
Date: Wed, 24 Feb 2016 13:15:16 +0900
Message-ID: <E1aYQr6-0000pm-PS@finisterre>
References: <1455627405-18155-4-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0985681749670519149=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60A6826145E
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 05:15:22 +0100 (CET)
In-Reply-To: <1455627405-18155-4-git-send-email-andire@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0985681749670519149==
Content-Type: text/plain

The patch

   ASoC: adau17x1: Add adau17x1 bindings document

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

>From ef329457237d885baf3408a56db9a02df97cde87 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Date: Tue, 16 Feb 2016 13:56:43 +0100
Subject: [PATCH] ASoC: adau17x1: Add adau17x1 bindings document
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andreas Irestål <andire@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/adi,adau17x1.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau17x1.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
new file mode 100644
index 000000000000..8dbce0e18dda
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
@@ -0,0 +1,24 @@
+Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781
+
+Required properties:
+
+ - compatible:		Should contain one of the following:
+			"adi,adau1361"
+			"adi,adau1461"
+			"adi,adau1761"
+			"adi,adau1961"
+			"adi,adau1381"
+			"adi,adau1781"
+
+ - reg:			The i2c address. Value depends on the state of ADDR0
+			and ADDR1, as wired in hardware.
+
+Examples:
+#include <dt-bindings/sound/adau17x1.h>
+
+	i2c_bus {
+		adau1361@38 {
+			compatible = "adi,adau1761";
+			reg = <0x38>;
+		};
+	};
-- 
2.7.0


--===============0985681749670519149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0985681749670519149==--
