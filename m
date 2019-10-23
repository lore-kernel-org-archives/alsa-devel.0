Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6689CA9EB9
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 04:52:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526B321872
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 04:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="leChkv4g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2h9xPiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526B321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3BCD1662;
	Wed, 23 Oct 2019 06:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3BCD1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571806320;
	bh=WJbpPyy06ZTWVw25vOQyHq24ONsI2GuBzTM5xDeoqhc=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=leChkv4gmaS25Cp2aC1quBz4QVLh3VYiofHipzYouO/R004p9Dx7VDGash5ik4tVi
	 Ltgf9/GPueDGXsF1bMxNHsU+pNzN0gos977IdaVWhfpRfbTCHImn0j9pK1XbALt0o9
	 XZ66gR11Q/lRRtzu/eO6kZWjVDZ+osFO3S4pV/xI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7907AF80274;
	Wed, 23 Oct 2019 06:48:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7266FF80368; Wed, 23 Oct 2019 06:05:22 +0200 (CEST)
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 941BCF80274
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 06:05:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 941BCF80274
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="X2h9xPiC"
Received: by mail-vs1-xe43.google.com with SMTP id j85so3789231vsd.11
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=9H8nYrQhOjB2A3FwoGKLO7o+79UaUbsJYfq2RcqOLpY=;
 b=X2h9xPiC11JJBVG4aZR9eDFAzk2iEeP0aPy32F6H+4OOKUh4eMSNpodUB5Ljz0RL9g
 tQcN71hFC7h7IPpVCs6pAIuq8QJUf9OL48MUw8sV00z20Rj9Z7HjT4CWXDe9njX+THPI
 HzakwCBf8nBM3khQfJ07tkcmhUTxi5poEP4UB5qRQjLNU7sqzCasCRY722DfjUAooWhu
 ruz5be99WQ+ZaQ9BOYP/odP+BO4O2B8GBVtHTVgeFqkQRFi5WwluurGzWJulZJE21FRo
 FA1gUO4pfifFyGBZIcr5lJcOWlfRCbHOLrfNEyiJlcW+H7lDd2U0xu09wxjE3HL0Xi7g
 MCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=9H8nYrQhOjB2A3FwoGKLO7o+79UaUbsJYfq2RcqOLpY=;
 b=W8LXMavNp4gY8jk1MSIGQ9C7lsmxYU3j8ZNIFNtNpMidB87x5uJWokKFiKHhmjdJ9K
 kiH8b/EtoT/rNkzbKo2sUWQCXJLEtLM0Pj82IKaQSvUqLZWrjeDWmbwUyBWLQOJ6uJzM
 G9BTVdUnrwSxyyM5HM45X/EF48/oHfbCTpVpe1KBR1I5xu6nIs0HSYbL1OxTxvf5yfjT
 DjI5vzAaLg05DwCnuYUVvk9kkI9rKT/v22AkMmPyGENiQXq2HeOq5SrhuIdd02YsnUx5
 0QEaDCULh5axyVyp+E25QKxH76IXIdQufDUSSFb75fl293bormb6NKgU10qIyfuwpKXa
 Mgxg==
X-Gm-Message-State: APjAAAWew0oS5HglAIBFlNdqFeOQyMVG5ohYG2Nf5L3fJfup0uO6MrDx
 54tdlBcc0marEVZSNvyRDAG6LVYwY158mHDUcvY=
X-Google-Smtp-Source: APXvYqyPqiB5q26NdusQaDAE9nmzfH55qAYC8hKj8nylD5Q6AFugbWBt77ls6KxG8hdFwBR1YOFd9xRVost37qOgfPA=
X-Received: by 2002:a05:6102:3004:: with SMTP id
 s4mr2507127vsa.214.1571803517087; 
 Tue, 22 Oct 2019 21:05:17 -0700 (PDT)
MIME-Version: 1.0
From: Fly Pig <flyingecar@gmail.com>
Date: Tue, 22 Oct 2019 21:05:08 -0700
Message-ID: <CA+9XP1jeMVuzj0gz_-H6zV=cmjWQwvBLi08AED1KBie+kugmcg@mail.gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
X-Mailman-Approved-At: Wed, 23 Oct 2019 06:48:10 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: Add Gustard U16/X26 device
 family to quirks for native DSD support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi There


This patch add native DSD support for Gustard U16/X26 USB Interface. Tested
on my unit, working properly. Hence submit the patch.

Cheers.

Thank you very much.

Pig







--- a/sound/usb/quirks.c 2019-09-22 21:28:09.757897000 +0000
+++ b/sound/usb/quirks.c 2019-09-22 21:33:36.892274800 +0000
@@ -1369,6 +1369,7 @@
  case USB_ID(0x22d9, 0x0461): /* OPPO UDP-205 */
  case USB_ID(0x2522, 0x0012): /* LH Labs VI DAC Infinity */
  case USB_ID(0x2772, 0x0230): /* Pro-Ject Pre Box S2 Digital */
+        case USB_ID(0x292b, 0xc4b3): /* Gustard U16 */
  if (fp->altsetting == 2)
  return SNDRV_PCM_FMTBIT_DSD_U32_BE;
  break;
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
