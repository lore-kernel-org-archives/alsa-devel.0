Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CC9C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 17:37:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61A1613F5
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 17:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61A1613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86D5A847;
	Mon, 24 May 2021 19:37:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86D5A847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621877870;
	bh=Fr3/C6y3g8ZIuGccyQyMnWkYOJCD6pgW4AycehoY23k=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WCC064X2CxFN1i6tmHgHk41ysCFnY24dF6GOCAhxsxzuJANwx/WeebB619ibW2QCB
	 raG/voq7sm4W4OLcyv7HacDjO7k6/pN5jBY4mwCY5/347EKMTDWZoU/0JbBNBPcgG6
	 kqePWxypJmtNQ0XwDFE1zb81l1CUE9/C+yfCWx/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0631CF8021D;
	Mon, 24 May 2021 19:37:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 679F9F8022B; Mon, 24 May 2021 19:36:57 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0CB7F800B8
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 19:36:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0CB7F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YrXVnXcf"
Received: by mail-pf1-x430.google.com with SMTP id q67so4346672pfb.4
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=aE0iQJWz3axz8pF6095x9rK/n7tnpnSurvnaFSIQj8o=;
 b=YrXVnXcfSwt5QnDj262YSEd1ENwB6g2QmZoeEPKL1B5oEsiw1CjPy6y6051sv0xpEj
 Y1cCdF2vpziIlWYbZAhQZiWqoRQ9OtIqHDiPWA6/bRFJMuASR+rqJ5ul27u9bBwY1XHa
 edFpnnTOq8KOg7KlV5w28fEXxyL/7icCBymLEEmJ7koo9Hl/ng3IE59lF60hBekYwTrB
 tqU1MlDrpB/h+gwF1PNg14aAghJt3iaQxGAtZfwyb7PiI98NX5ljM/sl344mCGZeRnEk
 pc/z5gXcgpGXNFUfw4mX2pMI1fqt6Y/e6r4rSHiBcUFigkCA4vI0e/Uhe8ICvz0Oc4Tz
 C0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=aE0iQJWz3axz8pF6095x9rK/n7tnpnSurvnaFSIQj8o=;
 b=qbnCKztRoayDhMQgv8GQDuW+WIwls5P+E6Ah6RSNRMs4dJ1queOoP91HjqrTxZ769T
 /pqItYKCtaDpvlXkJB1U+AKb8AXgiUzcl7Td82KVzDixOt5xOT1jZVSBuX1u/2PiY4TX
 hLaynRIQsL2KBegsWMjQR5ZOKwUAOXo8E+Z1elH4CT1EsjI6RK9M/Xpqk8BOdiMhAbyi
 9zUzoBq07erodBWFQGMydYEfLVSVF8ede60wPjQZTHrdHrMfaSXq2+C7oQCGrxke9Ysp
 wnXE5pJs1LG9uAa3ySkHVkEXSnDwvv0Sd2sv4BqpUq3an89eftogukWtAoGmgRC6FLJS
 5fBw==
X-Gm-Message-State: AOAM533YiX+NyoHp6Fqs1QxMiBGYivmwvry5vOr4N77TIqH4aJdGyBsK
 XmTg7IX1eVRUm1gTUvB3wiE=
X-Google-Smtp-Source: ABdhPJy0q11L7l2xXWJxsf5+Q1oi9FNRJsdIZyEtXD1nJZh7r+SRNLa1ZW1O1cH133Lcskrdzfgxyw==
X-Received: by 2002:a62:d0c2:0:b029:2d9:529f:f4ef with SMTP id
 p185-20020a62d0c20000b02902d9529ff4efmr26270999pfg.41.1621877810401; 
 Mon, 24 May 2021 10:36:50 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
 by smtp.gmail.com with ESMTPSA id x29sm11951643pgl.49.2021.05.24.10.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 10:36:49 -0700 (PDT)
Date: Tue, 25 May 2021 02:36:44 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Oliver Neukum <oneukum@suse.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ALSA: line6: Improve poor error handling in
 line6_init_cap_control
Message-ID: <20210524173644.GA116662@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

line6_init_cap_control doesn't free resources properly when allocations
like kmalloc, usb_alloc_urb fails. It can cause memory leak when some
allocations succeed, and then an error occurs.

This patch makes line6_init_cap_control to properly free the resources,
freeing previously allocated resources when there's an error.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 sound/usb/line6/driver.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 9602929b7de9..6991cb855023 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -688,34 +688,52 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 
 	/* initialize USB buffers: */
 	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
-	if (!line6->buffer_listen)
-		return -ENOMEM;
+	if (!line6->buffer_listen) {
+		ret = -ENOMEM;
+		goto fail_ret;
+	}
 
 	line6->urb_listen = usb_alloc_urb(0, GFP_KERNEL);
-	if (!line6->urb_listen)
-		return -ENOMEM;
+	if (!line6->urb_listen) {
+		ret = -ENOMEM;
+		goto fail1;
+	}
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
 		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
-		if (!line6->buffer_message)
-			return -ENOMEM;
+		if (!line6->buffer_message) {
+			ret = -ENOMEM;
+			goto fail2;
+		}
 
 		ret = line6_init_midi(line6);
 		if (ret < 0)
-			return ret;
+			goto fail3;
 	} else {
 		ret = line6_hwdep_init(line6);
 		if (ret < 0)
-			return ret;
+			goto fail2;
 	}
 
 	ret = line6_start_listen(line6);
 	if (ret < 0) {
 		dev_err(line6->ifcdev, "cannot start listening: %d\n", ret);
-		return ret;
+		if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
+			goto fail3;
+		else
+			goto fail2;
 	}
 
 	return 0;
+
+fail3:
+	kfree(line6->buffer_message);
+fail2:
+	usb_free_urb(line6->urb_listen);
+fail1:
+	kfree(line6->buffer_listen);
+fail_ret:
+	return ret;
 }
 
 static void line6_startup_work(struct work_struct *work)
-- 
2.25.1

