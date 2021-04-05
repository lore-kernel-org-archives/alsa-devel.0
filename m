Return-Path: <SRS0=UYyO=JC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C942C433B4
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Apr 2021 13:54:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A28613A7
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Apr 2021 13:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A28613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76B7A16E1;
	Mon,  5 Apr 2021 15:53:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76B7A16E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617630859;
	bh=CY4gmP2cYMEpUE9ZKpsikJPHByXxByWBaJbI65o20QY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UG5Jq8b2mS82+MbyFjih53OeS1FBQmzchV6JUv5k8sz5unjNz2KGBLYQt2TwBmESu
	 kVUkrlEDSk856s2qdvXKW2kggymQASXs+EWsGAwxZSGyfh2vXvVjmTXhV3T/ZgTdUG
	 CcHMwKtzfjDJbY/fM+OGpzPu/P6acU2SzxcK2IZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D094F80124;
	Mon,  5 Apr 2021 15:53:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CCE2F8016A; Mon,  5 Apr 2021 15:53:26 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BAF7F80124
 for <alsa-devel@alsa-project.org>; Mon,  5 Apr 2021 15:53:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BAF7F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VHxgE/ep"
Received: by mail-qk1-x72c.google.com with SMTP id v70so11473900qkb.8
 for <alsa-devel@alsa-project.org>; Mon, 05 Apr 2021 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=k5wq9MU2pKQMTs0SMAwvlebSMBppAPGOBU87emkmDOA=;
 b=VHxgE/epuVFE8oXcFie3pq8Wzhgq9PWDyvgEPnWJekDZnCFcXBxWReYwCpeqz2XNzd
 cB1S2Osi+FwhVdOlB8IH7Nz4EC9x48z6sJQYEbQ1/OAgF5sSP9DH2/wsU4wDt52uaHLx
 eXXshyPwF8So3nXnoz13BOyUYBAgUwhx+oS7/UpLCURsgcldVkPpsDOJtSq5SWEosyrh
 0FAbWBVR11517KA4+mKlkPW3tDfFAiLuCKVwy6UDvs+gu2kYUDhipxQf9+RAU1ecSn/i
 z+n9ffT2iX55vfxRubU3j6C8+bKwiieHjcyQ3jIKm+uDPU8A584DsEwBsdx/tl+DD+kB
 zVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=k5wq9MU2pKQMTs0SMAwvlebSMBppAPGOBU87emkmDOA=;
 b=VVokuoeeX8Htw36vPyPjU9Gq+wDKR7heDrOhtoQRfS6wJiU3Yu9i22Myyo+kM0Bc6N
 9mwtRNqHB6k0ueX7C9tZXTfjI9cz4hsFfXAwTDTDKOQQsixii+Ut21wqdZb/8LVfZhDA
 5T4o6hxTke+JpLMUXmWjalvB+Edv8j98JNm3lQt5sYw3dyG4SrtupK4YcUT7iLY8ThF2
 /3l1755+O806709IyFo3+rcrLs58zdI+PvwUyh3q30DvwgQhXlmD9LaUiEE0ZiVeRJKX
 wWvYIBOh8ZkXRnJsYF/ZRHQbBmvG0piPKfDqInJBo4oOvFEf+OJrfvUpc8cZGtlpWXmf
 dmFw==
X-Gm-Message-State: AOAM531MAlud5a3BNGDoD2E2DOApNKn7/6cFBhLIV7/cfEF/a8i8pIMS
 BwM4G5x1Hwjcnc9amPB0QavGdUg/jWDzfifnedaSUscPAHPGsw==
X-Google-Smtp-Source: ABdhPJyBW8N2vIKDmH35R6XS7I/RRdR2KqZSAxJp+wBvNt8SVhV6XCI3Gk7Z34xo9EvjUBFbzOdO5aNGaTkDn8ct+C8=
X-Received: by 2002:a05:620a:10a6:: with SMTP id
 h6mr24622595qkk.366.1617630800314; 
 Mon, 05 Apr 2021 06:53:20 -0700 (PDT)
MIME-Version: 1.0
From: Geraldo <geraldogabriel@gmail.com>
Date: Mon, 5 Apr 2021 10:49:20 -0300
Message-ID: <CAEsQvcs9LcciAYjoB64Kt_VaSww4EAW4-qN0ED5jDA0GeeTtDg@mail.gmail.com>
Subject: [PATCH v2] Pioneer devices: engage implicit feedback sync for playback
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: livvy@base.nu, fabian@lesniak-it.de, Takashi Iwai <tiwai@suse.de>,
 ard@kwaak.net, marcan@marcan.st, franta-linux@frantovo.cz, dmanlfc@gmail.com,
 dmitry@d-systems.ee
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dear Linux users of Pioneer gear, please disregard v1 of this patch and
test this instead if at all possible.

