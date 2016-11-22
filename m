From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Remove unused wm_coeff_ctl.kcontrol
Date: Tue, 22 Nov 2016 16:58:56 +0000
Message-ID: <1479833937-5238-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The kcontrol pointer in wm_coeff_ctl is not used now.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6ccb731..7698273 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -451,7 +451,6 @@ struct wm_coeff_ctl {
 	unsigned int offset;
 	size_t len;
 	unsigned int set:1;
-	struct snd_kcontrol *kcontrol;
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
 	unsigned int type;
@@ -1138,8 +1137,6 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 
 	kfree(kcontrol);
 
-	ctl->kcontrol = snd_soc_card_get_kcontrol(dsp->card, ctl->name);
-
 	return 0;
 
 err_kcontrol:
-- 
1.9.1
