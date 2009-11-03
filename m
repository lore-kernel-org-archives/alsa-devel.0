From: John Lindgren <john.lindgren@tds.net>
Subject: Re: [PATCH] alsa-lib: snd_device_name_hint misbehaving
Date: Tue, 03 Nov 2009 10:28:11 -0500
Message-ID: <1257262091.12479.19.camel@dark-knight>
References: <1257128586.16837.29.camel@dark-knight>
	<s5hy6mpvzus.wl%tiwai@suse.de> <1257172994.2856.2.camel@dark-knight>
	<s5hljipvuvd.wl%tiwai@suse.de> <1257184700.1937.8.camel@dark-knight>
	<s5hocnk9j9t.wl%tiwai@suse.de>  <s5hhbtc9gr4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D32B244D4
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 16:28:15 +0100 (CET)
Received: by gxk20 with SMTP id 20so1436352gxk.12
	for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2009 07:28:14 -0800 (PST)
In-Reply-To: <s5hhbtc9gr4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-11-03 at 09:03 +0100, Takashi Iwai wrote:
> Since no problem is found with valgrind, I applied the patch to git tree
> now.

Thanks.  I compiled the git version and the problem is fixed. Here are
the other changes, split into four separate patches:

* Card-independent devices such as "null" or "pulse" should only be
added once, not once for each card.

>>>>>>

diff --git a/src/control/namehint.c b/src/control/namehint.c
index a134ed7..408b36f 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -456,10 +456,6 @@ static int add_card(struct hint_list *list, int card)
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
@@ -485,6 +481,29 @@ static int get_card_name(struct hint_list *list, int card)
 	return 0;
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
 /**
  * \brief Return string list with device name hints.
  * \param card Card number or -1 (means all cards)
@@ -546,6 +565,7 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 		if (err >= 0)
 			err = add_card(&list, card);
 	} else {
+		add_software_devices(&list);
 		err = snd_card_next(&card);
 		if (err < 0)
 			goto __error;

<<<<<<

* Allow snd_device_name_hint to search for mixer devices.

>>>>>>

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 408b36f..34338dc 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -554,6 +554,8 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 		list.iface = SND_CTL_ELEM_IFACE_SEQUENCER;
 	else if (strcmp(iface, "hwdep") == 0)
 		list.iface = SND_CTL_ELEM_IFACE_HWDEP;
+	else if (strcmp(iface, "ctl") == 0)
+		list.iface = SND_CTL_ELEM_IFACE_MIXER;
 	else
 		return -EINVAL;
 	list.show_all = 0;

<<<<<<

* list->card is wrongly assumed to be initialized, but the previous
initialization is within a conditional that is false when only
card-independent devices are found.  (This is the case when searching
for mixers on my system; the end result is that the "pulse" mixer is
listed three times.)

>>>>>>

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 34338dc..78572d8 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -453,6 +453,7 @@ static int add_card(struct hint_list *list, int card)
 		if (err == -EXDEV)
 			continue;
 		if (err < 0) {
+			list->card = card;
 			list->device = -1;
 			err = try_config(list, list->siface, str);
 		}

<<<<<<

* Speed up repeated calls to snd_dlopen by caching the path to
libasound.so; this reduces the instructions executed by
snd_device_name_hint by 40 percent.

>>>>>>

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

<<<<<<

Peace,
John Lindgren
