From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 2/2] ASoC: Modifying the license string GPLv2
	for OMAP3 EVM
Date: Wed, 18 Nov 2009 18:09:14 +0530
Message-ID: <1258547954-13500-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 4559A2437C
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 13:39:19 +0100 (CET)
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
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Correcting the license string from GPLv2 -> GPL v2.
Found the problem while building OMAP3 ASoC driver as
module.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/omap3evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index 41a91b5..627fadb 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -144,4 +144,4 @@ module_exit(omap3evm_soc_exit);
 
 MODULE_AUTHOR("Anuj Aggarwal <anuj.aggarwal@ti.com>");
 MODULE_DESCRIPTION("ALSA SoC OMAP3 EVM");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
1.6.2.4
