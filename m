Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE6FC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:03:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DBC20715
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o5g4Zz4g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTcNzDrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DBC20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 375AE1671;
	Tue, 25 Aug 2020 13:02:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 375AE1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598353396;
	bh=arl6kymQUvKI0aFTN9OHnrJOcaaQ09VPUVpc9cUMbME=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o5g4Zz4gW0M2qt9Nxkj4nL5G9CrnNHLPI1ZT8B1nmcIprsEYNd6aqsd3sKR54Ub2U
	 k/7yvQU3BPjxgEFzdfC4LmQpbbz7tzSe+piogJy5iE7To8LeGigsdrYWXxvlc3SvsU
	 W2i/09Txv8gZcrDdVsNRtTUqZYnSw7ZZzSibWZFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E609DF8026A;
	Tue, 25 Aug 2020 13:01:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91E3FF801D9; Mon, 24 Aug 2020 14:16:46 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEFE0F800B8
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 14:16:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEFE0F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="fTcNzDrl"
Received: by mail-pj1-x1044.google.com with SMTP id mt12so4209710pjb.4
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I81TrQIlLLJRVVinDOxjbOmcQCTQyJqY7KYEl8xpvEM=;
 b=fTcNzDrl8kfLjwHdkCMdbczkh+KWqbexfro8OnEnfFmyMT8H88j8lunKyr2nCY42IE
 qr0xHOxX/r0EUEc91u2I5XCUJ68oIF/OwPlHhyGxIlg6BDfnZriWOUx2nChlrVVFgjtM
 12UR8j4H/Bwr96Lv1O0ur3R0+EkVJvTMbwP+JsRTwkMziQ6SpL1v+qVvIZ4UyENOPo9o
 l5Sk2eMkbNtQ5TPPZ5UBrfssJN88XJP1zj5rZIsJfVdhj/Ydpe/gxJi7jbrtZXoJzTTA
 G6f25vpDU6ECDRoPkrS/vBWHvJoiiyGJSQDoAdQ7nSvP5zhOtTZJRzQDXHkl95b+ZU6t
 SX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I81TrQIlLLJRVVinDOxjbOmcQCTQyJqY7KYEl8xpvEM=;
 b=mlLcLXDkQoycOE+UMvSHTfscRBBCVEAGujXPGKi9btgAsee3qBjfXows5L2vV1pJbD
 RTE9Q6S1ZVK3TsIHjdBktOwWJmwz+ksgiXgcGrV+S+13NOeTtYbPr7Rz9hEqSWoGfb6R
 QeOMaSE1g79zIvAH7CvHwJaEShVaOXZYzABfvXnPYCOoAf3W+zMP2mITjKT1PKPCuX8h
 HJtl/Zfo1VQGHjZ87qGgFd9ug1US8MM2F3XJv+4lm3AT7Rtc1cO1ypnxAgc9/wxhsrpx
 1Js6i5gn/9XdVrmcDczYFmlZsWQEy5z7OEvb0M2jAdoqt2IOZBgPcy3Y+6dQehgmYOUQ
 YUDQ==
X-Gm-Message-State: AOAM533r1CMyIWjyYhbQf8JSH5tlSxHFtioIm8uR+ia5iZ2KjsC8Cw9q
 HRc4qvriTMKPfqP9jrgEYtU=
X-Google-Smtp-Source: ABdhPJz3VGjcaREhiRJXYcgbj4i0IEOF7ornuO6w7LX5m2XEB/4NztqaV6m5y2MksmNQpIag5bWmFw==
X-Received: by 2002:a17:902:fe0f:: with SMTP id
 g15mr1445494plj.204.1598271395782; 
 Mon, 24 Aug 2020 05:16:35 -0700 (PDT)
Received: from localhost.localdomain ([112.214.139.41])
 by smtp.googlemail.com with ESMTPSA id j5sm11656610pfg.80.2020.08.24.05.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 05:16:35 -0700 (PDT)
From: Adrien Crivelli <adrien.crivelli@gmail.com>
To: 
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion 15
 inches
Date: Mon, 24 Aug 2020 21:15:54 +0900
Message-Id: <20200824121554.73933-1-adrien.crivelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2020 13:01:32 +0200
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Adrien Crivelli <adrien.crivelli@gmail.com>
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

The Galaxy Book Ion 15 inches uses the same ALC298 codec as other Samsung
laptops which have the no headphone sound bug. I confirmed on my own
hardware that this fixes the bug.

Commit e17f02d05 mixed up 13 inches and 15 inches models. This clarifies
the situation with the correct model names.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Adrien Crivelli <adrien.crivelli@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a1fa983d2..98789691a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7695,7 +7695,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
-	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc830, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
-- 
2.25.1

