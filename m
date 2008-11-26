From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] cleanup controllers in snd-usb-caiaq
Date: Wed, 26 Nov 2008 19:57:20 +0100
Message-ID: <20081126185720.GA22925@buzzloop.caiaq.de>
References: <20081126151901.GB20061@buzzloop.caiaq.de>
	<s5habbmqypj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4906A247AC
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 19:57:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5habbmqypj.wl%tiwai@suse.de>
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Takashi,

On Wed, Nov 26, 2008 at 04:44:08PM +0100, Takashi Iwai wrote:
> > this patch does some code cleanup in snd-usb-caiaq. No functional change
> > whatsoever. Version number bumped to 1.3.9.
> 
> A macro for such is ugly and potentially dangerous, IMO.
> Make a function instead.
> 
> Also, please add an error check of the return value from
> snd_ctl_add().

Ok, agreed and done. However, I considered it a good idea as it avoided
writing the array's name more than once.

Daniel


--UugvWAfsgieZRqgk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="caiaq-controls-cleanup.diff"

snd-usb-caiaq: clean up the control adding code by moving dulpicate code
to a function.

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/sound/usb/caiaq/caiaq-control.c b/sound/usb/caiaq/caiaq-control.c
index 798ca12..ccd763d 100644
--- a/sound/usb/caiaq/caiaq-control.c
+++ b/sound/usb/caiaq/caiaq-control.c
@@ -247,69 +247,56 @@ static struct caiaq_controller a8dj_controller[] = {
 	{ "Software lock", 			40 		}
 };
 
-int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
+static int __devinit add_controls(struct caiaq_controller *c, int num,
+				  struct snd_usb_caiaqdev *dev)
 {
-	int i;
+	int i, ret;
 	struct snd_kcontrol *kc;
 
+	for (i = 0; i < num; i++, c++) {
+		kcontrol_template.name = c->name;
+		kcontrol_template.private_value = c->index;
+		kc = snd_ctl_new1(&kcontrol_template, dev);
+		ret = snd_ctl_add(dev->chip.card, kc);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
+{
+	int ret = 0;
+
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
+		ret = add_controls(ak1_controller,
+			ARRAY_SIZE(ak1_controller), dev);
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
+		ret = add_controls(rk2_controller,
+			ARRAY_SIZE(rk2_controller), dev);
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
+		ret = add_controls(rk3_controller,
+			ARRAY_SIZE(rk3_controller), dev);
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
+		ret = add_controls(kore_controller,
+			ARRAY_SIZE(kore_controller), dev);
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
+		ret = add_controls(a8dj_controller,
+			ARRAY_SIZE(a8dj_controller), dev);
 		break;
 	}
 
-	return 0;
+	return ret;
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

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--UugvWAfsgieZRqgk--
