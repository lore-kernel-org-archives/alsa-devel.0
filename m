From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: wm-adsp: Add missing MODULE_LICENSE
Date: Fri,  4 Jul 2014 11:17:41 +0530
Message-ID: <1404452861-8951-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1832B265976
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 07:49:08 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Praveen Diwakar <praveen.diwakar@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Praveen Diwakar <praveen.diwakar@intel.com>

Since MODULE_LICENSE is missing the module load fails,
so add this for module.

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
---
 sound/soc/codecs/wm_adsp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0600271..2537725 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1758,3 +1758,5 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
+
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4
