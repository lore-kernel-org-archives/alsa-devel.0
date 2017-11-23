From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] ASoC: twl4030: Delete an unnecessary
 variable initialisation in twl4030_get_pdata()
Date: Thu, 23 Nov 2017 22:12:09 +0100
Message-ID: <7fda4752-0546-b194-997e-0db5b673aeab@users.sourceforge.net>
References: <d2edbce1-ffce-9c18-3f50-baa0cdfb0152@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 74FB8266F1C
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 22:12:17 +0100 (CET)
In-Reply-To: <d2edbce1-ffce-9c18-3f50-baa0cdfb0152@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 21:54:10 +0100

The variable "twl4030_codec_node" will be reassigned by
a following statement.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/twl4030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 946818a0412c..3ea6117beceb 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -230,7 +230,7 @@ static void twl4030_setup_pdata_of(struct twl4030_codec_data *pdata,
 static struct twl4030_codec_data *twl4030_get_pdata(struct snd_soc_codec *codec)
 {
 	struct twl4030_codec_data *pdata = dev_get_platdata(codec->dev);
-	struct device_node *twl4030_codec_node = NULL;
+	struct device_node *twl4030_codec_node;
 
 	twl4030_codec_node = of_get_child_by_name(codec->dev->parent->of_node,
 						  "codec");
-- 
2.15.0
