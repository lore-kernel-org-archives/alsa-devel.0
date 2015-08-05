From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 3/6][RESEND] ASoC: fsl_ssi: enable AC'97
	asymmetric rates
Date: Wed, 05 Aug 2015 17:24:10 +0200
Message-ID: <55C22A9A.2080007@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 77ED9265E04
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 17:24:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

AC'97 bus can support asymmetric playback/capture rates
so enable them in this case in fsl_ssi driver.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
This is a resend without changes, to keep the whole series
together.

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
