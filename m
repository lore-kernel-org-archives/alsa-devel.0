From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] imx-ssi: increase minimum periods to 4
Date: Tue, 13 Apr 2010 16:38:09 +0200
Message-ID: <1271169489-339-3-git-send-email-s.hauer@pengutronix.de>
References: <1271169489-339-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C82531037F7
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 16:38:13 +0200 (CEST)
In-Reply-To: <1271169489-339-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

Currently the notification of elapsed periods is not very exact.
Increase minimum periods to 4.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-pcm-fiq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 4b694d5..ecec332 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -179,7 +179,7 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 16 * 1024,
-	.periods_min = 2,
+	.periods_min = 4,
 	.periods_max = 255,
 	.fifo_size = 0,
 };
-- 
1.7.0
