From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: add Digital Playback Volume
	support" to the asoc tree
Date: Sat, 19 Sep 2015 17:13:05 -0700
Message-ID: <E1ZdSFd-000437-KF@finisterre>
References: <87wpvo1rj8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B52B22605E1
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:35 +0200 (CEST)
In-Reply-To: <87wpvo1rj8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: add Digital Playback Volume support

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

>From e3a4d958d78e4f1709f3d4611849617ac9222a0c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 00:52:44 +0000
Subject: [PATCH] ASoC: ak4613: add Digital Playback Volume support

For L/ROUT1 to L/ROUT6

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index fd96a8f..07a2664 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
+#include <sound/tlv.h>
 
 #define PW_MGMT1	0x00 /* Power Management 1 */
 #define PW_MGMT2	0x01 /* Power Management 2 */
@@ -91,6 +92,31 @@ struct ak4613_interface {
 	struct ak4613_formats playback;
 };
 
+/*
+ * Playback Volume
+ *
+ * max : 0x00 : 0 dB
+ *       ( 0.5 dB step )
+ * min : 0xFE : -127.0 dB
+ * mute: 0xFF
+ */
+static const DECLARE_TLV_DB_SCALE(out_tlv, -12750, 50, 1);
+
+static const struct snd_kcontrol_new ak4613_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Digital Playback Volume1", LOUT1, ROUT1,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume2", LOUT2, ROUT2,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume3", LOUT3, ROUT3,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume4", LOUT4, ROUT4,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume5", LOUT5, ROUT5,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume6", LOUT6, ROUT6,
+			 0, 0xFF, 1, out_tlv),
+};
+
 static const struct reg_default ak4613_reg[] = {
 	{ 0x0,  0x0f }, { 0x1,  0x07 }, { 0x2,  0x3f }, { 0x3,  0x20 },
 	{ 0x4,  0x20 }, { 0x5,  0x55 }, { 0x6,  0x05 }, { 0x7,  0x07 },
@@ -397,6 +423,8 @@ static int ak4613_resume(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
 	.resume			= ak4613_resume,
 	.set_bias_level		= ak4613_set_bias_level,
+	.controls		= ak4613_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4613_snd_controls),
 	.dapm_widgets		= ak4613_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(ak4613_dapm_widgets),
 	.dapm_routes		= ak4613_intercon,
-- 
2.5.0
