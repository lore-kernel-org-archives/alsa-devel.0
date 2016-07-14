From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 33/34] alisp: remove alloca() from
	FA_hctl_elem_write()
Date: Thu, 14 Jul 2016 23:07:50 +0900
Message-ID: <1468505271-5769-34-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8911E265A1D
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
 src/alisp/alisp_snd.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/src/alisp/alisp_snd.c b/src/alisp/alisp_snd.c
index 6d5018a..72c6ab0 100644
--- a/src/alisp/alisp_snd.c
+++ b/src/alisp/alisp_snd.c
@@ -684,8 +684,8 @@ static struct alisp_object * FA_hctl_elem_write(struct alisp_instance * instance
 {
 	snd_hctl_elem_t *handle;
 	struct alisp_object * p1 = NULL, * obj;
-	snd_ctl_elem_info_t *info;
-	snd_ctl_elem_value_t *value;
+	snd_ctl_elem_info_t info = {0};
+	snd_ctl_elem_value_t value = {0};
 	snd_ctl_elem_type_t type;
 	unsigned int idx, count;
 	int err;
@@ -700,15 +700,13 @@ static struct alisp_object * FA_hctl_elem_write(struct alisp_instance * instance
 		delete_tree(instance, p1);
 		return &alsa_lisp_nil;
 	}
-	snd_ctl_elem_info_alloca(&info);
-	snd_ctl_elem_value_alloca(&value);
-	err = snd_hctl_elem_info(handle, info);
+	err = snd_hctl_elem_info(handle, &info);
 	if (err < 0) {
 		delete_tree(instance, p1);
 		return new_integer(instance, err);
 	}
-	type = snd_ctl_elem_info_get_type(info);
-	count = snd_ctl_elem_info_get_count(info);
+	type = snd_ctl_elem_info_get_type(&info);
+	count = snd_ctl_elem_info_get_count(&info);
 	if (type == SND_CTL_ELEM_TYPE_IEC958) {
 		count = sizeof(snd_aes_iec958_t);
 		type = SND_CTL_ELEM_TYPE_BYTES;
@@ -722,19 +720,19 @@ static struct alisp_object * FA_hctl_elem_write(struct alisp_instance * instance
 		obj = car(p1);
 		switch (type) {
 		case SND_CTL_ELEM_TYPE_BOOLEAN:
-			snd_ctl_elem_value_set_boolean(value, idx, get_integer(obj));
+			snd_ctl_elem_value_set_boolean(&value, idx, get_integer(obj));
 			break;
 		case SND_CTL_ELEM_TYPE_INTEGER:
-			snd_ctl_elem_value_set_integer(value, idx, get_integer(obj));
+			snd_ctl_elem_value_set_integer(&value, idx, get_integer(obj));
 			break;
 		case SND_CTL_ELEM_TYPE_INTEGER64:
-			snd_ctl_elem_value_set_integer64(value, idx, get_integer(obj));
+			snd_ctl_elem_value_set_integer64(&value, idx, get_integer(obj));
 			break;
 		case SND_CTL_ELEM_TYPE_ENUMERATED:
-			snd_ctl_elem_value_set_enumerated(value, idx, get_integer(obj));
+			snd_ctl_elem_value_set_enumerated(&value, idx, get_integer(obj));
 			break;
 		case SND_CTL_ELEM_TYPE_BYTES:
-			snd_ctl_elem_value_set_byte(value, idx, get_integer(obj));
+			snd_ctl_elem_value_set_byte(&value, idx, get_integer(obj));
 			break;
 		default:
 			break;
@@ -743,7 +741,7 @@ static struct alisp_object * FA_hctl_elem_write(struct alisp_instance * instance
 		p1 = cdr(obj = p1);
 		delete_object(instance, obj);
 	} while (p1 != &alsa_lisp_nil);
-	err = snd_hctl_elem_write(handle, value);
+	err = snd_hctl_elem_write(handle, &value);
 	return new_integer(instance, err);
 }
 
-- 
2.7.4
