From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 34/34] alisp: remove alloca() from FA_pcm_info()
Date: Thu, 14 Jul 2016 23:07:51 +0900
Message-ID: <1468505271-5769-35-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 28F9026668F
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:10 +0200 (CEST)
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
 src/alisp/alisp_snd.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/src/alisp/alisp_snd.c b/src/alisp/alisp_snd.c
index 72c6ab0..c5e96e8 100644
--- a/src/alisp/alisp_snd.c
+++ b/src/alisp/alisp_snd.c
@@ -749,7 +749,7 @@ static struct alisp_object * FA_pcm_info(struct alisp_instance * instance, struc
 {
 	snd_pcm_t *handle;
 	struct alisp_object * lexpr, * p1;
-	snd_pcm_info_t *info;
+	snd_pcm_info_t info = {0};
 	int err;
 
 	p1 = eval(instance, car(args));
@@ -758,22 +758,21 @@ static struct alisp_object * FA_pcm_info(struct alisp_instance * instance, struc
 	handle = (snd_pcm_t *)get_ptr(instance, p1, item->prefix);
 	if (handle == NULL)
 		return &alsa_lisp_nil;
-	snd_pcm_info_alloca(&info);
-	err = snd_pcm_info(handle, info);
+	err = snd_pcm_info(handle, &info);
 	lexpr = new_lexpr(instance, err);
 	if (err < 0)
 		return lexpr;
-	p1 = add_cons(instance, lexpr->value.c.cdr, 0, "card", new_integer(instance, snd_pcm_info_get_card(info)));
-	p1 = add_cons(instance, p1, 1, "device", new_integer(instance, snd_pcm_info_get_device(info)));
-	p1 = add_cons(instance, p1, 1, "subdevice", new_integer(instance, snd_pcm_info_get_subdevice(info)));
-	p1 = add_cons(instance, p1, 1, "id", new_string(instance, snd_pcm_info_get_id(info)));
-	p1 = add_cons(instance, p1, 1, "name", new_string(instance, snd_pcm_info_get_name(info)));
-	p1 = add_cons(instance, p1, 1, "subdevice_name", new_string(instance, snd_pcm_info_get_subdevice_name(info)));
-	p1 = add_cons(instance, p1, 1, "class", new_integer(instance, snd_pcm_info_get_class(info)));
-	p1 = add_cons(instance, p1, 1, "subclass", new_integer(instance, snd_pcm_info_get_subclass(info)));
-	p1 = add_cons(instance, p1, 1, "subdevices_count", new_integer(instance, snd_pcm_info_get_subdevices_count(info)));
-	p1 = add_cons(instance, p1, 1, "subdevices_avail", new_integer(instance, snd_pcm_info_get_subdevices_avail(info)));
-	//p1 = add_cons(instance, p1, 1, "sync", new_string(instance, snd_pcm_info_get_sync(info)));
+	p1 = add_cons(instance, lexpr->value.c.cdr, 0, "card", new_integer(instance, snd_pcm_info_get_card(&info)));
+	p1 = add_cons(instance, p1, 1, "device", new_integer(instance, snd_pcm_info_get_device(&info)));
+	p1 = add_cons(instance, p1, 1, "subdevice", new_integer(instance, snd_pcm_info_get_subdevice(&info)));
+	p1 = add_cons(instance, p1, 1, "id", new_string(instance, snd_pcm_info_get_id(&info)));
+	p1 = add_cons(instance, p1, 1, "name", new_string(instance, snd_pcm_info_get_name(&info)));
+	p1 = add_cons(instance, p1, 1, "subdevice_name", new_string(instance, snd_pcm_info_get_subdevice_name(&info)));
+	p1 = add_cons(instance, p1, 1, "class", new_integer(instance, snd_pcm_info_get_class(&info)));
+	p1 = add_cons(instance, p1, 1, "subclass", new_integer(instance, snd_pcm_info_get_subclass(&info)));
+	p1 = add_cons(instance, p1, 1, "subdevices_count", new_integer(instance, snd_pcm_info_get_subdevices_count(&info)));
+	p1 = add_cons(instance, p1, 1, "subdevices_avail", new_integer(instance, snd_pcm_info_get_subdevices_avail(&info)));
+	//p1 = add_cons(instance, p1, 1, "sync", new_string(instance, snd_pcm_info_get_sync(&info)));
 	return lexpr;
 }
 
-- 
2.7.4
