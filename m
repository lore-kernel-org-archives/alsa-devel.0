From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/3] ASoC: sgtl5000: guide user when regulator
	support is needed
Date: Mon, 18 Jul 2011 17:53:04 +0200
Message-ID: <1311004385-14554-3-git-send-email-w.sang@pengutronix.de>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 67E1D2467A
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 17:53:15 +0200 (CEST)
In-Reply-To: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Print a hint when the user has a setup where CONFIG_REGULATOR is really
needed to make the driver work.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dong Aisheng <b29396@freescale.com>
Cc: Zeng Zhaoming <b32542@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sgtl5000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 17af336..76258f2 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -907,6 +907,7 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 				struct regulator_init_data *init_data,
 				int voltage)
 {
+	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
 	return -EINVAL;
 }
 
-- 
1.7.5.4
