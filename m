From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ALSA: add a module alias to the FSI driver
Date: Fri, 15 Apr 2011 20:17:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This patch enables FSI driver autoloading on sh-mobile systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/sh/fsi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 0c9997e..88b669c 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1321,3 +1321,4 @@ module_exit(fsi_mobile_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip FSI audio driver");
 MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
+MODULE_ALIAS("platform:fsi-pcm-audio");
-- 
1.7.2.5

