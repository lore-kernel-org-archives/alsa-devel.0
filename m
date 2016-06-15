From: jeeja.kp@intel.com
Subject: [PATCH] ASoC: dapm: Fix to return correct path list in
	is_connected_ep.
Date: Wed, 15 Jun 2016 11:16:55 +0530
Message-ID: <1465969615-29573-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A9B2651EB
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 07:40:24 +0200 (CEST)
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
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

In is_connected_ep, when custom_stop_condition is true, need to
return the correct paths instead of con which is 0.

Fixes: 6742064aef7f('ASoC: dapm: support user-defined stop condition in dai_get_connected_widgets')
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-dapm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index db781f6..3c3f027 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1092,8 +1092,10 @@ static __always_inline int is_connected_ep(struct snd_soc_dapm_widget *widget,
 	if (list)
 		list_add_tail(&widget->work_list, list);
 
-	if (custom_stop_condition && custom_stop_condition(widget, dir))
-		return con;
+	if (custom_stop_condition && custom_stop_condition(widget, dir)) {
+		widget->endpoints[dir] = 1;
+		return widget->endpoints[dir];
+	}
 
 	if ((widget->is_ep & SND_SOC_DAPM_DIR_TO_EP(dir)) && widget->connected) {
 		widget->endpoints[dir] = snd_soc_dapm_suspend_check(widget);
-- 
2.5.0
