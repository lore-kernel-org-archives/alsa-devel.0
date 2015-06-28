From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 5/6] ASoC: fsl_ssi: instantiate AC'97 CODEC
Date: Sun, 28 Jun 2015 15:48:37 +0200
Message-ID: <558FFB35.8000105@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Instantiate AC'97 CODEC in fsl_ssi driver AC'97 mode.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0b4fcd9..e79dc16 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1460,6 +1460,27 @@ done:
 		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
 				     ssi_private->dai_fmt);
 
+	if (fsl_ssi_is_ac97(ssi_private)) {
+		u32 ssi_idx;
+
+		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
+		if (ret) {
+			dev_err(&pdev->dev, "cannot get SSI index property\n");
+			goto error_sound_card;
+		}
+
+		ssi_private->pdev =
+			platform_device_register_data(NULL,
+					"ac97-codec", ssi_idx, NULL, 0);
+		if (IS_ERR(ssi_private->pdev)) {
+			ret = PTR_ERR(ssi_private->pdev);
+			dev_err(&pdev->dev,
+				"failed to register AC97 codec platform: %d\n",
+				ret);
+			goto error_sound_card;
+		}
+	}
+
 	return 0;
 
 error_sound_card:
