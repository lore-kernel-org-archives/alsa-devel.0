From: John Lindgren <john.lindgren@tds.net>
Subject: [PATCH] alsa-lib: snd_device_name_hint misbehaving
Date: Sun, 01 Nov 2009 21:23:06 -0500
Message-ID: <1257128586.16837.29.camel@dark-knight>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 42157245B3
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 03:23:18 +0100 (CET)
Received: by gxk2 with SMTP id 2so3875641gxk.4
	for <alsa-devel@alsa-project.org>; Sun, 01 Nov 2009 18:23:17 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

* Remove erroneous snd_config_delete calls that cause later calls to
snd_pcm_open to fail.

* Don't list card-independent PCM devices ("null" or PulseAudio, for
example) more than once even if multiple sound cards are installed.

* Add "ctl" to the list of device types that snd_device_name_hint can
search for.

* Cache the path to libasound.so within snd_dlopen rather than looking
it up with dladdr every call.

For a longer explanation:
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/022505.html

Signed-off-by: John Lindgren <john.lindgren@tds.net>

------

 src/conf.c             |    2 --
 src/control/namehint.c |   34 +++++++++++++++++++++++++++-------
 src/dlmisc.c           |   10 +++++++---
 3 files changed, 34 insertions(+), 12 deletions(-)

------

diff --git a/src/conf.c b/src/conf.c
index 570c90f..52a477c 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -1132,7 +1132,6 @@ static int parse_def(snd_config_t *parent, input_t *input, int skip, int overrid
 				free(id);
 				continue;
 			}
-			snd_config_delete(n);
 		}
 		if (mode == MERGE) {
 			SNDERR("%s does not exists", id);
@@ -1156,7 +1155,6 @@ static int parse_def(snd_config_t *parent, input_t *input, int skip, int overrid
 				skip = 1;
 				n = NULL;
 			} else if (mode == OVERRIDE) {
-				snd_config_delete(n);
 				n = NULL;
 			}
 		} else {
diff --git a/src/control/namehint.c b/src/control/namehint.c
index e878f83..ec9d04f 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -328,7 +328,6 @@ static int try_config(struct hint_list *list,
 	if (snd_config_search(cfg1, "slave", &cfg) >= 0 &&
 	    snd_config_search(cfg, base, &cfg1) >= 0)
 	    	goto __hint;
-	snd_config_delete(res);
 	res = NULL;
 	if (strchr(buf, ':') != NULL)
 		goto __ok;
@@ -379,8 +378,6 @@ static int try_config(struct hint_list *list,
 	      	err = hint_list_add(list, buf, buf1);
 	}
       __skip_add:
-      	if (res)
-	      	snd_config_delete(res);
 	if (buf1)
 		free(buf1);
       	free(buf);
@@ -450,13 +447,10 @@ static int add_card(struct hint_list *list, int card)
 		if (err == -EXDEV)
 			continue;
 		if (err < 0) {
+			list->card = card;
 			list->device = -1;
 			err = try_config(list, list->siface, str);
 		}
-		if (err < 0) {
-			list->card = -1;
-			err = try_config(list, list->siface, str);
-		}
 		if (err == -ENOMEM)
 			goto __error;
 	}
@@ -466,6 +460,29 @@ static int add_card(struct hint_list *list, int card)
 	return err;
 }
 
+static int add_software_devices(struct hint_list *list)
+{
+	int err;
+	snd_config_t *conf, *n;
+	snd_config_iterator_t i, next;
+	const char *str;
+
+	err = snd_config_search(snd_config, list->siface, &conf);
+	if (err < 0)
+		return err;
+	snd_config_for_each(i, next, conf) {
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &str) < 0)
+			continue;
+		list->card = -1;
+		list->device = -1;
+		err = try_config(list, list->siface, str);
+		if (err == -ENOMEM)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 static int get_card_name(struct hint_list *list, int card)
 {
 	char scard[16], *s;
@@ -532,6 +549,8 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 		list.iface = SND_CTL_ELEM_IFACE_SEQUENCER;
 	else if (strcmp(iface, "hwdep") == 0)
 		list.iface = SND_CTL_ELEM_IFACE_HWDEP;
+	else if (strcmp(iface, "ctl") == 0)
+		list.iface = SND_CTL_ELEM_IFACE_MIXER;
 	else
 		return -EINVAL;
 	list.show_all = 0;
@@ -543,6 +562,7 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 		if (err >= 0)
 			err = add_card(&list, card);
 	} else {
+		add_software_devices(&list);
 		err = snd_card_next(&card);
 		if (err < 0)
 			goto __error;
diff --git a/src/dlmisc.c b/src/dlmisc.c
index c882cdc..3cca0f0 100644
--- a/src/dlmisc.c
+++ b/src/dlmisc.c
@@ -54,9 +54,13 @@ void *snd_dlopen(const char *name, int mode)
 #else
 #ifdef HAVE_LIBDL
 	if (name == NULL) {
-		Dl_info dlinfo;
-		if (dladdr(snd_dlopen, &dlinfo) > 0)
-			name = dlinfo.dli_fname;
+		static const char * self = NULL;
+		if (self == NULL) {
+			Dl_info dlinfo;
+			if (dladdr(snd_dlopen, &dlinfo) > 0)
+				self = dlinfo.dli_fname;
+		}
+		name = self;
 	}
 #endif
 #endif
