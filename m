From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Flag the i.MX SSI driver as using
	symmetric rates
Date: Fri,  8 Jan 2010 16:19:58 +0000
Message-ID: <1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 385C810384E
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 17:20:02 +0100 (CET)
In-Reply-To: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

While the hardware is fully asymmetric the driver currently forces
a symmetric configuration so flag that up in the capabilities to
avoid breakage - when the driver is able to do symmetry the flag
can be dropped.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/imx/imx-ssi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index ccb7ec9..cfaf715 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -357,6 +357,8 @@ static struct snd_soc_dai imx_ssi_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = &imx_ssi_pcm_dai_ops,
+	/* Hardware is asymmetric but the driver isn't yet */
+	.symmetric_rates = 1,
 };
 
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
-- 
1.6.6
