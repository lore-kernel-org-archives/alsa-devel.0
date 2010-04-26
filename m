From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH] ASoC: UDA134X: Add UDA1345 CODEC support
Date: Mon, 26 Apr 2010 14:56:57 +0400
Message-ID: <1272279417-6673-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D7CD1037F1
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 12:57:43 +0200 (CEST)
Received: by bwz20 with SMTP id 20so4625677bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 03:57:42 -0700 (PDT)
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

This patch adds support for Philips UDA1345 CODEC. The CODEC has only
volume control, de-emphasis, mute, DC filtering and power control features.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/uda134x.h    |    1 +
 sound/soc/codecs/uda134x.c |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/sound/uda134x.h b/include/sound/uda134x.h
index 475ef8b..509efb0 100644
--- a/include/sound/uda134x.h
+++ b/include/sound/uda134x.h
@@ -21,6 +21,7 @@ struct uda134x_platform_data {
 #define UDA134X_UDA1340 1
 #define UDA134X_UDA1341 2
 #define UDA134X_UDA1344 3
+#define UDA134X_UDA1345 4
 };
 
 #endif /* _UDA134X_H */
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 20deaca..2f4d728 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -431,6 +431,14 @@ SOC_ENUM("PCM Playback De-emphasis", uda134x_mixer_enum[1]),
 SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
 };
 
+static const struct snd_kcontrol_new uda1345_snd_controls[] = {
+SOC_SINGLE("Master Playback Volume", UDA134X_DATA000, 0, 0x3F, 1),
+
+SOC_ENUM("PCM Playback De-emphasis", uda134x_mixer_enum[1]),
+
+SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
+};
+
 static struct snd_soc_dai_ops uda134x_dai_ops = {
 	.startup	= uda134x_startup,
 	.shutdown	= uda134x_shutdown,
@@ -486,6 +494,7 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 	case UDA134X_UDA1340:
 	case UDA134X_UDA1341:
 	case UDA134X_UDA1344:
+	case UDA134X_UDA1345:
 		break;
 	default:
 		printk(KERN_ERR "UDA134X SoC codec: "
@@ -551,6 +560,10 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 		ret = snd_soc_add_controls(codec, uda1341_snd_controls,
 					ARRAY_SIZE(uda1341_snd_controls));
 	break;
+	case UDA134X_UDA1345:
+		ret = snd_soc_add_controls(codec, uda1345_snd_controls,
+					ARRAY_SIZE(uda1345_snd_controls));
+	break;
 	default:
 		printk(KERN_ERR "%s unknown codec type: %d",
 			__func__, pd->model);
-- 
1.7.0.4
