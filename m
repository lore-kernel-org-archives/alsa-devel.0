From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 29/34] alisp: remove alloca() from
	FA_card_info()
Date: Thu, 14 Jul 2016 23:07:46 +0900
Message-ID: <1468505271-5769-30-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 531892659FF
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
 src/alisp/alisp_snd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/alisp/alisp_snd.c b/src/alisp/alisp_snd.c
index 0a1a3b4..e622035 100644
--- a/src/alisp/alisp_snd.c
+++ b/src/alisp/alisp_snd.c
@@ -444,7 +444,7 @@ static struct alisp_object * FA_card_info(struct alisp_instance * instance, stru
 {
 	snd_ctl_t *handle;
 	struct alisp_object * lexpr, * p1;
-	snd_ctl_card_info_t * info;
+	snd_ctl_card_info_t info = {0};
 	int err;
 
 	p1 = eval(instance, car(args));
@@ -453,17 +453,16 @@ static struct alisp_object * FA_card_info(struct alisp_instance * instance, stru
 	handle = (snd_ctl_t *)get_ptr(instance, p1, item->prefix);
 	if (handle == NULL)
 		return &alsa_lisp_nil;
-	snd_ctl_card_info_alloca(&info);
-	err = snd_ctl_card_info(handle, info);
+	err = snd_ctl_card_info(handle, &info);
 	lexpr = new_lexpr(instance, err);
 	if (err < 0)
 		return lexpr;
-	p1 = add_cons(instance, lexpr->value.c.cdr, 0, "id", new_string(instance, snd_ctl_card_info_get_id(info)));
-	p1 = add_cons(instance, p1, 1, "driver", new_string(instance, snd_ctl_card_info_get_driver(info)));
-	p1 = add_cons(instance, p1, 1, "name", new_string(instance, snd_ctl_card_info_get_name(info)));
-	p1 = add_cons(instance, p1, 1, "longname", new_string(instance, snd_ctl_card_info_get_longname(info)));
-	p1 = add_cons(instance, p1, 1, "mixername", new_string(instance, snd_ctl_card_info_get_mixername(info)));
-	p1 = add_cons(instance, p1, 1, "components", new_string(instance, snd_ctl_card_info_get_components(info)));
+	p1 = add_cons(instance, lexpr->value.c.cdr, 0, "id", new_string(instance, snd_ctl_card_info_get_id(&info)));
+	p1 = add_cons(instance, p1, 1, "driver", new_string(instance, snd_ctl_card_info_get_driver(&info)));
+	p1 = add_cons(instance, p1, 1, "name", new_string(instance, snd_ctl_card_info_get_name(&info)));
+	p1 = add_cons(instance, p1, 1, "longname", new_string(instance, snd_ctl_card_info_get_longname(&info)));
+	p1 = add_cons(instance, p1, 1, "mixername", new_string(instance, snd_ctl_card_info_get_mixername(&info)));
+	p1 = add_cons(instance, p1, 1, "components", new_string(instance, snd_ctl_card_info_get_components(&info)));
 	if (p1 == NULL) {
 		delete_tree(instance, lexpr);
 		return NULL;
-- 
2.7.4
