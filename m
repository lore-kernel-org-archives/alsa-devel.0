From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 28/34] conf: remove alloca() from
	snd_func_private_pcm_subdevice()
Date: Thu, 14 Jul 2016 23:07:45 +0900
Message-ID: <1468505271-5769-29-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id D84FE26658C
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
 src/confmisc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/confmisc.c b/src/confmisc.c
index 99be48b..a985f14 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -1162,7 +1162,7 @@ SND_DLSYM_BUILD_VERSION(snd_func_pcm_args_by_class, SND_CONFIG_DLSYM_VERSION_EVA
 int snd_func_private_pcm_subdevice(snd_config_t **dst, snd_config_t *root ATTRIBUTE_UNUSED,
 				   snd_config_t *src, snd_config_t *private_data)
 {
-	snd_pcm_info_t *info;
+	snd_pcm_info_t info = {0};
 	const char *id;
 	const void *data;
 	snd_pcm_t *pcm;
@@ -1181,15 +1181,15 @@ int snd_func_private_pcm_subdevice(snd_config_t **dst, snd_config_t *root ATTRIB
 		SNDERR("field pcm_handle is not a pointer");
 		return err;
 	}
-	snd_pcm_info_alloca(&info);
-	err = snd_pcm_info(pcm, info);
+	err = snd_pcm_info(pcm, &info);
 	if (err < 0) {
 		SNDERR("snd_ctl_pcm_info error: %s", snd_strerror(err));
 		return err;
 	}
 	err = snd_config_get_id(src, &id);
 	if (err >= 0)
-		err = snd_config_imake_integer(dst, id, snd_pcm_info_get_subdevice(info));
+		err = snd_config_imake_integer(dst, id,
+					snd_pcm_info_get_subdevice(&info));
 	return err;
 }
 #ifndef DOC_HIDDEN
-- 
2.7.4
