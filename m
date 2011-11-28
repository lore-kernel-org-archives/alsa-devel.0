From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Convert tegra_spdif to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 18:55:03 +0800
Message-ID: <1322477703.1939.4.camel@phoenix>
References: <1322477637.1939.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5C44A243D8
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 11:55:10 +0100 (CET)
Received: by yws1 with SMTP id 1so2380302yws.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 02:55:09 -0800 (PST)
In-Reply-To: <1322477637.1939.3.camel@phoenix>
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
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the module_platform_driver() macro which makes
the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/tegra/tegra_spdif.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/sound/soc/tegra/tegra_spdif.c b/sound/soc/tegra/tegra_spdif.c
index ea9c920..475428c 100644
--- a/sound/soc/tegra/tegra_spdif.c
+++ b/sound/soc/tegra/tegra_spdif.c
@@ -352,17 +352,7 @@ static struct platform_driver tegra_spdif_driver = {
 	.remove = __devexit_p(tegra_spdif_platform_remove),
 };
 
-static int __init snd_tegra_spdif_init(void)
-{
-	return platform_driver_register(&tegra_spdif_driver);
-}
-module_init(snd_tegra_spdif_init);
-
-static void __exit snd_tegra_spdif_exit(void)
-{
-	platform_driver_unregister(&tegra_spdif_driver);
-}
-module_exit(snd_tegra_spdif_exit);
+module_platform_driver(tegra_spdif_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra SPDIF ASoC driver");
-- 
1.7.5.4
