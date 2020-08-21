Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A92C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:01:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3661520738
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g/TAsmNK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFRXGiY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3661520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2A3F1683;
	Fri, 21 Aug 2020 21:00:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2A3F1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598036483;
	bh=xQiIoLEk5KOB6E/J9T4pYpG+NbUu6eskEaaEboFMhjw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/TAsmNKSyf/4Oa85teONm43DtrfAChQ4JACTa8PqPNaxucVU7zdTLq8yCibdD8Qb
	 AaQlFJc8F8KfesSNgfCsnTTOKCWKPCLZ379PuTiEKdzq2ex26zx5iefI2wxWbqYRus
	 0wxIyx+yJu4PhlEjozekhpn5A2CmitI8eLm00s18=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79C3AF80336;
	Fri, 21 Aug 2020 20:54:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D151F80316; Fri, 21 Aug 2020 20:54:12 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD7F1F802E3
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 20:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD7F1F802E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DFRXGiY0"
Received: by mail-qk1-x741.google.com with SMTP id 144so2261713qkl.5
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vbIqlW9tIGTLfzpUAmzhy2jwZSMiaqwnKKLjixkwjZs=;
 b=DFRXGiY0lVwbInp4Hc89l99KSZWL1Y7oOq+tGhWChfBNLIkYEbwUqlZ4BXU/tPedgV
 2wHD/yNKHdEwXsTgi7ljPnNM10evF+j56rGZJcj/UUSkuJW5O3+h+aGGBJHrLS3K+5W8
 YBCE7Uzd/2Ew6IUsRorq91yt/tLUcNL76j0F58g5xFJYCH8cozhBS6rhTI19skAZt3Na
 dGCls7TePTma8gQn7ElUlO92812r9ZQeir4EKlznCEddlp77Il1gz1alD39fjjqYYdZg
 Dz4FG6ya6MYVBuG395UPfgHZtIt0Ea7OqRSz+07GIUIzj7uwWR/CTw2SCTgJbCeEO7by
 tbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vbIqlW9tIGTLfzpUAmzhy2jwZSMiaqwnKKLjixkwjZs=;
 b=pshsc+vESlt37qvE1i24Z9ZwRBngPbPAmhqcYH792Po89SXSFWdZgWsg7K1KdQjLTY
 M1TN+zTRfwrkz9t/vM59neEQYmS+KKnW746lDfBcdFptnD1r3lnaCR3bfnDslLD605N0
 EmV8pIACvmOJht7Sgzr+gGsaakiN18UR0QVdGe0MRrQdOmbRWPMgMAaKP9cjoddGhB8N
 37AXqGTiP/aQPpI1YW4FoG8PTX2VJVdJBclPWdboKtv3aNiu7Vf1KxQt4QKv4/UUzGfN
 FJIN5g7eygtO/tuGqDklMrMNPgvylPjIzFfCuocEi0bdkD9ccrZl1eUWlyD1uXQhvifp
 Oe+A==
X-Gm-Message-State: AOAM533hzs5psWlOMUtqlYW1MLHSy+7IsjQ+3MPrGMADPvGvH86hS0vp
 No/hLVUsGZh6sQWFg2NTW94=
X-Google-Smtp-Source: ABdhPJyG++7Ob77MchmieGa7tWfqpRRJpEIGbAVu1UOAkvGBzvAcBL4dHOxqx5zI33G9zpwWabyJ/g==
X-Received: by 2002:a05:620a:1523:: with SMTP id
 n3mr3891494qkk.245.1598036041687; 
 Fri, 21 Aug 2020 11:54:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 11:54:01 -0700 (PDT)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 11/20] ALSA: hda/ca0132 - Add SoundBlaster AE-7 pincfg.
Date: Fri, 21 Aug 2020 14:52:28 -0400
Message-Id: <20200821185239.26133-12-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821185239.26133-1-conmanx360@gmail.com>
References: <20200821185239.26133-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, conmanx360@gmail.com,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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

Add AE-7 pincfg, based on the values set within Windows.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 57cb63ea88e6..5aad9d8ee5e4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1238,6 +1238,20 @@ static const struct hda_pintbl r3di_pincfgs[] = {
 	{}
 };
 
+static const struct hda_pintbl ae7_pincfgs[] = {
+	{ 0x0b, 0x01017010 },
+	{ 0x0c, 0x014510f0 },
+	{ 0x0d, 0x414510f0 },
+	{ 0x0e, 0x01c520f0 },
+	{ 0x0f, 0x01017114 },
+	{ 0x10, 0x01017011 },
+	{ 0x11, 0x018170ff },
+	{ 0x12, 0x01a170f0 },
+	{ 0x13, 0x908700f0 },
+	{ 0x18, 0x500000f0 },
+	{}
+};
+
 static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x057b, "Alienware M17x R4", QUIRK_ALIENWARE_M17XR4),
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
@@ -9105,6 +9119,10 @@ static void ca0132_config(struct hda_codec *codec)
 		codec_dbg(codec, "%s: QUIRK_AE5 applied.\n", __func__);
 		snd_hda_apply_pincfgs(codec, ae5_pincfgs);
 		break;
+	case QUIRK_AE7:
+		codec_dbg(codec, "%s: QUIRK_AE7 applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, ae7_pincfgs);
+		break;
 	default:
 		break;
 	}
@@ -9186,6 +9204,7 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->dig_in = 0x09;
 		break;
 	case QUIRK_AE5:
+	case QUIRK_AE7:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
 		spec->out_pins[1] = 0x11; /* Rear headphone out */
-- 
2.20.1

