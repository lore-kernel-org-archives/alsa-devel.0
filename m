From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ALSA: ASoC: ak4104: handle more sample
	rates
Date: Sun,  7 Oct 2012 17:51:23 +0200
Message-ID: <1349625084-15639-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D651C261608
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2012 17:51:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/ak4104.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 31d4483..d14163f 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -98,14 +98,32 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 	val = 0;
 
 	switch (params_rate(params)) {
+	case 22050:
+		val |= IEC958_AES3_CON_FS_22050;
+		break;
+	case 24000:
+		val |= IEC958_AES3_CON_FS_24000;
+		break;
+	case 32000:
+		val |= IEC958_AES3_CON_FS_32000;
+		break;
 	case 44100:
 		val |= IEC958_AES3_CON_FS_44100;
 		break;
 	case 48000:
 		val |= IEC958_AES3_CON_FS_48000;
 		break;
-	case 32000:
-		val |= IEC958_AES3_CON_FS_32000;
+	case 88200:
+		val |= IEC958_AES3_CON_FS_88200;
+		break;
+	case 96000:
+		val |= IEC958_AES3_CON_FS_96000;
+		break;
+	case 176400:
+		val |= IEC958_AES3_CON_FS_176400;
+		break;
+	case 192000:
+		val |= IEC958_AES3_CON_FS_192000;
 		break;
 	default:
 		dev_err(codec->dev, "unsupported sampling rate\n");
-- 
1.7.11.4
