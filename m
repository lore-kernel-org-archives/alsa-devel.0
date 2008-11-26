From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] cleanup controllers in snd-usb-caiaq
Date: Wed, 26 Nov 2008 16:19:01 +0100
Message-ID: <20081126151901.GB20061@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pvezYHf7grwyp3Bc"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A65724621
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 16:19:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 5C0D07F402D
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 16:19:04 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZmKp8KtvTr8i for <alsa-devel@alsa-project.org>;
	Wed, 26 Nov 2008 16:19:01 +0100 (CET)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch does some code cleanup in snd-usb-caiaq. No functional change
whatsoever. Version number bumped to 1.3.9.

Best regards,
Daniel


--pvezYHf7grwyp3Bc
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="caiaq-controls-cleanup.diff"

Cleanup controler registration in snd-usb-caiaq.

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/sound/usb/caiaq/caiaq-control.c b/sound/usb/caiaq/caiaq-control.c
index 798ca12..fc3aed9 100644
--- a/sound/usb/caiaq/caiaq-control.c
+++ b/sound/usb/caiaq/caiaq-control.c
@@ -247,6 +247,15 @@ static struct caiaq_controller a8dj_controller[] = {
 	{ "Software lock", 			40 		}
 };
 
+#define ADD_ALL_CONTROLS(a) \
+	for (i = 0; i < ARRAY_SIZE(a); i++) {				\
+		struct caiaq_controller *c = a + i;			\
+		kcontrol_template.name = c->name;			\
+		kcontrol_template.private_value = c->index;		\
+		kc = snd_ctl_new1(&kcontrol_template, dev);		\
+		snd_ctl_add(dev->chip.card, kc);			\
+	}
+
 int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
 {
 	int i;
@@ -254,59 +263,24 @@ int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
 
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
-		for (i = 0; i < ARRAY_SIZE(ak1_controller); i++) {
-			struct caiaq_controller *c = ak1_controller + i;
-			kcontrol_template.name = c->name;
-			kcontrol_template.private_value = c->index;
-			kc = snd_ctl_new1(&kcontrol_template, dev);
-			snd_ctl_add(dev->chip.card, kc);
-		}
-
+		ADD_ALL_CONTROLS(ak1_controller);
 		break;
 
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
-		for (i = 0; i < ARRAY_SIZE(rk2_controller); i++) {
-			struct caiaq_controller *c = rk2_controller + i;
-			kcontrol_template.name = c->name;
-			kcontrol_template.private_value = c->index;
-			kc = snd_ctl_new1(&kcontrol_template, dev);
-			snd_ctl_add(dev->chip.card, kc);
-		}
-
+		ADD_ALL_CONTROLS(rk2_controller);
 		break;
 
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
-		for (i = 0; i < ARRAY_SIZE(rk3_controller); i++) {
-			struct caiaq_controller *c = rk3_controller + i;
-			kcontrol_template.name = c->name;
-			kcontrol_template.private_value = c->index;
-			kc = snd_ctl_new1(&kcontrol_template, dev);
-			snd_ctl_add(dev->chip.card, kc);
-		}
-
+		ADD_ALL_CONTROLS(rk3_controller);
 		break;
 
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
-		for (i = 0; i < ARRAY_SIZE(kore_controller); i++) {
-			struct caiaq_controller *c = kore_controller + i;
-			kcontrol_template.name = c->name;
-			kcontrol_template.private_value = c->index;
-			kc = snd_ctl_new1(&kcontrol_template, dev);
-			snd_ctl_add(dev->chip.card, kc);
-		}
-
+		ADD_ALL_CONTROLS(kore_controller);
 		break;
 
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ):
-		for (i = 0; i < ARRAY_SIZE(a8dj_controller); i++) {
-			struct caiaq_controller *c = a8dj_controller + i;
-			kcontrol_template.name = c->name;
-			kcontrol_template.private_value = c->index;
-			kc = snd_ctl_new1(&kcontrol_template, dev);
-			snd_ctl_add(dev->chip.card, kc);
-		}
-
+		ADD_ALL_CONTROLS(a8dj_controller);
 		break;
 	}
 
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 8317508..b143ef7 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,7 +42,7 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.8");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.9");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"

--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--pvezYHf7grwyp3Bc--
