From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Set sgtl5000->ldo in
	ldo_regulator_register
Date: Thu, 20 Oct 2011 18:32:59 +0800
Message-ID: <1319106779.8866.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D775E244ED
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 12:33:14 +0200 (CEST)
Received: by gyg8 with SMTP id 8so2806646gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2011 03:33:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Otherwise calling ldo_regulator_remove() does not unregister regulator
and free memories.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sgtl5000.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 3637a62..8395002 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -806,6 +806,7 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 				int voltage)
 {
 	struct ldo_regulator *ldo;
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
 	ldo = kzalloc(sizeof(struct ldo_regulator), GFP_KERNEL);
 
@@ -840,6 +841,7 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 
 		return ret;
 	}
+	sgtl5000->ldo = ldo;
 
 	return 0;
 }
-- 
1.7.5.4
