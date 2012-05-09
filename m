From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: sh: fix migor.c compilation
Date: Wed, 9 May 2012 12:57:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205091255190.8599@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix a recent compilation breakage, caused by a change in SH clock API.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/sh/migor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 9d9ad8d..8526e1e 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -35,7 +35,7 @@ static unsigned long siumckb_recalc(struct clk *clk)
 	return codec_freq;
 }
 
-static struct clk_ops siumckb_clk_ops = {
+static struct sh_clk_ops siumckb_clk_ops = {
 	.recalc = siumckb_recalc,
 };
 
-- 
1.7.2.5

