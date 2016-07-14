From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 27/34] conf: remove alloca() from
	snd_func_pcm_args_by_class()
Date: Thu, 14 Jul 2016 23:07:44 +0900
Message-ID: <1468505271-5769-28-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 4B7EF2659FE
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
 src/confmisc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/confmisc.c b/src/confmisc.c
index 2275ccd..99be48b 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -1053,7 +1053,7 @@ int snd_func_pcm_args_by_class(snd_config_t **dst, snd_config_t *root, snd_confi
 {
 	snd_config_t *n;
 	snd_ctl_t *ctl = NULL;
-	snd_pcm_info_t *info;
+	snd_pcm_info_t info = {0};
 	const char *id;
 	int card = -1, dev;
 	long class, index;
@@ -1091,7 +1091,6 @@ int snd_func_pcm_args_by_class(snd_config_t **dst, snd_config_t *root, snd_confi
 		goto __out;
 	}
 
-	snd_pcm_info_alloca(&info);
 	while(1) {
 		err = snd_card_next(&card);
 		if (err < 0) {
@@ -1106,7 +1105,6 @@ int snd_func_pcm_args_by_class(snd_config_t **dst, snd_config_t *root, snd_confi
 			goto __out;
 		}
 		dev = -1;
-		memset(info, 0, snd_pcm_info_sizeof());
 		while(1) {
 			err = snd_ctl_pcm_next_device(ctl, &dev);
 			if (err < 0) {
@@ -1115,11 +1113,11 @@ int snd_func_pcm_args_by_class(snd_config_t **dst, snd_config_t *root, snd_confi
 			}
 			if (dev < 0)
 				break;
-			snd_pcm_info_set_device(info, dev);
-			err = snd_ctl_pcm_info(ctl, info);
+			snd_pcm_info_set_device(&info, dev);
+			err = snd_ctl_pcm_info(ctl, &info);
 			if (err < 0)
 				continue;
-			if (snd_pcm_info_get_class(info) == (snd_pcm_class_t)class &&
+			if (snd_pcm_info_get_class(&info) == (snd_pcm_class_t)class &&
 					index == idx++)
 				goto __out;
 		}
-- 
2.7.4
