From: Clemens Lang <clemens.lang@bmw-carit.de>
Subject: [PATCH 2/2] Adapt to changes in the linked list API
Date: Thu, 23 Jul 2015 18:02:41 +0200
Message-ID: <1437667361-23152-3-git-send-email-clemens.lang@bmw-carit.de>
References: <20150119143100.GH4920@ulm-bmuc496424.bmw-carit.de>
 <1437667361-23152-1-git-send-email-clemens.lang@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bmw-carit.de (mail.bmw-carit.de [62.245.222.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B39A26128B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:03:00 +0200 (CEST)
In-Reply-To: <1437667361-23152-1-git-send-email-clemens.lang@bmw-carit.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Clemens Lang <clemens.lang@bmw-carit.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Clemens Lang <clemens.lang@bmw-carit.de>
---
 aserver/aserver.c            |  4 +-
 modules/mixer/simple/sbase.c | 36 +++++------------
 src/alisp/alisp.c            | 61 ++++++++--------------------
 src/async.c                  |  5 +--
 src/control/control.c        |  2 +-
 src/control/setup.c          | 10 ++---
 src/dlmisc.c                 | 16 +++-----
 src/mixer/bag.c              |  5 +--
 src/mixer/mixer.c            | 64 ++++++++++-------------------
 src/mixer/mixer_local.h      |  4 +-
 src/mixer/simple.c           |  4 +-
 src/pcm/pcm_hooks.c          | 22 +++++-----
 src/pcm/pcm_ladspa.c         | 64 +++++++++++++----------------
 src/pcm/pcm_meter.c          | 31 +++++----------
 src/pcm/pcm_share.c          | 20 ++++------
 src/shmarea.c                |  4 +-
 src/ucm/main.c               | 95 +++++++++++++-------------------------------
 src/ucm/utils.c              | 42 +++++++-------------
 18 files changed, 164 insertions(+), 325 deletions(-)

diff --git a/aserver/aserver.c b/aserver/aserver.c
index 1579da7..696abb8 100644
--- a/aserver/aserver.c
+++ b/aserver/aserver.c
@@ -829,7 +829,6 @@ static int inet_pending_handler(waiter_t *waiter, unsigned short events)
 	inet_pending_t *pdata;
 	client_t *client;
 	uint32_t cookie;
-	struct list_head *item;
 	int remove = 0;
 	if (events & POLLHUP)
 		remove = 1;
@@ -851,8 +850,7 @@ static int inet_pending_handler(waiter_t *waiter, unsigned short events)
 		return 0;
 	}
 
-	list_for_each(item, &inet_pendings) {
-		pdata = list_entry(item, inet_pending_t, list);
+	list_for_each(&inet_pendings, pdata, list) {
 		if (pdata->cookie == cookie)
 			goto found;
 	}
diff --git a/modules/mixer/simple/sbase.c b/modules/mixer/simple/sbase.c
index bb2f59d..838d2df 100644
--- a/modules/mixer/simple/sbase.c
+++ b/modules/mixer/simple/sbase.c
@@ -75,15 +75,13 @@ static void update_ranges(struct selem_base *s)
 	static unsigned int mask[2] = { SM_CAP_PVOLUME, SM_CAP_CVOLUME };
 	static unsigned int gmask[2] = { SM_CAP_GVOLUME, SM_CAP_GVOLUME };
 	unsigned int dir, ok_flag;
-	struct list_head *pos;
 	struct helem_base *helem;
 	
 	for (dir = 0; dir < 2; dir++) {
 		s->dir[dir].min = 0;
 		s->dir[dir].max = 0;
 		ok_flag = 0;
-		list_for_each(pos, &s->helems) {
-			helem = list_entry(pos, struct helem_base, list);
+		list_for_each(&s->helems, helem, list) {
 			printf("min = %li, max = %li\n", helem->min, helem->max);
 			if (helem->caps & mask[dir]) {
 				s->dir[dir].min = helem->min;
@@ -94,8 +92,7 @@ static void update_ranges(struct selem_base *s)
 		}
 		if (ok_flag)
 			continue;
-		list_for_each(pos, &s->helems) {
-			helem = list_entry(pos, struct helem_base, list);
+		list_for_each(&s->helems, helem, list) {
 			if (helem->caps & gmask[dir]) {
 				s->dir[dir].min = helem->min;
 				s->dir[dir].max = helem->max;
@@ -116,10 +113,8 @@ static int is_ops(snd_mixer_elem_t *elem, int dir, int cmd, int val)
 	switch (cmd) {
 
 	case SM_OPS_IS_ACTIVE: {
-		struct list_head *pos;
 		struct helem_base *helem;
-		list_for_each(pos, &s->helems) {
-			helem = list_entry(pos, struct helem_base, list);
+		list_for_each(&s->helems, helem, list) {
 			if (helem->inactive)
 				return 0;
 		}
@@ -301,13 +296,11 @@ static int simple_event_remove(snd_hctl_elem_t *helem,
 static void selem_free(snd_mixer_elem_t *elem)
 {
 	struct selem_base *simple = snd_mixer_elem_get_private(elem);
-	struct helem_base *hsimple;
-	struct list_head *pos, *npos;
+	struct helem_base *hsimple, *nhsimple;
 
 	if (simple->selem.id)
 		snd_mixer_selem_id_free(simple->selem.id);
-	list_for_each_safe(pos, npos, &simple->helems) {
-		hsimple = list_entry(pos, struct helem_base, list);
+	list_for_each_safe(&simple->helems, hsimple, nhsimple, list) {
 		free(hsimple);
 	}
 	free(simple);
@@ -327,13 +320,11 @@ static int simple_event_add1(snd_mixer_class_t *class,
 	unsigned long values;
 	long min, max;
 	int err, new = 0;
-	struct list_head *pos;
 	struct bclass_sid *bsid;
 	struct melem_sids *sid;
 	unsigned int ui;
 	
-	list_for_each(pos, &priv->sids) {
-		bsid = list_entry(pos, struct bclass_sid, list);
+	list_for_each(&priv->sids, bsid, list) {
 		for (ui = 0; ui < bsid->count; ui++) {
 			if (bsid->sids[ui].sid == sel->sid) {
 				sid = &bsid->sids[ui];
@@ -458,15 +449,13 @@ static int simple_event_add(snd_mixer_class_t *class, snd_hctl_elem_t *helem)
 	struct bclass_private *priv = snd_mixer_sbasic_get_private(class);
 	struct bclass_selector *sel;
 	struct helem_selector *hsel;
-	struct list_head *pos;
 	snd_ctl_elem_iface_t iface = snd_hctl_elem_get_interface(helem);
 	const char *name = snd_hctl_elem_get_name(helem);
 	unsigned int index = snd_hctl_elem_get_index(helem);
 	unsigned int ui;
 	int err;
 
-	list_for_each(pos, &priv->selectors) {
-		sel = list_entry(pos, struct bclass_selector, list);
+	list_for_each(&priv->selectors, sel, list) {
 		for (ui = 0; ui < sel->count; ui++) {
 			hsel = &sel->selectors[ui];
 			if (hsel->iface == iface && !strcmp(hsel->name, name) && hsel->index == index) {
@@ -515,16 +504,13 @@ int alsa_mixer_sbasic_event(snd_mixer_class_t *class, unsigned int mask,
 static void sbasic_cpriv_free(snd_mixer_class_t *class)
 {
 	struct bclass_private *priv = snd_mixer_sbasic_get_private(class);
-	struct bclass_selector *sel;
-	struct bclass_sid *sid;
-	struct list_head *pos, *pos1;
+	struct bclass_selector *sel, *nsel;
+	struct bclass_sid *sid, *nsid;
 
-	list_for_each_safe(pos, pos1, &priv->selectors) {
-		sel = list_entry(pos, struct bclass_selector, list);
+	list_for_each_safe(&priv->selectors, sel, nsel, list) {
 		free(sel);
 	}
-	list_for_each_safe(pos, pos1, &priv->sids) {
-		sid = list_entry(pos, struct bclass_sid, list);
+	list_for_each_safe(&priv->sids, sid, nsid, list) {
 		free(sid);
 	}
 	free(priv);
diff --git a/src/alisp/alisp.c b/src/alisp/alisp.c
index 3c61bb1..ed71282 100644
--- a/src/alisp/alisp.c
+++ b/src/alisp/alisp.c
@@ -257,14 +257,12 @@ static struct alisp_object * incref_tree_explicit(struct alisp_instance *instanc
 
 static void free_objects(struct alisp_instance *instance)
 {
-	struct list_head *pos, *pos1;
-	struct alisp_object * p;
-	struct alisp_object_pair * pair;
+	struct alisp_object * p, * pnext;
+	struct alisp_object_pair * pair, * pairnext;
 	int i, j;
 
 	for (i = 0; i < ALISP_OBJ_PAIR_HASH_SIZE; i++) {
-		list_for_each_safe(pos, pos1, &instance->setobjs_list[i]) {
-			pair = list_entry(pos, struct alisp_object_pair, list);
+		list_for_each_safe(&instance->setobjs_list[i], pair, pairnext, list) {
 			lisp_debug(instance, "freeing pair: '%s' -> %p", pair->name, pair->value);
 			delete_tree(instance, pair->value);
 			free((void *)pair->name);
@@ -273,8 +271,7 @@ static void free_objects(struct alisp_instance *instance)
 	}
 	for (i = 0; i < ALISP_OBJ_PAIR_HASH_SIZE; i++)
 		for (j = 0; j <= ALISP_OBJ_LAST_SEARCH; j++) {
-			list_for_each_safe(pos, pos1, &instance->used_objs_list[i][j]) {
-				p = list_entry(pos, struct alisp_object, list);
+			list_for_each_safe(&instance->used_objs_list[i][j], p, pnext, list) {
 				lisp_warn(instance, "object %p is still referenced %i times!", p, alisp_get_refs(p));
 #if 0
 				snd_output_printf(instance->wout, ">>>> ");
@@ -286,8 +283,7 @@ static void free_objects(struct alisp_instance *instance)
 				delete_object(instance, p);
 			}
 		}
-	list_for_each_safe(pos, pos1, &instance->free_objs_list) {
-		p = list_entry(pos, struct alisp_object, list);
+	list_for_each_safe(&instance->free_objs_list, p, pnext, list) {
 		list_del(&p->list);
 		free(p);
 		lisp_debug(instance, "freed (all) cons %p", p);
@@ -296,11 +292,9 @@ static void free_objects(struct alisp_instance *instance)
 
 static struct alisp_object * search_object_identifier(struct alisp_instance *instance, const char *s)
 {
-	struct list_head * pos;
 	struct alisp_object * p;
 
-	list_for_each(pos, &instance->used_objs_list[get_string_hash(s)][ALISP_OBJ_IDENTIFIER]) {
-		p = list_entry(pos, struct alisp_object, list);
+	list_for_each(&instance->used_objs_list[get_string_hash(s)][ALISP_OBJ_IDENTIFIER], p, list) {
 		if (alisp_get_refs(p) > ALISP_MAX_REFS_LIMIT)
 			continue;
 		if (!strcmp(p->value.s, s))
@@ -312,11 +306,9 @@ static struct alisp_object * search_object_identifier(struct alisp_instance *ins
 
 static struct alisp_object * search_object_string(struct alisp_instance *instance, const char *s)
 {
-	struct list_head * pos;
 	struct alisp_object * p;
 
-	list_for_each(pos, &instance->used_objs_list[get_string_hash(s)][ALISP_OBJ_STRING]) {
-		p = list_entry(pos, struct alisp_object, list);
+	list_for_each(&instance->used_objs_list[get_string_hash(s)][ALISP_OBJ_STRING], p, list) {
 		if (!strcmp(p->value.s, s)) {
 			if (alisp_get_refs(p) > ALISP_MAX_REFS_LIMIT)
 				continue;
@@ -329,11 +321,9 @@ static struct alisp_object * search_object_string(struct alisp_instance *instanc
 
 static struct alisp_object * search_object_integer(struct alisp_instance *instance, long in)
 {
-	struct list_head * pos;
 	struct alisp_object * p;
 
-	list_for_each(pos, &instance->used_objs_list[in & ALISP_OBJ_PAIR_HASH_MASK][ALISP_OBJ_INTEGER]) {
-		p = list_entry(pos, struct alisp_object, list);
+	list_for_each(&instance->used_objs_list[in & ALISP_OBJ_PAIR_HASH_MASK][ALISP_OBJ_INTEGER], p, list) {
 		if (p->value.i == in) {
 			if (alisp_get_refs(p) > ALISP_MAX_REFS_LIMIT)
 				continue;
@@ -346,11 +336,9 @@ static struct alisp_object * search_object_integer(struct alisp_instance *instan
 
 static struct alisp_object * search_object_float(struct alisp_instance *instance, double in)
 {
-	struct list_head * pos;
 	struct alisp_object * p;
 
-	list_for_each(pos, &instance->used_objs_list[(long)in & ALISP_OBJ_PAIR_HASH_MASK][ALISP_OBJ_FLOAT]) {
-		p = list_entry(pos, struct alisp_object, list);
+	list_for_each(&instance->used_objs_list[(long)in & ALISP_OBJ_PAIR_HASH_MASK][ALISP_OBJ_FLOAT], p, list) {
 		if (p->value.i == in) {
 			if (alisp_get_refs(p) > ALISP_MAX_REFS_LIMIT)
 				continue;
@@ -363,11 +351,9 @@ static struct alisp_object * search_object_float(struct alisp_instance *instance
 
 static struct alisp_object * search_object_pointer(struct alisp_instance *instance, const void *ptr)
 {
-	struct list_head * pos;
 	struct alisp_object * p;
 
-	list_for_each(pos, &instance->used_objs_list[(long)ptr & ALISP_OBJ_PAIR_HASH_MASK][ALISP_OBJ_POINTER]) {
-		p = list_entry(pos, struct alisp_object, list);
+	list_for_each(&instance->used_objs_list[(long)ptr & ALISP_OBJ_PAIR_HASH_MASK][ALISP_OBJ_POINTER], p, list) {
 		if (p->value.ptr == ptr) {
 			if (alisp_get_refs(p) > ALISP_MAX_REFS_LIMIT)
 				continue;
@@ -866,7 +852,6 @@ static int check_set_object(struct alisp_instance * instance, struct alisp_objec
 
 static struct alisp_object_pair * set_object(struct alisp_instance *instance, struct alisp_object * name, struct alisp_object * value)
 {
-	struct list_head *pos;
 	struct alisp_object_pair *p;
 	const char *id;
 
@@ -875,8 +860,7 @@ static struct alisp_object_pair * set_object(struct alisp_instance *instance, st
 
 	id = name->value.s;
 
-	list_for_each(pos, &instance->setobjs_list[get_string_hash(id)]) {
-		p = list_entry(pos, struct alisp_object_pair, list);
+	list_for_each(&instance->setobjs_list[get_string_hash(id)], p, list) {
 		if (!strcmp(p->name, id)) {
 			delete_tree(instance, p->value);
 			p->value = value;
@@ -902,7 +886,6 @@ static struct alisp_object_pair * set_object(struct alisp_instance *instance, st
 
 static struct alisp_object * unset_object(struct alisp_instance *instance, struct alisp_object * name)
 {
-	struct list_head *pos;
 	struct alisp_object *res;
 	struct alisp_object_pair *p;
 	const char *id;
@@ -914,8 +897,7 @@ static struct alisp_object * unset_object(struct alisp_instance *instance, struc
 	}
 	id = name->value.s;
 
-	list_for_each(pos, &instance->setobjs_list[get_string_hash(id)]) {
-		p = list_entry(pos, struct alisp_object_pair, list);
+	list_for_each(&instance->setobjs_list[get_string_hash(id)], p, list) {
 		if (!strcmp(p->name, id)) {
 			list_del(&p->list);
 			res = p->value;
@@ -931,10 +913,8 @@ static struct alisp_object * unset_object(struct alisp_instance *instance, struc
 static struct alisp_object * get_object1(struct alisp_instance *instance, const char *id)
 {
 	struct alisp_object_pair *p;
-	struct list_head *pos;
 
-	list_for_each(pos, &instance->setobjs_list[get_string_hash(id)]) {
-		p = list_entry(pos, struct alisp_object_pair, list);
+	list_for_each(&instance->setobjs_list[get_string_hash(id)], p, list) {
 		if (!strcmp(p->name, id))
 			return p->value;
 	}
@@ -956,7 +936,6 @@ static struct alisp_object * replace_object(struct alisp_instance *instance, str
 {
 	struct alisp_object_pair *p;
 	struct alisp_object *r;
-	struct list_head *pos;
 	const char *id;
 
 	if (!alisp_compare_type(name, ALISP_OBJ_IDENTIFIER) &&
@@ -965,8 +944,7 @@ static struct alisp_object * replace_object(struct alisp_instance *instance, str
 		return &alsa_lisp_nil;
 	}
 	id = name->value.s;
-	list_for_each(pos, &instance->setobjs_list[get_string_hash(id)]) {
-		p = list_entry(pos, struct alisp_object_pair, list);
+	list_for_each(&instance->setobjs_list[get_string_hash(id)], p, list) {
 		if (!strcmp(p->name, id)) {
 			r = p->value;
 			p->value = onew;
@@ -981,7 +959,6 @@ static void dump_objects(struct alisp_instance *instance, const char *fname)
 {
 	struct alisp_object_pair *p;
 	snd_output_t *out;
-	struct list_head *pos;
 	int i, err;
 
 	if (!strcmp(fname, "-"))
@@ -994,8 +971,7 @@ static void dump_objects(struct alisp_instance *instance, const char *fname)
 	}
 
 	for (i = 0; i < ALISP_OBJ_PAIR_HASH_SIZE; i++) {
-		list_for_each(pos, &instance->setobjs_list[i]) {
-			p = list_entry(pos, struct alisp_object_pair, list);
+		list_for_each(&instance->setobjs_list[i], p, list) {
 			if (alisp_compare_type(p->value, ALISP_OBJ_CONS) &&
 			    alisp_compare_type(p->value->value.c.car, ALISP_OBJ_IDENTIFIER) &&
 			    !strcmp(p->value->value.c.car->value.s, "lambda")) {
@@ -1029,15 +1005,13 @@ static const char *obj_type_str(struct alisp_object * p)
 
 static void print_obj_lists(struct alisp_instance *instance, snd_output_t *out)
 {
-	struct list_head *pos;
 	struct alisp_object * p;
 	int i, j;
 
 	snd_output_printf(out, "** used objects\n");
 	for (i = 0; i < ALISP_OBJ_PAIR_HASH_SIZE; i++)
 		for (j = 0; j <= ALISP_OBJ_LAST_SEARCH; j++)
-			list_for_each(pos, &instance->used_objs_list[i][j]) {
-				p = list_entry(pos, struct alisp_object, list);
+			list_for_each(&instance->used_objs_list[i][j], p, list) {
 				snd_output_printf(out, "**   %p (%s) (", p, obj_type_str(p));
 				if (!alisp_compare_type(p, ALISP_OBJ_CONS))
 					princ_object(out, p);
@@ -1046,8 +1020,7 @@ static void print_obj_lists(struct alisp_instance *instance, snd_output_t *out)
 				snd_output_printf(out, ") refs=%i\n", alisp_get_refs(p));
 			}
 	snd_output_printf(out, "** free objects\n");
-	list_for_each(pos, &instance->free_objs_list) {
-		p = list_entry(pos, struct alisp_object, list);
+	list_for_each(&instance->free_objs_list, p, list) {
 		snd_output_printf(out, "**   %p\n", p);
 	}
 }
diff --git a/src/async.c b/src/async.c
index 98aec78..fbe2ad1 100644
--- a/src/async.c
+++ b/src/async.c
@@ -52,11 +52,10 @@ static LIST_HEAD(snd_async_handlers);
 static void snd_async_handler(int signo ATTRIBUTE_UNUSED, siginfo_t *siginfo, void *context ATTRIBUTE_UNUSED)
 {
 	int fd;
-	struct list_head *i;
+	snd_async_handler_t *h;
 	//assert(siginfo->si_code == SI_SIGIO);
 	fd = siginfo->si_fd;
-	list_for_each(i, &snd_async_handlers) {
-		snd_async_handler_t *h = list_entry(i, snd_async_handler_t, glist);
+	list_for_each(&snd_async_handlers, h, glist) {
 		if (h->fd == fd && h->callback)
 			h->callback(h);
 	}
diff --git a/src/control/control.c b/src/control/control.c
index 4a28cf6..766fc49 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -90,7 +90,7 @@ int snd_ctl_close(snd_ctl_t *ctl)
 {
 	int err;
 	while (!list_empty(&ctl->async_handlers)) {
-		snd_async_handler_t *h = list_entry(&ctl->async_handlers.next, snd_async_handler_t, hlist);
+		snd_async_handler_t *h = list_entry(ctl->async_handlers.next, snd_async_handler_t, hlist);
 		snd_async_del_handler(h);
 	}
 	err = ctl->ops->close(ctl);
diff --git a/src/control/setup.c b/src/control/setup.c
index f23bf2c..14b933a 100644
--- a/src/control/setup.c
+++ b/src/control/setup.c
@@ -82,12 +82,11 @@ static int free_elems(snd_sctl_t *h)
  */
 int snd_sctl_install(snd_sctl_t *h)
 {
-	struct list_head *pos;
+	snd_sctl_elem_t *elem;
 	int err;
 	unsigned int k;
 	assert(h);
-	list_for_each(pos, &h->elems) {
-		snd_sctl_elem_t *elem = list_entry(pos, snd_sctl_elem_t, list);
+	list_for_each(&h->elems, elem, list) {
 		unsigned int count;
 		snd_ctl_elem_type_t type;
 		if (elem->lock) {
@@ -180,11 +179,10 @@ int snd_sctl_install(snd_sctl_t *h)
  */
 int snd_sctl_remove(snd_sctl_t *h)
 {
-	struct list_head *pos;
+	snd_sctl_elem_t *elem;
 	int err;
 	assert(h);
-	list_for_each(pos, &h->elems) {
-		snd_sctl_elem_t *elem = list_entry(pos, snd_sctl_elem_t, list);
+	list_for_each(&h->elems, elem, list) {
 		if (elem->lock) {
 			err = snd_ctl_elem_unlock(h->ctl, elem->id);
 			if (err < 0) {
diff --git a/src/dlmisc.c b/src/dlmisc.c
index b36c48f..bb6b99f 100644
--- a/src/dlmisc.c
+++ b/src/dlmisc.c
@@ -226,13 +226,11 @@ static LIST_HEAD(pcm_dlobj_list);
 void *snd_dlobj_cache_get(const char *lib, const char *name,
 			  const char *version, int verbose)
 {
-	struct list_head *p;
 	struct dlobj_cache *c;
 	void *func, *dlobj;
 
 	snd_dlobj_lock();
-	list_for_each(p, &pcm_dlobj_list) {
-		c = list_entry(p, struct dlobj_cache, list);
+	list_for_each(&pcm_dlobj_list, c, list) {
 		if (c->lib && lib && strcmp(c->lib, lib) != 0)
 			continue;
 		if (!c->lib && lib)
@@ -287,7 +285,6 @@ void *snd_dlobj_cache_get(const char *lib, const char *name,
 
 int snd_dlobj_cache_put(void *func)
 {
-	struct list_head *p;
 	struct dlobj_cache *c;
 	unsigned int refcnt;
 
@@ -295,8 +292,7 @@ int snd_dlobj_cache_put(void *func)
 		return -ENOENT;
 
 	snd_dlobj_lock();
-	list_for_each(p, &pcm_dlobj_list) {
-		c = list_entry(p, struct dlobj_cache, list);
+	list_for_each(&pcm_dlobj_list, c, list) {
 		if (c->func == func) {
 			refcnt = c->refcnt;
 			if (c->refcnt > 0)
@@ -311,15 +307,13 @@ int snd_dlobj_cache_put(void *func)
 
 void snd_dlobj_cache_cleanup(void)
 {
-	struct list_head *p, *npos;
-	struct dlobj_cache *c;
+	struct dlobj_cache *c, *nc;
 
 	snd_dlobj_lock();
-	list_for_each_safe(p, npos, &pcm_dlobj_list) {
-		c = list_entry(p, struct dlobj_cache, list);
+	list_for_each_safe(&pcm_dlobj_list, c, nc, list) {
 		if (c->refcnt)
 			continue;
-		list_del(p);
+		list_del(&c->list);
 		snd_dlclose(c->dlobj);
 		free((void *)c->name); /* shut up gcc warning */
 		free((void *)c->lib); /* shut up gcc warning */
diff --git a/src/mixer/bag.c b/src/mixer/bag.c
index d88a900..576bd31 100644
--- a/src/mixer/bag.c
+++ b/src/mixer/bag.c
@@ -54,9 +54,8 @@ int bag_add(bag_t *bag, void *ptr)
 
 int bag_del(bag_t *bag, void *ptr)
 {
-	struct list_head *pos;
-	list_for_each(pos, bag) {
-		bag1_t *b = list_entry(pos, bag1_t, list);
+	bag1_t *b;
+	list_for_each(bag, b, list) {
 		if (b->ptr == ptr) {
 			list_del(&b->list);
 			free(b);
diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 3a79c8e..025be1a 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -170,16 +170,14 @@ static int hctl_event_handler(snd_hctl_t *hctl, unsigned int mask,
 	snd_mixer_t *mixer = snd_hctl_get_callback_private(hctl);
 	int res = 0;
 	if (mask & SND_CTL_EVENT_MASK_ADD) {
-		struct list_head *pos;
+		snd_mixer_class_t *c;
 		bag_t *bag;
 		int err = bag_new(&bag);
 		if (err < 0)
 			return err;
 		snd_hctl_elem_set_callback(elem, hctl_elem_event_handler);
 		snd_hctl_elem_set_callback_private(elem, bag);
-		list_for_each(pos, &mixer->classes) {
-			snd_mixer_class_t *c;
-			c = list_entry(pos, snd_mixer_class_t, list);
+		list_for_each(&mixer->classes, c, list) {
 			err = c->event(c, mask, elem, NULL);
 			if (err < 0)
 				res = err;
@@ -249,13 +247,11 @@ int snd_mixer_attach_hctl(snd_mixer_t *mixer, snd_hctl_t *hctl)
  */
 int snd_mixer_detach(snd_mixer_t *mixer, const char *name)
 {
-	struct list_head *pos;
-	list_for_each(pos, &mixer->slaves) {
-		snd_mixer_slave_t *s;
-		s = list_entry(pos, snd_mixer_slave_t, list);
+	snd_mixer_slave_t *s;
+	list_for_each(&mixer->slaves, s, list) {
 		if (strcmp(name, snd_hctl_name(s->hctl)) == 0) {
 			snd_hctl_close(s->hctl);
-			list_del(pos);
+			list_del(&s->list);
 			free(s);
 			return 0;
 		}
@@ -273,12 +269,10 @@ int snd_mixer_detach(snd_mixer_t *mixer, const char *name)
  */
 int snd_mixer_detach_hctl(snd_mixer_t *mixer, snd_hctl_t *hctl)
 {
-	struct list_head *pos;
-	list_for_each(pos, &mixer->slaves) {
-		snd_mixer_slave_t *s;
-		s = list_entry(pos, snd_mixer_slave_t, list);
+	snd_mixer_slave_t *s;
+	list_for_each(&mixer->slaves, s, list) {
 		if (hctl == s->hctl) {
-			list_del(pos);
+			list_del(&s->list);
 			free(s);
 			return 0;
 		}
@@ -295,10 +289,8 @@ int snd_mixer_detach_hctl(snd_mixer_t *mixer, snd_hctl_t *hctl)
  */
 int snd_mixer_get_hctl(snd_mixer_t *mixer, const char *name, snd_hctl_t **hctl)
 {
-	struct list_head *pos;
-	list_for_each(pos, &mixer->slaves) {
-		snd_mixer_slave_t *s;
-		s = list_entry(pos, snd_mixer_slave_t, list);
+	snd_mixer_slave_t *s;
+	list_for_each(&mixer->slaves, s, list) {
 		if (strcmp(name, snd_hctl_name(s->hctl)) == 0) {
 			*hctl = s->hctl;
 			return 0;
@@ -515,16 +507,14 @@ int snd_mixer_elem_value(snd_mixer_elem_t *elem)
  */
 int snd_mixer_class_register(snd_mixer_class_t *class, snd_mixer_t *mixer)
 {
-	struct list_head *pos;
+	snd_mixer_slave_t *slave;
 	class->mixer = mixer;
 	list_add_tail(&class->list, &mixer->classes);
 	if (!class->event)
 		return 0;
-	list_for_each(pos, &mixer->slaves) {
+	list_for_each(&mixer->slaves, slave, list) {
 		int err;
-		snd_mixer_slave_t *slave;
 		snd_hctl_elem_t *elem;
-		slave = list_entry(pos, snd_mixer_slave_t, list);
 		elem = snd_hctl_first_elem(slave->hctl);
 		while (elem) {
 			err = class->event(class, SND_CTL_EVENT_MASK_ADD, elem, NULL);
@@ -567,11 +557,9 @@ int snd_mixer_class_unregister(snd_mixer_class_t *class)
  */
 int snd_mixer_load(snd_mixer_t *mixer)
 {
-	struct list_head *pos;
-	list_for_each(pos, &mixer->slaves) {
+	snd_mixer_slave_t *s;
+	list_for_each(&mixer->slaves, s, list) {
 		int err;
-		snd_mixer_slave_t *s;
-		s = list_entry(pos, snd_mixer_slave_t, list);
 		err = snd_hctl_load(s->hctl);
 		if (err < 0)
 			return err;
@@ -585,10 +573,8 @@ int snd_mixer_load(snd_mixer_t *mixer)
  */
 void snd_mixer_free(snd_mixer_t *mixer)
 {
-	struct list_head *pos;
-	list_for_each(pos, &mixer->slaves) {
-		snd_mixer_slave_t *s;
-		s = list_entry(pos, snd_mixer_slave_t, list);
+	snd_mixer_slave_t *s;
+	list_for_each(&mixer->slaves, s, list) {
 		snd_hctl_free(s->hctl);
 	}
 }
@@ -685,13 +671,11 @@ int snd_mixer_set_compare(snd_mixer_t *mixer, snd_mixer_compare_t compare)
  */
 int snd_mixer_poll_descriptors_count(snd_mixer_t *mixer)
 {
-	struct list_head *pos;
+	snd_mixer_slave_t *s;
 	unsigned int c = 0;
 	assert(mixer);
-	list_for_each(pos, &mixer->slaves) {
-		snd_mixer_slave_t *s;
+	list_for_each(&mixer->slaves, s, list) {
 		int n;
-		s = list_entry(pos, snd_mixer_slave_t, list);
 		n = snd_hctl_poll_descriptors_count(s->hctl);
 		if (n < 0)
 			return n;
@@ -709,13 +693,11 @@ int snd_mixer_poll_descriptors_count(snd_mixer_t *mixer)
  */
 int snd_mixer_poll_descriptors(snd_mixer_t *mixer, struct pollfd *pfds, unsigned int space)
 {
-	struct list_head *pos;
+	snd_mixer_slave_t *s;
 	unsigned int count = 0;
 	assert(mixer);
-	list_for_each(pos, &mixer->slaves) {
-		snd_mixer_slave_t *s;
+	list_for_each(&mixer->slaves, s, list) {
 		int n;
-		s = list_entry(pos, snd_mixer_slave_t, list);
 		n = snd_hctl_poll_descriptors(s->hctl, pfds, space);
 		if (n < 0)
 			return n;
@@ -839,13 +821,11 @@ snd_mixer_elem_t *snd_mixer_elem_prev(snd_mixer_elem_t *elem)
  */
 int snd_mixer_handle_events(snd_mixer_t *mixer)
 {
-	struct list_head *pos;
+	snd_mixer_slave_t *s;
 	assert(mixer);
 	mixer->events = 0;
-	list_for_each(pos, &mixer->slaves) {
+	list_for_each(&mixer->slaves, s, list) {
 		int err;
-		snd_mixer_slave_t *s;
-		s = list_entry(pos, snd_mixer_slave_t, list);
 		err = snd_hctl_handle_events(s->hctl);
 		if (err < 0)
 			return err;
diff --git a/src/mixer/mixer_local.h b/src/mixer/mixer_local.h
index 27b4a3b..6d307d4 100644
--- a/src/mixer/mixer_local.h
+++ b/src/mixer/mixer_local.h
@@ -39,8 +39,8 @@ void bag_del_all(bag_t *bag);
 typedef struct list_head *bag_iterator_t;
 
 #define bag_iterator_entry(i) (list_entry((i), bag1_t, list)->ptr)
-#define bag_for_each(pos, bag) list_for_each(pos, bag)
-#define bag_for_each_safe(pos, next, bag) list_for_each_safe(pos, next, bag)
+#define bag_for_each(pos, bag) list_for_each_raw(bag, pos)
+#define bag_for_each_safe(pos, next, bag) list_for_each_raw_safe(bag, pos, next)
 
 struct _snd_mixer_class {
 	struct list_head list;
diff --git a/src/mixer/simple.c b/src/mixer/simple.c
index fd9ba93..af9118d 100644
--- a/src/mixer/simple.c
+++ b/src/mixer/simple.c
@@ -133,12 +133,10 @@ int snd_mixer_selem_compare(const snd_mixer_elem_t *c1, const snd_mixer_elem_t *
 snd_mixer_elem_t *snd_mixer_find_selem(snd_mixer_t *mixer,
 				       const snd_mixer_selem_id_t *id)
 {
-	struct list_head *list;
 	snd_mixer_elem_t *e;
 	sm_selem_t *s;
 
-	list_for_each(list, &mixer->elems) {
-		e = list_entry(list, snd_mixer_elem_t, list);
+	list_for_each(&mixer->elems, e, list) {
 		if (e->type != SND_MIXER_ELEM_SIMPLE)
 			continue;
 		s = e->private_data;
diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index ce1cf36..aa44cfd 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -79,12 +79,11 @@ static void hook_remove_dlobj(struct snd_pcm_hook_dllist *dl)
 static int snd_pcm_hooks_close(snd_pcm_t *pcm)
 {
 	snd_pcm_hooks_t *h = pcm->private_data;
-	struct list_head *pos, *next;
+	snd_pcm_hook_t *hook, *nhook;
 	unsigned int k;
 	int res = 0, err;
 
-	list_for_each_safe(pos, next, &h->hooks[SND_PCM_HOOK_TYPE_CLOSE]) {
-		snd_pcm_hook_t *hook = list_entry(pos, snd_pcm_hook_t, list);
+	list_for_each_safe(&h->hooks[SND_PCM_HOOK_TYPE_CLOSE], hook, nhook, list) {
 		err = hook->func(hook);
 		if (err < 0)
 			res = err;
@@ -93,14 +92,13 @@ static int snd_pcm_hooks_close(snd_pcm_t *pcm)
 		struct list_head *hooks = &h->hooks[k];
 		while (!list_empty(hooks)) {
 			snd_pcm_hook_t *hook;
-			pos = hooks->next;
-			hook = list_entry(pos, snd_pcm_hook_t, list);
+			hook = list_entry(hooks->next, snd_pcm_hook_t, list);
 			snd_pcm_hook_remove(hook);
 		}
 	}
 	while (!list_empty(&h->dllist)) {
-		pos = h->dllist.next;
-		hook_remove_dlobj(list_entry(pos, struct snd_pcm_hook_dllist, list));
+		hook_remove_dlobj(list_entry(h->dllist.next, struct snd_pcm_hook_dllist,
+		                             list));
 	}
 	err = snd_pcm_generic_close(pcm);
 	if (err < 0)
@@ -111,12 +109,11 @@ static int snd_pcm_hooks_close(snd_pcm_t *pcm)
 static int snd_pcm_hooks_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 {
 	snd_pcm_hooks_t *h = pcm->private_data;
-	struct list_head *pos, *next;
+	snd_pcm_hook_t *hook, *nhook;
 	int err = snd_pcm_generic_hw_params(pcm, params);
 	if (err < 0)
 		return err;
-	list_for_each_safe(pos, next, &h->hooks[SND_PCM_HOOK_TYPE_HW_PARAMS]) {
-		snd_pcm_hook_t *hook = list_entry(pos, snd_pcm_hook_t, list);
+	list_for_each_safe(&h->hooks[SND_PCM_HOOK_TYPE_HW_PARAMS], hook, nhook, list) {
 		err = hook->func(hook);
 		if (err < 0)
 			return err;
@@ -127,12 +124,11 @@ static int snd_pcm_hooks_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 static int snd_pcm_hooks_hw_free(snd_pcm_t *pcm)
 {
 	snd_pcm_hooks_t *h = pcm->private_data;
-	struct list_head *pos, *next;
+	snd_pcm_hook_t *hook, *nhook;
 	int err = snd_pcm_generic_hw_free(pcm);
 	if (err < 0)
 		return err;
-	list_for_each_safe(pos, next, &h->hooks[SND_PCM_HOOK_TYPE_HW_FREE]) {
-		snd_pcm_hook_t *hook = list_entry(pos, snd_pcm_hook_t, list);
+	list_for_each_safe(&h->hooks[SND_PCM_HOOK_TYPE_HW_FREE], hook, nhook, list) {
 		err = hook->func(hook);
 		if (err < 0)
 			return err;
diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index 631ee0f..02b904d 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -318,14 +318,14 @@ static void snd_pcm_ladspa_free_eps(snd_pcm_ladspa_eps_t *eps)
 
 static void snd_pcm_ladspa_free_instances(snd_pcm_t *pcm, snd_pcm_ladspa_t *ladspa, int cleanup)
 {
-	struct list_head *list, *pos, *pos1, *next1;
+	struct list_head *list;
+	snd_pcm_ladspa_plugin_t *plugin;
 	unsigned int idx;
 	
 	list = pcm->stream == SND_PCM_STREAM_PLAYBACK ? &ladspa->pplugins : &ladspa->cplugins;
-	list_for_each(pos, list) {
-		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
-		list_for_each_safe(pos1, next1, &plugin->instances) {
-			snd_pcm_ladspa_instance_t *instance = list_entry(pos1, snd_pcm_ladspa_instance_t, list);
+	list_for_each(list, plugin, list) {
+		snd_pcm_ladspa_instance_t *instance, *ninstance;
+		list_for_each_safe(&plugin->instances, instance, ninstance, list) {
 			if (plugin->desc->deactivate)
 				plugin->desc->deactivate(instance->handle);
 			if (cleanup) {
@@ -614,6 +614,7 @@ static int snd_pcm_ladspa_allocate_instances(snd_pcm_t *pcm, snd_pcm_ladspa_t *l
 	unsigned int depth, idx, count;
         unsigned int in_channels;
 	unsigned int in_ports, out_ports;
+	snd_pcm_ladspa_plugin_t *plugin;
 	snd_pcm_ladspa_instance_t *instance = NULL;
 	int err;
 	
@@ -621,8 +622,7 @@ static int snd_pcm_ladspa_allocate_instances(snd_pcm_t *pcm, snd_pcm_ladspa_t *l
 	in_channels = ladspa->channels > 0 ? ladspa->channels :
 	              (pcm->stream == SND_PCM_STREAM_PLAYBACK ? pcm->channels : ladspa->plug.gen.slave->channels);
 	depth = 0;
-	list_for_each(pos, list) {
-		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
+	list_for_each(list, plugin, list) {
                 in_ports = snd_pcm_ladspa_count_ports(plugin, LADSPA_PORT_INPUT | LADSPA_PORT_AUDIO);
                 out_ports = snd_pcm_ladspa_count_ports(plugin, LADSPA_PORT_OUTPUT | LADSPA_PORT_AUDIO);
 		count = 1;
@@ -685,7 +685,8 @@ static LADSPA_Data *snd_pcm_ladspa_allocate_zero(snd_pcm_ladspa_t *ladspa, unsig
 
 static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *ladspa)
 {
-	struct list_head *list, *pos, *pos1;
+	struct list_head *list;
+	snd_pcm_ladspa_plugin_t *plugin;
 	snd_pcm_ladspa_instance_t *instance;
 	unsigned int channels = 16, nchannels;
 	unsigned int ichannels, ochannels;
@@ -706,10 +707,8 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
 	if (pchannels == NULL)
 	        return -ENOMEM;
 	list = pcm->stream == SND_PCM_STREAM_PLAYBACK ? &ladspa->pplugins : &ladspa->cplugins;
-	list_for_each(pos, list) {
-		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
-		list_for_each(pos1, &plugin->instances) {
-			instance = list_entry(pos1, snd_pcm_ladspa_instance_t, list);
+	list_for_each(list, plugin, list) {
+		list_for_each(&plugin->instances, instance, list) {
 			nchannels = channels;
 			for (idx = 0; idx < instance->input.channels.size; idx++) {
 			        chn = instance->input.channels.array[idx];
@@ -780,10 +779,8 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
 	/* next loop deallocates the last output LADSPA areas and connects */
 	/* them to ALSA areas (NULL) or dummy area ladpsa->free[1] ; */
 	/* this algorithm might be optimized to not allocate the last LADSPA outputs */
-	list_for_each(pos, list) {
-		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
-		list_for_each(pos1, &plugin->instances) {
-			instance = list_entry(pos1, snd_pcm_ladspa_instance_t, list);
+	list_for_each(list, plugin, list) {
+		list_for_each(&plugin->instances, instance, list) {
                         for (idx = 0; idx < instance->output.channels.size; idx++) {
         			chn = instance->output.channels.array[idx];
                                 if (instance->output.data[idx] == pchannels[chn]) {
@@ -805,10 +802,8 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
 #if 0
         printf("zero[0] = %p\n", ladspa->zero[0]);
         printf("zero[1] = %p\n", ladspa->zero[1]);
-	list_for_each(pos, list) {
-		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
-		list_for_each(pos1, &plugin->instances) {
-			instance = list_entry(pos1, snd_pcm_ladspa_instance_t, list);
+	list_for_each(list, plugin, list) {
+		list_for_each(&plugin->instances, instance, list) {
                         for (idx = 0; idx < instance->input.channels.size; idx++)
                                 printf("%i:alloc-input%i:  data = %p, m_data = %p\n", instance->depth, idx, instance->input.data[idx], instance->input.m_data[idx]);
                         for (idx = 0; idx < instance->output.channels.size; idx++)
@@ -857,8 +852,8 @@ snd_pcm_ladspa_write_areas(snd_pcm_t *pcm,
 			   snd_pcm_uframes_t *slave_sizep)
 {
 	snd_pcm_ladspa_t *ladspa = pcm->private_data;
+	snd_pcm_ladspa_plugin_t *plugin;
 	snd_pcm_ladspa_instance_t *instance;
-	struct list_head *pos, *pos1;
 	LADSPA_Data *data;
 	unsigned int idx, chn, size1, size2;
 	
@@ -874,11 +869,9 @@ snd_pcm_ladspa_write_areas(snd_pcm_t *pcm,
                 size1 = size;
                 if (size1 > ladspa->allocated)
                         size1 = ladspa->allocated;
-        	list_for_each(pos, &ladspa->pplugins) {
-        		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
-        		list_for_each(pos1, &plugin->instances) {
-        			instance = list_entry(pos1, snd_pcm_ladspa_instance_t, list);
-        			for (idx = 0; idx < instance->input.channels.size; idx++) {
+                list_for_each(&ladspa->pplugins, plugin, list) {
+                        list_for_each(&plugin->instances, instance, list) {
+                                for (idx = 0; idx < instance->input.channels.size; idx++) {
                                         chn = instance->input.channels.array[idx];
                                         data = instance->input.data[idx];
                                         if (data == NULL) {
@@ -918,8 +911,8 @@ snd_pcm_ladspa_read_areas(snd_pcm_t *pcm,
 			  snd_pcm_uframes_t *slave_sizep)
 {
 	snd_pcm_ladspa_t *ladspa = pcm->private_data;
+	snd_pcm_ladspa_plugin_t *plugin;
 	snd_pcm_ladspa_instance_t *instance;
-	struct list_head *pos, *pos1;
 	LADSPA_Data *data;
 	unsigned int idx, chn, size1, size2;;
 
@@ -935,11 +928,9 @@ snd_pcm_ladspa_read_areas(snd_pcm_t *pcm,
                 size1 = size;
                 if (size1 > ladspa->allocated)
                         size1 = ladspa->allocated;
-        	list_for_each(pos, &ladspa->cplugins) {
-        		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
-        		list_for_each(pos1, &plugin->instances) {
-        			instance = list_entry(pos1, snd_pcm_ladspa_instance_t, list);
-        			for (idx = 0; idx < instance->input.channels.size; idx++) {
+                list_for_each(&ladspa->cplugins, plugin, list) {
+                        list_for_each(&plugin->instances, instance, list) {
+                                for (idx = 0; idx < instance->input.channels.size; idx++) {
                                         chn = instance->input.channels.array[idx];
                                         data = instance->input.data[idx];
                                         if (data == NULL) {
@@ -1020,18 +1011,17 @@ static void snd_pcm_ladspa_dump_array(snd_output_t *out,
 
 static void snd_pcm_ladspa_plugins_dump(struct list_head *list, snd_output_t *out)
 {
-	struct list_head *pos, *pos2;
+	snd_pcm_ladspa_plugin_t *plugin;
 	
-	list_for_each(pos, list) {
-		snd_pcm_ladspa_plugin_t *plugin = list_entry(pos, snd_pcm_ladspa_plugin_t, list);
+	list_for_each(list, plugin, list) {
+		snd_pcm_ladspa_instance_t *in;
 		snd_output_printf(out, "    Policy: %s\n", plugin->policy == SND_PCM_LADSPA_POLICY_NONE ? "none" : "duplicate");
 		snd_output_printf(out, "    Filename: %s\n", plugin->filename);
 		snd_output_printf(out, "    Plugin Name: %s\n", plugin->desc->Name);
 		snd_output_printf(out, "    Plugin Label: %s\n", plugin->desc->Label);
 		snd_output_printf(out, "    Plugin Unique ID: %lu\n", plugin->desc->UniqueID);
                 snd_output_printf(out, "    Instances:\n");
-		list_for_each(pos2, &plugin->instances) {
-		        snd_pcm_ladspa_instance_t *in = (snd_pcm_ladspa_instance_t *) pos2;
+		list_for_each(&plugin->instances, in, list) {
 		        snd_output_printf(out, "      Depth: %i\n", in->depth);
 		        snd_output_printf(out, "         InChannels: ");
                         snd_pcm_ladspa_dump_array(out, &in->input.channels, NULL);
diff --git a/src/pcm/pcm_meter.c b/src/pcm/pcm_meter.c
index 034f582..39bc67d 100644
--- a/src/pcm/pcm_meter.c
+++ b/src/pcm/pcm_meter.c
@@ -186,11 +186,9 @@ static void *snd_pcm_meter_thread(void *data)
 	snd_pcm_t *pcm = data;
 	snd_pcm_meter_t *meter = pcm->private_data;
 	snd_pcm_t *spcm = meter->gen.slave;
-	struct list_head *pos;
 	snd_pcm_scope_t *scope;
 	int reset;
-	list_for_each(pos, &meter->scopes) {
-		scope = list_entry(pos, snd_pcm_scope_t, list);
+	list_for_each(&meter->scopes, scope, list) {
 		snd_pcm_scope_enable(scope);
 	}
 	while (!meter->closed) {
@@ -204,8 +202,7 @@ static void *snd_pcm_meter_thread(void *data)
 		    (status.state != SND_PCM_STATE_DRAINING ||
 		     spcm->stream != SND_PCM_STREAM_PLAYBACK)) {
 			if (meter->running) {
-				list_for_each(pos, &meter->scopes) {
-					scope = list_entry(pos, snd_pcm_scope_t, list);
+				list_for_each(&meter->scopes, scope, list) {
 					scope->ops->stop(scope);
 				}
 				meter->running = 0;
@@ -236,30 +233,26 @@ static void *snd_pcm_meter_thread(void *data)
 			}
 		}
 		if (reset) {
-			list_for_each(pos, &meter->scopes) {
-				scope = list_entry(pos, snd_pcm_scope_t, list);
+			list_for_each(&meter->scopes, scope, list) {
 				if (scope->enabled)
 					scope->ops->reset(scope);
 			}
 			continue;
 		}
 		if (!meter->running) {
-			list_for_each(pos, &meter->scopes) {
-				scope = list_entry(pos, snd_pcm_scope_t, list);
+			list_for_each(&meter->scopes, scope, list) {
 				if (scope->enabled)
 					scope->ops->start(scope);
 			}
 			meter->running = 1;
 		}
-		list_for_each(pos, &meter->scopes) {
-			scope = list_entry(pos, snd_pcm_scope_t, list);
+		list_for_each(&meter->scopes, scope, list) {
 			if (scope->enabled)
 				scope->ops->update(scope);
 		}
 	        nanosleep(&meter->delay, NULL);
 	}
-	list_for_each(pos, &meter->scopes) {
-		scope = list_entry(pos, snd_pcm_scope_t, list);
+	list_for_each(&meter->scopes, scope, list) {
 		if (scope->enabled)
 			snd_pcm_scope_disable(scope);
 	}
@@ -269,16 +262,14 @@ static void *snd_pcm_meter_thread(void *data)
 static int snd_pcm_meter_close(snd_pcm_t *pcm)
 {
 	snd_pcm_meter_t *meter = pcm->private_data;
-	struct list_head *pos, *npos;
+	snd_pcm_scope_t *scope, *nscope;
 	int err = 0;
 	pthread_mutex_destroy(&meter->update_mutex);
 	pthread_mutex_destroy(&meter->running_mutex);
 	pthread_cond_destroy(&meter->running_cond);
 	if (meter->gen.close_slave)
 		err = snd_pcm_close(meter->gen.slave);
-	list_for_each_safe(pos, npos, &meter->scopes) {
-		snd_pcm_scope_t *scope;
-		scope = list_entry(pos, snd_pcm_scope_t, list);
+	list_for_each_safe(&meter->scopes, scope, nscope, list) {
 		snd_pcm_scope_remove(scope);
 	}
 	if (meter->dl_handle)
@@ -860,12 +851,10 @@ int snd_pcm_meter_add_scope(snd_pcm_t *pcm, snd_pcm_scope_t *scope)
 snd_pcm_scope_t *snd_pcm_meter_search_scope(snd_pcm_t *pcm, const char *name)
 {
 	snd_pcm_meter_t *meter;
-	struct list_head *pos;
+	snd_pcm_scope_t *scope;
 	assert(pcm->type == SND_PCM_TYPE_METER);
 	meter = pcm->private_data;
-	list_for_each(pos, &meter->scopes) {
-		snd_pcm_scope_t *scope;
-		scope = list_entry(pos, snd_pcm_scope_t, list);
+	list_for_each(&meter->scopes, scope, list) {
 		if (scope->name && strcmp(scope->name, name) == 0)
 			return scope;
 	}
diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 4b68f1f..27c3280 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -137,7 +137,7 @@ static snd_pcm_uframes_t snd_pcm_share_slave_avail(snd_pcm_share_slave_t *slave)
 /* Return number of frames to mmap_commit the slave */
 static snd_pcm_uframes_t _snd_pcm_share_slave_forward(snd_pcm_share_slave_t *slave)
 {
-	struct list_head *i;
+	snd_pcm_share_t *share;
 	snd_pcm_uframes_t buffer_size;
 	snd_pcm_sframes_t frames, safety_frames;
 	snd_pcm_sframes_t min_frames, max_frames;
@@ -147,8 +147,7 @@ static snd_pcm_uframes_t _snd_pcm_share_slave_forward(snd_pcm_share_slave_t *sla
 	buffer_size = slave->pcm->buffer_size;
 	min_frames = slave_avail;
 	max_frames = 0;
-	list_for_each(i, &slave->clients) {
-		snd_pcm_share_t *share = list_entry(i, snd_pcm_share_t, list);
+	list_for_each(&slave->clients, share, list) {
 		snd_pcm_t *pcm = share->pcm;
 		switch (share->state) {
 		case SND_PCM_STATE_RUNNING:
@@ -338,11 +337,10 @@ static snd_pcm_uframes_t _snd_pcm_share_missing(snd_pcm_t *pcm)
 static snd_pcm_uframes_t _snd_pcm_share_slave_missing(snd_pcm_share_slave_t *slave)
 {
 	snd_pcm_uframes_t missing = INT_MAX;
-	struct list_head *i;
+	snd_pcm_share_t *share;
 	/* snd_pcm_sframes_t avail = */ snd_pcm_avail_update(slave->pcm);
 	slave->hw_ptr = *slave->pcm->hw.ptr;
-	list_for_each(i, &slave->clients) {
-		snd_pcm_share_t *share = list_entry(i, snd_pcm_share_t, list);
+	list_for_each(&slave->clients, share, list) {
 		snd_pcm_t *pcm = share->pcm;
 		snd_pcm_uframes_t m = _snd_pcm_share_missing(pcm);
 		if (m < missing)
@@ -1376,9 +1374,9 @@ int snd_pcm_share_open(snd_pcm_t **pcmp, const char *name, const char *sname,
 		       snd_pcm_stream_t stream, int mode)
 {
 	snd_pcm_t *pcm;
-	snd_pcm_share_t *share;
+	snd_pcm_share_t *share, *sh;
 	int err;
-	struct list_head *i;
+	snd_pcm_share_slave_t *s;
 	char slave_map[32] = { 0 };
 	unsigned int k;
 	snd_pcm_share_slave_t *slave = NULL;
@@ -1453,8 +1451,7 @@ int snd_pcm_share_open(snd_pcm_t **pcmp, const char *name, const char *sname,
 	}
 
 	Pthread_mutex_lock(&snd_pcm_share_slaves_mutex);
-	list_for_each(i, &snd_pcm_share_slaves) {
-		snd_pcm_share_slave_t *s = list_entry(i, snd_pcm_share_slave_t, list);
+	list_for_each(&snd_pcm_share_slaves, s, list) {
 		if (s->pcm->name && strcmp(s->pcm->name, sname) == 0) {
 			slave = s;
 			break;
@@ -1502,8 +1499,7 @@ int snd_pcm_share_open(snd_pcm_t **pcmp, const char *name, const char *sname,
 	} else {
 		Pthread_mutex_lock(&slave->mutex);
 		Pthread_mutex_unlock(&snd_pcm_share_slaves_mutex);
-		list_for_each(i, &slave->clients) {
-			snd_pcm_share_t *sh = list_entry(i, snd_pcm_share_t, list);
+		list_for_each(&slave->clients, sh, list) {
 			for (k = 0; k < sh->channels; ++k) {
 				if (slave_map[sh->slave_channels[k]]) {
 					SNDERR("Slave channel %d is already in use", sh->slave_channels[k]);
diff --git a/src/shmarea.c b/src/shmarea.c
index 071f9f3..80e0b37 100644
--- a/src/shmarea.c
+++ b/src/shmarea.c
@@ -98,11 +98,9 @@ void snd_shm_area_destructor(void) __attribute__ ((destructor));
 
 void snd_shm_area_destructor(void)
 {
-	struct list_head *pos;
 	struct snd_shm_area *area;
 
-	list_for_each(pos, &shm_areas) {
-		area = list_entry(pos, struct snd_shm_area, list);
+	list_for_each(&shm_areas, area, list) {
 		shmdt(area->ptr);
 	}
 }
diff --git a/src/ucm/main.c b/src/ucm/main.c
index 7e44603..48d6a26 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -65,7 +65,7 @@ static int list_count(struct list_head *list)
         struct list_head *pos;
         int count = 0;
         
-        list_for_each(pos, list) {
+        list_for_each_raw(list, pos) {
                 count += 1;
         }
         return count;
@@ -282,14 +282,12 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 			    struct list_head *value_list2,
 			    struct list_head *value_list3)
 {
-	struct list_head *pos;
 	struct sequence_element *s;
 	char *cdev = NULL;
 	snd_ctl_t *ctl = NULL;
 	int err = 0;
 
-	list_for_each(pos, seq) {
-		s = list_entry(pos, struct sequence_element, list);
+	list_for_each(seq, s, list) {
 		switch (s->type) {
 		case SEQUENCE_ELEMENT_TYPE_CDEV:
 			cdev = strdup(s->data.cdev);
@@ -406,11 +404,9 @@ static void *find0(struct list_head *list,
 		   unsigned long soffset,
 		   const char *match)
 {
-	struct list_head *pos;
 	char *ptr, *str;
 
-	list_for_each(pos, list) {
-		ptr = list_entry_offset(pos, char, offset);
+	list_for_each_off(list, ptr, offset) {
 		str = *((char **)(ptr + soffset));
 		if (strcmp(str, match) == 0)
 			return ptr;
@@ -437,7 +433,6 @@ static int get_list0(struct list_head *list,
 {
         char **res;
         int cnt;
-	struct list_head *pos;
 	char *ptr, *str1;
 
 	cnt = alloc_str_list(list, 1, &res);
@@ -446,8 +441,7 @@ static int get_list0(struct list_head *list,
 	        return cnt;
 	}
 	*result = (const char **)res;
-	list_for_each(pos, list) {
-		ptr = list_entry_offset(pos, char, offset);
+	list_for_each_off(list, ptr, offset) {
 		str1 = *((char **)(ptr + s1offset));
 		if (str1 != NULL) {
 		        *res = strdup(str1);
@@ -486,7 +480,6 @@ static int get_list20(struct list_head *list,
 {
         char **res;
         int cnt;
-	struct list_head *pos;
 	char *ptr, *str1, *str2;
 
 	cnt = alloc_str_list(list, 2, &res);
@@ -495,8 +488,7 @@ static int get_list20(struct list_head *list,
 	        return cnt;
 	}
         *result = (const char **)res;
-	list_for_each(pos, list) {
-		ptr = list_entry_offset(pos, char, offset);
+	list_for_each_off(list, ptr, offset) {
 		str1 = *((char **)(ptr + s1offset));
 		if (str1 != NULL) {
 		        *res = strdup(str1);
@@ -547,7 +539,6 @@ static int is_devlist_supported(snd_use_case_mgr_t *uc_mgr,
 {
 	struct dev_list_node *device;
 	struct use_case_device *adev;
-	struct list_head *pos, *pos1;
 	int found_ret;
 
 	switch (dev_list->type) {
@@ -562,12 +553,8 @@ static int is_devlist_supported(snd_use_case_mgr_t *uc_mgr,
 		break;
 	}
 
-	list_for_each(pos, &dev_list->list) {
-		device = list_entry(pos, struct dev_list_node, list);
-
-		list_for_each(pos1, &uc_mgr->active_devices) {
-			adev = list_entry(pos1, struct use_case_device,
-					    active_list);
+	list_for_each(&dev_list->list, device, list) {
+		list_for_each(&uc_mgr->active_devices, adev, active_list) {
 			if (!strcmp(device->name, adev->name))
 				return found_ret;
 		}
@@ -598,11 +585,8 @@ static inline struct use_case_device *
 		    const char *device_name, int check_supported)
 {
 	struct use_case_device *device;
-	struct list_head *pos;
-
-	list_for_each(pos, &verb->device_list) {
-		device = list_entry(pos, struct use_case_device, list);
 
+	list_for_each(&verb->device_list, device, list) {
 		if (strcmp(device_name, device->name))
 			continue;
 
@@ -626,11 +610,8 @@ static struct use_case_modifier *
 		      const char *modifier_name, int check_supported)
 {
 	struct use_case_modifier *modifier;
-	struct list_head *pos;
-
-	list_for_each(pos, &verb->modifier_list) {
-		modifier = list_entry(pos, struct use_case_modifier, list);
 
+	list_for_each(&verb->modifier_list, modifier, list) {
 		if (strcmp(modifier->name, modifier_name))
 			continue;
 
@@ -647,10 +628,8 @@ long device_status(snd_use_case_mgr_t *uc_mgr,
                    const char *device_name)
 {
         struct use_case_device *dev;
-        struct list_head *pos;
 
-        list_for_each(pos, &uc_mgr->active_devices) {
-                dev = list_entry(pos, struct use_case_device, active_list);
+        list_for_each(&uc_mgr->active_devices, dev, active_list) {
                 if (strcmp(dev->name, device_name) == 0)
                         return 1;
         }
@@ -661,10 +640,8 @@ long modifier_status(snd_use_case_mgr_t *uc_mgr,
                      const char *modifier_name)
 {
         struct use_case_modifier *mod;
-        struct list_head *pos;
 
-        list_for_each(pos, &uc_mgr->active_modifiers) {
-                mod = list_entry(pos, struct use_case_modifier, active_list);
+        list_for_each(&uc_mgr->active_modifiers, mod, active_list) {
                 if (strcmp(mod->name, modifier_name) == 0)
                         return 1;
         }
@@ -854,23 +831,18 @@ int snd_use_case_mgr_close(snd_use_case_mgr_t *uc_mgr)
  */
 static int dismantle_use_case(snd_use_case_mgr_t *uc_mgr)
 {
-	struct list_head *pos, *npos;
-	struct use_case_modifier *modifier;
-	struct use_case_device *device;
+	struct use_case_modifier *modifier, *nmodifier;
+	struct use_case_device *device, *ndevice;
 	int err;
 
-	list_for_each_safe(pos, npos, &uc_mgr->active_modifiers) {
-		modifier = list_entry(pos, struct use_case_modifier,
-				      active_list);
+	list_for_each_safe(&uc_mgr->active_modifiers, modifier, nmodifier, active_list) {
 		err = set_modifier(uc_mgr, modifier, 0);
 		if (err < 0)
 			uc_error("Unable to disable modifier %s", modifier->name);
 	}
 	INIT_LIST_HEAD(&uc_mgr->active_modifiers);
 
-	list_for_each_safe(pos, npos, &uc_mgr->active_devices) {
-		device = list_entry(pos, struct use_case_device,
-				    active_list);
+	list_for_each_safe(&uc_mgr->active_devices, device, ndevice, active_list) {
 		err = set_device(uc_mgr, device, 0);
 		if (err < 0)
 			uc_error("Unable to disable device %s", device->name);
@@ -1057,15 +1029,12 @@ static int add_values(struct list_head *list,
 {
         struct ucm_value *v;
         struct myvalue *val;
-        struct list_head *pos, *pos1;
         int match;
         
-        list_for_each(pos, source) {
-                v = list_entry(pos, struct ucm_value, list);
+        list_for_each(source, v, list) {
                 if (check_identifier(identifier, v->name)) {
                         match = 0;
-                        list_for_each(pos1, list) {
-                                val = list_entry(pos1, struct myvalue, list);
+                        list_for_each(list, val, list) {
                                 if (strcmp(val->value, v->data) == 0) {
                                         match = 1;
                                         break;
@@ -1094,8 +1063,8 @@ static int get_value_list(snd_use_case_mgr_t *uc_mgr,
                           const char **list[],
                           char *verbname)
 {
-        struct list_head mylist, *pos, *npos;
-        struct myvalue *val;
+        struct list_head mylist;
+        struct myvalue *val, *nval;
         struct use_case_verb *verb;
         struct use_case_device *dev;
         struct use_case_modifier *mod;
@@ -1116,14 +1085,12 @@ static int get_value_list(snd_use_case_mgr_t *uc_mgr,
         err = add_values(&mylist, identifier, &verb->value_list);
         if (err < 0)
                 goto __fail;
-        list_for_each(pos, &verb->device_list) {
-                dev = list_entry(pos, struct use_case_device, list);
+        list_for_each(&verb->device_list, dev, list) {
                 err = add_values(&mylist, identifier, &dev->value_list);
                 if (err < 0)
                         goto __fail;
         }
-        list_for_each(pos, &verb->modifier_list) {
-                mod = list_entry(pos, struct use_case_modifier, list);
+        list_for_each(&verb->modifier_list, mod, list) {
                 err = add_values(&mylist, identifier, &mod->value_list);
                 if (err < 0)
                         goto __fail;
@@ -1131,8 +1098,7 @@ static int get_value_list(snd_use_case_mgr_t *uc_mgr,
         err = alloc_str_list(&mylist, 1, &res);
         if (err >= 0) {
 	        *list = (const char **)res;
-                list_for_each(pos, &mylist) {
-                        val = list_entry(pos, struct myvalue, list);
+                list_for_each(&mylist, val, list) {
                         *res = strdup(val->value);
                         if (*res == NULL) {
                                 snd_use_case_free_list((const char **)res, err);
@@ -1143,8 +1109,7 @@ static int get_value_list(snd_use_case_mgr_t *uc_mgr,
                 }
         }
       __fail:
-        list_for_each_safe(pos, npos, &mylist) {
-                val = list_entry(pos, struct myvalue, list);
+        list_for_each_safe(&mylist, val, nval, list) {
                 list_del(&val->list);
                 free(val);
         }
@@ -1241,13 +1206,11 @@ static int get_value1(char **value, struct list_head *value_list,
                       const char *identifier)
 {
         struct ucm_value *val;
-        struct list_head *pos;
         
 	if (!value_list)
 		return -ENOENT;
 
-        list_for_each(pos, value_list) {
-              val = list_entry(pos, struct ucm_value, list);
+        list_for_each(value_list, val, list) {
               if (check_identifier(identifier, val->name)) {
                       *value = strdup(val->data);
                       if (*value == NULL)
@@ -1496,8 +1459,7 @@ static int handle_transition_verb(snd_use_case_mgr_t *uc_mgr,
         struct transition_sequence *trans;
         int err;
 
-        list_for_each(pos, &uc_mgr->active_verb->transition_list) {
-                trans = list_entry(pos, struct transition_sequence, list);
+        list_for_each(&uc_mgr->active_verb->transition_list, trans, list) {
                 if (strcmp(trans->name, new_verb->name) == 0) {
                         err = execute_sequence(uc_mgr, &trans->transition_list,
 					       &uc_mgr->active_verb->value_list,
@@ -1585,7 +1547,6 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
 {
         struct use_case_device *xold, *xnew;
         struct transition_sequence *trans;
-        struct list_head *pos;
         int err, seq_found = 0;
         
         if (uc_mgr->active_verb == NULL)
@@ -1607,8 +1568,7 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
         if (xnew == NULL)
                 return -ENOENT;
         err = 0;
-        list_for_each(pos, &xold->transition_list) {
-                trans = list_entry(pos, struct transition_sequence, list);
+        list_for_each(&xold->transition_list, trans, list) {
                 if (strcmp(trans->name, new_device) == 0) {
                         err = execute_sequence(uc_mgr, &trans->transition_list,
 					       &xold->value_list,
@@ -1659,8 +1619,7 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
         if (xnew == NULL)
                 return -ENOENT;
         err = 0;
-        list_for_each(pos, &xold->transition_list) {
-                trans = list_entry(pos, struct transition_sequence, list);
+        list_for_each(&xold->transition_list, trans, list) {
                 if (strcmp(trans->name, new_modifier) == 0) {
                         err = execute_sequence(uc_mgr, &trans->transition_list,
 					       &xold->value_list,
diff --git a/src/ucm/utils.c b/src/ucm/utils.c
index 45307b0..a6a3466 100644
--- a/src/ucm/utils.c
+++ b/src/ucm/utils.c
@@ -87,11 +87,9 @@ int uc_mgr_config_load(const char *file, snd_config_t **cfg)
 
 void uc_mgr_free_value(struct list_head *base)
 {
-	struct list_head *pos, *npos;
-	struct ucm_value *val;
+	struct ucm_value *val, *nval;
 	
-	list_for_each_safe(pos, npos, base) {
-		val = list_entry(pos, struct ucm_value, list);
+	list_for_each_safe(base, val, nval, list) {
 		free(val->name);
 		free(val->data);
 		list_del(&val->list);
@@ -101,11 +99,9 @@ void uc_mgr_free_value(struct list_head *base)
 
 void uc_mgr_free_dev_list(struct dev_list *dev_list)
 {
-	struct list_head *pos, *npos;
-	struct dev_list_node *dlist;
+	struct dev_list_node *dlist, *ndlist;
 	
-	list_for_each_safe(pos, npos, &dev_list->list) {
-		dlist = list_entry(pos, struct dev_list_node, list);
+	list_for_each_safe(&dev_list->list, dlist, ndlist, list) {
 		free(dlist->name);
 		list_del(&dlist->list);
 		free(dlist);
@@ -129,11 +125,9 @@ void uc_mgr_free_sequence_element(struct sequence_element *seq)
 
 void uc_mgr_free_sequence(struct list_head *base)
 {
-	struct list_head *pos, *npos;
-	struct sequence_element *seq;
+	struct sequence_element *seq, *nseq;
 	
-	list_for_each_safe(pos, npos, base) {
-		seq = list_entry(pos, struct sequence_element, list);
+	list_for_each_safe(base, seq, nseq, list) {
 		list_del(&seq->list);
 		uc_mgr_free_sequence_element(seq);
 	}
@@ -148,11 +142,9 @@ void uc_mgr_free_transition_element(struct transition_sequence *tseq)
 
 void uc_mgr_free_transition(struct list_head *base)
 {
-	struct list_head *pos, *npos;
-	struct transition_sequence *tseq;
+	struct transition_sequence *tseq, *ntseq;
 	
-	list_for_each_safe(pos, npos, base) {
-		tseq = list_entry(pos, struct transition_sequence, list);
+	list_for_each_safe(base, tseq, ntseq, list) {
 		list_del(&tseq->list);
 		uc_mgr_free_transition_element(tseq);
 	}
@@ -160,11 +152,9 @@ void uc_mgr_free_transition(struct list_head *base)
 
 void uc_mgr_free_modifier(struct list_head *base)
 {
-	struct list_head *pos, *npos;
-	struct use_case_modifier *mod;
+	struct use_case_modifier *mod, *nmod;
 	
-	list_for_each_safe(pos, npos, base) {
-		mod = list_entry(pos, struct use_case_modifier, list);
+	list_for_each_safe(base, mod, nmod, list) {
 		free(mod->name);
 		free(mod->comment);
 		uc_mgr_free_sequence(&mod->enable_list);
@@ -179,11 +169,9 @@ void uc_mgr_free_modifier(struct list_head *base)
 
 void uc_mgr_free_device(struct list_head *base)
 {
-	struct list_head *pos, *npos;
-	struct use_case_device *dev;
+	struct use_case_device *dev, *ndev;
 	
-	list_for_each_safe(pos, npos, base) {
-		dev = list_entry(pos, struct use_case_device, list);
+	list_for_each_safe(base, dev, ndev, list) {
 		free(dev->name);
 		free(dev->comment);
 		uc_mgr_free_sequence(&dev->enable_list);
@@ -198,11 +186,9 @@ void uc_mgr_free_device(struct list_head *base)
 
 void uc_mgr_free_verb(snd_use_case_mgr_t *uc_mgr)
 {
-	struct list_head *pos, *npos;
-	struct use_case_verb *verb;
+	struct use_case_verb *verb, *nverb;
 
-	list_for_each_safe(pos, npos, &uc_mgr->verb_list) {
-		verb = list_entry(pos, struct use_case_verb, list);
+	list_for_each_safe(&uc_mgr->verb_list, verb, nverb, list) {
 		free(verb->name);
 		free(verb->comment);
 		uc_mgr_free_sequence(&verb->enable_list);
-- 
2.1.0
