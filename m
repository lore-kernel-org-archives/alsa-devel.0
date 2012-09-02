From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ALSA: fix possible memory leak in snd_mixer_oss_build_input()
Date: Sun, 2 Sep 2012 22:10:27 +0800
Message-ID: <CAPgLHd8PAEMY8zan8v+DTrPpyid4Lbnr4LsNvWoZqi4r5opTaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

uinfo has been allocated in this function and should be
freed before leaving from the error handling cases.

spatch with a semantic match is used to found this problem.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/core/oss/mixer_oss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 18297f7..29f6ded 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1046,6 +1046,7 @@ static int snd_mixer_oss_build_input(struct snd_mixer_oss *mixer, struct snd_mix
 			
 		if (kctl->info(kctl, uinfo)) {
 			up_read(&mixer->card->controls_rwsem);
+			kfree(uinfo);
 			return 0;
 		}
 		strcpy(str, ptr->name);
@@ -1061,6 +1062,7 @@ static int snd_mixer_oss_build_input(struct snd_mixer_oss *mixer, struct snd_mix
 				uinfo->value.enumerated.item = slot.capture_item;
 				if (kctl->info(kctl, uinfo)) {
 					up_read(&mixer->card->controls_rwsem);
+					kfree(uinfo);
 					return 0;
 				}
 				if (!strcmp(uinfo->value.enumerated.name, str)) {
