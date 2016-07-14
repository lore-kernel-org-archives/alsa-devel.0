From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 26/34] conf: remove alloca() from
	snd_func_pcm_id()
Date: Thu, 14 Jul 2016 23:07:43 +0900
Message-ID: <1468505271-5769-27-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id D477B2664FB
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:09 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both of alloca() and automatic variables keeps storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/confmisc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/confmisc.c b/src/confmisc.c
index fd10b34..2275ccd 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -969,7 +969,7 @@ int snd_func_pcm_id(snd_config_t **dst, snd_config_t *root, snd_config_t *src, v
 {
 	snd_config_t *n;
 	snd_ctl_t *ctl = NULL;
-	snd_pcm_info_t *info;
+	snd_pcm_info_t info = {0};
 	const char *id;
 	long card, device, subdevice = 0;
 	int err;
@@ -1009,17 +1009,17 @@ int snd_func_pcm_id(snd_config_t **dst, snd_config_t *root, snd_config_t *src, v
 		SNDERR("could not open control for card %li", card);
 		goto __error;
 	}
-	snd_pcm_info_alloca(&info);
-	snd_pcm_info_set_device(info, device);
-	snd_pcm_info_set_subdevice(info, subdevice);
-	err = snd_ctl_pcm_info(ctl, info);
+	snd_pcm_info_set_device(&info, device);
+	snd_pcm_info_set_subdevice(&info, subdevice);
+	err = snd_ctl_pcm_info(ctl, &info);
 	if (err < 0) {
 		SNDERR("snd_ctl_pcm_info error: %s", snd_strerror(err));
 		goto __error;
 	}
 	err = snd_config_get_id(src, &id);
 	if (err >= 0)
-		err = snd_config_imake_string(dst, id, snd_pcm_info_get_id(info));
+		err = snd_config_imake_string(dst, id,
+						snd_pcm_info_get_id(&info));
       __error:
       	if (ctl)
       		snd_ctl_close(ctl);
-- 
2.7.4
