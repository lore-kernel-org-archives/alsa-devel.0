From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Subject: [PATCH v2 1/3] ASoC: Intel: board: Remove .owner
	initialization in bxt_rt298 driver
Date: Thu, 20 Jul 2017 11:40:55 +0530
Message-ID: <1500531057-4286-2-git-send-email-pradeep.d.tewani@intel.com>
References: <1500531057-4286-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C68FD2673B5
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 08:13:07 +0200 (CEST)
In-Reply-To: <1500531057-4286-1-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com, Pradeep Tewani <pradeep.d.tewani@intel.com>
List-Id: alsa-devel@alsa-project.org

The .owner field is not required to be initialized in the driver. So,
remove it.

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 0c3a3cb..1daf98e 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -492,7 +492,6 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 /* broxton audio machine driver for SPT + RT298S */
 static struct snd_soc_card broxton_rt298 = {
 	.name = "broxton-rt298",
-	.owner = THIS_MODULE,
 	.dai_link = broxton_rt298_dais,
 	.num_links = ARRAY_SIZE(broxton_rt298_dais),
 	.controls = broxton_controls,
-- 
2.7.4
