From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Use core pm_runtime callbacks for fsi
Date: Mon,  5 Dec 2011 00:01:31 +0000
Message-ID: <1323043291-6797-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADA481039E4
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 01:01:36 +0100 (CET)
In-Reply-To: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that the core holds a pm_runtime reference to the device while the
link is active there is no need for the driver to do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/sh/fsi.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index a27c306..db6c89a 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -893,8 +893,6 @@ static int fsi_hw_startup(struct fsi_priv *fsi,
 	u32 flags = fsi_get_info_flags(fsi);
 	u32 data = 0;
 
-	pm_runtime_get_sync(dev);
-
 	/* clock setting */
 	if (fsi_is_clk_master(fsi))
 		data = DIMD | DOMD;
@@ -951,8 +949,6 @@ static void fsi_hw_shutdown(struct fsi_priv *fsi,
 {
 	if (fsi_is_clk_master(fsi))
 		fsi_set_master_clk(dev, fsi, fsi->rate, 0);
-
-	pm_runtime_put_sync(dev);
 }
 
 static int fsi_dai_startup(struct snd_pcm_substream *substream,
-- 
1.7.7.3