My initial assessment that we needed to let the capture EP be opened twice
was clearly proven wrong by further testing. This is good because if we
really needed that it would require a lot of reengineering inside ALSA.

One thing that still boggles my mind though is why we need a special
Pioneer case inside snd_usb_parse_implicit_fb_quirk that returns 1 like a
capture quirk was found.

This is a highly experimental patch on top of 5.12-rc6 that's supposed to
engage implicit feedback sync on the playback for Pioneer devices. Without
implicit feedback sync the inputs started glitching due to clock drift in
about an hour in my Pioneer DJ DDJ-SR2.

Once again I'd like to thank Takashi Iwai. He's the true author of the bulk
of this code, I just adapted it and coerced it into working.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

--- implicit.c.git      2021-04-04 20:51:57.226754632 -0300
+++ implicit.c  2021-04-05 10:02:41.059816581 -0300
@@ -177,30 +177,31 @@ static int add_roland_implicit_fb(struct
                                       ifnum, alts);
 }

-/* Playback and capture EPs on Pioneer devices share the same iface/altset,
- * but they don't seem working with the implicit fb mode well, hence we
- * just return as if the sync were already set up.
+/* Pioneer devices: playback and capture streams sharing the same
iface/altset
  */
-static int skip_pioneer_sync_ep(struct snd_usb_audio *chip,
-                               struct audioformat *fmt,
-                               struct usb_host_interface *alts)
-{
-       struct usb_endpoint_descriptor *epd;
-
-       if (alts->desc.bNumEndpoints != 2)
-               return 0;
-
-       epd = get_endpoint(alts, 1);
-       if (!usb_endpoint_is_isoc_in(epd) ||
-           (epd->bmAttributes & USB_ENDPOINT_SYNCTYPE) !=
USB_ENDPOINT_SYNC_ASYNC ||
-           ((epd->bmAttributes & USB_ENDPOINT_USAGE_MASK) !=
-            USB_ENDPOINT_USAGE_DATA &&
-            (epd->bmAttributes & USB_ENDPOINT_USAGE_MASK) !=
-            USB_ENDPOINT_USAGE_IMPLICIT_FB))
-               return 0;
-       return 1; /* don't handle with the implicit fb, just skip sync EP */
+static int add_pioneer_implicit_fb(struct snd_usb_audio *chip,
+                                  struct audioformat *fmt,
+                                  struct usb_host_interface *alts)
+{
+       struct usb_endpoint_descriptor *epd;
+
+       if (alts->desc.bNumEndpoints != 2)
+               return 0;
+
+       epd = get_endpoint(alts, 1);
+
+       if (!usb_endpoint_is_isoc_in(epd) ||
+           (epd->bmAttributes & USB_ENDPOINT_SYNCTYPE) !=
USB_ENDPOINT_SYNC_ASYNC ||
+           ((epd->bmAttributes & USB_ENDPOINT_USAGE_MASK) !=
+            USB_ENDPOINT_USAGE_DATA &&
+            (epd->bmAttributes & USB_ENDPOINT_USAGE_MASK) !=
+            USB_ENDPOINT_USAGE_IMPLICIT_FB))
+               return 0;
+       return add_implicit_fb_sync_ep(chip, fmt, epd->bEndpointAddress, 1,
+                                      alts->desc.bInterfaceNumber, alts);
 }

+
 static int __add_generic_implicit_fb(struct snd_usb_audio *chip,
                                     struct audioformat *fmt,
                                     int iface, int altset)
@@ -306,7 +307,7 @@ static int audioformat_implicit_fb_quirk
            alts->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
            (USB_ID_VENDOR(chip->usb_id) == 0x2b73 || /* Pioneer */
             USB_ID_VENDOR(chip->usb_id) == 0x08e4    /* Pioneer */)) {
-               if (skip_pioneer_sync_ep(chip, fmt, alts))
+               if (add_pioneer_implicit_fb(chip, fmt, alts))
                        return 1;
        }

@@ -339,8 +340,20 @@ int snd_usb_parse_implicit_fb_quirk(stru
                                    struct audioformat *fmt,
                                    struct usb_host_interface *alts)
 {
-       if (fmt->endpoint & USB_DIR_IN)
-               return audioformat_capture_quirk(chip, fmt, alts);
+        bool isPioneer;
+
+        if (alts->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+            (USB_ID_VENDOR(chip->usb_id) == 0x2b73 || /* Pioneer */
+             USB_ID_VENDOR(chip->usb_id) == 0x08e4    /* Pioneer */))
+            isPioneer = true;
+
+       if (fmt->endpoint & USB_DIR_IN) {
+                if (isPioneer == true)
+                    return 1;
+                else
+                   return audioformat_capture_quirk(chip, fmt, alts);
+        }
+
        else
                return audioformat_implicit_fb_quirk(chip, fmt, alts);
 }
