From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Remove duplicate set of kcontrol->iface
Date: Mon, 3 Oct 2016 11:40:38 +0100
Message-ID: <1475491238-11834-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b943dde..7320fca 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -962,17 +962,16 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 	int ret;
 
 	if (!ctl || !ctl->name)
 		return -EINVAL;
 
 	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
 	if (!kcontrol)
 		return -ENOMEM;
-	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 
 	kcontrol->name = ctl->name;
 	kcontrol->info = wm_coeff_info;
 	kcontrol->get = wm_coeff_get;
 	kcontrol->put = wm_coeff_put;
 	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	kcontrol->tlv.c = snd_soc_bytes_tlv_callback;
 	kcontrol->private_value = (unsigned long)&ctl->bytes_ext;
-- 
1.9.1
