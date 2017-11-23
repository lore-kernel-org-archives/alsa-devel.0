From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] ASoC: twl4030: Improve a size
 determination in two functions
Date: Thu, 23 Nov 2017 22:11:11 +0100
Message-ID: <a26b98ae-532e-4490-098a-7f8592bc32bd@users.sourceforge.net>
References: <d2edbce1-ffce-9c18-3f50-baa0cdfb0152@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 44077266F1C
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 22:11:18 +0100 (CET)
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
Date: Thu, 23 Nov 2017 21:45:55 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/twl4030.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index a1f0b45c83ca..946818a0412c 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -236,9 +236,7 @@ static struct twl4030_codec_data *twl4030_get_pdata(struct snd_soc_codec *codec)
 						  "codec");
 
 	if (!pdata && twl4030_codec_node) {
-		pdata = devm_kzalloc(codec->dev,
-				     sizeof(struct twl4030_codec_data),
-				     GFP_KERNEL);
+		pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
 		if (!pdata)
 			goto put_node;
 
@@ -2168,8 +2166,7 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 {
 	struct twl4030_priv *twl4030;
 
-	twl4030 = devm_kzalloc(codec->dev, sizeof(struct twl4030_priv),
-			       GFP_KERNEL);
+	twl4030 = devm_kzalloc(codec->dev, sizeof(*twl4030), GFP_KERNEL);
 	if (!twl4030)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, twl4030);
-- 
2.15.0
