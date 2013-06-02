From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs: mxs-saif: Fix the playback/record
	capabilities
Date: Sun,  2 Jun 2013 13:38:12 -0300
Message-ID: <1370191092-1773-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 263BE2610B3
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2013 18:38:31 +0200 (CEST)
Received: by mail-qa0-f45.google.com with SMTP id o13so1380575qaj.4
 for <alsa-devel@alsa-project.org>; Sun, 02 Jun 2013 09:38:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Running "aplay -l" and "arecord -l" results in the following outputs:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

On mx28 there are two serial audio interface ports (SAIF0 and SAIF1) and each
one of them are unidirectional.

Create a mxs_saif_dai array containing a playback element and a record element
only in order to properly describe the dai links.

After this change we can correctly report the capabilities as follows:

$ aplay -l                                                      
**** List of PLAYBACK Hardware Devices ****                                     
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []       
  Subdevices: 1/1                                                               
  Subdevice #0: subdevice #0                                                    

$ arecord -l                                                    
**** List of CAPTURE Hardware Devices ****                                      
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []        
  Subdevices: 1/1                                                               
  Subdevice #0: subdevice #0                                                    

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This patch also needs:
"[PATCH] ASoC: pcm: Require both CODEC and CPU support when declaring stream caps"
from Mark Brown.

 sound/soc/mxs/mxs-saif.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 49d8700..7f3e67a 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -607,22 +607,28 @@ static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static struct snd_soc_dai_driver mxs_saif_dai = {
-	.name = "mxs-saif",
-	.probe = mxs_saif_dai_probe,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = MXS_SAIF_RATES,
-		.formats = MXS_SAIF_FORMATS,
+static struct snd_soc_dai_driver mxs_saif_dai[2] = {
+	{
+		.name = "saif0",
+		.probe = mxs_saif_dai_probe,
+		.playback = {
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = MXS_SAIF_RATES,
+			.formats = MXS_SAIF_FORMATS,
+		},
+		.ops = &mxs_saif_dai_ops,
+	}, {
+		.name = "saif1",
+		.probe = mxs_saif_dai_probe,
+		.capture = {
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = MXS_SAIF_RATES,
+			.formats = MXS_SAIF_FORMATS,
+		},
+		.ops = &mxs_saif_dai_ops,
 	},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = MXS_SAIF_RATES,
-		.formats = MXS_SAIF_FORMATS,
-	},
-	.ops = &mxs_saif_dai_ops,
 };
 
 static const struct snd_soc_component_driver mxs_saif_component = {
@@ -735,7 +741,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, saif);
 
 	ret = snd_soc_register_component(&pdev->dev, &mxs_saif_component,
-					 &mxs_saif_dai, 1);
+					 &mxs_saif_dai[saif->id], 1);
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
 		return ret;
-- 
1.8.1.2
