From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/3] ASoC: dapm: Add kcontrol support for
	PGAs
Date: Tue, 20 Oct 2015 22:30:06 +0530
Message-ID: <1445360408-3478-2-git-send-email-vinod.koul@intel.com>
References: <1445360408-3478-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F19F2665FF
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 18:57:03 +0200 (CEST)
In-Reply-To: <1445360408-3478-1-git-send-email-vinod.koul@intel.com>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Mythri P K <mythri.p.k@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

For DSPs we can define processing blocks as DAPM PGA widgets.
Some of these proceesing blocks can be configured by usermode
like EQ etc. So we need to add support of kcontrol for PGA
widgets.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-dapm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ff8bda471b25..8e64bea53aab 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -779,7 +779,7 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
  * Determine if a kcontrol is shared. If it is, look it up. If it isn't,
  * create it. Either way, add the widget into the control's widget list
  */
-static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
+static int dapm_create_or_share_kcontrol(struct snd_soc_dapm_widget *w,
 	int kci)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
@@ -810,6 +810,7 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 			switch (w->id) {
 			case snd_soc_dapm_switch:
 			case snd_soc_dapm_mixer:
+			case snd_soc_dapm_pga:
 				wname_in_long_name = true;
 				kcname_in_long_name = true;
 				break;
@@ -899,7 +900,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				continue;
 
 			if (!w->kcontrols[i]) {
-				ret = dapm_create_or_share_mixmux_kcontrol(w, i);
+				ret = dapm_create_or_share_kcontrol(w, i);
 				if (ret < 0)
 					return ret;
 			}
@@ -952,7 +953,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 		return -EINVAL;
 	}
 
-	ret = dapm_create_or_share_mixmux_kcontrol(w, 0);
+	ret = dapm_create_or_share_kcontrol(w, 0);
 	if (ret < 0)
 		return ret;
 
@@ -967,9 +968,13 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 /* create new dapm volume control */
 static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 {
-	if (w->num_kcontrols)
-		dev_err(w->dapm->dev,
-			"ASoC: PGA controls not supported: '%s'\n", w->name);
+	int i, ret;
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		ret = dapm_create_or_share_kcontrol(w, i);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
1.9.1
