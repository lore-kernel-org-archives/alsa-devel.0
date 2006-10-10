From: Jaroslav Kysela <perex@suse.cz>
Subject: RFC: provide a device name list for applications
Date: Tue, 10 Oct 2006 15:45:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610101530410.9410@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DE86B17E
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Oct 2006 15:45:55 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	AA6379941E for <alsa-devel@alsa-project.org>;
	Tue, 10 Oct 2006 15:45:55 +0200 (MEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	7A715E9486 for <alsa-devel@alsa-project.org>;
	Tue, 10 Oct 2006 15:45:55 +0200 (CEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

	here is my proposal to provide (a long waited feature) a device 
name list for applications (especially for GUI). The work is not finished, 
but the patch bellow gives already useful hints like (for PCM devices):

hw:CARD=Intel,DEV=0
hw:CARD=Intel,DEV=1
hw:CARD=Intel,DEV=2
hw:CARD=Intel,DEV=6
plughw:CARD=Intel,DEV=0
plughw:CARD=Intel,DEV=1
plughw:CARD=Intel,DEV=2
plughw:CARD=Intel,DEV=6
plug
shm
tee
file
null

	Things to do:

- provide device description behind '|' separator - add this description
  to configuration files
- some virtual devices does not make sense without arguments (like file) -
  add a list off switch 
- gather virtual devices from configuration files probably from
  namehint.pcm tree:

namehint.pcm [
	"file:FILE=/tmp/soundwave.raw|Save sound output to /tmp/soundwave.raw file"
	"plug:front|Do all conversions for front speakers"
]

- sorting / ordering of resulted hints? any hints from you? ;-) maybe add
  a wieght to config files?

						Jaroslav

diff -r cbe0a9529254 include/control.h
--- a/include/control.h	Fri Oct 06 15:22:34 2006 +0200
+++ b/include/control.h	Tue Oct 10 15:34:55 2006 +0200
@@ -213,6 +213,9 @@ int snd_card_get_index(const char *name)
 int snd_card_get_index(const char *name);
 int snd_card_get_name(int card, char **name);
 int snd_card_get_longname(int card, char **name);
+
+int snd_device_name_hint(int card, snd_ctl_elem_iface_t iface, char ***hints);
+int snd_device_name_free_hint(char **hints);
 
 int snd_ctl_open(snd_ctl_t **ctl, const char *name, int mode);
 int snd_ctl_open_lconf(snd_ctl_t **ctl, const char *name, int mode, snd_config_t *lconf);
@@ -256,6 +259,7 @@ snd_ctl_type_t snd_ctl_type(snd_ctl_t *c
 
 const char *snd_ctl_elem_type_name(snd_ctl_elem_type_t type);
 const char *snd_ctl_elem_iface_name(snd_ctl_elem_iface_t iface);
+const char *snd_ctl_iface_conf_name(snd_ctl_elem_iface_t iface);
 const char *snd_ctl_event_type_name(snd_ctl_event_type_t type);
 
 unsigned int snd_ctl_event_elem_get_mask(const snd_ctl_event_t *obj);
diff -r cbe0a9529254 include/local.h
--- a/include/local.h	Fri Oct 06 15:22:34 2006 +0200
+++ b/include/local.h	Tue Oct 10 15:34:55 2006 +0200
@@ -259,4 +259,8 @@ int snd_config_check_hop(snd_config_t *c
 int snd_config_check_hop(snd_config_t *conf);
 #define SND_CONF_MAX_HOPS	64
 
-#endif
+int snd_config_search_alias_hooks(snd_config_t *config,
+                                  const char *base, const char *key,
+				  snd_config_t **result);
+
+#endif
diff -r cbe0a9529254 src/Versions
--- a/src/Versions	Fri Oct 06 15:22:34 2006 +0200
+++ b/src/Versions	Tue Oct 10 15:34:55 2006 +0200
@@ -288,3 +288,11 @@ ALSA_1.0.12 {
     snd_hctl_elem_tlv_write;
     snd_hctl_elem_tlv_command;
 } ALSA_1.0.11;
+
+ALSA_1.0.14 {
+  global:
+
+    snd_device_name_hint;
+    snd_device_name_free_hint;
+    snd_ctl_iface_conf_name;
+} ALSA_1.0.12;
diff -r cbe0a9529254 src/conf.c
--- a/src/conf.c	Fri Oct 06 15:22:34 2006 +0200
+++ b/src/conf.c	Tue Oct 10 15:34:55 2006 +0200
@@ -3935,6 +3935,10 @@ int snd_config_expand(snd_config_t *conf
 	snd_config_t *defs, *subs = NULL, *res;
 	err = snd_config_search(config, "@args", &defs);
 	if (err < 0) {
+		if (args != NULL) {
+			SNDERR("Unknown parameters %s", args);
+			return -EINVAL;
+		}
 		err = snd_config_copy(&res, config);
 		if (err < 0)
 			return err;
diff -r cbe0a9529254 src/control/Makefile.am
--- a/src/control/Makefile.am	Fri Oct 06 15:22:34 2006 +0200
+++ b/src/control/Makefile.am	Tue Oct 10 15:34:55 2006 +0200
@@ -1,6 +1,6 @@ EXTRA_LTLIBRARIES = libcontrol.la
 EXTRA_LTLIBRARIES = libcontrol.la
 
-libcontrol_la_SOURCES = cards.c hcontrol.c \
+libcontrol_la_SOURCES = cards.c namehint.c hcontrol.c \
                         control.c control_hw.c control_shm.c \
 			control_ext.c setup.c control_symbols.c
 
diff -r cbe0a9529254 src/control/control.c
--- a/src/control/control.c	Fri Oct 06 15:22:34 2006 +0200
+++ b/src/control/control.c	Tue Oct 10 15:34:55 2006 +0200
@@ -950,6 +950,7 @@ int snd_ctl_open_lconf(snd_ctl_t **ctlp,
 #ifndef DOC_HIDDEN
 #define TYPE(v) [SND_CTL_ELEM_TYPE_##v] = #v
 #define IFACE(v) [SND_CTL_ELEM_IFACE_##v] = #v
+#define IFACE1(v, n) [SND_CTL_ELEM_IFACE_##v] = #n
 #define EVENT(v) [SND_CTL_EVENT_##v] = #v
 
 static const char *snd_ctl_elem_type_names[] = {
@@ -972,6 +973,16 @@ static const char *snd_ctl_elem_iface_na
 	IFACE(SEQUENCER),
 };
 
+static const char *snd_ctl_iface_conf_names[] = {
+	IFACE1(CARD, card),
+	IFACE1(HWDEP, hwdep),
+	IFACE1(MIXER, mixer),
+	IFACE1(PCM, pcm),
+	IFACE1(RAWMIDI, rawmidi),
+	IFACE1(TIMER, timer),
+	IFACE1(SEQUENCER, seq),
+};
+
 static const char *snd_ctl_event_type_names[] = {
 	EVENT(ELEM),
 };
@@ -997,6 +1008,17 @@ const char *snd_ctl_elem_iface_name(snd_
 {
 	assert(iface <= SND_CTL_ELEM_IFACE_LAST);
 	return snd_ctl_elem_iface_names[iface];
+}
+
+/**
+ * \brief get configuration name of related interface
+ * \param iface ala CTL interface identification
+ * \return ascii name of configuration interface
+ */
+const char *snd_ctl_iface_conf_name(snd_ctl_elem_iface_t iface)
+{
+	assert(iface <= SND_CTL_ELEM_IFACE_LAST);
+	return snd_ctl_iface_conf_names[iface];
 }
 
 /**
diff -r cbe0a9529254 test/Makefile.am
--- a/test/Makefile.am	Fri Oct 06 15:22:34 2006 +0200
+++ b/test/Makefile.am	Tue Oct 10 15:34:55 2006 +0200
@@ -1,6 +1,6 @@ check_PROGRAMS=control pcm pcm_min laten
 check_PROGRAMS=control pcm pcm_min latency seq \
 	       playmidi1 timer rawmidi midiloop \
-	       oldapi queue_timer
+	       oldapi queue_timer namehint
 
 control_LDADD=../src/libasound.la
 pcm_LDADD=../src/libasound.la
@@ -13,6 +13,7 @@ midiloop_LDADD=../src/libasound.la
 midiloop_LDADD=../src/libasound.la
 oldapi_LDADD=../src/libasound.la
 queue_timer_LDADD=../src/libasound.la
+namehint_LDADD=../src/libasound.la
 code_CFLAGS=-Wall -pipe -g -O2
 
 INCLUDES=-I$(top_srcdir)/include
diff -r cbe0a9529254 src/control/namehint.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/src/control/namehint.c	Tue Oct 10 15:34:55 2006 +0200
@@ -0,0 +1,264 @@
+/**
+ * \file control/namehint.c
+ * \brief Give device name hints
+ * \author Jaroslav Kysela <perex@suse.cz>
+ * \date 2006
+ */
+/*
+ *  Give device name hints  - main file
+ *  Copyright (c) 2006 by Jaroslav Kysela <perex@suse.cz>
+ *
+ *
+ *   This library is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU Lesser General Public License as
+ *   published by the Free Software Foundation; either version 2.1 of
+ *   the License, or (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include "local.h"
+
+struct hint_list {
+	char **list;
+	unsigned int count;
+	unsigned int allocated;
+};
+
+static int hint_list_add(struct hint_list *list,
+			 const char *name,
+			 const char *description)
+{
+	char *x;
+
+	if (list->count == list->allocated) {
+		char **n = realloc(list->list, (list->allocated + 10) * sizeof(char *));
+		if (n == NULL)
+			return -ENOMEM;
+		list->allocated += 10;
+		list->list = n;
+	}
+	if (name == NULL) {
+		x = NULL;
+	} else {
+		x = malloc(strlen(name) + (description != NULL ? (strlen(description) + 1) : 0) + 1);
+		if (x == NULL)
+			return -ENOMEM;
+		strcpy(x, name);
+		if (description != NULL) {
+			strcat(x, "|");
+			strcat(x, description);
+		}
+	}
+	list->list[list->count++] = x;
+	return 0;
+}
+
+static void zero_handler(const char *file ATTRIBUTE_UNUSED,
+			 int line ATTRIBUTE_UNUSED,
+			 const char *function ATTRIBUTE_UNUSED,
+			 int err ATTRIBUTE_UNUSED,
+			 const char *fmt ATTRIBUTE_UNUSED, ...)
+{
+}
+
+static int try_config(struct hint_list *list,
+		      const char *base,
+		      const char *fmt, ...)
+{
+	va_list arg;
+	snd_lib_error_handler_t eh;
+	snd_config_t *res;
+	char *buf = malloc(512);
+	int err;
+
+	if (buf == NULL)
+		return -ENOMEM;
+	va_start(arg, fmt);
+	vsnprintf(buf, 512, fmt, arg);
+	buf[512-1] = '\0';
+	va_end(arg);
+	eh = snd_lib_error;
+	snd_lib_error_set_handler(&zero_handler);		
+	err = snd_config_search_definition(snd_config, base, buf, &res);
+	snd_lib_error_set_handler(eh);
+	if (err < 0)
+		return err;
+	err = -EINVAL;
+	if (snd_config_get_type(res) != SND_CONFIG_TYPE_COMPOUND)
+		goto __cleanup;
+	if (snd_config_search(res, "type", NULL) < 0)
+		goto __cleanup;
+	err = 0;
+#if 0	/* for debug purposes */
+		{
+			snd_output_t *out;
+			printf("********* PCM '%s':\n", buf);
+			snd_output_stdio_attach(&out, stderr, 0);
+			snd_config_save(res, out);
+			snd_output_close(out);
+			printf("\n");
+		}
+#endif
+      __cleanup:
+      	snd_config_delete(res);
+      	if (err >= 0)
+	      	err = hint_list_add(list, buf, NULL);
+      	free(buf);
+	return err;
+}
+
+#ifndef DOC_HIDDEN
+#define IFACE(v, fcn) [SND_CTL_ELEM_IFACE_##v] = (next_devices_t)fcn
+
+typedef int (*next_devices_t)(snd_ctl_t *, int *);
+
+static next_devices_t next_devices[] = {
+	IFACE(CARD, NULL),
+	IFACE(HWDEP, snd_ctl_hwdep_next_device),
+	IFACE(MIXER, NULL),
+	IFACE(PCM, snd_ctl_pcm_next_device),
+	IFACE(RAWMIDI, snd_ctl_rawmidi_next_device),
+	IFACE(TIMER, NULL),
+	IFACE(SEQUENCER, NULL)
+};
+#endif
+
+static int add_card(struct hint_list *list, int card, snd_ctl_elem_iface_t iface)
+{
+	int err, first, ok;
+	snd_config_t *conf, *n;
+	snd_config_iterator_t i, next;
+	const char *str, *base;
+	snd_ctl_t *ctl;
+	char ctl_name[16];
+	snd_ctl_card_info_t *info;
+	
+	snd_ctl_card_info_alloca(&info);
+	if (iface > SND_CTL_ELEM_IFACE_LAST)
+		return -EINVAL;
+	if (snd_card_get_name(card, (char **)&str) < 0)
+		return 0;
+	base = snd_ctl_iface_conf_name(iface);
+	err = snd_config_search(snd_config, base, &conf);
+	if (err < 0)
+		return err;
+	sprintf(ctl_name, "hw:%i", card);
+	err = snd_ctl_open(&ctl, ctl_name, 0);
+	if (err < 0)
+		return err;
+	err = snd_ctl_card_info(ctl, info);
+	if (err < 0)
+		goto __error;
+	snd_config_for_each(i, next, conf) {
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &str) < 0)
+			continue;
+		if (next_devices[iface] != NULL) {
+			first = -1;
+			err = next_devices[iface](ctl, &first);
+			if (first < 0)
+				err = -EINVAL;
+			ok = 0;
+			while (err >= 0 && first >= 0) {
+				err = try_config(list, base, "%s:CARD=%s,DEV=%i", str, snd_ctl_card_info_get_id(info), first);
+				if (err < 0)
+					break;
+				err = next_devices[iface](ctl, &first);
+				ok++;
+			}
+			if (ok)
+				continue;
+		} else {
+			err = -EINVAL;
+		}
+		if (err < 0)
+			err = try_config(list, base, "%s:CARD=%s", str, snd_ctl_card_info_get_id(info));
+		if (err < 0)
+			err = try_config(list, base, str);
+		if (err == -ENOMEM)
+			goto __error;
+	}
+	err = 0;
+      __error:
+      	if (err < 0)
+      		snd_ctl_close(ctl);
+	return err;
+}
+
+/**
+ * \brief Return string list with device name hints.
+ * \param card Card number or -1 (means all cards)
+ * \param iface Interface identification
+ * \param hints Result - array of string with device name hints
+ * \result zero if success, otherwise a negative error code
+ *
+ * Note: The device description is separated with '|' char.
+ */
+int snd_device_name_hint(int card, snd_ctl_elem_iface_t iface, char ***hints)
+{
+	struct hint_list list;
+	int err;
+
+	if (hints == NULL)
+		return -EINVAL;
+	err = snd_config_update();
+	if (err < 0)
+		return err;
+	list.list = NULL;
+	list.count = list.allocated = 0;
+	if (card >= 0) {
+		err = add_card(&list, card, iface);
+	} else {
+		err = snd_card_next(&card);
+		if (err < 0)
+			goto __error;
+		while (card >= 0) {
+			err = add_card(&list, card, iface);
+			if (err < 0)
+				goto __error;
+			err = snd_card_next(&card);
+			if (err < 0)
+				goto __error;
+		}
+	}
+      __error:
+      	if (err < 0) {
+      		snd_device_name_free_hint(list.list);
+      		return err;
+      	} else {
+      		err = hint_list_add(&list, NULL, NULL);
+      		if (err < 0)
+      			goto __error;
+      		*hints = list.list;
+	}
+      	return 0;
+}
+
+/**
+ * \brief Free a string list with device name hints.
+ * \param name Result - card long name corresponding to card number
+ * \result zero if success, otherwise a negative error code
+ */
+int snd_device_name_free_hint(char **hints)
+{
+	char **h;
+
+	if (hints == NULL)
+		return 0;
+	h = hints;
+	while (*h) {
+		free(*h);
+		h++;
+	}
+	free(hints);
+	return 0;
+}
diff -r cbe0a9529254 test/namehint.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/namehint.c	Tue Oct 10 15:34:55 2006 +0200
@@ -0,0 +1,28 @@
+#include "../include/asoundlib.h"
+#include <err.h>
+
+int main(int argc, char *argv[])
+{
+	const char *iface = "pcm";
+	snd_ctl_elem_iface_t niface;
+	char **hints, **n;
+	int err;
+
+	if (argc > 1)
+		iface = argv[1];
+	for (niface = 0; niface < SND_CTL_ELEM_IFACE_LAST; niface++)
+		if (strcmp(snd_ctl_iface_conf_name(niface), iface) == 0)
+			break;
+	if (niface > SND_CTL_ELEM_IFACE_LAST)
+		errx(1, "interface %s dnoes not exist", iface);
+	err = snd_device_name_hint(-1, niface, &hints);
+	if (err < 0)
+		errx(1, "snd_device_name_hint error: %s", snd_strerror(err));
+	n = hints;
+	while (*n != NULL) {
+		printf("%s\n", *n);
+		n++;
+	}
+	snd_device_name_free_hint(hints);
+	return 0;
+}

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
