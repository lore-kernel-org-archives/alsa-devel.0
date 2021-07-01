Return-Path: <SRS0=xdAn=LZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB1C11F64
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jul 2021 09:16:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F0A61480
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jul 2021 09:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F0A61480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD685169C;
	Thu,  1 Jul 2021 11:15:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD685169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625130991;
	bh=10ApzUPZT2iN0jFAY6VgW1BlkffTX5+pDPxLSa8vqdo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEaKHie0OoMlmo87hDuLfbmg4eXFH9Dd9FxOMLW5e11V7ya4oIiXCwJTV9X/noUaR
	 LVseVjIdOPtjF6zwa9FvLIQV11xzuJDJeIVwwlZb1BdwiKxOGDVA8QJj6WvZv0i4Wu
	 7/44dGdXc/WHksd94FwNRMbllyDTUuQCCz5V3JVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52667F804B4;
	Thu,  1 Jul 2021 11:14:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6312F802D2; Thu,  1 Jul 2021 11:14:49 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9005BF8025D
 for <alsa-devel@alsa-project.org>; Thu,  1 Jul 2021 11:14:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9005BF8025D
Received: from mail-pg1-f198.google.com ([209.85.215.198])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <andy.chi@canonical.com>) id 1lysmQ-00075P-SO
 for alsa-devel@alsa-project.org; Thu, 01 Jul 2021 09:14:43 +0000
Received: by mail-pg1-f198.google.com with SMTP id
 1-20020a6317410000b0290228062f22a0so3699105pgx.22
 for <alsa-devel@alsa-project.org>; Thu, 01 Jul 2021 02:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9/fqvpbjKgQMRg7iZrW6B8O8Uu9VdWOniL08X6W/aU=;
 b=iVGfnelAnPUAnU+8sT04Ni/xNSi4zZLEhqpPKHYo1L3+e01ERu9DE/eJ8vm2ROfFh9
 7pL3riUUZ0ovkDsxe017SYLMtgatrSDPWInOQbcbOTuCmB7uXR6yzmsTqbduZIU8VAP7
 HmvukqGTl5GteOja8u5PcuagmSD7bSPEYiOdxnOCyZuI15f9J4fTwk/zcWIaL2+aQmNq
 YVm8wmCdmA1bDLh/gSHzRwAVRwCUEvfsoRzLT00g5+le/fyXKeHaOYOocMBpDXd9L63p
 al+VoUU8BO7MI9ZrwYzPzXh8aV6Slzlk3OIej87H/deiUerVeEA1XI0oNO8xiz9s7GUo
 Rhcg==
X-Gm-Message-State: AOAM530aPWjglE9IyUGQ7Ta0t+X0XCk1vx7jd7VBizaW1sFWq1GUgsqZ
 npxH+A26vpwiSJFvLRaKdUw+ENeR9JCsya07S5oLlCXcFlrJZXqwNDtPr34qfyy/d9DV24cR9mm
 gNP/xB2jHbyavoXMM6i/XaVrLFd/lXrrCb7DJVYac
X-Received: by 2002:a62:6447:0:b029:30d:4bba:8b5a with SMTP id
 y68-20020a6264470000b029030d4bba8b5amr17894357pfb.71.1625130881480; 
 Thu, 01 Jul 2021 02:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJasFPj16Ov0bOfkITpp0DDnYHeL11ZbT+TguiSAiGd55GdvBTgzRgX2sTPujm8vg8dEQ4tA==
X-Received: by 2002:a62:6447:0:b029:30d:4bba:8b5a with SMTP id
 y68-20020a6264470000b029030d4bba8b5amr17894332pfb.71.1625130881287; 
 Thu, 01 Jul 2021 02:14:41 -0700 (PDT)
Received: from localhost.localdomain (61-220-137-37.HINET-IP.hinet.net.
 [61.220.137.37])
 by smtp.gmail.com with ESMTPSA id c14sm18133190pfj.205.2021.07.01.02.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jul 2021 02:14:40 -0700 (PDT)
From: Andy Chi <andy.chi@canonical.com>
To: 
Subject: [PATCH v2 2/3] ALSA: hda/realtek: fix mute/micmute LEDs for HP
 ProBook 445 G8
Date: Thu,  1 Jul 2021 17:14:14 +0800
Message-Id: <20210701091417.9696-2-andy.chi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701091417.9696-1-andy.chi@canonical.com>
References: <20210701091417.9696-1-andy.chi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Chiu <chris.chiu@canonical.com>, Jian-Hong Pan <jhp@endlessos.org>,
 Kailang Yang <kailang@realtek.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Jeremy Szu <jeremy.szu@canonical.com>,
 open list <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Werner Sembach <wse@tuxedocomputers.com>,
 Hui Wang <hui.wang@canonical.com>, andy.chi@canonical.com,
 Sami Loone <sami@loone.fi>
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

The HP ProBook 445 G8 using ALC236 codec.
COEF index 0x34 bit 5 is used to control the playback mute LED, but the
microphone mute LED is controlled using pin VREF instead of a COEF index.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6c423172a1f4..949c8e5ac54a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8372,6 +8372,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8862, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8863, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.25.1

