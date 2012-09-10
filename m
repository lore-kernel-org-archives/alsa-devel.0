From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 1/2] ASoC: core: display the platform node name
	if there is no platform name
Date: Mon, 10 Sep 2012 17:02:55 -0500
Message-ID: <1347314576-13832-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id D1B2826514E
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 00:03:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A platform can be matched by either a string name or a device tree node
pointer, so we can't assume that dai_link->platform_name is valid.  Fix
an error message in soc_bind_dai_link() to use the device tree node
name if the platform name is null.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/soc-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad65459..d81ef5b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -897,7 +897,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	}
 	if (!rtd->platform) {
 		dev_err(card->dev, "platform %s not registered\n",
-			dai_link->platform_name);
+			dai_link->platform_name ? :
+				dai_link->platform_of_node->full_name);
 		return -EPROBE_DEFER;
 	}
 
-- 
1.7.3.4
