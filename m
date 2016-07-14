From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/34] pcm: remove alloca() from
	_snd_pcm_hook_ctl_elems_install()
Date: Thu, 14 Jul 2016 23:07:28 +0900
Message-ID: <1468505271-5769-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8845D2659B6
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:08 +0200 (CEST)
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
 src/pcm/pcm_hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index ce1cf36..66e7051 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -667,7 +667,7 @@ int _snd_pcm_hook_ctl_elems_install(snd_pcm_t *pcm, snd_config_t *conf)
 {
 	int err;
 	int card;
-	snd_pcm_info_t *info;
+	snd_pcm_info_t info = {0};
 	char ctl_name[16];
 	snd_ctl_t *ctl;
 	snd_sctl_t *sctl = NULL;
@@ -675,11 +675,11 @@ int _snd_pcm_hook_ctl_elems_install(snd_pcm_t *pcm, snd_config_t *conf)
 	snd_pcm_hook_t *h_hw_params = NULL, *h_hw_free = NULL, *h_close = NULL;
 	assert(conf);
 	assert(snd_config_get_type(conf) == SND_CONFIG_TYPE_COMPOUND);
-	snd_pcm_info_alloca(&info);
-	err = snd_pcm_info(pcm, info);
+
+	err = snd_pcm_info(pcm, &info);
 	if (err < 0)
 		return err;
-	card = snd_pcm_info_get_card(info);
+	card = snd_pcm_info_get_card(&info);
 	if (card < 0) {
 		SNDERR("No card for this PCM");
 		return -EINVAL;
-- 
2.7.4
