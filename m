From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] control, hw,
	rawmidi: accept control device node as card	identifier when opening
Date: Tue, 12 May 2009 00:41:30 +0200
Message-ID: <20090511224130.GA10955@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 58ED1244D1
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 00:41:32 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

Traditionally low-level ALSA devices are opened with device strings like
'hw:CARD' where CARD is either a numeric index or a card name. This
patch introduces a third syntax that allows you to specify the file name
of the control device node. The purpose for this is to make ALSA a bit
more like other Linux devices and allow implementaiton of udev device
symlinks similar to how disks are currently handled, with
/dev/disk/by-path/xxxx /dev/disk/by-id/xxxx and so on.

With this patch this line:

  aplay -f CD -D hw:/dev/snd/controlC0 < /dev/urandom

becomes equivalent to this line:

  aplay -f CD -D hw:0 < /dev/urandom

A more useful example is this:

  aplay -f CD -D hw:/dev/snd/by-path/pci-0000:00:1a.7-usb-0:2:1.2

(this line requires a a few additional udev rules)

This only works for control devices nodes, not for PCM or any other
device nodes. Since the control device node is used as 'entry point'
when opening PCM devices this is no limitation.

Lennart

---
 include/pcm_plugin.h        |    4 ++-
 src/control/cards.c         |   20 ++++++++++--
 src/control/control_hw.c    |   69 +++++++++++++++++++++++++++++++++----------
 src/control/control_local.h |    3 +-
 src/pcm/pcm_hw.c            |   29 ++++++++++++------
 src/rawmidi/rawmidi_hw.c    |   30 ++++++++++++------
 src/rawmidi/rawmidi_local.h |    6 ++-
 7 files changed, 118 insertions(+), 43 deletions(-)

diff --git a/include/pcm_plugin.h b/include/pcm_plugin.h
index eea1d82..758144e 100644
--- a/include/pcm_plugin.h
+++ b/include/pcm_plugin.h
@@ -1,3 +1,4 @@
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: t; c-basic-offset: 8 -*- */
 /**
  * \file include/pcm_plugin.h
  * \brief Common PCM plugin code
@@ -66,7 +67,8 @@ typedef int snd_pcm_route_ttable_entry_t;
  *  Hardware plugin
  */
 int snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
-		    int card, int device, int subdevice,
+		    int card, const char *control_device_node,
+		    int device, int subdevice,
 		    snd_pcm_stream_t stream, int mode,
 		    int mmap_emulation, int sync_ptr_ioctl);
 int _snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
diff --git a/src/control/cards.c b/src/control/cards.c
index 4d2c739..912e8c8 100644
--- a/src/control/cards.c
+++ b/src/control/cards.c
@@ -1,3 +1,4 @@
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: t; c-basic-offset: 8 -*- */
 /**
  * \file control/cards.c
  * \brief Basic Soundcard Operations
@@ -127,12 +128,25 @@ int snd_card_get_index(const char *string)
 			return card;
 		return err;
 	}
+
+	if (string[0] == '/') {
+		err = snd_ctl_hw_open(&handle, NULL, -1, string, 0);
+
+		if (err < 0)
+			return err;
+
+		card = snd_ctl_hw_card(handle);
+		snd_ctl_close(handle);
+
+		return card;
+	}
+
 	for (card = 0; card < 32; card++) {
 #ifdef SUPPORT_ALOAD
 		if (! snd_card_load(card))
 			continue;
 #endif
-		if (snd_ctl_hw_open(&handle, NULL, card, 0) < 0)
+		if (snd_ctl_hw_open(&handle, NULL, card, NULL, 0) < 0)
 			continue;
 		if (snd_ctl_card_info(handle, &info) < 0) {
 			snd_ctl_close(handle);
@@ -159,7 +173,7 @@ int snd_card_get_name(int card, char **name)
 	
 	if (name == NULL)
 		return -EINVAL;
-	if ((err = snd_ctl_hw_open(&handle, NULL, card, 0)) < 0)
+	if ((err = snd_ctl_hw_open(&handle, NULL, card, NULL, 0)) < 0)
 		return err;
 	if ((err = snd_ctl_card_info(handle, &info)) < 0) {
 		snd_ctl_close(handle);
@@ -186,7 +200,7 @@ int snd_card_get_longname(int card, char **name)
 	
 	if (name == NULL)
 		return -EINVAL;
-	if ((err = snd_ctl_hw_open(&handle, NULL, card, 0)) < 0)
+	if ((err = snd_ctl_hw_open(&handle, NULL, card, NULL, 0)) < 0)
 		return err;
 	if ((err = snd_ctl_card_info(handle, &info)) < 0) {
 		snd_ctl_close(handle);
diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index e9a6be2..3cead5e 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -1,4 +1,5 @@
-/*
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: t; c-basic-offset: 8 -*-
+ *
  *  Control Interface - Hardware
  *  Copyright (c) 1998,1999,2000 by Jaroslav Kysela <perex@perex.cz>
  *  Copyright (c) 2000 by Abramo Bagnara <abramo@alsa-project.org>
@@ -49,6 +50,12 @@ typedef struct {
 } snd_ctl_hw_t;
 #endif /* DOC_HIDDEN */
 
