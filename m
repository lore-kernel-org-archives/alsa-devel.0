From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 260/493] ALSA: usb-audio: remove use of
	__devinit
Date: Mon, 19 Nov 2012 13:23:29 -0500
Message-ID: <1353349642-3677-260-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.virginia.edu
 [128.143.12.139])
 by alsa0.perex.cz (Postfix) with ESMTP id B5B842625D9
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 19:28:02 +0100 (CET)
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: Daniel Mack <zonque@gmail.com> 
Cc: alsa-devel@alsa-project.org 
---
 sound/usb/6fire/chip.c     | 2 +-
 sound/usb/6fire/comm.c     | 2 +-
 sound/usb/6fire/comm.h     | 2 +-
 sound/usb/6fire/control.c  | 2 +-
 sound/usb/6fire/control.h  | 2 +-
 sound/usb/6fire/firmware.h | 2 +-
 sound/usb/6fire/midi.c     | 2 +-
 sound/usb/6fire/midi.h     | 2 +-
 sound/usb/6fire/pcm.c      | 4 ++--
 sound/usb/6fire/pcm.h      | 2 +-
 sound/usb/caiaq/control.c  | 4 ++--
 sound/usb/caiaq/device.c   | 6 +++---
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index fc8cc82..e0f0f92 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -82,7 +82,7 @@ static void usb6fire_chip_destroy(struct sfire_chip *chip)
 	}
 }
 
