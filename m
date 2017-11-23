From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] ASoC: twl4030: Use common error handling
 code in twl4030_get_pdata()
Date: Thu, 23 Nov 2017 22:10:16 +0100
Message-ID: <54fbbfe9-ee59-c346-e22a-f059e1f2552f@users.sourceforge.net>
References: <d2edbce1-ffce-9c18-3f50-baa0cdfb0152@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 03267266F1C
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 22:10:25 +0100 (CET)
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
Date: Thu, 23 Nov 2017 21:35:28 +0100

Add a jump target so that a bit of exception handling can be better reused
in an if branch of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/twl4030.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 90691701b082..a1f0b45c83ca 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -239,11 +239,11 @@ static struct twl4030_codec_data *twl4030_get_pdata(struct snd_soc_codec *codec)
 		pdata = devm_kzalloc(codec->dev,
 				     sizeof(struct twl4030_codec_data),
 				     GFP_KERNEL);
-		if (!pdata) {
-			of_node_put(twl4030_codec_node);
-			return NULL;
-		}
+		if (!pdata)
+			goto put_node;
+
 		twl4030_setup_pdata_of(pdata, twl4030_codec_node);
+put_node:
 		of_node_put(twl4030_codec_node);
 	}
 
-- 
2.15.0
