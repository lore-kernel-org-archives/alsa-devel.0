From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric rates
Date: Thu, 30 Jul 2015 16:34:19 +0200
Message-ID: <55BA35EB.6020901@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

AC'97 bus can support asymmetric playback/capture rates
so enable them in this case in fsl_ssi driver.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a83b900..7f4f0b9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1377,7 +1377,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	/* Are the RX and the TX clocks locked? */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
-		ssi_private->cpu_dai_drv.symmetric_rates = 1;
+		if (!fsl_ssi_is_ac97(ssi_private))
+			ssi_private->cpu_dai_drv.symmetric_rates = 1;
+
 		ssi_private->cpu_dai_drv.symmetric_channels = 1;
 		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
 	}
