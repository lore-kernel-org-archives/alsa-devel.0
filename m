From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: mxs-sgtl5000: Remove unneeded fields
	from snd_soc_dai_link
Date: Wed, 24 Apr 2013 13:23:15 -0300
Message-ID: <1366820595-19762-2-git-send-email-festevam@gmail.com>
References: <1366820595-19762-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f169.google.com (mail-gg0-f169.google.com
 [209.85.161.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BFC0261698
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 18:23:27 +0200 (CEST)
Received: by mail-gg0-f169.google.com with SMTP id h3so279798gge.14
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 09:23:27 -0700 (PDT)
In-Reply-To: <1366820595-19762-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

It makes no sense to hardcode the I2C bus into the codec_name field.

cpu_dai_name and platform_name are also overwritten later in 
mxs_sgtl5000_probe_dt().

So remove the three fields, as mxs platform is dt-only platform.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-sgtl5000.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 4f74b05..1b134d7 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -90,17 +90,11 @@ static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 		.name		= "HiFi Tx",
 		.stream_name	= "HiFi Playback",
 		.codec_dai_name	= "sgtl5000",
-		.codec_name	= "sgtl5000.0-000a",
-		.cpu_dai_name	= "mxs-saif.0",
-		.platform_name	= "mxs-saif.0",
 		.ops		= &mxs_sgtl5000_hifi_ops,
 	}, {
 		.name		= "HiFi Rx",
 		.stream_name	= "HiFi Capture",
 		.codec_dai_name	= "sgtl5000",
-		.codec_name	= "sgtl5000.0-000a",
-		.cpu_dai_name	= "mxs-saif.1",
-		.platform_name	= "mxs-saif.1",
 		.ops		= &mxs_sgtl5000_hifi_ops,
 	},
 };
-- 
1.7.9.5
