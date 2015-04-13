From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 05/13] ASoC: wm_adsp: Move temporary control
	name to the stack
Date: Mon, 13 Apr 2015 13:27:57 +0100
Message-ID: <1428928085-20250-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5672A2650FE
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:06 +0200 (CEST)
In-Reply-To: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Now we only allocate 44 bytes for the control name keep it on the stack
to avoid a lot of pointless memory allocation.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c291203..6c4f013 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -785,14 +785,10 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
-	char *name;
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	char *region_name;
 	int ret;
 
-	name = kmalloc(SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
-	if (!name)
-		return -ENOMEM;
-
 	switch (alg_region->type) {
 	case WMFW_ADSP1_PM:
 		region_name = "PM";
@@ -810,8 +806,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		region_name = "ZM";
 		break;
 	default:
-		ret = -EINVAL;
-		goto err_name;
+		return -EINVAL;
 	}
 
 	snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "DSP%d %s %x",
@@ -822,15 +817,13 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		if (!strcmp(ctl->name, name)) {
 			if (!ctl->enabled)
 				ctl->enabled = 1;
-			goto found;
+			return 0;
 		}
 	}
 
 	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
-	if (!ctl) {
-		ret = -ENOMEM;
-		goto err_name;
-	}
+	if (!ctl)
+		return -ENOMEM;
 	ctl->alg_region = *alg_region;
 	ctl->name = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
 	if (!ctl->name) {
@@ -866,9 +859,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
 	schedule_work(&ctl_work->work);
 
-found:
-	kfree(name);
-
 	return 0;
 
 err_ctl_cache:
@@ -877,8 +867,7 @@ err_ctl_name:
 	kfree(ctl->name);
 err_ctl:
 	kfree(ctl);
-err_name:
-	kfree(name);
+
 	return ret;
 }
 
-- 
1.7.2.5
