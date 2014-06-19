From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: sh/fsi: Make one-bit bitfields
	unsigned
Date: Thu, 19 Jun 2014 09:40:31 +0200
Message-ID: <1403163631-26215-6-git-send-email-lars@metafoo.de>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 07CEF265292
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 09:40:47 +0200 (CEST)
In-Reply-To: <1403163631-26215-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

One-bit signed bitfields have two possible values: 0 and -1. This sometimes
leads to unexpected results (e.g. foo.bar = 1; foo.bar == 1 => false) which is
why it is recommended to make one-bit bitfields unsigned.

This fixes the following sparse warnings:
	sound/soc/sh/fsi.c:267:25: error: dubious one-bit signed bitfield
	sound/soc/sh/fsi.c:268:22: error: dubious one-bit signed bitfield
	sound/soc/sh/fsi.c:269:20: error: dubious one-bit signed bitfield
	sound/soc/sh/fsi.c:270:28: error: dubious one-bit signed bitfield
	sound/soc/sh/fsi.c:271:26: error: dubious one-bit signed bitfield
	sound/soc/sh/fsi.c:272:25: error: dubious one-bit signed bitfield

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/fsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 710a079..2c95d85 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -264,12 +264,12 @@ struct fsi_priv {
 	u32 fmt;
 
 	int chan_num:16;
-	int clk_master:1;
-	int clk_cpg:1;
-	int spdif:1;
-	int enable_stream:1;
-	int bit_clk_inv:1;
-	int lr_clk_inv:1;
+	unsigned int clk_master:1;
+	unsigned int clk_cpg:1;
+	unsigned int spdif:1;
+	unsigned int enable_stream:1;
+	unsigned int bit_clk_inv:1;
+	unsigned int lr_clk_inv:1;
 };
 
 struct fsi_stream_handler {
-- 
1.8.0
