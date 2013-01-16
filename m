From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] ASoC: fsi: Remove __devinitconst
Date: Wed, 16 Jan 2013 12:09:45 +0100
Message-ID: <1358334585-25046-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

__devinitconst and friends have recently been removed and must not be
used anymore.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 sound/soc/sh/fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 9157612..c724026 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -2160,7 +2160,7 @@ static struct fsi_core fsi2_core = {
 	.b_mclk	= B_MST_CTLR,
 };
 
-static struct of_device_id fsi_of_match[] __devinitconst = {
+static struct of_device_id fsi_of_match[] = {
 	{ .compatible = "renesas,sh_fsi",	.data = &fsi1_core},
 	{ .compatible = "renesas,sh_fsi2",	.data = &fsi2_core},
 	{},
-- 
1.8.1
