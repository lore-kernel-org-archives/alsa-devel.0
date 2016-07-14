From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 23/34] conf: remove alloca() from
	snd_determine_driver()
Date: Thu, 14 Jul 2016 23:07:40 +0900
Message-ID: <1468505271-5769-24-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 3FCCB2659D7
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
index ae0275f..3f12e34 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -664,7 +664,7 @@ SND_DLSYM_BUILD_VERSION(snd_func_private_string, SND_CONFIG_DLSYM_VERSION_EVALUA
 int snd_determine_driver(int card, char **driver)
 {
 	snd_ctl_t *ctl = NULL;
-	snd_ctl_card_info_t *info;
+	snd_ctl_card_info_t info = {0};
 	char *res = NULL;
 	int err;
 
@@ -674,13 +674,12 @@ int snd_determine_driver(int card, char **driver)
 		SNDERR("could not open control for card %i", card);
 		goto __error;
 	}
-	snd_ctl_card_info_alloca(&info);
-	err = snd_ctl_card_info(ctl, info);
+	err = snd_ctl_card_info(ctl, &info);
 	if (err < 0) {
 		SNDERR("snd_ctl_card_info error: %s", snd_strerror(err));
 		goto __error;
 	}
-	res = strdup(snd_ctl_card_info_get_driver(info));
+	res = strdup(snd_ctl_card_info_get_driver(&info));
 	if (res == NULL)
 		err = -ENOMEM;
 	else {
-- 
2.7.4
