From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 24/34] conf: remove alloca() from
	snd_func_card_id()
Date: Thu, 14 Jul 2016 23:07:41 +0900
Message-ID: <1468505271-5769-25-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C29B7265D3C
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
 src/confmisc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/confmisc.c b/src/confmisc.c
index 3f12e34..7763511 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -862,7 +862,7 @@ int snd_func_card_id(snd_config_t **dst, snd_config_t *root, snd_config_t *src,
 		     snd_config_t *private_data)
 {
 	snd_ctl_t *ctl = NULL;
-	snd_ctl_card_info_t *info;
+	snd_ctl_card_info_t info = {0};
 	const char *id;
 	int card, err;
 	
@@ -874,8 +874,7 @@ int snd_func_card_id(snd_config_t **dst, snd_config_t *root, snd_config_t *src,
 		SNDERR("could not open control for card %i", card);
 		goto __error;
 	}
-	snd_ctl_card_info_alloca(&info);
-	err = snd_ctl_card_info(ctl, info);
+	err = snd_ctl_card_info(ctl, &info);
 	if (err < 0) {
 		SNDERR("snd_ctl_card_info error: %s", snd_strerror(err));
 		goto __error;
@@ -883,7 +882,7 @@ int snd_func_card_id(snd_config_t **dst, snd_config_t *root, snd_config_t *src,
 	err = snd_config_get_id(src, &id);
 	if (err >= 0)
 		err = snd_config_imake_string(dst, id,
-					      snd_ctl_card_info_get_id(info));
+					      snd_ctl_card_info_get_id(&info));
       __error:
       	if (ctl)
       		snd_ctl_close(ctl);
-- 
2.7.4
