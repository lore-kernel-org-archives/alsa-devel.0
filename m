From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: ak4671: Use snd_soc_update_bits for
	read-modify-write
Date: Thu, 20 Oct 2011 10:54:13 +0800
Message-ID: <1319079253.5380.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 17747103836
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 04:54:20 +0200 (CEST)
Received: by yxi13 with SMTP id 13so2351021yxi.38
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 19:54:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4671.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 41e3d55..de9ff66 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -168,18 +168,15 @@ static int ak4671_out2_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	u8 reg;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		reg = snd_soc_read(codec, AK4671_LOUT2_POWER_MANAGERMENT);
-		reg |= AK4671_MUTEN;
-		snd_soc_write(codec, AK4671_LOUT2_POWER_MANAGERMENT, reg);
+		snd_soc_update_bits(codec, AK4671_LOUT2_POWER_MANAGERMENT,
+				    AK4671_MUTEN, AK4671_MUTEN);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		reg = snd_soc_read(codec, AK4671_LOUT2_POWER_MANAGERMENT);
-		reg &= ~AK4671_MUTEN;
-		snd_soc_write(codec, AK4671_LOUT2_POWER_MANAGERMENT, reg);
+		snd_soc_update_bits(codec, AK4671_LOUT2_POWER_MANAGERMENT,
+				    AK4671_MUTEN, 0);
 		break;
 	}
 
@@ -575,15 +572,12 @@ static int ak4671_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int ak4671_set_bias_level(struct snd_soc_codec *codec,
 		enum snd_soc_bias_level level)
 {
-	u8 reg;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
-		reg = snd_soc_read(codec, AK4671_AD_DA_POWER_MANAGEMENT);
-		snd_soc_write(codec, AK4671_AD_DA_POWER_MANAGEMENT,
-				reg | AK4671_PMVCM);
+		snd_soc_update_bits(codec, AK4671_AD_DA_POWER_MANAGEMENT,
+				    AK4671_PMVCM, AK4671_PMVCM);
 		break;
 	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, AK4671_AD_DA_POWER_MANAGEMENT, 0x00);
-- 
1.7.5.4
