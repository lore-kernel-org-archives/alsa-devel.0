From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH 2/2 v2] ASoC: uda134x: correct bias level setup
	for codecs family
Date: Thu, 24 Jun 2010 17:19:25 +0400
Message-ID: <1277385565-30727-1-git-send-email-vzapolskiy@gmail.com>
References: <1277378228-29658-2-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B2AF10381B
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 15:19:59 +0200 (CEST)
Received: by bwz11 with SMTP id 11so132262bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 06:19:59 -0700 (PDT)
In-Reply-To: <1277378228-29658-2-git-send-email-vzapolskiy@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

For UDA1341 codec power control is managed in STATUS1 register, and
for all other codecs in DATA011 register.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 sound/soc/codecs/uda134x.c |   36 ++++++++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index e770029..e8066b6 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -353,8 +353,22 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* ADC, DAC on */
-		reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
-		uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
+		switch (pd->model) {
+		case UDA134X_UDA1340:
+		case UDA134X_UDA1344:
+		case UDA134X_UDA1345:
+			reg = uda134x_read_reg_cache(codec, UDA134X_DATA011);
+			uda134x_write(codec, UDA134X_DATA011, reg | 0x03);
+			break;
+		case UDA134X_UDA1341:
+			reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
+			uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
+			break;
+		default:
+			printk(KERN_ERR "UDA134X SoC codec: "
+			       "unsupported model %d\n", pd->model);
+			return -EINVAL;
+		}
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* power on */
@@ -367,8 +381,22 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* ADC, DAC power off */
-		reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
-		uda134x_write(codec, UDA134X_STATUS1, reg & ~(0x03));
+		switch (pd->model) {
+		case UDA134X_UDA1340:
+		case UDA134X_UDA1344:
+		case UDA134X_UDA1345:
+			reg = uda134x_read_reg_cache(codec, UDA134X_DATA011);
+			uda134x_write(codec, UDA134X_DATA011, reg & ~(0x03));
+			break;
+		case UDA134X_UDA1341:
+			reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
+			uda134x_write(codec, UDA134X_STATUS1, reg & ~(0x03));
+			break;
+		default:
+			printk(KERN_ERR "UDA134X SoC codec: "
+			       "unsupported model %d\n", pd->model);
+			return -EINVAL;
+		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* power off */
-- 
1.7.0.4
