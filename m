From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
Date: Sat, 10 Mar 2018 23:11:58 +0100
Message-ID: <20180310221158.28422-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 93BCC267172
 for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2018 22:05:12 +0100 (CET)
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
Cc: syzkaller-bugs@googlegroups.com
List-Id: alsa-devel@alsa-project.org

snd_pcm_oss_get_formats() has an obvious UAF around snd_mask_test()
calls, as spotted by syzbot.  The passed format_mask argument is a
pointer to the hw_params object that is freed before the loop.
What a surprise that it has been present since the original code of
decades ago...

Reported-by: syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index b044c0a5a674..02298c9c6020 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1762,10 +1762,9 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss_file *pcm_oss_file)
 		return -ENOMEM;
 	_snd_pcm_hw_params_any(params);
 	err = snd_pcm_hw_refine(substream, params);
-	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	kfree(params);
 	if (err < 0)
-		return err;
+		goto error;
+	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt = 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
@@ -1773,7 +1772,10 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss_file *pcm_oss_file)
 				formats |= f;
 		}
 	}
-	return formats;
+
+ error:
+	kfree(params);
+	return err < 0 ? err : formats;
 }
 
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
-- 
2.16.2
