From: Mario Kicherer <dev@kicherer.org>
Subject: [PATCH 3/3] snd-bcd2000: add control interface
Date: Sat, 31 Jan 2015 22:34:25 +0100
Message-ID: <1422740065-20196-4-git-send-email-dev@kicherer.org>
References: <1422740065-20196-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 7920126052A
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 22:34:31 +0100 (CET)
In-Reply-To: <1422740065-20196-1-git-send-email-dev@kicherer.org>
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
Cc: Mario Kicherer <dev@kicherer.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mario Kicherer <dev@kicherer.org>
---
 sound/usb/bcd2000/Makefile  |   2 +-
 sound/usb/bcd2000/bcd2000.c |   6 +++
 sound/usb/bcd2000/bcd2000.h |   2 +
 sound/usb/bcd2000/control.c | 119 ++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/bcd2000/control.h |  15 ++++++
 5 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/bcd2000/control.c
 create mode 100644 sound/usb/bcd2000/control.h

diff --git a/sound/usb/bcd2000/Makefile b/sound/usb/bcd2000/Makefile
index d424dff..176324f 100644
--- a/sound/usb/bcd2000/Makefile
+++ b/sound/usb/bcd2000/Makefile
@@ -1,3 +1,3 @@
-snd-bcd2000-y := bcd2000.o audio.o midi.o
+snd-bcd2000-y := bcd2000.o audio.o control.o midi.o
 
 obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
\ No newline at end of file
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index f7ba9ad..1bd5111 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -59,6 +59,8 @@ static void bcd2000_disconnect(struct usb_interface *interface)
 	/* make sure that userspace cannot create new requests */
 	snd_card_disconnect(bcd2k->card);
 
+	bcd2000_free_control(bcd2k);
+
 	bcd2000_free_audio(bcd2k);
 
 	bcd2000_free_midi(bcd2k);
@@ -126,6 +128,10 @@ static int bcd2000_probe(struct usb_interface *interface,
 	if (err < 0)
 		goto probe_error;
 
+	err = bcd2000_init_control(bcd2k);
+	if (err < 0)
+		goto probe_error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto probe_error;
diff --git a/sound/usb/bcd2000/bcd2000.h b/sound/usb/bcd2000/bcd2000.h
index 802685b..96d93f5 100644
--- a/sound/usb/bcd2000/bcd2000.h
+++ b/sound/usb/bcd2000/bcd2000.h
@@ -10,6 +10,7 @@
 #define PREFIX "snd-bcd2000: "
 
 #include "audio.h"
+#include "control.h"
 #include "midi.h"
 
 struct bcd2000 {
@@ -18,6 +19,7 @@ struct bcd2000 {
 	struct usb_interface *intf;
 	int card_index;
 
+	struct bcd2000_control control;
 	struct bcd2000_midi midi;
 	struct bcd2000_pcm pcm;
 };
diff --git a/sound/usb/bcd2000/control.c b/sound/usb/bcd2000/control.c
new file mode 100644
index 0000000..70b3620
--- /dev/null
+++ b/sound/usb/bcd2000/control.c
@@ -0,0 +1,119 @@
+/*
+ * Behringer BCD2000 driver
+ *
+ *   Copyright (C) 2014 Mario Kicherer (dev@kicherer.org)
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
+ */
+
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <sound/control.h>
+#include <sound/tlv.h>
+
+#include "bcd2000.h"
+#include "control.h"
+#include "midi.h"
+
+static const char * const phono_mic_sw_texts[2] = { "Phono A", "Mic" };
+
+/*
+ * switch between Phono A and Mic input using a MIDI program change command
+ *
+ * The manual specifies "c0 [00|01]" but the windows driver sends
+ * "09 01 [00|01]", we follow the manual here.
+ */
+static void bcd2000_control_phono_mic_sw_update(struct bcd2000_control *ctrl)
+{
+	int actual_length, ret;
+	char buffer[MIDI_URB_BUFSIZE] = MIDI_CMD_PREFIX_INIT;
+
+	buffer[2] = 2;
+	buffer[3] = 0xC0;
+	buffer[4] = ctrl->phono_mic_switch;
+
+	ret = usb_interrupt_msg(ctrl->bcd2k->dev,
+				usb_sndintpipe(ctrl->bcd2k->dev, 0x1),
+				buffer, MIDI_URB_BUFSIZE, &actual_length, 100);
+	if (ret)
+		dev_err(&ctrl->bcd2k->dev->dev, PREFIX
+			"usb_interrupt_msg failed\n");
+}
+
+static int bcd2000_control_phono_mic_sw_info(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, 2, phono_mic_sw_texts);
+}
+
+static int bcd2000_control_phono_mic_sw_put(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_value *ucontrol)
+{
+	struct bcd2000_control *ctrl = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
+
+	if (ctrl->phono_mic_switch != ucontrol->value.enumerated.item[0]) {
+		ctrl->phono_mic_switch = ucontrol->value.enumerated.item[0];
+
+		bcd2000_control_phono_mic_sw_update(ctrl);
+
+		changed = 1;
+	}
+
+	return changed;
+}
+
+static int bcd2000_control_phono_mic_sw_get(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_value *ucontrol)
+{
+	struct bcd2000_control *ctrl = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = ctrl->phono_mic_switch;
+
+	return 0;
+}
+
+static struct snd_kcontrol_new elements[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Phono A / Mic Capture Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = bcd2000_control_phono_mic_sw_info,
+		.get = bcd2000_control_phono_mic_sw_get,
+		.put = bcd2000_control_phono_mic_sw_put
+	},
+	{}
+};
+
+int bcd2000_init_control(struct bcd2000 *bcd2k)
+{
+	int i, ret;
+
+	bcd2k->control.bcd2k = bcd2k;
+
+	i = 0;
+	while (elements[i].name) {
+		ret = snd_ctl_add(bcd2k->card, snd_ctl_new1(&elements[i],
+							    &bcd2k->control));
+		if (ret < 0) {
+			dev_err(&bcd2k->dev->dev, "cannot add control\n");
+			return ret;
+		}
+		i++;
+	}
+
+	return 0;
+}
+
+void bcd2000_free_control(struct bcd2000 *bcd2k)
+{
+}
diff --git a/sound/usb/bcd2000/control.h b/sound/usb/bcd2000/control.h
new file mode 100644
index 0000000..79cc053
--- /dev/null
+++ b/sound/usb/bcd2000/control.h
@@ -0,0 +1,15 @@
+#ifndef CONTROL_H
+#define CONTROL_H
+
+struct bcd2000;
+
+struct bcd2000_control {
+	struct bcd2000 *bcd2k;
+
+	bool phono_mic_switch;
+};
+
+int bcd2000_init_control(struct bcd2000 *bcd2k);
+void bcd2000_free_control(struct bcd2000 *bcd2k);
+
+#endif
-- 
2.0.5
