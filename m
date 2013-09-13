From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: core: Only add platform DAI widgets once.
Date: Fri, 13 Sep 2013 18:09:45 +0100
Message-ID: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B0852608EC
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:10:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently platform CPU DAI widgets are created in soc_probe_platform and
soc_probe_link_dais. Remove the extra call in soc_probe_link_dais().

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8e86aba..09e341d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1365,7 +1365,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				return -ENODEV;
 
 			list_add(&cpu_dai->dapm.list, &card->dapm_list);
-			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
 		}
 
 		if (cpu_dai->driver->probe) {
-- 
1.8.1.2
