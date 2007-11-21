From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH 2/2] caiaq/NativeInstruments:
	control	support
Date: Wed, 21 Nov 2007 22:29:59 +0100
Message-ID: <20071121212959.GA11890@buzzloop.caiaq.de>
References: <20071120133210.GA4425@buzzloop.caiaq.de>
	<20071120133746.GC4425@buzzloop.caiaq.de>
	<s5hbq9nj4rx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 06B4524C9C
	for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 22:30:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbq9nj4rx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2007 at 11:01:54AM +0100, Takashi Iwai wrote:
> > +#ifdef CONFIG_SND_USB_CAIAQ_INPUT
> > +#include <linux/input.h>
> > +#endif
> 
> Do you really need ifdef here?

No, I agree. Also removed that from other places.

> The put callback is supposed to return 1 if a value is changed.
> It's no strict requirement, so far, but if this still doesn't follow
> put a comment like FIXME. 

Changed.

> > +/*
> > + *
> > + * 0
> > + * 1 << 1
> > + * 1 << 0 | 1 << 1
> > + * 1 << 0 | 1 << 1 | 1 << 2
> > + * 1 << 0
> > + * 0
> > + *
> > + */
> 
> What's this? :)

I developement left-over - I'm still not yet used to git-update-index ;)

New version attached.

Greets,
Daniel


--tThc/1wpZn/ma/RB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-caiaq-1.3.0.diff"

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 7061438..05a311d 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -57,6 +57,7 @@ config SND_USB_CAIAQ_INPUT
 
 	   * Native Instruments RigKontrol2
 	   * Native Instruments RigKontrol3
+	   * Native Instruments Kore Controller
 	   * Native Instruments Audio Kontrol 1
 
 endmenu
diff --git a/sound/usb/caiaq/Makefile b/sound/usb/caiaq/Makefile
index 455c8c5..345a965 100644
--- a/sound/usb/caiaq/Makefile
+++ b/sound/usb/caiaq/Makefile
@@ -1,3 +1,3 @@
-snd-usb-caiaq-objs := caiaq-device.o caiaq-audio.o caiaq-midi.o caiaq-input.o
+snd-usb-caiaq-objs := caiaq-device.o caiaq-audio.o caiaq-midi.o caiaq-input.o caiaq-control.o
 
 obj-$(CONFIG_SND_USB_CAIAQ) += snd-usb-caiaq.o
diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index 0666908..bf551c0 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -27,9 +27,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
-#ifdef CONFIG_SND_USB_CAIAQ_INPUT
 #include <linux/input.h>
-#endif
 
 #include "caiaq-device.h"
 #include "caiaq-audio.h"
