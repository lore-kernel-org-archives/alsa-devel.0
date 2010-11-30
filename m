From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix compile error for s6000-i2s.c by adding a
	missing ';' character
Date: Tue, 30 Nov 2010 09:45:53 +0800
Message-ID: <1291081553.18485.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: dg@emlix.com, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I don't have toolchain to compile s6000, I'm not able to put the error message in the commit log.
But I know this patch indeed fixes a compile error.

 sound/soc/s6000/s6000-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index 8778faa..3052f64 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -434,7 +434,7 @@ static struct snd_soc_dai_driver s6000_i2s_dai = {
 		.rate_max = 1562500,
 	},
 	.ops = &s6000_i2s_dai_ops,
-}
+};
 
 static int __devinit s6000_i2s_probe(struct platform_device *pdev)
 {
-- 
1.7.2
