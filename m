From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] ASoC: bt-sco: support wide band speech
Date: Wed, 26 Nov 2014 13:08:58 +0800
Message-ID: <1416978538-3318-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id AA4A3261A40
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 06:11:22 +0100 (CET)
Received: by mail-pa0-f52.google.com with SMTP id eu11so2076530pac.25
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 21:11:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Yibo Cai <Yibo.Cai@csr.com>, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

From: Yibo Cai <Yibo.Cai@csr.com>

HFP1.6 requires support for wide band speech(16KHz) over Bluetooth.

Signed-off-by: Yibo Cai <Yibo.Cai@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/bt-sco.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index c4cf069..3878491 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -52,6 +52,14 @@ static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
 
 static int bt_sco_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+
+	/* Check wide band SCO(16KHz) support */
+	if (id && (strcmp(id->name, "bt-sco-wb") == 0)) {
+		bt_sco_dai.playback.rates |= SNDRV_PCM_RATE_16000;
+		bt_sco_dai.capture.rates |= SNDRV_PCM_RATE_16000;
+	}
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_bt_sco,
 			&bt_sco_dai, 1);
 }
@@ -70,6 +78,9 @@ static struct platform_device_id bt_sco_driver_ids[] = {
 	{
 		.name		= "bt-sco",
 	},
+	{
+		.name		= "bt-sco-wb",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
-- 
2.1.3