diff --git a/sound/usb/caiaq/caiaq-control.c b/sound/usb/caiaq/caiaq-control.c
new file mode 100644
index 0000000..77854ff
--- /dev/null
+++ b/sound/usb/caiaq/caiaq-control.c
@@ -0,0 +1,316 @@
+/*
+ *   Copyright (c) 2007 Daniel Mack
+ *   friendly supported by NI.
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
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/rawmidi.h>
+#include <sound/control.h>
+#include <linux/input.h>
+
+#include "caiaq-device.h"
+#include "caiaq-control.h"
+
+#define CNT_INTVAL 0x10000
+
+static int control_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_usb_audio *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
+	int pos = kcontrol->private_value;
+	int is_intval = pos & CNT_INTVAL;
+
+	uinfo->count = 1;
+	pos &= ~CNT_INTVAL;
+
+	if (dev->chip.usb_id == 
+		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)
+		&& (pos == 0)) {
+		/* current input mode of A8DJ */
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->value.integer.min = 0;
+		uinfo->value.integer.max = 2;
+		return 0;
+	}
+
+	if (is_intval) {
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->value.integer.min = 0;
+		uinfo->value.integer.max = 64;
+	} else {
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+		uinfo->value.integer.min = 0;
+		uinfo->value.integer.max = 1;
+	}
+
+	return 0;
+}
+
+static int control_get(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_audio *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
+	int pos = kcontrol->private_value;
+
+	if (pos & CNT_INTVAL)
+		ucontrol->value.integer.value[0]
+			= dev->control_state[pos & ~CNT_INTVAL];
+	else
+		ucontrol->value.integer.value[0] 
+			= !!(dev->control_state[pos / 8] & (1 << pos % 8));
+
+	return 0;
+}
+
+static int control_put(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_audio *chip = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
+	int pos = kcontrol->private_value;
+
+	if (pos & CNT_INTVAL) {
+		dev->control_state[pos & ~CNT_INTVAL] 
+			= ucontrol->value.integer.value[0];
+		snd_usb_caiaq_send_command(dev, EP1_CMD_DIMM_LEDS,
+				dev->control_state, sizeof(dev->control_state));
+	} else {
+		if (ucontrol->value.integer.value[0])
+			dev->control_state[pos / 8] |= 1 << (pos % 8);
+		else
+			dev->control_state[pos / 8] &= ~(1 << (pos % 8));
+	
+		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
+				dev->control_state, sizeof(dev->control_state));
+	}
+	
+
+	return 1;
+}
+
+static struct snd_kcontrol_new kcontrol_template __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.index = 0,
+	.info = control_info,
+	.get  = control_get,
+	.put  = control_put,
+	/* name and private_value filled later */
+};
+
+struct caiaq_controller {
+	char *name;
+	int index;
+};
+
+static struct caiaq_controller ak1_controller[] = {
+	{ "LED left", 	2 },
+	{ "LED middle", 1 },
+	{ "LED right", 	0 },
+	{ "LED ring", 	3 }
+};
+
+static struct caiaq_controller rk2_controller[] = {
+	{ "LED 1",		5  },
+	{ "LED 2",		4  },
+	{ "LED 3",		3  },
+	{ "LED 4",		2  },
+	{ "LED 5",		1  },
+	{ "LED 6",		0  },
+	{ "LED pedal",		6  },
+	{ "LED 7seg_1b",	8  },
+	{ "LED 7seg_1c",	9  },
+	{ "LED 7seg_2a",	10 },
+	{ "LED 7seg_2b",	11 },
+	{ "LED 7seg_2c",	12 },
+	{ "LED 7seg_2d",	13 },
+	{ "LED 7seg_2e",	14 },
+	{ "LED 7seg_2f",	15 },
+	{ "LED 7seg_2g",	16 },
+	{ "LED 7seg_3a",	17 },
+	{ "LED 7seg_3b",	18 },
+	{ "LED 7seg_3c",	19 },
+	{ "LED 7seg_3d",	20 },
+	{ "LED 7seg_3e",	21 },
+	{ "LED 7seg_3f",	22 },
+	{ "LED 7seg_3g",	23 }
+};
+
+static struct caiaq_controller rk3_controller[] = {
+	{ "LED 7seg_1a",        0 + 0 },
+	{ "LED 7seg_1b",        0 + 1 },
+	{ "LED 7seg_1c",        0 + 2 },
+	{ "LED 7seg_1d",        0 + 3 },
+	{ "LED 7seg_1e",        0 + 4 },
+	{ "LED 7seg_1f",        0 + 5 },
+	{ "LED 7seg_1g",        0 + 6 },
+	{ "LED 7seg_1p",        0 + 7 },
+	
+	{ "LED 7seg_2a",        8 + 0 },
+	{ "LED 7seg_2b",        8 + 1 },
+	{ "LED 7seg_2c",        8 + 2 },
+	{ "LED 7seg_2d",        8 + 3 },
+	{ "LED 7seg_2e",        8 + 4 },
+	{ "LED 7seg_2f",        8 + 5 },
+	{ "LED 7seg_2g",        8 + 6 },
+	{ "LED 7seg_2p",        8 + 7 },
+
+	{ "LED 7seg_3a",        16 + 0 },
+	{ "LED 7seg_3b",        16 + 1 },
+	{ "LED 7seg_3c",        16 + 2 },
+	{ "LED 7seg_3d",        16 + 3 },
+	{ "LED 7seg_3e",        16 + 4 },
+	{ "LED 7seg_3f",        16 + 5 },
+	{ "LED 7seg_3g",        16 + 6 },
+	{ "LED 7seg_3p",        16 + 7 },
+
+	{ "LED 7seg_4a",        24 + 0 },
+	{ "LED 7seg_4b",        24 + 1 },
+	{ "LED 7seg_4c",        24 + 2 },
+	{ "LED 7seg_4d",        24 + 3 },
+	{ "LED 7seg_4e",        24 + 4 },
+	{ "LED 7seg_4f",        24 + 5 },
+	{ "LED 7seg_4g",        24 + 6 },
+	{ "LED 7seg_4p",        24 + 7 },
+
+	{ "LED 1",		32 + 0 },
+	{ "LED 2",		32 + 1 },
+	{ "LED 3",		32 + 2 },
+	{ "LED 4",		32 + 3 },
+	{ "LED 5",		32 + 4 },
+	{ "LED 6",		32 + 5 },
+	{ "LED 7",		32 + 6 },
+	{ "LED 8",		32 + 7 },
+	{ "LED pedal",		32 + 8 }
+};
+
+static struct caiaq_controller kore_controller[] = {
+	{ "LED F1",		8   | CNT_INTVAL },
+	{ "LED F2",		12  | CNT_INTVAL },
+	{ "LED F3",		0   | CNT_INTVAL },
+	{ "LED F4",		4   | CNT_INTVAL },
+	{ "LED F5",		11  | CNT_INTVAL },
+	{ "LED F6",		15  | CNT_INTVAL },
+	{ "LED F7",		3   | CNT_INTVAL },
+	{ "LED F8",		7   | CNT_INTVAL },
+	{ "LED touch1",	     	10  | CNT_INTVAL },
+	{ "LED touch2",	     	14  | CNT_INTVAL },
+	{ "LED touch3",	     	2   | CNT_INTVAL },
+	{ "LED touch4",	     	6   | CNT_INTVAL },
+	{ "LED touch5",	     	9   | CNT_INTVAL },
+	{ "LED touch6",	     	13  | CNT_INTVAL },
+	{ "LED touch7",	     	1   | CNT_INTVAL },
+	{ "LED touch8",	     	5   | CNT_INTVAL },
+	{ "LED left",	       	18  | CNT_INTVAL },
+	{ "LED right",	     	22  | CNT_INTVAL },
+	{ "LED up",		16  | CNT_INTVAL },
+	{ "LED down",	       	20  | CNT_INTVAL },
+	{ "LED stop",	       	23  | CNT_INTVAL },
+	{ "LED play",	       	21  | CNT_INTVAL },
+	{ "LED record",	     	19  | CNT_INTVAL },
+	{ "LED listen",		17  | CNT_INTVAL },
+	{ "LED lcd",		30  | CNT_INTVAL },
+	{ "LED menu",		28  | CNT_INTVAL },
+	{ "LED sound",	 	31  | CNT_INTVAL },
+	{ "LED esc",		29  | CNT_INTVAL },
+	{ "LED view",		27  | CNT_INTVAL },
+	{ "LED enter",		24  | CNT_INTVAL },
+	{ "LED control",	26  | CNT_INTVAL }
+};
+
+static struct caiaq_controller a8dj_controller[] = {
+	{ "Current input mode",			0 | CNT_INTVAL 	},
+	{ "GND lift for TC Vinyl mode", 	24 + 0 		},
+	{ "GND lift for TC CD/Line mode", 	24 + 1 		},
+	{ "GND lift for phono mode", 		24 + 2 		},
+	{ "GND lift for TC Vinyl mode", 	24 + 3 		},
+	{ "Software lock", 			40 		}
+};
+
+int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
+{
+	int i;
+	struct snd_kcontrol *kc;
+
+	switch(dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
+		for (i = 0; i < ARRAY_SIZE(ak1_controller); i++) {
+			struct caiaq_controller *c = ak1_controller + i;
+			kcontrol_template.name = c->name;
+			kcontrol_template.private_value = c->index;
+			kc = snd_ctl_new1(&kcontrol_template, dev);
+			snd_ctl_add(dev->chip.card, kc);
+		}
+
+		break;
+	
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
+		for (i = 0; i < ARRAY_SIZE(rk2_controller); i++) {
+			struct caiaq_controller *c = rk2_controller + i;
+			kcontrol_template.name = c->name;
+			kcontrol_template.private_value = c->index;
+			kc = snd_ctl_new1(&kcontrol_template, dev);
+			snd_ctl_add(dev->chip.card, kc);
+		}
+
+		break;
+	
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
+		for (i = 0; i < ARRAY_SIZE(rk3_controller); i++) {
+			struct caiaq_controller *c = rk3_controller + i;
+			kcontrol_template.name = c->name;
+			kcontrol_template.private_value = c->index;
+			kc = snd_ctl_new1(&kcontrol_template, dev);
+			snd_ctl_add(dev->chip.card, kc);
+		}
+
+		break;
+	
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+		for (i = 0; i < ARRAY_SIZE(kore_controller); i++) {
+			struct caiaq_controller *c = kore_controller + i;
+			kcontrol_template.name = c->name;
+			kcontrol_template.private_value = c->index;
+			kc = snd_ctl_new1(&kcontrol_template, dev);
+			snd_ctl_add(dev->chip.card, kc);
+		}
+
+		break;
+	
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ):
+		for (i = 0; i < ARRAY_SIZE(a8dj_controller); i++) {
+			struct caiaq_controller *c = a8dj_controller + i;
+			kcontrol_template.name = c->name;
+			kcontrol_template.private_value = c->index;
+			kc = snd_ctl_new1(&kcontrol_template, dev);
+			snd_ctl_add(dev->chip.card, kc);
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
diff --git a/sound/usb/caiaq/caiaq-control.h b/sound/usb/caiaq/caiaq-control.h
new file mode 100644
index 0000000..2e7ab1a
--- /dev/null
+++ b/sound/usb/caiaq/caiaq-control.h
@@ -0,0 +1,6 @@
+#ifndef CAIAQ_CONTROL_H
+#define CAIAQ_CONTROL_H
+
+int snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev);
+
+#endif /* CAIAQ_CONTROL_H */
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 58af814..a0bf8c5 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -31,17 +31,19 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
+#include <sound/control.h>
 
 #include "caiaq-device.h"
 #include "caiaq-audio.h"
 #include "caiaq-midi.h"
+#include "caiaq-control.h"
 
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 #include "caiaq-input.h"
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.2.0");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.0");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
@@ -140,14 +142,21 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 	case EP1_CMD_MIDI_READ:
 		snd_usb_caiaq_midi_handle_input(dev, buf[1], buf + 3, buf[2]);
 		break;
