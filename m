From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/3] ASoC: Revert "ASoC: ab8500: Inform SoC
	Core that we have our own I/O arrangements"
Date: Mon, 10 Sep 2012 13:10:09 -0300
Message-ID: <1347293410-23683-2-git-send-email-fabio.estevam@freescale.com>
References: <1347293410-23683-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id CDCFC2650F0
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 18:10:22 +0200 (CEST)
In-Reply-To: <1347293410-23683-1-git-send-email-fabio.estevam@freescale.com>
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
 sound/soc/codecs/ab8500-codec.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 3f46bff..2c1c252 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2404,9 +2404,6 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 	dev_dbg(dev, "%s: Enter.\n", __func__);
 
-	/* Inform SoC Core that we have our own I/O arrangements. */
-	codec->control_data = (void *)true;
-
 	/* Setup AB8500 according to board-settings */
 	pdata = dev_get_platdata(dev->parent);
 
-- 
1.7.9.5
