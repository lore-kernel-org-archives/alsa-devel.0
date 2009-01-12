From: LCID Fire <lcid-fire@gmx.net>
Subject: [PATCH] serato phono patch
Date: Mon, 12 Jan 2009 20:07:22 +0100
Message-ID: <496B94EA.8080109@gmx.net>
References: <20090112175416.482cdc60.krzysztof.h1@poczta.fm>
	<s5h63kkbgro.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id B46571037F4
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 20:07:45 +0100 (CET)
In-Reply-To: <s5h63kkbgro.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Add serato input phono switch

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index b8cfb7c..66fc115 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2859,7 +2859,7 @@ static int snd_usb_create_streams(struct 
snd_usb_audio *chip, int ctrlif)
     /* find audiocontrol interface */
     host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
     if (!(p1 = snd_usb_find_csint_desc(host_iface->extra, 
host_iface->extralen, NULL, HEADER))) {
-        snd_printk(KERN_ERR "cannot find HEADER\n");
+        snd_printk(KERN_ERR "cannot find HEADER for %d in %s\n", 
ctrlif, host_iface->extra);
         return -EINVAL;
     }
     if (! p1[7] || p1[0] < 8 + p1[7]) {
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 89c63d0..8e936d1 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -2012,6 +2012,233 @@ static void snd_audigy2nx_proc_read(struct 
snd_info_entry *entry,
     }
 }
 