-
+	case EP1_CMD_READ_IO:
+		if (dev->chip.usb_id ==
+			USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)) {
+			if (urb->actual_length > sizeof(dev->control_state))
+				urb->actual_length = sizeof(dev->control_state);
+			memcpy(dev->control_state, buf + 1, urb->actual_length);
+			wake_up(&dev->ep1_wait_queue);
+			break;
+		}
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	case EP1_CMD_READ_ERP:
 	case EP1_CMD_READ_ANALOG:
-	case EP1_CMD_READ_IO:
 		snd_usb_caiaq_input_dispatch(dev, buf, urb->actual_length);
-		break;
 #endif
+		break;
 	}
 
 	dev->ep1_in_urb.actual_length = 0;
@@ -156,10 +165,10 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 		log("unable to submit urb. OOM!?\n");
 }
 
-static int send_command (struct snd_usb_caiaqdev *dev,
-			 unsigned char command, 
-			 const unsigned char *buffer,
-			 int len)
+int snd_usb_caiaq_send_command (struct snd_usb_caiaqdev *dev,
+			 	unsigned char command, 
+				const unsigned char *buffer,
+				int len)
 {
 	int actual_len;
 	struct usb_device *usb_dev = dev->chip.dev;
@@ -207,7 +216,7 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev,
 		rate, depth, bpp);
 
 	dev->audio_parm_answer = -1;
