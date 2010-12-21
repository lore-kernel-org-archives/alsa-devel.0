From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 09/11] ucm: only select modifier when supported
	device is enabled
Date: Tue, 21 Dec 2010 22:11:58 +0000
Message-ID: <1292969520-18047-10-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E53BD103A3E
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:25 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so4322500wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:25 -0800 (PST)
In-Reply-To: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Make sure the supported device of a modifier is enabled before
we enable the modifier.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 src/ucm/main.c |   54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 4c13547..5f44461 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -463,19 +463,52 @@ static inline struct use_case_device *
 		    device_name);
 }
 
+static int is_modifier_supported(snd_use_case_mgr_t *uc_mgr, 
+	struct use_case_modifier *modifier)
+{
+	struct dev_list *device;
+	struct list_head *pos;
+
+	list_for_each(pos, &modifier->dev_list) {
+		device = list_entry(pos, struct dev_list, list);
+		if (find(&uc_mgr->active_devices,
+		    struct use_case_device, active_list, name, device->name))
+			return 1;
+		
+	}
+	return 0;
+}
+
 /**
  * \brief Find modifier
  * \param verb Use case verb
  * \param modifier_name modifier to find
  * \return structure on success, otherwise a NULL (not found)
  */
-static inline struct use_case_modifier *
-        find_modifier(struct use_case_verb *verb,
-                      const char *modifier_name)
+static struct use_case_modifier *
+        find_modifier(snd_use_case_mgr_t *uc_mgr, const char *modifier_name)
 {
-	return find(&verb->modifier_list,
-		    struct use_case_modifier, list, name,
-		    modifier_name);
+	struct use_case_modifier *modifier;
+	struct use_case_verb *verb = uc_mgr->active_verb;
+	struct list_head *pos;
+	char name[64], *cpos;
+
+	list_for_each(pos, &verb->modifier_list) {
+		modifier = list_entry(pos, struct use_case_modifier, list);
+
+		strncpy(name, modifier->name, sizeof(name));
+		cpos = strchr(name, '.');
+		if (!cpos)
+			continue;
+		*cpos= '\0';
+
+		if (strcmp(name, modifier_name))
+			continue;
+
+		if (is_modifier_supported(uc_mgr, modifier))
+			return modifier;
+	}
+	return NULL;
 }
 
 /**
@@ -1011,7 +1044,7 @@ static int get_value(snd_use_case_mgr_t *uc_mgr,
 	int err;
 
 	if (modifier != NULL) {
-	        mod = find_modifier(uc_mgr->active_verb, modifier);
+	        mod = find_modifier(uc_mgr, modifier);
 		if (mod != NULL) {
 			err = get_value1(value, &mod->value_list, identifier);
 			if (err >= 0 || err != -ENOENT)
@@ -1242,7 +1275,8 @@ static int set_modifier_user(snd_use_case_mgr_t *uc_mgr,
 
         if (uc_mgr->active_verb == NULL)
                 return -ENOENT;
-        modifier = find_modifier(uc_mgr->active_verb, modifier_name);
+
+        modifier = find_modifier(uc_mgr, modifier_name);
         if (modifier == NULL)
                 return -ENOENT;
         return set_modifier(uc_mgr, modifier, enable);
@@ -1319,10 +1353,10 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
                 uc_error("error: modifier %s already enabled", new_modifier);
                 return -EINVAL;
         }
-        xold = find_modifier(uc_mgr->active_verb, old_modifier);
+        xold = find_modifier(uc_mgr, old_modifier);
         if (xold == NULL)
                 return -ENOENT;
-        xnew = find_modifier(uc_mgr->active_verb, new_modifier);
+        xnew = find_modifier(uc_mgr, new_modifier);
         if (xnew == NULL)
                 return -ENOENT;
         err = 0;
-- 
1.7.1
