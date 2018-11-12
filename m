From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Factor out common init code
Date: Mon, 12 Nov 2018 13:36:39 +0000
Message-ID: <20181112133639.13444-2-rf@opensource.cirrus.com>
References: <20181112133639.13444-1-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112133639.13444-1-rf@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

Factor out the duplicated initialization statements from
wm_adsp1_init() and wm_adsp2_init() into new function
wm_adsp_common_init().

The entire content of wm_adsp1_init() is the common code
but it is convenient to retain this exported function
to hide what we currently treat as common init (which might
change in the future) and also make clear the difference
between an ADSP1 entry point and common code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 66501b8dc46f..1dd291cebe67 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2419,7 +2419,7 @@ static int wm_adsp_create_name(struct wm_adsp *dsp)
 	return 0;
 }
 
-int wm_adsp1_init(struct wm_adsp *dsp)
+static int wm_adsp_common_init(struct wm_adsp *dsp)
 {
 	int ret;
 
@@ -2428,11 +2428,17 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 		return ret;
 
 	INIT_LIST_HEAD(&dsp->alg_regions);
+	INIT_LIST_HEAD(&dsp->ctl_list);
 
 	mutex_init(&dsp->pwr_lock);
 
 	return 0;
 }
+
+int wm_adsp1_init(struct wm_adsp *dsp)
+{
+	return wm_adsp_common_init(dsp);
+}
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
 
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
@@ -2917,7 +2923,7 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
 
-	ret = wm_adsp_create_name(dsp);
+	ret = wm_adsp_common_init(dsp);
 	if (ret)
 		return ret;
 
@@ -2939,12 +2945,8 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 		break;
 	}
 
-	INIT_LIST_HEAD(&dsp->alg_regions);
-	INIT_LIST_HEAD(&dsp->ctl_list);
 	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
-	mutex_init(&dsp->pwr_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
-- 
2.11.0