-	ret = send_command(dev, EP1_CMD_AUDIO_PARAMS, tmp, sizeof(tmp));
+	ret = snd_usb_caiaq_send_command(dev, EP1_CMD_AUDIO_PARAMS, tmp, sizeof(tmp));
 
 	if (ret)
 		return ret;
@@ -226,7 +235,7 @@ int snd_usb_caiaq_set_auto_msg (struct snd_usb_caiaqdev *dev,
 				int digital, int analog, int erp)
 {
 	char tmp[3] = { digital, analog, erp };
-	return send_command(dev, EP1_CMD_AUTO_MSG, tmp, sizeof(tmp));
+	return snd_usb_caiaq_send_command(dev, EP1_CMD_AUTO_MSG, tmp, sizeof(tmp));
 }
 
 static void setup_card(struct snd_usb_caiaqdev *dev)
@@ -241,7 +250,7 @@ static void setup_card(struct snd_usb_caiaqdev *dev)
 		val[0] = 0x00;
 		val[1] = 0x00;
 		val[2] = 0x01;
-		send_command(dev, EP1_CMD_WRITE_IO, val, 3);
+		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO, val, 3);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
 		/* RigKontrol2 - display two centered dashes ('--') */
@@ -249,12 +258,34 @@ static void setup_card(struct snd_usb_caiaqdev *dev)
 		val[1] = 0x40;
 		val[2] = 0x40;
 		val[3] = 0x00;