+void snd_usb_cleanup_interrupt_urb(struct urb* pUrb)
+{
+    if(pUrb->transfer_buffer_length > 0)
+        kfree(pUrb->transfer_buffer);
+   
+    if(pUrb->context)
+        kfree(pUrb->context);
+
+    usb_free_urb(pUrb);
+}
+
+/* Wrapper for setting and submitting the interrupt urb().*/
+int snd_usb_interrupt_trans(struct usb_device *dev, unsigned int pipe, 
void *data,
+             __u16 size, usb_complete_t callback)
+{
+    int err;
+    void *buf = NULL;
+    struct urb* pUrb = NULL;
+
+    if (size > 0) {
+        buf = kmemdup(data, size, GFP_KERNEL);
+        if (!buf)
+            return -ENOMEM;
+    }
+
+    pUrb = usb_alloc_urb(1/*int iso packets*/, GFP_KERNEL);
+
+    /*TODO: Remove hardcoded 4*/
+    usb_fill_int_urb(pUrb, dev, pipe, buf, size, callback, NULL, 4);
+
+    err = usb_submit_urb(pUrb, GFP_KERNEL);
+   
+    return err;
+}
+
+#define snd_sl_phono_info        snd_ctl_boolean_mono_info
+
+#define snd_sl_phono_receive snd_usb_cleanup_interrupt_urb
+
+#define snd_sl_phono_changed snd_sl_phono_receive
+
+static int snd_sl_phono_get(struct snd_kcontrol *kcontrol, struct 
snd_ctl_elem_value *ucontrol)
+{
+    ucontrol->value.integer.value[0] = kcontrol->private_value;
+
+/* getting value of the device - commented out
+
+    snd_usb_interrupt_trans(mixer->chip->dev,
+                usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+                buffer, bufferSize, snd_sl_phono_receive);
+
+    unsigned char statusMessage[] = {7};
+
+    snd_usb_interrupt_trans(mixer->chip->dev,
+                usb_sndintpipe(mixer->chip->dev, 0x03),
+                statusMessage, 1, snd_sl_phono_receive);
+*/
+
+    return 0;
+}
+
+/* Log of usb messages on startup
+STARTUP:
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x01 "00"
+IN  03 Length: 0x40 "00 00 03 00 FF FF 02 00 01 00 03 00 01 00 FB FF 01 
00 FF FF 06 00 02 00 FF FF 03 00 05 00 00 00 06 00 FC FF FD FF 03 00 FD 
FF 04 00 FB FF F8 FF FC FF FD FF 06 00 01 00 01 00 FF FF 04 00 02 00"
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x02 "07 01"
+IN  03 Length: 0x40 "07 FF 03 00 FF FF 02 00 01 00 03 00 01 00 FB FF 01 
00 FF FF 06 00 02 00 FF FF 03 00 05 00 00 00 06 00 FC FF FD FF 03 00 FD 
FF 04 00 FB FF F8 FF FC FF FD FF 06 00 01 00 01 00 FF FF 04 00 02 00"
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x01 "06"
+OUT 83 Length: 0x01 "00"
+IN  03 Length: 0x40 "00 FF FE FF FD FF 01 00 03 00 07 00 FE FF 08 00 03 
00 00 00 FC FF 03 00 FF FF 00 00 01 00 03 00 FB FF F9 FF 01 00 FF FF FD 
FF 00 00 FE FF FA FF FF FF FD FF 01 00 04 00 00 00 03 00 FB FF 01 00"
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x01 "01"
+IN  03 Length: 0x40 "01 42 FC 54 03 FF 01 00 03 00 07 00 FE FF 08 00 03 
00 00 00 FC FF 03 00 FF FF 00 00 01 00 03 00 FB FF F9 FF 01 00 FF FF FD 
FF 00 00 FE FF FA FF FF FF FD FF 01 00 04 00 00
+*/
+
+/* Following the messages that are sent prior and after setting the device
+ * no clue what they are good for - but they don't seem necessary
+static int snd_sl_phono_start(struct snd_kcontrol *kcontrol)
+{
+    unsigned char buffer[] = {0};
+    struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+    return snd_usb_interrupt_trans(mixer->chip->dev,
+                usb_sndintpipe(mixer->chip->dev, 0x03),
+                buffer, 1, snd_sl_phono_receive);
+}
+
+static int snd_sl_phono_end(struct snd_kcontrol *kcontrol)
+{
+    unsigned char buffer[] = {6};
+    struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+    return snd_usb_interrupt_trans(mixer->chip->dev,
+                usb_sndintpipe(mixer->chip->dev, 0x03),
+                buffer, 1, snd_sl_phono_receive);
+}
+*/
+
+static int snd_sl_phono_put(struct snd_kcontrol *kcontrol, struct 
snd_ctl_elem_value *ucontrol)
+{
+    int err, changed;
+    const unsigned int bufferSize = 64;
+    unsigned char buffer[bufferSize];   
+    unsigned char instructions[] = {7, 0};
+   
+    struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+    int value = ucontrol->value.integer.value[0];   
+
+/* USB traffic by serato driver
+line to phono:
+
+OUT 03 Length: 0x01 "00"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x02 "07 00"
+IN  83 Length: 0x40 "07 00 01 00 04 00 02 00 02 00 05 00 04 00 02 00 05 
00 06 00 02 00 01 00 03 00 0E 00 05 00 0E 00 09 00 FF FF 02 00 02 00 05 
00 03 00 FA FF 04 00 05 00 07 00 08 00 01 00 02 00 01 00 02 00 01 00"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x01 "06"
+IN  83 Length: 0x40 No answer!?
+
+phono to line:
+OUT 03 Length: 0x01 "00"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x02 "07 01"
+IN  83 Length: 0x40 "07 FF F9 FF FB FF 01 00 FF FF FE FF F6 FF EF FF F8 
FF FD FF FB FF FC FF FA FF 00 00 FA FF F7 FF F5 FF FB FF 01 00 F7 FF F7 
FF FC FF F9 FF F9 FF F7 FF F7 FF 00 00 F4 FF FB FF F6 FF F9 FF FA FF"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x01 "06"
+IN  83 Length: 0x40 No answer!?
+*/
+
+    if (value > 1)
+        return -EINVAL;
+
+    changed = (value != ucontrol->value.integer.value[0]);
+
+/* outcommented for now since it works without and don't have a clue 
what it's good for
+    err = snd_sl_phono_start(kcontrol);
+*/
+
+    err = snd_usb_interrupt_trans(mixer->chip->dev,
+                usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+                buffer, bufferSize, snd_sl_phono_receive);
+   
+    /* 07 00 = phone
+       07 01 = line */
+    instructions[1] = !value;
+
+    err =  snd_usb_interrupt_trans(mixer->chip->dev,
+                usb_sndintpipe(mixer->chip->dev, 0x03),
+                instructions, 2, snd_sl_phono_receive);
+
+    if(err < 0)
+        return err;
+   
+    err = snd_usb_interrupt_trans(mixer->chip->dev,
+                usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+                buffer, bufferSize, snd_sl_phono_changed);
+
+/* outcommented for now since it works without and don't have a clue 
what it's good for
+    err = snd_sl_phono_end(kcontrol);
+*/
+
+    if (err < 0)
+        return err;
+
+    kcontrol->private_value = value;
+    return changed;
+}
+
+static struct snd_kcontrol_new snd_sl_controls[] =
+{
+    {
+        .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name = "Capture Switch",
+        .info = snd_sl_phono_info,
+        .get = snd_sl_phono_get,
+        .put = snd_sl_phono_put,
+        .private_value = 1, /*switch is activated*/
+    }
+};
+
+/* gets called multiple times! */
+static int snd_sl_controls_create(struct usb_mixer_interface *mixer)
+{
+    int i, err;
+
+    for (i = 0; i < ARRAY_SIZE(snd_sl_controls); ++i) {
+        struct snd_ctl_elem_value ucontrol;
+        struct snd_kcontrol *kcontrol = 
snd_ctl_new1(&snd_sl_controls[i], mixer);
+
+        /* Since we only need one control and the routine
+         * is called multiple times we have to ignore all
+         * attempts to attach controls multiple times*/
+        if(snd_ctl_find_id(mixer->chip->card, &kcontrol->id))
+        {
+            /* we found the control - it is already present
+             * so just continue*/
+            snd_ctl_free_one(kcontrol);
+            continue;
+        }
+
+        /* add frees the control if on err < 0! */
+        err = snd_ctl_add(mixer->chip->card,
+                  kcontrol);
+        if (err < 0)
+            return err;
+       
+        /* Phono input is on by default */
+        ucontrol.value.integer.value[0] = 1;
+
+        err = snd_sl_phono_put(kcontrol, &ucontrol);
+
+        if(err < 0)
+            return err; /* the device screwed up */
+    }
+
+    return 0;
+}
+
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif)
 {
     static struct snd_device_ops dev_ops = {
@@ -2043,6 +2270,11 @@ int snd_usb_create_mixer(struct snd_usb_audio 
*chip, int ctrlif)
     if ((err = snd_usb_soundblaster_remote_init(mixer)) < 0)
         goto _error;
 
+    if (mixer->chip->usb_id == USB_ID(0x13e5, 0x001)) {
+        if ((err = snd_sl_controls_create(mixer)) < 0)
+            goto _error;
+    }
+
     if (mixer->chip->usb_id == USB_ID(0x041e, 0x3020) ||
         mixer->chip->usb_id == USB_ID(0x041e, 0x3040)) {
         struct snd_info_entry *entry;
diff --git a/sound/usb/usbmixer_maps.c b/sound/usb/usbmixer_maps.c
index d755be0..87054af 100644
--- a/sound/usb/usbmixer_maps.c
+++ b/sound/usb/usbmixer_maps.c
@@ -261,6 +261,22 @@ static struct usbmix_name_map aureon_51_2_map[] = {
     {} /* terminator */
 };
 
+static struct usbmix_name_map scratch_live_map[] = {
+    /* 1: IT Line 1 (USB streaming) */
+    /* 2: OT Line 1 (Speaker) */
+    /* 3: IT Line 1 (Line connector) */
+    { 4, "Line 1 In" }, /* FU */
+    /* 5: OT Line 1 (USB streaming) */
+    /* 6: IT Line 2 (USB streaming) */
+    /* 7: OT Line 2 (Speaker) */
+    /* 8: IT Line 2 (Line connector) */
+    { 9, "Line 2 In" }, /* FU */
+    /* 10: OT Line 2 (USB streaming) */
+    /* 11: IT Mic (Line connector) */
+    /* 12: OT Mic (USB streaming) */
+    { 0 } /* terminator */
+};
+
 /*
  * Control map entries
  */
@@ -311,6 +327,11 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
         .id = USB_ID(0x0ccd, 0x0028),
         .map = aureon_51_2_map,
     },
+    {
+        .id = USB_ID(0x13e5, 0x0001),
+        .map = scratch_live_map,
+        .ignore_ctl_error = 1,
+    },
     { 0 } /* terminator */
 };
