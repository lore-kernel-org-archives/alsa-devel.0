From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH v2 1/5] ASoC: adau17x1: Fix incorrect BCLK ratio definitions
Date: Tue, 16 Feb 2016 13:56:41 +0100
Message-ID: <1455627405-18155-2-git-send-email-andire@axis.com>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455627405-18155-1-git-send-email-andire@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andreas Irest=C3=A5l <andire@axis.com>
---
 sound/soc/codecs/adau17x1.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index e13583e..5ae87a0 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -103,9 +103,9 @@ bool adau17x1_has_dsp(struct adau *adau);
 #define ADAU17X1_CLOCK_CONTROL_CORECLK_SRC_PLL	BIT(3)
 #define ADAU17X1_CLOCK_CONTROL_SYSCLK_EN	BIT(0)
=20
-#define ADAU17X1_SERIAL_PORT1_BCLK32		(0x0 << 5)
-#define ADAU17X1_SERIAL_PORT1_BCLK48		(0x1 << 5)
-#define ADAU17X1_SERIAL_PORT1_BCLK64		(0x2 << 5)
+#define ADAU17X1_SERIAL_PORT1_BCLK64		(0x0 << 5)
+#define ADAU17X1_SERIAL_PORT1_BCLK32		(0x1 << 5)
+#define ADAU17X1_SERIAL_PORT1_BCLK48		(0x2 << 5)
 #define ADAU17X1_SERIAL_PORT1_BCLK128		(0x3 << 5)
 #define ADAU17X1_SERIAL_PORT1_BCLK256		(0x4 << 5)
 #define ADAU17X1_SERIAL_PORT1_BCLK_MASK		(0x7 << 5)
--=20
2.1.4
