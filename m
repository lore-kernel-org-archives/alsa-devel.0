From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 30/34] alisp: remove alloca() from
	FA_hctl_find_elem()
Date: Thu, 14 Jul 2016 23:07:47 +0900
Message-ID: <1468505271-5769-31-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E9D02266687
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
 src/alisp/alisp_snd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/alisp/alisp_snd.c b/src/alisp/alisp_snd.c
index e622035..e9c3573 100644
--- a/src/alisp/alisp_snd.c
+++ b/src/alisp/alisp_snd.c
@@ -522,7 +522,7 @@ static int parse_ctl_elem_id(struct alisp_instance * instance,
 static struct alisp_object * FA_hctl_find_elem(struct alisp_instance * instance, struct acall_table * item, struct alisp_object * args)
 {
 	snd_hctl_t *handle;
-	snd_ctl_elem_id_t *id;
+	snd_ctl_elem_id_t id = {0};
 	struct alisp_object *p1;
 
 	handle = (snd_hctl_t *)get_ptr(instance, car(args), item->prefix);
@@ -531,14 +531,13 @@ static struct alisp_object * FA_hctl_find_elem(struct alisp_instance * instance,
 		delete_object(instance, args);
 		return &alsa_lisp_nil;
 	}
-	snd_ctl_elem_id_alloca(&id);
 	p1 = car(cdr(args));
 	delete_tree(instance, cdr(cdr(args)));
 	delete_object(instance, cdr(args));
 	delete_object(instance, args);
-	if (parse_ctl_elem_id(instance, eval(instance, p1), id) < 0)
+	if (parse_ctl_elem_id(instance, eval(instance, p1), &id) < 0)
 		return &alsa_lisp_nil;
-	return new_cons_pointer(instance, "hctl_elem", snd_hctl_find_elem(handle, id));
+	return new_cons_pointer(instance, "hctl_elem", snd_hctl_find_elem(handle, &id));
 }
 
 static struct alisp_object * FA_hctl_elem_info(struct alisp_instance * instance, struct acall_table * item, struct alisp_object * args)
-- 
2.7.4
