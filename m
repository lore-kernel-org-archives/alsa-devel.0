From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/7] ASoC i.MX phycore ac97: remove unnecessary
	includes
Date: Thu,  4 Nov 2010 17:05:41 +0100
Message-ID: <1288886745-25977-4-git-send-email-s.hauer@pengutronix.de>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CE5111038A4
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 17:05:48 +0100 (CET)
In-Reply-To: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/phycore-ac97.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index 6a65dd7..cf46a17 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -20,9 +20,6 @@
 #include <sound/soc-dapm.h>
 #include <asm/mach-types.h>
 
-#include "../codecs/wm9712.h"
-#include "imx-ssi.h"
-
 static struct snd_soc_card imx_phycore;
 
 static struct snd_soc_ops imx_phycore_hifi_ops = {
-- 
1.7.2.3