-		send_command(dev, EP1_CMD_WRITE_IO, val, 4);
+		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO, val, 4);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
 		/* Audio Kontrol 1 - make USB-LED stop blinking */
 		val[0] = 0x00;
-		send_command(dev, EP1_CMD_WRITE_IO, val, 1);
+		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO, val, 1);
+		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ):
+		/* Audio 8 DJ - trigger read of current settings */
+		dev->control_state[0] = 0xff;
+		snd_usb_caiaq_set_auto_msg(dev, 1, 0, 0);
+		snd_usb_caiaq_send_command(dev, EP1_CMD_READ_IO, NULL, 0);
+		
+		if (!wait_event_timeout(dev->ep1_wait_queue, 
+	    		dev->control_state[0] != 0xff, HZ))
+			return;
+
+		/* fix up some defaults */
+		if ((dev->control_state[1] != 2) ||
+		    (dev->control_state[2] != 3) ||
+		    (dev->control_state[4] != 2)) {
+			dev->control_state[1] = 2;
+			dev->control_state[2] = 3;
+			dev->control_state[4] = 2;
+			snd_usb_caiaq_send_command(dev, 
+				EP1_CMD_WRITE_IO, dev->control_state, 6);
+		}
+
 		break;
 	}
 	
@@ -278,6 +309,10 @@ static void setup_card(struct snd_usb_caiaqdev *dev)
 		log("snd_card_register() returned %d\n", ret);
 		snd_card_free(dev->chip.card);
 	}
+	
+	ret = snd_usb_caiaq_control_init(dev);
+	if (ret < 0)
+		log("Unable to set up control system (ret=%d)\n", ret);
 }
 
 static struct snd_card* create_card(struct usb_device* usb_dev)
@@ -340,7 +375,7 @@ static int init_card(struct snd_usb_caiaqdev *dev)
 	if (usb_submit_urb(&dev->ep1_in_urb, GFP_KERNEL) != 0)
 		return -EIO;
 
-	err = send_command(dev, EP1_CMD_GET_DEVICE_INFO, NULL, 0);
+	err = snd_usb_caiaq_send_command(dev, EP1_CMD_GET_DEVICE_INFO, NULL, 0);
 	if (err)
 		return err;
 
diff --git a/sound/usb/caiaq/caiaq-device.h b/sound/usb/caiaq/caiaq-device.h
index 6857612..a616b6a 100644
--- a/sound/usb/caiaq/caiaq-device.h
+++ b/sound/usb/caiaq/caiaq-device.h
@@ -35,6 +35,7 @@
 #define EP1_CMD_MIDI_WRITE	0x7
 #define EP1_CMD_AUDIO_PARAMS	0x9
 #define EP1_CMD_AUTO_MSG	0xb
