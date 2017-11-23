From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ASoC: da7213: Delete an error message for a failed memory
 allocation in da7213_fw_to_pdata()
Date: Thu, 23 Nov 2017 18:32:40 +0100
Message-ID: <6dc71b14-4c14-82f6-9dad-92bfa9854de2@users.sourceforge.net>
References: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, support.opensource@diasemi.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 17:56:54 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/da7213.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 41d9b1da27c2..d1b77a0e3b74 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1654,10 +1654,8 @@ static struct da7213_platform_data
 	u32 fw_val32;
 
 	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_warn(codec->dev, "Failed to allocate memory for pdata\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	if (device_property_read_u32(dev, "dlg,micbias1-lvl", &fw_val32) >= 0)
 		pdata->micbias1_lvl = da7213_of_micbias_lvl(codec, fw_val32);
-- 
2.15.0
