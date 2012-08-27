From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 01/11] ALSA: implement MEDIA_IOC_DEVICE_INFO
Date: Tue, 28 Aug 2012 00:29:33 +0200
Message-ID: <503BF4CD.6000207@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 400FB265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:30:30 +0200 (CEST)
In-Reply-To: <503BF48E.1090100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a callback to snd_card to allow card drivers to return driver-
specific information.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/core.h  |    5 +++
 include/sound/media.h |   50 ++++++++++++++++++++++++++++++++
 sound/core/Kconfig    |    7 +++++
 sound/core/Makefile   |    1 +
 sound/core/media.c    |   76 +++++++++++++++++++++++++++++++++++++++++++++++++
 sound/core/sound.c    |    3 ++
 6 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/media.h
 create mode 100644 sound/core/media.c

diff --git a/include/sound/core.h b/include/sound/core.h
index bc05668..5eca6f5 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -42,6 +42,7 @@ struct pci_dev;
 struct module;
 struct device;
 struct device_attribute;
+struct snd_media_card_ops;

 /* device allocation stuff */

@@ -145,6 +146,10 @@ struct snd_card {
 	struct snd_mixer_oss *mixer_oss;
 	int mixer_oss_change_count;
 #endif
+
+#ifdef CONFIG_SND_MEDIA
+	const struct snd_media_card_ops *media_ops;
+#endif
 };

 #ifdef CONFIG_PM
diff --git a/include/sound/media.h b/include/sound/media.h
new file mode 100644
index 0000000..d196219
--- /dev/null
+++ b/include/sound/media.h
@@ -0,0 +1,50 @@
+/*
+ *  media controller interface for ALSA driver
+ *  Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SOUND_MEDIA_H_INCLUDED
+#define SOUND_MEDIA_H_INCLUDED
+
+#include <linux/init.h>
+
+struct snd_card;
+struct media_device_info;
+
+struct snd_media_card_ops {
+	int (*get_info)(struct snd_card *card, struct media_device_info *info);
+};
+
+#ifdef CONFIG_SND_MEDIA
+
+#define snd_card_set_media_ops(card, ops) ((card)->media_ops = (ops))
+
+void __init snd_media_init(void);
+void __exit snd_media_exit(void);
+
+#else /* CONFIG_SND_MEDIA */
+
+#define snd_card_set_media_ops(card, ops)
+
+static inline void snd_media_init()
+{ }
+static inline void snd_media_exit()
+{ }
+
+#endif /* !CONFIG_SND_MEDIA */
+
+#endif
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index b413ed0..fadbdf5 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -147,6 +147,13 @@ config SND_SEQ_RTCTIMER_DEFAULT

 	  If in doubt, say Y.

+config SND_MEDIA
+	bool "Media Controller API (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Say Y here to enable the media controller API, which allows to
+	  retrieve the internal topology of sound devices.
+
 config SND_DYNAMIC_MINORS
 	bool "Dynamic device file minor numbers"
 	help
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 43d4117..b6de542 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -9,6 +9,7 @@ snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o info_oss.o
 snd-$(CONFIG_SND_VMASTER) += vmaster.o
 snd-$(CONFIG_SND_KCTL_JACK) += ctljack.o
 snd-$(CONFIG_SND_JACK)	  += jack.o
+snd-$(CONFIG_SND_MEDIA)   += media.o

 snd-pcm-objs := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
 		pcm_memory.o
diff --git a/sound/core/media.c b/sound/core/media.c
new file mode 100644
index 0000000..6ceb12a
--- /dev/null
+++ b/sound/core/media.c
@@ -0,0 +1,76 @@
+/*
+ *  media controller interface for ALSA driver
+ *  Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/media.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/media.h>
+
+static int snd_media_device_info(struct snd_card *card,
+				 struct media_device_info __user *infop)
+{
+	struct media_device_info info;
+	int err;
+
+	memset(&info, 0, sizeof(info));
+
+	if (card->dev && card->dev->driver)
+		strlcpy(info.driver, card->dev->driver->name, sizeof(info.driver));
+	strlcpy(info.model, card->shortname, sizeof(info.model));
+	info.media_version = MEDIA_API_VERSION;
+
+	if (card->media_ops) {
+		err = card->media_ops->get_info(card, &info);
+		if (err < 0)
+			return err;
+	}
+
+	return copy_to_user(infop, &info, sizeof(info));
+}
+
+static int snd_media_control_ioctl(struct snd_card *card,
+				   struct snd_ctl_file *ctl_file,
+				   unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case MEDIA_IOC_DEVICE_INFO:
+		return snd_media_device_info(card, argp);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+void __init snd_media_init(void)
+{
+	snd_ctl_register_ioctl(snd_media_control_ioctl);
+	snd_ctl_register_ioctl_compat(snd_media_control_ioctl);
+}
+
+void __exit snd_media_exit(void)
+{
+	snd_ctl_unregister_ioctl(snd_media_control_ioctl);
+	snd_ctl_unregister_ioctl_compat(snd_media_control_ioctl);
+}
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 28f3559..7a7721c 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -30,6 +30,7 @@
 #include <sound/version.h>
 #include <sound/control.h>
 #include <sound/initval.h>
+#include <sound/media.h>
 #include <linux/kmod.h>
 #include <linux/mutex.h>

@@ -467,6 +468,7 @@ static int __init alsa_sound_init(void)
 		return -ENOMEM;
 	}
 	snd_info_minor_register();
+	snd_media_init();
 #ifndef MODULE
 	printk(KERN_INFO "Advanced Linux Sound Architecture Driver Version " CONFIG_SND_VERSION CONFIG_SND_DATE ".\n");
 #endif
@@ -475,6 +477,7 @@ static int __init alsa_sound_init(void)

 static void __exit alsa_sound_exit(void)
 {
+	snd_media_exit();
 	snd_info_minor_unregister();
 	snd_info_done();
 	unregister_chrdev(major, "alsa");
