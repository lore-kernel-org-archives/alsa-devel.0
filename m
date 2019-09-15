Return-Path: <SRS0=b7Q8=XK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E6C4CEC7
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 12:45:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B00214C6
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XLr9WQ4W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netforce.ua header.i=@netforce.ua header.b="PipIVkOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B00214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=netforce.ua
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 122811612;
	Sun, 15 Sep 2019 14:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 122811612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568551521;
	bh=tvgXNthATEw2ixW15EJGH5Q1kpV8tn6ZFxTiSg7V/Vw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XLr9WQ4W536Gnn+nzORhLQus0amlaJaMPJgnMzjT1Ktgf5SI2iqqYqX86Ji9VR5HS
	 l2OzGuZH+mlYkfWaPwnsz9afWUP4K8ZX7kUJtgmv2PC3M7vtwIZ40GwZ4Pwl5a5rSU
	 Be4VqqTyn8f0GWLvHn4alRTWSpgY9TUyEGsjnySM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6605BF802DF;
	Sun, 15 Sep 2019 14:44:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B51BF80361; Sun, 15 Sep 2019 14:44:27 +0200 (CEST)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBEE2F802DF
 for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2019 14:44:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBEE2F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=netforce.ua header.i=@netforce.ua
 header.b="PipIVkOF"
Received: by mail-lf1-x144.google.com with SMTP id w67so25332491lff.4
 for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2019 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netforce.ua; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MFj5Gh6TGZA1arOapAJ2tmpTqH/CJaSifKu4rw3SbJg=;
 b=PipIVkOF2Dqa/X61x5eYjgo9Fh8ef1m5QJ331U36vW22ClfNxvNqkcXj/v4JWkfq+C
 Q42U83HjNsovM4bbXNuCjFf/kg3hNp+Wwegb0UI0DZEOpLovXPVqWPcKLPqcMN7tIMzW
 mTL84UN1Mpn5fEP9SFUUPJgvhEl6FsMT31pIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MFj5Gh6TGZA1arOapAJ2tmpTqH/CJaSifKu4rw3SbJg=;
 b=KEA3R284C+LjyvNFsR7lORSLRX6M0VYUmtanPqSmK4+nsQlGpjxlGQoZhsN+cTuo7X
 60M9K5sGbo3iY/ik9stt4ElQU0SgmF1QEuxm4CunExIrtZ9cIQXYgTFKg5UFXHV/1Olf
 qykG6eF8sjPEw+3HlgO3QH6Bqesl2OvoOhirAwmY3RZE+CgvZH5Fe3jgL7yRVZKs7q4M
 pdidwogkGVlpumWUfRrto+qUV3RjoFakWHgauK7a8/LCn58CNDJod41TY9K3Mhw7XTFA
 VbMyHlU/OQ7RSEl9X+XwS5ORf9X77+BN7CcN6K4Ishw9UJLQyOe71jOCu0uOSDqMwas4
 Kg5Q==
X-Gm-Message-State: APjAAAVfpbKPfbPDevuENXvFuq4LSbMfvCAiIJfjfzPSu6GpWe/7SBeP
 axmYDwyahdDewrbZjaIN/NoQZw==
X-Google-Smtp-Source: APXvYqwPfJiyb6VwO8HmojQIrfBxm93gekDw9na/dZ90/f4+oy8hhpzP9igR0I8qLC4eYLZWbVQRdA==
X-Received: by 2002:a19:2d19:: with SMTP id k25mr37919346lfj.76.1568551462691; 
 Sun, 15 Sep 2019 05:44:22 -0700 (PDT)
Received: from rhea.localdomain ([37.46.255.109])
 by smtp.gmail.com with ESMTPSA id 77sm7819743ljf.85.2019.09.15.05.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 05:44:22 -0700 (PDT)
From: ilya.pshonkin@netforce.ua
To: ilya.pshonkin@netforce.ua
Date: Sun, 15 Sep 2019 15:43:59 +0300
Message-Id: <20190915124400.6244-1-ilya.pshonkin@netforce.ua>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Tony Das <tdas444@gmail.com>, Udo Eberhardt <udo.eberhardt@thesycon.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manuel Reinhardt <manuel.rhdt@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Jussi Laako <jussi@sonarnerd.net>, Olek Poplavsky <woodenbits@gmail.com>,
 Sudokamikaze <sudokamikaze@protonmail.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>,
 alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: Add Hiby device family to
	quirks for native DSD support
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

From: Sudokamikaze <sudokamikaze@protonmail.com>

This patch adds quirk VID ID for Hiby portable players family with native DSD playback support

Signed-off-by: Sudokamikaze <sudokamikaze@protonmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 78858918cbc1..64a8d73972e3 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1655,6 +1655,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
 	case 0x2ab6:  /* T+A devices */
+	case 0xc502:  /* HiBy devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
