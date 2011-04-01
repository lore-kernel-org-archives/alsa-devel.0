From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/2] ASoC: Name jack GPIOs based on jack not
	codec
Date: Fri,  1 Apr 2011 14:50:43 -0600
Message-ID: <1301691044-24080-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 93BD6103840
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Apr 2011 22:50:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_jack_gpio has a name field. Use that name when registering the IRQ,
since this is far more informative than the codec driver name. This shows
up in /proc/interrupts.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-jack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fcab80b..6203a72 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -325,7 +325,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 					      gpio_handler,
 					      IRQF_TRIGGER_RISING |
 					      IRQF_TRIGGER_FALLING,
-					      jack->codec->dev->driver->name,
+					      gpios[i].name,
 					      &gpios[i]);
 		if (ret)
 			goto err;
-- 
1.7.1
