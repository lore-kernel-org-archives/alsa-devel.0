From: Dan Allongo <gongo2k1@gmail.com>
Subject: Re: PATCH: C-Media 6206 USB Audio
Date: Mon, 8 Jun 2009 11:37:15 -0400
Message-ID: <194d079b0906080837q5d2e6e83vb0fcfab86008e1c0@mail.gmail.com>
References: <194d079b0906071946n8a67312se5d23f7080496fea@mail.gmail.com>
	<s5hd49fqo3z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id C5965244BF
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 17:37:18 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id l33so741003rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 08:37:16 -0700 (PDT)
In-Reply-To: <s5hd49fqo3z.wl%tiwai@suse.de>
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

>From 888c94e4f714bdec2f0959a540721dd700fc8c88 Mon Sep 17 00:00:00 2001
From: Dan Allongo <gongo2k1@gmail.com>
Date: Mon, 8 Jun 2009 11:21:52 -0400
Subject: [PATCH - CM6206 1/1]     modified:   sound/usb/usbaudio.c

Added boot quirk for C-Media CM6206 device in snd_usb_audio_probe.
The function snd_usb_cm6206_boot_quirk sets up six internal 16-bit
registers in order to initialize the device. Values for the registers
came from sniffing USB traffic under Windows since only four of the six
are documented in the datasheet for CM106 and some reserved bits were
also being set.

Signed-off-by: Dan Allongo <gongo2k1@gmail.com>

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index a8ef2cb..94e43ee 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -3291,6 +3291,24 @@ static int snd_usb_cm106_boot_quirk(struct usb_device
*dev)
     return snd_usb_cm106_write_int_reg(dev, 2, 0x8004);
 }

+/*
+ * C-Media CM6206 is based on CM106 with two additional
+ * registers that are not documented in the data sheet.
+ * Values here are chosen based on sniffing USB traffic
+ * under Windows.
+ */
+static int snd_usb_cm6206_boot_quirk(struct usb_device *dev)
+{
+    int err, reg;
+    int val[] = {0x200c,0x3000,0xf800,0x143f,0x0000,0x3000};
+
+    for (reg = 0; reg < 6; reg++) {
+        if ((err = snd_usb_cm106_write_int_reg(dev, reg, val[reg])) < 0)
+            return err;
+    }
+
+    return err;
+}

 /*
  * Setup quirks
@@ -3577,6 +3595,12 @@ static void *snd_usb_audio_probe(struct usb_device
*dev,
             goto __err_val;
     }

+    /* C-Media CM6206 / CM106-Like Sound Device */
+    if (id == USB_ID(0x0d8c, 0x0102)) {
+        if (snd_usb_cm6206_boot_quirk(dev) < 0)
+            goto __err_val;
+    }
+
     /*
      * found a config.  now register to ALSA
      */
-- 
1.5.6.5



On Mon, Jun 8, 2009 at 1:41 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 7 Jun 2009 22:46:51 -0400,
> Dan Allongo wrote:
> >
> > I've been posting on the alsa-users list and I think I finally have a
> > working patch now that I'd like to submit.
> > The C-Media 6206 device is based off of CM106 and just needed a boot
> quirk
> > added to set the registers properly for output.
> > At least one other user can confirm that this patch works and that the
> > SPDIF-out is also functioning now with this change.
> > This is diff'd against today's snapshot so it should be good to go.
> > Let me know if there's anything else that I need to do or change with
> this.
>
> Thanks for the patch!  I'd like certainly to apply it, however...
>
> > +    return snd_usb_cm106_write_int_reg(dev, 0, 0x200c) +
> > +        snd_usb_cm106_write_int_reg(dev, 1, 0x3000) +
> > +        snd_usb_cm106_write_int_reg(dev, 2, 0xf800) +
> > +        snd_usb_cm106_write_int_reg(dev, 3, 0x143f) +
> > +        snd_usb_cm106_write_int_reg(dev, 4, 0x0000) +
> > +        snd_usb_cm106_write_int_reg(dev, 5, 0x3000);
>
> Summing the return values here look weird.
> You want to return an error code, right?  Then use a simple if
> sequence, or write a loop there.
>
> Also, run $LINUX/scripts/checkpatch.pl to your patch and fix errors /
> warnings suggested there.  Then please repost the patch with your
> sign-off.
>
>
> thanks,
>
> Takashi
>
