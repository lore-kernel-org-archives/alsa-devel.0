From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Remove unused member of struct wm_coeff_ctl_ops
Date: Wed, 24 May 2017 10:59:39 +0100
Message-ID: <1495619979-3620-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1495619979-3620-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495619979-3620-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The xinfo member of struct wm_coeff_ctl_ops is never used.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a7dc760..5aff83b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -482,8 +482,6 @@ struct wm_coeff_ctl_ops {
 		    struct snd_ctl_elem_value *ucontrol);
 	int (*xput)(struct snd_kcontrol *kcontrol,
 		    struct snd_ctl_elem_value *ucontrol);
-	int (*xinfo)(struct snd_kcontrol *kcontrol,
-		     struct snd_ctl_elem_info *uinfo);
 };
 
 struct wm_coeff_ctl {
-- 
1.9.1
