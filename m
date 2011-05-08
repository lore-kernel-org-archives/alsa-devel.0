From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: SSM2602: Provide dB ranges for the
	volume controls
Date: Sun,  8 May 2011 09:24:46 -0700
Message-ID: <1304871886-18509-6-git-send-email-lars@metafoo.de>
References: <20110508135613.GA15968@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-048.synserver.de
	[212.40.185.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 48C23103838
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 18:25:24 +0200 (CEST)
In-Reply-To: <20110508135613.GA15968@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Also fix the maximum value for the capture volume control.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 763d392..70099c9 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -40,6 +40,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 
 #include "ssm2602.h"
 
@@ -87,8 +88,18 @@ static const struct soc_enum ssm2602_enum[] = {
 	SOC_ENUM_SINGLE(SSM2602_APDIGI, 1, 4, ssm2602_deemph),
 };
 
+static const unsigned int ssm260x_outmix_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 47, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 0),
+	48, 127, TLV_DB_SCALE_ITEM(-7400, 100, 0),
+};
+
+static const DECLARE_TLV_DB_SCALE(ssm260x_inpga_tlv, -3450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(ssm260x_sidetone_tlv, -1500, 300, 0);
+
 static const struct snd_kcontrol_new ssm260x_snd_controls[] = {
-SOC_DOUBLE_R("Capture Volume", SSM2602_LINVOL, SSM2602_RINVOL, 0, 31, 0),
+SOC_DOUBLE_R_TLV("Capture Volume", SSM2602_LINVOL, SSM2602_RINVOL, 0, 45, 0,
+	ssm260x_inpga_tlv),
 SOC_DOUBLE_R("Capture Switch", SSM2602_LINVOL, SSM2602_RINVOL, 7, 1, 1),
 
 SOC_SINGLE("ADC High Pass Filter Switch", SSM2602_APDIGI, 0, 1, 1),
@@ -98,12 +109,12 @@ SOC_ENUM("Playback De-emphasis", ssm2602_enum[1]),
 };
 
 static const struct snd_kcontrol_new ssm2602_snd_controls[] = {
-SOC_DOUBLE_R("Master Playback Volume", SSM2602_LOUT1V, SSM2602_ROUT1V,
-	0, 127, 0),
+SOC_DOUBLE_R_TLV("Master Playback Volume", SSM2602_LOUT1V, SSM2602_ROUT1V,
+	0, 127, 0, ssm260x_outmix_tlv),
 SOC_DOUBLE_R("Master Playback ZC Switch", SSM2602_LOUT1V, SSM2602_ROUT1V,
 	7, 1, 0),
-
-SOC_SINGLE("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1),
+SOC_SINGLE_TLV("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1,
+	ssm260x_sidetone_tlv),
 
 SOC_SINGLE("Mic Boost (+20dB)", SSM2602_APANA, 0, 1, 0),
 SOC_SINGLE("Mic Boost2 (+20dB)", SSM2602_APANA, 8, 1, 0),
-- 
1.7.2.5
