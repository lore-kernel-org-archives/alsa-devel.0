From: Jerome Forissier <jerome@taodyne.com>
Subject: [PATCH 3/3] snd_device_name_hint(): do not use global
	snd_config.
Date: Thu, 31 Jan 2013 15:47:25 +0100
Message-ID: <1359643645-33558-4-git-send-email-jerome@taodyne.com>
References: <1359643645-33558-1-git-send-email-jerome@taodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ubuntu (102.30.7.109.rev.sfr.net [109.7.30.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 12CEF260728
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 15:47:34 +0100 (CET)
In-Reply-To: <1359643645-33558-1-git-send-email-jerome@taodyne.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jerome Forissier <jerome@taodyne.com>
List-Id: alsa-devel@alsa-project.org

This commit and its parent make the function reentrant.

Signed-off-by: Jerome Forissier <jerome@taodyne.com>
---
 src/control/namehint.c | 52 +++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index defc036..8d5e925 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -209,7 +209,8 @@ static char *get_dev_name(struct hint_list *list)
 #define BUF_SIZE 128
 #endif
 
-static int try_config(struct hint_list *list,
+static int try_config(snd_config_t *config,
+		      struct hint_list *list,
 		      const char *base,
 		      const char *name)
 {
@@ -229,7 +230,7 @@ static int try_config(struct hint_list *list,
 		return -ENOMEM;
 	sprintf(buf, "%s.%s", base, name);
 	/* look for redirection */
-	if (snd_config_search(snd_config, buf, &cfg) >= 0 &&
+	if (snd_config_search(config, buf, &cfg) >= 0 &&
 	    snd_config_get_string(cfg, &str) >= 0 &&
 	    ((strncmp(base, str, strlen(base)) == 0 &&
 	     str[strlen(base)] == '.') || strchr(str, '.') == NULL))
@@ -241,7 +242,7 @@ static int try_config(struct hint_list *list,
 	else
 		strcpy(buf, name);
 	eh = snd_lib_error_set_local(&zero_handler);
-	err = snd_config_search_definition(snd_config, base, buf, &res);
+	err = snd_config_search_definition(config, base, buf, &res);
 	snd_lib_error_set_local(eh);
 	if (err < 0)
 		goto __skip_add;
@@ -338,7 +339,7 @@ static int try_config(struct hint_list *list,
 	/* find, if all parameters have a default, */
 	/* otherwise filter this definition */
 	eh = snd_lib_error_set_local(&zero_handler);
-	err = snd_config_search_alias_hooks(snd_config, base, buf, &res);
+	err = snd_config_search_alias_hooks(config, base, buf, &res);
 	snd_lib_error_set_local(eh);
 	if (err < 0)
 		goto __cleanup;
@@ -405,7 +406,7 @@ static const next_devices_t next_devices[] = {
 };
 #endif
 
-static int add_card(struct hint_list *list, int card)
+static int add_card(snd_config_t *config, struct hint_list *list, int card)
 {
 	int err, ok;
 	snd_config_t *conf, *n;
@@ -417,7 +418,7 @@ static int add_card(struct hint_list *list, int card)
 	
 	snd_ctl_card_info_alloca(&info);
 	list->info = info;
-	err = snd_config_search(snd_config, list->siface, &conf);
+	err = snd_config_search(config, list->siface, &conf);
 	if (err < 0)
 		return err;
 	sprintf(ctl_name, "hw:%i", card);
@@ -448,7 +449,7 @@ static int add_card(struct hint_list *list, int card)
 			ok = 0;
 			for (device = 0; err >= 0 && device <= max_device; device++) {
 				list->device = device;
-				err = try_config(list, list->siface, str);
+				err = try_config(config, list, list->siface, str);
 				if (err < 0)
 					break;
 				ok++;
@@ -463,7 +464,7 @@ static int add_card(struct hint_list *list, int card)
 		if (err < 0) {
 			list->card = card;
 			list->device = -1;
-			err = try_config(list, list->siface, str);
+			err = try_config(config, list, list->siface, str);
 		}
 		if (err == -ENOMEM)
 			goto __error;
@@ -492,14 +493,14 @@ static int get_card_name(struct hint_list *list, int card)
 	return 0;
 }
 
-static int add_software_devices(struct hint_list *list)
+static int add_software_devices(snd_config_t *config, struct hint_list *list)
 {
 	int err;
 	snd_config_t *conf, *n;
 	snd_config_iterator_t i, next;
 	const char *str;
 
-	err = snd_config_search(snd_config, list->siface, &conf);
+	err = snd_config_search(config, list->siface, &conf);
 	if (err < 0)
 		return err;
 	snd_config_for_each(i, next, conf) {
@@ -508,7 +509,7 @@ static int add_software_devices(struct hint_list *list)
 			continue;
 		list->card = -1;
 		list->device = -1;
-		err = try_config(list, list->siface, str);
+		err = try_config(config, list, list->siface, str);
 		if (err == -ENOMEM)
 			return -ENOMEM;
 	}
@@ -546,13 +547,14 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 	struct hint_list list;
 	char ehints[24];
 	const char *str;
-	snd_config_t *conf;
+	snd_config_t *conf, *local_config = NULL;
+	snd_config_update_t *local_config_update = NULL;
 	snd_config_iterator_t i, next;
 	int err;
 
 	if (hints == NULL)
 		return -EINVAL;
-	err = snd_config_update();
+	err = snd_config_update_r(&local_config, &local_config_update, NULL);
 	if (err < 0)
 		return err;
 	list.list = NULL;
@@ -572,18 +574,21 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 		list.iface = SND_CTL_ELEM_IFACE_HWDEP;
 	else if (strcmp(iface, "ctl") == 0)
 		list.iface = SND_CTL_ELEM_IFACE_MIXER;
-	else
-		return -EINVAL;
+	else {
+		err = -EINVAL;
+		goto __error;
+	}
+
 	list.show_all = 0;
 	list.cardname = NULL;
-	if (snd_config_search(snd_config, "defaults.namehint.showall", &conf) >= 0)
+	if (snd_config_search(local_config, "defaults.namehint.showall", &conf) >= 0)
 		list.show_all = snd_config_get_bool(conf) > 0;
 	if (card >= 0) {
 		err = get_card_name(&list, card);
 		if (err >= 0)
-			err = add_card(&list, card);
+			err = add_card(local_config, &list, card);
 	} else {
-		add_software_devices(&list);
+		add_software_devices(local_config, &list);
 		err = snd_card_next(&card);
 		if (err < 0)
 			goto __error;
@@ -591,7 +596,7 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 			err = get_card_name(&list, card);
 			if (err < 0)
 				goto __error;
-			err = add_card(&list, card);
+			err = add_card(local_config, &list, card);
 			if (err < 0)
 				goto __error;
 			err = snd_card_next(&card);
@@ -600,7 +605,7 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 		}
 	}
 	sprintf(ehints, "namehint.%s", list.siface);
-	err = snd_config_search(snd_config, ehints, &conf);
+	err = snd_config_search(local_config, ehints, &conf);
 	if (err >= 0) {
 		snd_config_for_each(i, next, conf) {
 			if (snd_config_get_string(snd_config_iterator_entry(i),
@@ -617,7 +622,6 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
       		snd_device_name_free_hint((void **)list.list);
       		if (list.cardname)
 	      		free(list.cardname);
-      		return err;
       	} else {
       		err = hint_list_add(&list, NULL, NULL);
       		if (err < 0)
@@ -626,7 +630,11 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
       		if (list.cardname)
 	      		free(list.cardname);
 	}
-      	return 0;
+	if (local_config)
+		snd_config_delete(local_config);
+	if (local_config_update)
+		snd_config_update_free(local_config_update);
+	return err;
 }
 
 /**
-- 
1.8.1.2
