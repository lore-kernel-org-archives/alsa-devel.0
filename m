From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add SOC_DOUBLE_R_EXT" to the asoc tree
Date: Wed, 30 Sep 2015 20:32:17 +0100
Message-ID: <E1ZhN6v-000638-UZ@finisterre>
References: <73e9957cca4f29bd1b9881c4518132e47b2f00b4.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0135826644E
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:32:26 +0200 (CEST)
In-Reply-To: <73e9957cca4f29bd1b9881c4518132e47b2f00b4.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add SOC_DOUBLE_R_EXT

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

>From c25c79b468a61ad8a54f764553056e2e2a427ea8 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 29 Sep 2015 16:43:56 +0100
Subject: [PATCH] ASoC: Add SOC_DOUBLE_R_EXT

_EXT version of SOC_DOUBLE_R required to allow for custom handlers.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 884e728..2d79cb5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -217,6 +217,13 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = \
 		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, max, invert, 0) }
+#define SOC_DOUBLE_R_EXT(xname, reg_left, reg_right, xshift, xmax, xinvert,\
+	 xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = snd_soc_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
+					    xmax, xinvert) }
 #define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-- 
2.5.0
