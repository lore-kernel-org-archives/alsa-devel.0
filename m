From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/3] ASoC: Revert "ASoC: mc13783: Provide
	codec->control_data"
Date: Mon, 10 Sep 2012 13:10:08 -0300
Message-ID: <1347293410-23683-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 59D0C2650F0
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 18:10:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, manuel.lauss@googlemail.com, lee.jones@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since commit 98d3088e5 (SoC: core: Fix check before defaulting to regmap)
, it is not necessary to provide codec->control_data anymore.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/mc13783.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 8def29a..bc95599 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -585,8 +585,6 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
 
-	codec->control_data = priv->mc13xxx;
-
 	mc13xxx_lock(priv->mc13xxx);
 
 	/* these are the reset values */
-- 
1.7.9.5
