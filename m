From: John Lindgren <john.lindgren@tds.net>
Subject: Patches for libasound to support upcoming Audacious 2.2
Date: Sun, 25 Oct 2009 22:21:09 -0400
Message-ID: <1256523669.24282.46.camel@dark-knight>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OP5nhNcMe/WU3EKxBkkC"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DA7C1037F2
	for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2009 03:21:17 +0100 (CET)
Received: by yxe34 with SMTP id 34so9533474yxe.16
	for <alsa-devel@alsa-project.org>; Sun, 25 Oct 2009 19:21:16 -0700 (PDT)
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
Cc: William Pitcock <nenolod@atheme.org>
List-Id: alsa-devel@alsa-project.org


--=-OP5nhNcMe/WU3EKxBkkC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I've been working on the ALSA output for the upcoming 2.2 release of
Audacious media player and have run into some problems in
snd_device_name_hint, which is now used to show the user a list of
possible output devices.  I've written patches which correct those
problems.

The biggest problem is that in several places, functions called by
snd_device_name_hint call snd_config_delete on sections of the config
returned by snd_config_search.  Once these sections are deleted, future
calls to snd_pcm_open fail miserably.

        ALSA lib conf.c:4600:(snd_config_expand) Unknown parameters CARD=ICH6,DEV=0
        ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM front:CARD=ICH6,DEV=0
        alsa-gapless: snd_pcm_open failed: Invalid argument.

        ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM pulse
        alsa-gapless: snd_pcm_open failed: No such file or directory.

A smaller but still annoying problem shows up only once the offending
snd_config_delete calls are taken out: software devices, such as "pulse"
and "null" are listed twice or three times depending on how many
hardware devices I have plugged in.

A third problem is that "ctl" seems to be arbitrarily left out of the
list of device types that snd_device_name_hint will search for.  I've
added it to the list in this patch, and it seems to work fine.

Finally, a performance issue: snd_device_name_hint indirectly calls
snd_dlopen frequently with the parameter name == NULL, meaning to open
libasound.so itself.  In this case, snd_dlopen calls dladdr every call
to find out the path to libasound.so.  Caching this path within
snd_dlopen so that dladdr is called only once speeds up the execution
time of snd_device_name_hint (a somewhat slow call) by 40%.

I am attaching three patches that fix these problems:
 - src/conf.c
 - src/dlmisc.c
 - src/control/namehint.c

Peace,
John Lindgren

--=-OP5nhNcMe/WU3EKxBkkC
Content-Disposition: attachment; filename="conf.c.diff"
Content-Type: text/x-patch; name="conf.c.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- conf.0.c	2009-09-09 08:34:54.000000000 -0400
+++ conf.c	2009-10-24 11:35:28.000000000 -0400
@@ -1132,7 +1132,6 @@
 				free(id);
 				continue;
 			}
-			snd_config_delete(n);
 		}
 		if (mode == MERGE) {
 			SNDERR("%s does not exists", id);
@@ -1156,7 +1155,6 @@
 				skip = 1;
 				n = NULL;
 			} else if (mode == OVERRIDE) {
-				snd_config_delete(n);
 				n = NULL;
 			}
 		} else {

--=-OP5nhNcMe/WU3EKxBkkC
Content-Disposition: attachment; filename="dlmisc.c.diff"
Content-Type: text/x-patch; name="dlmisc.c.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- dlmisc.0.c	2009-09-09 08:34:54.000000000 -0400
+++ dlmisc.c	2009-10-24 11:57:46.000000000 -0400
@@ -54,9 +54,13 @@
 #else
 #ifdef HAVE_LIBDL
 	if (name == NULL) {
-		Dl_info dlinfo;
-		if (dladdr(snd_dlopen, &dlinfo) > 0)
-			name = dlinfo.dli_fname;
+		static const char * self = NULL;
+		if (self == NULL) {
+			static Dl_info dlinfo;
+			if (dladdr(snd_dlopen, &dlinfo) > 0)
+				self = dlinfo.dli_fname;
+		}
+		name = self;
 	}
 #endif
 #endif

--=-OP5nhNcMe/WU3EKxBkkC
Content-Disposition: attachment; filename="namehint.c.diff"
Content-Type: text/x-patch; name="namehint.c.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- namehint.0.c	2009-09-09 08:34:54.000000000 -0400
+++ namehint.c	2009-10-25 21:38:54.000000000 -0400
@@ -328,7 +328,6 @@
 	if (snd_config_search(cfg1, "slave", &cfg) >= 0 &&
 	    snd_config_search(cfg, base, &cfg1) >= 0)
 	    	goto __hint;
-	snd_config_delete(res);
 	res = NULL;
 	if (strchr(buf, ':') != NULL)
 		goto __ok;
@@ -379,8 +378,6 @@
 	      	err = hint_list_add(list, buf, buf1);
 	}
       __skip_add:
-      	if (res)
-	      	snd_config_delete(res);
 	if (buf1)
 		free(buf1);
       	free(buf);
@@ -450,13 +447,10 @@
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
@@ -466,6 +460,29 @@
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
@@ -532,6 +549,8 @@
 		list.iface = SND_CTL_ELEM_IFACE_SEQUENCER;
 	else if (strcmp(iface, "hwdep") == 0)
 		list.iface = SND_CTL_ELEM_IFACE_HWDEP;
+	else if (strcmp(iface, "ctl") == 0)
+		list.iface = SND_CTL_ELEM_IFACE_MIXER;
 	else
 		return -EINVAL;
 	list.show_all = 0;
@@ -543,6 +562,7 @@
 		if (err >= 0)
 			err = add_card(&list, card);
 	} else {
+		add_software_devices(&list);
 		err = snd_card_next(&card);
 		if (err < 0)
 			goto __error;

--=-OP5nhNcMe/WU3EKxBkkC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-OP5nhNcMe/WU3EKxBkkC--
