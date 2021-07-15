Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64F5C07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 06:56:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E05F6115B
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 06:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E05F6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 060A81685;
	Thu, 15 Jul 2021 08:55:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 060A81685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626332173;
	bh=AYlFQTO3wPDStxxZ3BJ4AEN/4qr7brdknRkhzu4gd2w=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CgqvSF+Vgdnr7Q2ITZuTf71oY5axWoXeV0iKlJ2SLvRH4z75flhvNa3sxqs/vgpF5
	 EobSXC8XHGkROa1ct8qb4YLMfjJZz8gqpWU2sCuE56CRZq1FYeiJwfQYxx68pYeSUE
	 ByfkRavDA8ihak1ETumzc8Y6nOoIWTdwRwHnuVmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32245F804FD;
	Thu, 15 Jul 2021 08:52:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AB05F80254; Thu, 15 Jul 2021 02:56:38 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EBD3F8013C
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 02:56:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EBD3F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TZTYDeob"
Received: by mail-wr1-x42c.google.com with SMTP id d12so5393806wre.13
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=gSBGqDMM3Jz7qv5xcKdOnajx3PDMhN4qp53yDYdoaRU=;
 b=TZTYDeobReI0lDgoPR6N8gFO8LN1w4DsdXGUhDLn1nrJzQf+Xs0tP0mW0cLjRVIM+G
 G90WjIGjw12EZiffyjbsbkl186cn8MzGRF6nbrGbScN78/O5Spu7AWkA6w6AQplLRcrA
 l+FSln1FteHsKdHKBjJZZf9TCcXPDmDARD0FKHAOCVXKhEEf3Xq0R7Wrw9+yAKghlIhd
 af7FAPq5NPYqnLsTqsws7qTZ60EkSO5FrF2uXWQ/6F2JVbv7Hir8BGDkw2tysLmq/1/4
 K1SVZPIytbtXqlbFBjK2cgBMiF4fuqPxYbPw6TbjbKPcVmpw2tdvci7BCay9hs2VNnq7
 CfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=gSBGqDMM3Jz7qv5xcKdOnajx3PDMhN4qp53yDYdoaRU=;
 b=RDg9xHilPLk7didOrkE4V4mRdtG6yuLgKoxJzMRwFYvO7xZy0YermXRwvcidUWfvLK
 SEZygdZJrXxmBe78tyvZycR5rPOXzxmkskbVvN5D09Wr+YBSHqANUIstxkJN7z8Kqnwq
 R4jQuE0vwcqxMOiubcSFj/WL7fYXlXjd/iJ8VtWVTZ7jBNgRvk+lYY5LpxED0V9Vc7Cy
 Pua9s3i1ZsFiVpBFqcOCFAjANoxkFesPPajpwOE8Z7fjQ/ajqvGAca32bO9ekN/SKEzu
 /tbw3UatfNXOL6ZxEzynRmxqHkaV4d+uuvh7WNRFhDuRynxBFEkTmGhD7JPE7tx6AKeB
 Ovpw==
X-Gm-Message-State: AOAM532jiVmdWFsqKKTpc2J0nu7Ampaz/z4jiiDpsPfYAT+jNifYCKgv
 zk4OFLQBOC3yMgOAqXRVuX8=
X-Google-Smtp-Source: ABdhPJz8WKBFCdSljGyrcHfmuKAd2NQ/pQWZ3gjNWrVIIw8NUt4dycZyqTTRwc3+UQYiTpG9tzZoZg==
X-Received: by 2002:adf:a183:: with SMTP id u3mr897426wru.175.1626310589080;
 Wed, 14 Jul 2021 17:56:29 -0700 (PDT)
Received: from pc ([196.235.28.219])
 by smtp.gmail.com with ESMTPSA id p2sm3352888wmg.6.2021.07.14.17.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 17:56:28 -0700 (PDT)
Date: Thu, 15 Jul 2021 01:56:25 +0100
From: Salah Triki <salah.triki@gmail.com>
To: perex@perex.cz, tiwai@suse.com
Subject: [PATCH] sound: usb: line6: free allocated urbs on failure
Message-ID: <20210715005625.GA1997259@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 15 Jul 2021 08:52:27 +0200
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

Free allocated urbs on failure in order to prevent memory leaks.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 sound/usb/line6/capture.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 970c9bdce0b2..345b75ede5d5 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -258,6 +258,7 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 {
 	struct usb_line6 *line6 = line6pcm->line6;
 	int i;
+	int ret;
 
 	line6pcm->in.urbs = kcalloc(line6->iso_buffers, sizeof(struct urb *),
 				    GFP_KERNEL);
@@ -272,8 +273,10 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 		urb = line6pcm->in.urbs[i] =
 		    usb_alloc_urb(LINE6_ISO_PACKETS, GFP_KERNEL);
 
-		if (urb == NULL)
-			return -ENOMEM;
+		if (urb == NULL) {
+			ret = -ENOMEM;
+			goto enomem;
+		}
 
 		urb->dev = line6->usbdev;
 		urb->pipe =
@@ -286,9 +289,20 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 		urb->interval = LINE6_ISO_INTERVAL;
 		urb->error_count = 0;
 		urb->complete = audio_in_callback;
-		if (usb_urb_ep_type_check(urb))
-			return -EINVAL;
+		if (usb_urb_ep_type_check(urb)) {
+			ret = -EINVAL;
+			goto einval;
+		}
 	}
 
 	return 0;
+
+enomem:
+	i--;
+
+einval:
+	while (i >= 0)
+		usb_free_urb(line6pcm->in.urbs[i--]);
+
+	return ret;
 }
-- 
2.25.1