+#define EP1_CMD_DIMM_LEDS       0xc
 
 struct caiaq_device_spec {
 	unsigned short fw_version;
@@ -90,11 +91,14 @@ struct snd_usb_caiaqdev {
 	struct snd_pcm_substream *sub_playback[MAX_STREAMS];
 	struct snd_pcm_substream *sub_capture[MAX_STREAMS];
 
+	/* Controls */
+	unsigned char control_state[64];
+
 	/* Linux input */
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	struct input_dev *input_dev;
 	char phys[64];			/* physical device path */
-	unsigned short keycode[10];
+	unsigned short keycode[64];
 #endif
 
 	/* ALSA */
@@ -114,6 +118,9 @@ struct snd_usb_caiaq_cb_info {
 
 int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev, int rate, int depth, int bbp);
 int snd_usb_caiaq_set_auto_msg (struct snd_usb_caiaqdev *dev, int digital, int analog, int erp);
-
+int snd_usb_caiaq_send_command (struct snd_usb_caiaqdev *dev,
+                                unsigned char command,
+				const unsigned char *buffer,
+				int len);
 
 #endif /* CAIAQ_DEVICE_H */
diff --git a/sound/usb/caiaq/caiaq-input.c b/sound/usb/caiaq/caiaq-input.c
index 0aa15ab..78d8bbb 100644
--- a/sound/usb/caiaq/caiaq-input.c
+++ b/sound/usb/caiaq/caiaq-input.c
@@ -38,6 +38,41 @@ static unsigned short keycode_rk2[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
 static unsigned short keycode_rk3[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
 					 KEY_5, KEY_6, KEY_7, KEY_5, KEY_6 };
 
+static unsigned short keycode_kore[] = {
+        KEY_FN_F1,      /* "menu"               */
+        KEY_FN_F7,      /* "lcd backlight       */
+        KEY_FN_F2,      /* "control"            */
+        KEY_FN_F3,      /* "enter"              */
+        KEY_FN_F4,      /* "view"               */
+        KEY_FN_F5,      /* "esc"                */
+        KEY_FN_F6,      /* "sound"              */
+        KEY_FN_F8,      /* array spacer, never triggered. */
+        KEY_RIGHT,
+        KEY_DOWN,
+        KEY_UP,
+        KEY_LEFT,
+        KEY_SOUND,      /* "listen"             */
+        KEY_RECORD,
+        KEY_PLAYPAUSE,
+        KEY_STOP,
+        BTN_4,          /* 8 softkeys */
+        BTN_3,
+        BTN_2,
+        BTN_1,
+        BTN_8,
+        BTN_7,
+        BTN_6,
+        BTN_5,
+        KEY_BRL_DOT4,   /* touch sensitive knobs */
+        KEY_BRL_DOT3,
+        KEY_BRL_DOT2,
+        KEY_BRL_DOT1,
+        KEY_BRL_DOT8,
+        KEY_BRL_DOT7,
+        KEY_BRL_DOT6,
+        KEY_BRL_DOT5
+};
+
 #define DEG90		(range / 2)
 #define DEG180		(range)
 #define DEG270		(DEG90 + DEG180)
@@ -115,19 +150,25 @@ static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev,
 {
 	struct input_dev *input_dev = dev->input_dev;
 
-	switch(input_dev->id.product) {
-	case USB_PID_RIGKONTROL2:
+	switch(dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
 		input_report_abs(input_dev, ABS_X, (buf[4] << 8) | buf[5]);
 		input_report_abs(input_dev, ABS_Y, (buf[0] << 8) | buf[1]);
 		input_report_abs(input_dev, ABS_Z, (buf[2] << 8) | buf[3]);
 		input_sync(input_dev);
 		break;
-	case USB_PID_RIGKONTROL3:
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
 		input_report_abs(input_dev, ABS_X, (buf[0] << 8) | buf[1]);
 		input_report_abs(input_dev, ABS_Y, (buf[2] << 8) | buf[3]);
 		input_report_abs(input_dev, ABS_Z, (buf[4] << 8) | buf[5]);
 		input_sync(input_dev);
 		break;
+        case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+                input_report_abs(input_dev, ABS_X, (buf[0] << 8) | buf[1]);
+                input_report_abs(input_dev, ABS_Y, (buf[2] << 8) | buf[3]);
+                input_report_abs(input_dev, ABS_Z, (buf[4] << 8) | buf[5]);
+                input_sync(input_dev);
+                break;
 	}
 }
 
@@ -137,13 +178,32 @@ static void snd_caiaq_input_read_erp(struct snd_usb_caiaqdev *dev,
 	struct input_dev *input_dev = dev->input_dev;
 	int i;
 
-	switch(input_dev->id.product) {
-	case USB_PID_AK1:
+	switch(dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
 		i = decode_erp(buf[0], buf[1]);
 		input_report_abs(input_dev, ABS_X, i);
 		input_sync(input_dev);
 		break;
-	}
+        case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+                i = decode_erp(buf[7], buf[5]);
+                input_report_abs(input_dev, ABS_HAT0X, i);
+                i = decode_erp(buf[12], buf[14]);
+                input_report_abs(input_dev, ABS_HAT0Y, i);
+                i = decode_erp(buf[15], buf[13]);
+                input_report_abs(input_dev, ABS_HAT1X, i);
+                i = decode_erp(buf[0], buf[2]);
+                input_report_abs(input_dev, ABS_HAT1Y, i);
+                i = decode_erp(buf[3], buf[1]);
+                input_report_abs(input_dev, ABS_HAT2X, i);
+                i = decode_erp(buf[8], buf[10]);
+                input_report_abs(input_dev, ABS_HAT2Y, i);
+                i = decode_erp(buf[11], buf[9]);
+                input_report_abs(input_dev, ABS_HAT3X, i);
+                i = decode_erp(buf[4], buf[6]);
+                input_report_abs(input_dev, ABS_HAT3Y, i);
+                input_sync(input_dev);
+                break;
+        }
 }
 
 static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev,
@@ -160,10 +220,14 @@ static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev,
 		for (i = 0; i < len; i++)
 			buf[i] = ~buf[i];
 
-	for (i = 0; i < input_dev->keycodemax && i < len; i++)
+	for (i = 0; i < input_dev->keycodemax && i < len * 8; i++)
 		input_report_key(input_dev, keycode[i],
 				 buf[i / 8] & (1 << (i % 8)));
 
+        if (dev->chip.usb_id ==
+                USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER))
+                input_report_abs(dev->input_dev, ABS_MISC, 255 - buf[4]);
+
 	input_sync(input_dev);
 }
 
@@ -218,10 +282,10 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 		input_set_abs_params(input, ABS_Z, 0, 4096, 0, 10);
 		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 0);
 		break;
-
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
-		input->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-		input->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_Z);
+		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+		input->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) | 
+			BIT_MASK(ABS_Z);
 		BUILD_BUG_ON(sizeof(dev->keycode) < sizeof(keycode_rk3));
 		memcpy(dev->keycode, keycode_rk3, sizeof(keycode_rk3));
 		input->keycodemax = ARRAY_SIZE(keycode_rk3);