+int snd_ctl_hw_card(snd_ctl_t *handle) {
+	snd_ctl_hw_t *hw = handle->private_data;
+
+	return hw->card;
+}
+
 static int snd_ctl_hw_close(snd_ctl_t *handle)
 {
 	snd_ctl_hw_t *hw = handle->private_data;
@@ -361,7 +368,7 @@ static const snd_ctl_ops_t snd_ctl_hw_ops = {
 	.read = snd_ctl_hw_read,
 };
 
-int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
+int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, const char *devnode, int mode)
 {
 	int fd, ver;
 	char filename[sizeof(SNDRV_FILE_CONTROL) + 10];
@@ -370,13 +377,23 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
 	snd_ctl_hw_t *hw;
 	int err;
 
-	*handle = NULL;	
+	*handle = NULL;
 
-	if (CHECK_SANITY(card < 0 || card >= 32)) {
+	if (CHECK_SANITY(!!devnode == (card >= 0))) {
+		SNDMSG("Specified both card index and device node");
+		return -EINVAL;
+	}
+
+	if (CHECK_SANITY(card >= 32)) {
 		SNDMSG("Invalid card index %d", card);
 		return -EINVAL;
 	}
-	sprintf(filename, SNDRV_FILE_CONTROL, card);
+
+	if (!devnode) {
+		sprintf(filename, SNDRV_FILE_CONTROL, card);
+		devnode = filename;
+	}
+
 	if (mode & SND_CTL_READONLY)
 		fmode = O_RDONLY;
 	else
@@ -385,13 +402,15 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
 		fmode |= O_NONBLOCK;
 	if (mode & SND_CTL_ASYNC)
 		fmode |= O_ASYNC;
-	fd = snd_open_device(filename, fmode);
-	if (fd < 0) {
+	fd = snd_open_device(devnode, fmode);
+	if (fd < 0 && card >= 0) {
 		snd_card_load(card);
-		fd = snd_open_device(filename, fmode);
-		if (fd < 0)
-			return -errno;
+		fd = snd_open_device(devnode, fmode);
 	}
+
+	if (fd < 0)
+		return -errno;
+
 #if 0
 	/*
 	 * this is bogus, an application have to care about open filedescriptors
@@ -412,6 +431,19 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
 		close(fd);
 		return -SND_ERROR_INCOMPATIBLE_VERSION;
 	}
+
+	if (card < 0) {
+		snd_ctl_card_info_t info;
+
+		if (ioctl(fd, SNDRV_CTL_IOCTL_CARD_INFO, &info) < 0) {
+			err = -errno;
+			close(fd);
+			return err;
+		}
+
+		card = info.card;
+	}
+
 	hw = calloc(1, sizeof(snd_ctl_hw_t));
 	if (hw == NULL) {
 		close(fd);
@@ -437,7 +469,7 @@ int _snd_ctl_hw_open(snd_ctl_t **handlep, char *name, snd_config_t *root ATTRIBU
 {
 	snd_config_iterator_t i, next;
 	long card = -1;
-	const char *str;
+	const char *str, *devnode = NULL;
 	int err;
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -454,16 +486,21 @@ int _snd_ctl_hw_open(snd_ctl_t **handlep, char *name, snd_config_t *root ATTRIBU
 				err = snd_config_get_string(n, &str);
 				if (err < 0)
 					return -EINVAL;
-				card = snd_card_get_index(str);
-				if (card < 0)
-					return card;
+				if (str[0] == '/')
+					devnode = name;
+				else {
+					card = snd_card_get_index(str);
+					if (card < 0)
+						return card;
+				}
+
 			}
 			continue;
 		}
 		return -EINVAL;
 	}
-	if (card < 0)
+	if (card < 0 && !devnode)
 		return -EINVAL;
-	return snd_ctl_hw_open(handlep, name, card, mode);
+	return snd_ctl_hw_open(handlep, name, card, devnode, mode);
 }
 SND_DLSYM_BUILD_VERSION(_snd_ctl_hw_open, SND_CONTROL_DLSYM_VERSION);
diff --git a/src/control/control_local.h b/src/control/control_local.h
index fd9f941..5088b5f 100644
--- a/src/control/control_local.h
+++ b/src/control/control_local.h
@@ -95,6 +95,7 @@ struct _snd_hctl {
 int snd_ctl_new(snd_ctl_t **ctlp, snd_ctl_type_t type, const char *name);
 int _snd_ctl_poll_descriptor(snd_ctl_t *ctl);
 #define _snd_ctl_async_descriptor _snd_ctl_poll_descriptor
-int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode);
+int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, const char *devnode, int mode);
+int snd_ctl_hw_card(snd_ctl_t *handle);
 int snd_ctl_shm_open(snd_ctl_t **handlep, const char *name, const char *sockname, const char *sname, int mode);
 int snd_ctl_async(snd_ctl_t *ctl, int sig, pid_t pid);
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c46d14f..59734a1 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1,3 +1,4 @@
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: t; c-basic-offset: 8 -*- */
 /**
  * \file pcm/pcm_hw.c
  * \ingroup PCM_Plugins
@@ -1260,7 +1261,8 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
  * \brief Creates a new hw PCM
  * \param pcmp Returns created PCM handle
  * \param name Name of PCM
- * \param card Number of card
+ * \param card Number of card (must be -1 if control_device_node is non-NULL)
+ * \param control_device_node Control device node in the file system (must be NULL if card is != -1)
  * \param device Number of device
  * \param subdevice Number of subdevice
  * \param stream PCM Stream
@@ -1273,7 +1275,8 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
  *          changed in future.
  */
 int snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
-		    int card, int device, int subdevice,
+		    int card, const char *control_device_node,
+		    int device, int subdevice,
 		    snd_pcm_stream_t stream, int mode,
 		    int mmap_emulation ATTRIBUTE_UNUSED,
 		    int sync_ptr_ioctl)
@@ -1288,9 +1291,11 @@ int snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
 
 	assert(pcmp);
 
-	if ((ret = snd_ctl_hw_open(&ctl, NULL, card, 0)) < 0)
+	if ((ret = snd_ctl_hw_open(&ctl, NULL, card, control_device_node, 0)) < 0)
 		return ret;
 
+	card = snd_ctl_hw_card(ctl);
+
 	switch (stream) {
 	case SND_PCM_STREAM_PLAYBACK:
 		filefmt = SNDRV_FILE_PCM_STREAM_PLAYBACK;
@@ -1399,7 +1404,7 @@ int _snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
 {
 	snd_config_iterator_t i, next;
 	long card = -1, device = 0, subdevice = -1;
-	const char *str;
+	const char *str, *devnode = NULL;
 	int err, sync_ptr_ioctl = 0;
 	int rate = 0, channels = 0;
 	snd_pcm_format_t format = SND_PCM_FORMAT_UNKNOWN;
@@ -1428,10 +1433,14 @@ int _snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
 					SNDERR("Invalid type for %s", id);
 					return -EINVAL;
 				}
-				card = snd_card_get_index(str);
-				if (card < 0) {
-					SNDERR("Invalid value for %s", id);
-					return card;
+				if (str[0] == '/')
+					devnode = str;
+				else {
+					card = snd_card_get_index(str);
+					if (card < 0) {
+						SNDERR("Invalid value for %s", id);
+						return card;
+					}
 				}
 			}
 			continue;
@@ -1498,11 +1507,11 @@ int _snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
-	if (card < 0) {
+	if (card < 0 && !devnode) {
 		SNDERR("card is not defined");
 		return -EINVAL;
 	}
-	err = snd_pcm_hw_open(pcmp, name, card, device, subdevice, stream,
+	err = snd_pcm_hw_open(pcmp, name, card, devnode, device, subdevice, stream,
 			      mode | (nonblock ? SND_PCM_NONBLOCK : 0),
 			      0, sync_ptr_ioctl);
 	if (err < 0)
diff --git a/src/rawmidi/rawmidi_hw.c b/src/rawmidi/rawmidi_hw.c
index 87829fd..f02d4cf 100644
--- a/src/rawmidi/rawmidi_hw.c
+++ b/src/rawmidi/rawmidi_hw.c
@@ -1,4 +1,5 @@
-/*
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: t; c-basic-offset: 8 -*-
+ *
  *  RawMIDI - Hardware
  *  Copyright (c) 2000 by Jaroslav Kysela <perex@perex.cz>
  *                        Abramo Bagnara <abramo@alsa-project.org>
@@ -170,7 +171,9 @@ static const snd_rawmidi_ops_t snd_rawmidi_hw_ops = {
 
 
 int snd_rawmidi_hw_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
-			const char *name, int card, int device, int subdevice,
+			const char *name,
+                        int card, const  char *control_device_node,
+                        int device, int subdevice,
 			int mode)
 {
 	int fd, ver, ret;
@@ -186,9 +189,12 @@ int snd_rawmidi_hw_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
 		*inputp = NULL;
 	if (outputp)
 		*outputp = NULL;
-	
-	if ((ret = snd_ctl_hw_open(&ctl, NULL, card, 0)) < 0)
+
+	if ((ret = snd_ctl_hw_open(&ctl, NULL, card, control_device_node, 0)) < 0)
 		return ret;
+
+	card = snd_ctl_hw_card(ctl);
+
 	sprintf(filename, SNDRV_FILE_RAWMIDI, card, device);
 
       __again:
@@ -330,7 +336,7 @@ int _snd_rawmidi_hw_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
 {
 	snd_config_iterator_t i, next;
 	long card = -1, device = 0, subdevice = -1;
-	const char *str;
+	const char *str, *devnode = NULL;
 	int err;
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -345,9 +351,13 @@ int _snd_rawmidi_hw_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
 				err = snd_config_get_string(n, &str);
 				if (err < 0)
 					return -EINVAL;
-				card = snd_card_get_index(str);
-				if (card < 0)
-					return card;
+				if (str[0] == '/')
+					devnode = str;
+				else {
+					card = snd_card_get_index(str);
+					if (card < 0)
+						return card;
+				}
 			}
 			continue;
 		}
@@ -365,8 +375,8 @@ int _snd_rawmidi_hw_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
 		}
 		return -EINVAL;
 	}
-	if (card < 0)
+	if (card < 0 && !devnode)
 		return -EINVAL;
-	return snd_rawmidi_hw_open(inputp, outputp, name, card, device, subdevice, mode);
+	return snd_rawmidi_hw_open(inputp, outputp, name, card, devnode, device, subdevice, mode);
 }
 SND_DLSYM_BUILD_VERSION(_snd_rawmidi_hw_open, SND_RAWMIDI_DLSYM_VERSION);
diff --git a/src/rawmidi/rawmidi_local.h b/src/rawmidi/rawmidi_local.h
index 3388502..ed2b7da 100644
--- a/src/rawmidi/rawmidi_local.h
+++ b/src/rawmidi/rawmidi_local.h
@@ -1,4 +1,4 @@
-/*
+/* -*- Mode: C; tab-width: 8; indent-tabs-mode: t; c-basic-offset: 8 -*-
  *  Rawmidi interface - local header file
  *  Copyright (c) 2000 by Abramo Bagnara <abramo@alsa-project.org>
  *
@@ -51,7 +51,9 @@ struct _snd_rawmidi {
 };
 
 int snd_rawmidi_hw_open(snd_rawmidi_t **input, snd_rawmidi_t **output,
-			const char *name, int card, int device, int subdevice,
+			const char *name,
+			int card, const char *control_device_node,
+			int device, int subdevice,
 			int mode);
 
 int snd_rawmidi_virtual_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
-- 
1.6.2.2



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
