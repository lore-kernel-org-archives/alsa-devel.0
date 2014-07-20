From: weiyj_lk@163.com
Subject: [PATCH -next] ALSA: bebob: Fix missing unlock on error in special_clk_ctl_put()
Date: Sun, 20 Jul 2014 12:50:35 +0800
Message-ID: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock before return from function special_clk_ctl_put()
in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/firewire/bebob/bebob_maudio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 6af50eb..6748515 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -382,8 +382,10 @@ static int special_clk_ctl_put(struct snd_kcontrol *kctl,
 	mutex_lock(&bebob->mutex);
 
 	id = uval->value.enumerated.item[0];
-	if (id >= ARRAY_SIZE(special_clk_labels))
+	if (id >= ARRAY_SIZE(special_clk_labels)) {
+		mutex_unlock(&bebob->mutex);
 		return 0;
+	}
 
 	err = avc_maudio_set_special_clk(bebob, id,
 					 params->dig_in_fmt,
