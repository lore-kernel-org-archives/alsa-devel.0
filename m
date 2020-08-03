Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A18CC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 00:30:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD442070A
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 00:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l2yrsaTS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZnPYnbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD442070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 915D315E2;
	Mon,  3 Aug 2020 02:29:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 915D315E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596414637;
	bh=0R/h9u46Tj5hYVXR64MDrJkicSzQD68C8mUa5PZa0uI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2yrsaTSpwLPrxFnNQOfKU0Z0zDi5Q9JbCq7xFI1nJgqoOWO+2dxoUZc98MfmdZ5i
	 zPx1FgyLiqVXjgnFmfY7OI71CnYGfmZqbGI0SqI0giyRi/40RUwC6BEQVpkllD7QYw
	 ZbysqqtK5HmW+mIgN98hmf4ZyOfmvsPGdWOxl9oE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30340F80141;
	Mon,  3 Aug 2020 02:29:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82D53F8015A; Mon,  3 Aug 2020 02:29:44 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F0AAF80141
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 02:29:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F0AAF80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kZnPYnbh"
Received: by mail-qk1-x743.google.com with SMTP id j187so33772254qke.11
 for <alsa-devel@alsa-project.org>; Sun, 02 Aug 2020 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wbEGrIvZnD3c5e9YLVsP9l3cXHWv/XnjtutRuXBXv2Y=;
 b=kZnPYnbhyn4b0RUOJvuHY816xQkFRnbusqzvbEsBIywM9J6tMQozU+auwAFsgXDvkW
 Z1wwjHkEnsQ+4AsmYEntMY5HsJOlgTr9m0ydGIyzN75pVl8+pb1vrEqS8UXVQ2Z1mylf
 ouYo5TDRvGc756JR+azL7yqDiducTqb09NP0iMusiEvjxXJiWULAqu0IUHlj9uPgvUvM
 4ydmKFZVIa7dx1Mjo1SUSaf60MlZr6XdsNGUmdDnKNaD5egsl4CFQHFBPA9XFzaK963j
 nD/hLuKov+eaD1QySN9G6TophreFTJYELd5bTMbwl3I0VrV0I8sxI1lsD0MSsvB+YXof
 hU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wbEGrIvZnD3c5e9YLVsP9l3cXHWv/XnjtutRuXBXv2Y=;
 b=lq214kOxkyeyHC3j4v1qlJv2Sq8cGW1AUshcPlEStjfpLjBg3FS/JxSKoYIyzVh17p
 Sx/9Qisz3HQ4Px0GR/taYkw83oQknsZz1h1o0wAlrrWfXO9sgfMgwM2ST7dwthcSPGYe
 IuUI7qFi+OE4HOE/HQHMgpEXA0KQgxAAx5DIUvrWlnD7pvxWr7mk2xlTRUwXZcLoYKF0
 Azi21lj1ICTiYBRyj0sY9bDEhzi4oTud+dFiLOIEp/0wSKFEYL6SuE9q8gM/bIj9pzvA
 w+MEFk/EHqyT/ecV6xjSaLRxuvVEDSuqwSh14DGywrZdw4SkjTd/zijx+huWji3M9Uk8
 SkjQ==
X-Gm-Message-State: AOAM532L6xY3JHndk7T5VMiArffAQsXCiB2XKR4pT2MaK8Bzo8CkfsnL
 llCgqd3MZXk1pIseC0Lv6x4=
X-Google-Smtp-Source: ABdhPJxT/YVhLXF97DW1ZpYjJmuQrmDDCsUH8rSWcK8mvU3A1R/Ju0jerejM4AM0S2Rt2IdmmQ8Mpw==
X-Received: by 2002:a05:620a:4d9:: with SMTP id
 25mr13611430qks.411.1596414577758; 
 Sun, 02 Aug 2020 17:29:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id e23sm18261614qto.15.2020.08.02.17.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 17:29:37 -0700 (PDT)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 2/3] ALSA: hda/ca0132 - Add new quirk ID for Recon3D.
Date: Sun,  2 Aug 2020 20:29:26 -0400
Message-Id: <20200803002928.8638-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803002928.8638-1-conmanx360@gmail.com>
References: <20200803002928.8638-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Geoffrey Allott <geoffrey@allott.email>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 conmanx360@gmail.com, =?UTF-8?q?Pawe=C5=82=20Rekowski?= <p.rekowski@gmail.com>
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

Add a new quirk ID for the Recon3D, as tested by me.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2cbe01d59c16..40fa9d82ef95 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1182,6 +1182,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
+	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0051, "Sound Blaster AE-5", QUIRK_AE5),
 	{}
 };
-- 
2.20.1

