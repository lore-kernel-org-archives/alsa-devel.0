From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Fix voltage units in dev_err
	message
Date: Wed, 28 Dec 2011 09:55:15 -0200
Message-ID: <1325073315-5021-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 625F5244F0
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 12:55:34 +0100 (CET)
Received: by ghbz2 with SMTP id z2so2671940ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 03:55:33 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

vdda, vddio and vddd are voltages expressed in milivolts (mV), so use the
proper annotation.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index bbcf921..c189663 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1077,7 +1077,7 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	/* according to datasheet, maximum voltage of supplies */
 	if (vdda > 3600 || vddio > 3600 || vddd > 1980) {
 		dev_err(codec->dev,
-			"exceed max voltage vdda %dmv vddio %dma vddd %dma\n",
+			"exceed max voltage vdda %dmV vddio %dmV vddd %dmV\n",
 			vdda, vddio, vddd);
 
 		return -EINVAL;
-- 
1.7.1
