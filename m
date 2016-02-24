From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Fix incorrect BCLK ratio
	definitions" to the asoc tree
Date: Wed, 24 Feb 2016 13:15:19 +0900
Message-ID: <E1aYQr9-0000qk-Hs@finisterre>
References: <1454423510-1330-2-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3515316037955130156=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7625E265D9F
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 05:15:24 +0100 (CET)
In-Reply-To: <1454423510-1330-2-git-send-email-andire@axis.com>
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

--===============3515316037955130156==
Content-Type: text/plain

The patch

   ASoC: adau17x1: Fix incorrect BCLK ratio definitions

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

>From 7c139db2e579669c3313f92d2dd2256b255fcc07 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Date: Tue, 16 Feb 2016 13:56:41 +0100
Subject: [PATCH] ASoC: adau17x1: Fix incorrect BCLK ratio definitions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andreas Irestål <andire@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index e13583e6ff56..5ae87a084d97 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -103,9 +103,9 @@ bool adau17x1_has_dsp(struct adau *adau);
 #define ADAU17X1_CLOCK_CONTROL_CORECLK_SRC_PLL	BIT(3)
 #define ADAU17X1_CLOCK_CONTROL_SYSCLK_EN	BIT(0)
 
-#define ADAU17X1_SERIAL_PORT1_BCLK32		(0x0 << 5)
-#define ADAU17X1_SERIAL_PORT1_BCLK48		(0x1 << 5)
-#define ADAU17X1_SERIAL_PORT1_BCLK64		(0x2 << 5)
+#define ADAU17X1_SERIAL_PORT1_BCLK64		(0x0 << 5)
+#define ADAU17X1_SERIAL_PORT1_BCLK32		(0x1 << 5)
+#define ADAU17X1_SERIAL_PORT1_BCLK48		(0x2 << 5)
 #define ADAU17X1_SERIAL_PORT1_BCLK128		(0x3 << 5)
 #define ADAU17X1_SERIAL_PORT1_BCLK256		(0x4 << 5)
 #define ADAU17X1_SERIAL_PORT1_BCLK_MASK		(0x7 << 5)
-- 
2.7.0


--===============3515316037955130156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3515316037955130156==--