@@ -239,6 +303,32 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 		input_set_abs_params(input, ABS_X, 0, 999, 0, 10);
 		snd_usb_caiaq_set_auto_msg(dev, 1, 0, 5);
 		break;
+        case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+                input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+                input->absbit[0] = BIT_MASK(ABS_HAT0X) | BIT_MASK(ABS_HAT0Y) |
+                                   BIT_MASK(ABS_HAT1X) | BIT_MASK(ABS_HAT1Y) |
+                                   BIT_MASK(ABS_HAT2X) | BIT_MASK(ABS_HAT2Y) |
+                                   BIT_MASK(ABS_HAT3X) | BIT_MASK(ABS_HAT3Y) |
+                                   BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) | 
+				   BIT_MASK(ABS_Z);
+		input->absbit[BIT_WORD(ABS_MISC)] |= BIT_MASK(ABS_MISC);
+		BUILD_BUG_ON(sizeof(dev->keycode) < sizeof(keycode_kore));
+		memcpy(dev->keycode, keycode_kore, sizeof(keycode_kore));
+                input->keycodemax = ARRAY_SIZE(keycode_kore);
+                input_set_abs_params(input, ABS_HAT0X, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_HAT0Y, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_HAT1X, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_HAT1Y, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_HAT2X, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_HAT2Y, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_HAT3X, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_HAT3Y, 0, 999, 0, 10);
+                input_set_abs_params(input, ABS_X, 0, 4096, 0, 10);
+                input_set_abs_params(input, ABS_Y, 0, 4096, 0, 10);
+                input_set_abs_params(input, ABS_Z, 0, 4096, 0, 10);
+                input_set_abs_params(input, ABS_MISC, 0, 255, 0, 1);
+                snd_usb_caiaq_set_auto_msg(dev, 1, 10, 5);
+                break;
 	default:
 		/* no input methods supported on this device */
 		input_free_device(input);

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--tThc/1wpZn/ma/RB--