-static int __devinit usb6fire_chip_probe(struct usb_interface *intf,
+static int usb6fire_chip_probe(struct usb_interface *intf,
 		const struct usb_device_id *usb_id)
 {
 	int ret;
diff --git a/sound/usb/6fire/comm.c b/sound/usb/6fire/comm.c
index 6c3d531..5954fde 100644
--- a/sound/usb/6fire/comm.c
+++ b/sound/usb/6fire/comm.c
@@ -125,7 +125,7 @@ static int usb6fire_comm_write16(struct comm_runtime *rt, u8 request,
 	return usb6fire_comm_send_buffer(buffer, rt->chip->dev);
 }
 
-int __devinit usb6fire_comm_init(struct sfire_chip *chip)
+int usb6fire_comm_init(struct sfire_chip *chip)
 {
 	struct comm_runtime *rt = kzalloc(sizeof(struct comm_runtime),
 			GFP_KERNEL);
diff --git a/sound/usb/6fire/comm.h b/sound/usb/6fire/comm.h
index d2af0a5..6a0840b 100644
--- a/sound/usb/6fire/comm.h
+++ b/sound/usb/6fire/comm.h
@@ -36,7 +36,7 @@ struct comm_runtime {
 			u8 vh, u8 vl);
 };
 
-int __devinit usb6fire_comm_init(struct sfire_chip *chip);
+int usb6fire_comm_init(struct sfire_chip *chip);
 void usb6fire_comm_abort(struct sfire_chip *chip);
 void usb6fire_comm_destroy(struct sfire_chip *chip);
 #endif /* USB6FIRE_COMM_H */
diff --git a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
index 07ed914..3492bd1 100644
--- a/sound/usb/6fire/control.c
+++ b/sound/usb/6fire/control.c
@@ -561,7 +561,7 @@ static int usb6fire_control_add_virtual(
 	return 0;
 }
 
-int __devinit usb6fire_control_init(struct sfire_chip *chip)
+int usb6fire_control_init(struct sfire_chip *chip)
 {
 	int i;
 	int ret;
diff --git a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
index 9a596d9..5a40ba1 100644
--- a/sound/usb/6fire/control.h
+++ b/sound/usb/6fire/control.h
@@ -50,7 +50,7 @@ struct control_runtime {
 	u8 ivol_updated;
 };
 
-int __devinit usb6fire_control_init(struct sfire_chip *chip);
+int usb6fire_control_init(struct sfire_chip *chip);
 void usb6fire_control_abort(struct sfire_chip *chip);
 void usb6fire_control_destroy(struct sfire_chip *chip);
 #endif /* USB6FIRE_CONTROL_H */
diff --git a/sound/usb/6fire/firmware.h b/sound/usb/6fire/firmware.h
index 0085698..c109c4f 100644
--- a/sound/usb/6fire/firmware.h
+++ b/sound/usb/6fire/firmware.h
@@ -22,6 +22,6 @@ enum /* firmware state of device */
 	FW_NOT_READY = 1
 };
 
-int __devinit usb6fire_fw_init(struct usb_interface *intf);
+int usb6fire_fw_init(struct usb_interface *intf);
 #endif /* USB6FIRE_FIRMWARE_H */
 
diff --git a/sound/usb/6fire/midi.c b/sound/usb/6fire/midi.c
index f0e5179..2672242 100644
--- a/sound/usb/6fire/midi.c
+++ b/sound/usb/6fire/midi.c
@@ -146,7 +146,7 @@ static struct snd_rawmidi_ops in_ops = {
 	.trigger = usb6fire_midi_in_trigger
 };
 
-int __devinit usb6fire_midi_init(struct sfire_chip *chip)
+int usb6fire_midi_init(struct sfire_chip *chip)
 {
 	int ret;
 	struct midi_runtime *rt = kzalloc(sizeof(struct midi_runtime),
diff --git a/sound/usb/6fire/midi.h b/sound/usb/6fire/midi.h
index 5114ecc..c321006 100644
--- a/sound/usb/6fire/midi.h
+++ b/sound/usb/6fire/midi.h
@@ -38,7 +38,7 @@ struct midi_runtime {
 	void (*in_received)(struct midi_runtime *rt, u8 *data, int length);
 };
 
-int __devinit usb6fire_midi_init(struct sfire_chip *chip);
+int usb6fire_midi_init(struct sfire_chip *chip);
 void usb6fire_midi_abort(struct sfire_chip *chip);
 void usb6fire_midi_destroy(struct sfire_chip *chip);
 #endif /* USB6FIRE_MIDI_H */
diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index c97d05f..f87bd55 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -559,7 +559,7 @@ static struct snd_pcm_ops pcm_ops = {
 	.pointer = usb6fire_pcm_pointer,
 };
 
-static void __devinit usb6fire_pcm_init_urb(struct pcm_urb *urb,
+static void usb6fire_pcm_init_urb(struct pcm_urb *urb,
 		struct sfire_chip *chip, bool in, int ep,
 		void (*handler)(struct urb *))
 {
@@ -578,7 +578,7 @@ static void __devinit usb6fire_pcm_init_urb(struct pcm_urb *urb,
 	urb->instance.number_of_packets = PCM_N_PACKETS_PER_URB;
 }
 
-int __devinit usb6fire_pcm_init(struct sfire_chip *chip)
+int usb6fire_pcm_init(struct sfire_chip *chip)
 {
 	int i;
 	int ret;
diff --git a/sound/usb/6fire/pcm.h b/sound/usb/6fire/pcm.h
index 3104301..9b01133 100644
--- a/sound/usb/6fire/pcm.h
+++ b/sound/usb/6fire/pcm.h
@@ -69,7 +69,7 @@ struct pcm_runtime {
 	bool stream_wait_cond;
 };
 
-int __devinit usb6fire_pcm_init(struct sfire_chip *chip);
+int usb6fire_pcm_init(struct sfire_chip *chip);
 void usb6fire_pcm_abort(struct sfire_chip *chip);
 void usb6fire_pcm_destroy(struct sfire_chip *chip);
 #endif /* USB6FIRE_PCM_H */
diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 00e5d0a..8d6c308 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -489,7 +489,7 @@ static struct caiaq_controller kontrols4_controller[] = {
 	{ "LED: FX2: Mode",			133 | CNT_INTVAL },
 };
 
-static int __devinit add_controls(struct caiaq_controller *c, int num,
+static int add_controls(struct caiaq_controller *c, int num,
 				  struct snd_usb_caiaqdev *dev)
 {
 	int i, ret;
@@ -507,7 +507,7 @@ static int __devinit add_controls(struct caiaq_controller *c, int num,
 	return 0;
 }
 
-int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
+int snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
 {
 	int ret = 0;
 
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 7da0d0a..c828f81 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -289,7 +289,7 @@ int snd_usb_caiaq_set_auto_msg(struct snd_usb_caiaqdev *dev,
 					  tmp, sizeof(tmp));
 }
 
-static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
+static void setup_card(struct snd_usb_caiaqdev *dev)
 {
 	int ret;
 	char val[4];
@@ -407,7 +407,7 @@ static int create_card(struct usb_device *usb_dev,
 	return 0;
 }
 
-static int __devinit init_card(struct snd_usb_caiaqdev *dev)
+static int init_card(struct snd_usb_caiaqdev *dev)
 {
 	char *c, usbpath[32];
 	struct usb_device *usb_dev = dev->chip.dev;
@@ -481,7 +481,7 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	return 0;
 }
 
-static int __devinit snd_probe(struct usb_interface *intf,
+static int snd_probe(struct usb_interface *intf,
 		     const struct usb_device_id *id)
 {
 	int ret;
-- 
1.8.0
