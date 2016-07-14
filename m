From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 31/34] alisp: remove alloca() from
	FA_hctl_elem_info()
Date: Thu, 14 Jul 2016 23:07:48 +0900
Message-ID: <1468505271-5769-32-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E4FEB266672
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
 src/alisp/alisp_snd.c | 54 +++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/src/alisp/alisp_snd.c b/src/alisp/alisp_snd.c
index e9c3573..c63806b 100644
--- a/src/alisp/alisp_snd.c
+++ b/src/alisp/alisp_snd.c
@@ -544,8 +544,8 @@ static struct alisp_object * FA_hctl_elem_info(struct alisp_instance * instance,
 {
 	snd_hctl_elem_t *handle;
 	struct alisp_object * lexpr, * p1, * p2;
-	snd_ctl_elem_info_t *info;
-	snd_ctl_elem_id_t *id;
+	snd_ctl_elem_info_t info = {0};
+	snd_ctl_elem_id_t id = {0};
 	snd_ctl_elem_type_t type;
 	int err;
 
@@ -555,60 +555,58 @@ static struct alisp_object * FA_hctl_elem_info(struct alisp_instance * instance,
 	handle = (snd_hctl_elem_t *)get_ptr(instance, p1, item->prefix);
 	if (handle == NULL)
 		return &alsa_lisp_nil;
-	snd_ctl_elem_info_alloca(&info);
-	snd_ctl_elem_id_alloca(&id);
-	err = snd_hctl_elem_info(handle, info);
+	err = snd_hctl_elem_info(handle, &info);
 	lexpr = new_lexpr(instance, err);
 	if (err < 0)
 		return lexpr;
-	type = snd_ctl_elem_info_get_type(info);
+	type = snd_ctl_elem_info_get_type(&info);
 	p1 = add_cons(instance, lexpr->value.c.cdr, 0, "id", p2 = new_object(instance, ALISP_OBJ_CONS));
-	snd_ctl_elem_info_get_id(info, id);
-	if (create_ctl_elem_id(instance, id, p2) == NULL) {
+	snd_ctl_elem_info_get_id(&info, &id);
+	if (create_ctl_elem_id(instance, &id, p2) == NULL) {
 		delete_tree(instance, lexpr);
 		return NULL;
 	}
 	p1 = add_cons(instance, p1, 1, "type", new_string(instance, snd_ctl_elem_type_name(type)));
-	p1 = add_cons(instance, p1, 1, "readable", new_integer(instance, snd_ctl_elem_info_is_readable(info)));
-	p1 = add_cons(instance, p1, 1, "writable", new_integer(instance, snd_ctl_elem_info_is_writable(info)));
-	p1 = add_cons(instance, p1, 1, "volatile", new_integer(instance, snd_ctl_elem_info_is_volatile(info)));
-	p1 = add_cons(instance, p1, 1, "inactive", new_integer(instance, snd_ctl_elem_info_is_inactive(info)));
-	p1 = add_cons(instance, p1, 1, "locked", new_integer(instance, snd_ctl_elem_info_is_locked(info)));
-	p1 = add_cons(instance, p1, 1, "isowner", new_integer(instance, snd_ctl_elem_info_is_owner(info)));
-	p1 = add_cons(instance, p1, 1, "owner", new_integer(instance, snd_ctl_elem_info_get_owner(info)));
-	p1 = add_cons(instance, p1, 1, "count", new_integer(instance, snd_ctl_elem_info_get_count(info)));
-	err = snd_ctl_elem_info_get_dimensions(info);
+	p1 = add_cons(instance, p1, 1, "readable", new_integer(instance, snd_ctl_elem_info_is_readable(&info)));
+	p1 = add_cons(instance, p1, 1, "writable", new_integer(instance, snd_ctl_elem_info_is_writable(&info)));
+	p1 = add_cons(instance, p1, 1, "volatile", new_integer(instance, snd_ctl_elem_info_is_volatile(&info)));
+	p1 = add_cons(instance, p1, 1, "inactive", new_integer(instance, snd_ctl_elem_info_is_inactive(&info)));
+	p1 = add_cons(instance, p1, 1, "locked", new_integer(instance, snd_ctl_elem_info_is_locked(&info)));
+	p1 = add_cons(instance, p1, 1, "isowner", new_integer(instance, snd_ctl_elem_info_is_owner(&info)));
+	p1 = add_cons(instance, p1, 1, "owner", new_integer(instance, snd_ctl_elem_info_get_owner(&info)));
+	p1 = add_cons(instance, p1, 1, "count", new_integer(instance, snd_ctl_elem_info_get_count(&info)));
+	err = snd_ctl_elem_info_get_dimensions(&info);
 	if (err > 0) {
 		int idx;
 		p1 = add_cons(instance, p1, 1, "dimensions", p2 = new_object(instance, ALISP_OBJ_CONS));
 		for (idx = 0; idx < err; idx++)
-			p2 = add_cons2(instance, p2, idx > 0, new_integer(instance, snd_ctl_elem_info_get_dimension(info, idx)));
+			p2 = add_cons2(instance, p2, idx > 0, new_integer(instance, snd_ctl_elem_info_get_dimension(&info, idx)));
 	}
 	switch (type) {
 	case SND_CTL_ELEM_TYPE_ENUMERATED: {
 		unsigned int items, item;
-		items = snd_ctl_elem_info_get_items(info);
+		items = snd_ctl_elem_info_get_items(&info);
 		p1 = add_cons(instance, p1, 1, "items", p2 = new_object(instance, ALISP_OBJ_CONS));
 		for (item = 0; item < items; item++) {
-			snd_ctl_elem_info_set_item(info, item);
-			err = snd_hctl_elem_info(handle, info);
+			snd_ctl_elem_info_set_item(&info, item);
+			err = snd_hctl_elem_info(handle, &info);
 			if (err < 0) {
 				p2 = add_cons2(instance, p2, item, &alsa_lisp_nil);
 			} else {
-				p2 = add_cons2(instance, p2, item, new_string(instance, snd_ctl_elem_info_get_item_name(info)));
+				p2 = add_cons2(instance, p2, item, new_string(instance, snd_ctl_elem_info_get_item_name(&info)));
 			}
 		}
 		break;
 	}
 	case SND_CTL_ELEM_TYPE_INTEGER:
-		p1 = add_cons(instance, p1, 1, "min", new_integer(instance, snd_ctl_elem_info_get_min(info)));
-		p1 = add_cons(instance, p1, 1, "max", new_integer(instance, snd_ctl_elem_info_get_max(info)));
-		p1 = add_cons(instance, p1, 1, "step", new_integer(instance, snd_ctl_elem_info_get_step(info)));
+		p1 = add_cons(instance, p1, 1, "min", new_integer(instance, snd_ctl_elem_info_get_min(&info)));
+		p1 = add_cons(instance, p1, 1, "max", new_integer(instance, snd_ctl_elem_info_get_max(&info)));
+		p1 = add_cons(instance, p1, 1, "step", new_integer(instance, snd_ctl_elem_info_get_step(&info)));
 		break;
 	case SND_CTL_ELEM_TYPE_INTEGER64:
-		p1 = add_cons(instance, p1, 1, "min64", new_float(instance, snd_ctl_elem_info_get_min64(info)));
-		p1 = add_cons(instance, p1, 1, "max64", new_float(instance, snd_ctl_elem_info_get_max64(info)));
-		p1 = add_cons(instance, p1, 1, "step64", new_float(instance, snd_ctl_elem_info_get_step64(info)));
+		p1 = add_cons(instance, p1, 1, "min64", new_float(instance, snd_ctl_elem_info_get_min64(&info)));
+		p1 = add_cons(instance, p1, 1, "max64", new_float(instance, snd_ctl_elem_info_get_max64(&info)));
+		p1 = add_cons(instance, p1, 1, "step64", new_float(instance, snd_ctl_elem_info_get_step64(&info)));
 		break;
 	default:
 		break;
-- 
2.7.4
