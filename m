From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 2/4] ASoC: when removing a CPU DAI,
	clean up its DAPM context
Date: Fri,  8 Jun 2012 12:34:21 -0600
Message-ID: <1339180463-21178-2-git-send-email-swarren@wwwdotorg.org>
References: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B250F103E6F
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 20:34:31 +0200 (CEST)
In-Reply-To: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

When a standalone CPU DAI (one not part of a CODEC) is probed, widgets
are created for it. Add a call to snd_soc_dapm_free() in order to clean
these up when the CPU DAI is removed.

In order for snd_soc_dapm_free() to work, the CPU DAI's DAPM context's
list member must be initialized, since snd_soc_dapm_free() removes that
from the list it's part of. Add it to the card's list of DAPM contexts.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 448d4a7..621c5bd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -984,8 +984,10 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 		cpu_dai->probed = 0;
 		list_del(&cpu_dai->card_list);
 
-		if (!cpu_dai->codec)
+		if (!cpu_dai->codec) {
+			snd_soc_dapm_free(&cpu_dai->dapm);
 			module_put(cpu_dai->dev->driver->owner);
+		}
 	}
 }
 
@@ -1264,6 +1266,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 			if (!try_module_get(cpu_dai->dev->driver->owner))
 				return -ENODEV;
 
+			list_add(&cpu_dai->dapm.list, &card->dapm_list);
 			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
 		}
 
-- 
1.7.0.4
