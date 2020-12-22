Return-Path: <SRS0=1LS8=F2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABD1C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Dec 2020 15:06:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884E22312E
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Dec 2020 15:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884E22312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=endlessos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0560171A;
	Tue, 22 Dec 2020 16:05:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0560171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608649566;
	bh=y9mV0pXPAqy4grD23Wznh5cVN3raTqtO+ixMA2XSFl8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rSm5VHYfXc6UDCFbSctEXz1q0y6g7Xe3GUEm13Jct5QVhUMi7lA0ALnsAYU8t7FP1
	 hOcLaKO3JEigy2jYG7BMaR8VGSkLNS9+wDhAnS6j4dT4Bjp3sfoPVK4fn5r5NPqXAX
	 dEvjaRQ8FnpDX5YrT28J0CF5hoOxJaYS2Eisd0rc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4688EF80224;
	Tue, 22 Dec 2020 16:05:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16CC6F80232; Tue, 22 Dec 2020 16:05:15 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B53B7F80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2020 16:05:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B53B7F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org
 header.b="HkRAe48k"
Received: by mail-pf1-x435.google.com with SMTP id v2so8619085pfm.9
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2020 07:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessos.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+mDMj1VhS1g9ZAydEXjYxo+LFu7baJkisWPTmeHryq4=;
 b=HkRAe48kmhhdtqn526nFfNaVz5YDjvAHem15pAA1tH2xPajKeNawB4hMOddDcGBvRs
 n9Ahdraj8di2Bw+ju2Qhj+uFiFf02l853SnlzIqJSIrXe7hrNcubbWXOvY62xmgyp4/a
 aVB4C/sPqQC9Iy3WiI/60pUJFq3PI96QMes5e3euokL0gJ90o9OkzhEqt/+XCpwvBm+G
 Axji+O5gqnBF7RRy6ZNlM0mAUKN/avuS/ijjROTjesFj8xoKdTjVWtUPqh2VhHOcPQqk
 nvFRLv+USeuK9J7XeYi8JAzGwGmj6TvN/Bg4uwvLZXAVSlQlRR5cKxEVeLw6Bt6sxi2e
 2cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+mDMj1VhS1g9ZAydEXjYxo+LFu7baJkisWPTmeHryq4=;
 b=icTQ4gxcNg+N54oNqms1bT6aDD9vZaMCjwWBf+tt13uGUto/sewM3tprOe6FZrE53w
 sbbUGHog8cJHDEnM4shCVzlRs7Xg1aHEwnOfxglpdTEUfrTxTprBgbbetqnYNTWNpDDf
 cgt5vcHprD0rm7biJ5vjUC4YyD81EQbf9RlwD0+PUnMGoRFxjTranNivdYk0RBo1PIFE
 r4VwxEp+sTvQzl6iE6+j8DhLz44kn2BKqW3vdwh8TvFiN7UzBgaFMlYTZLSD9q1tnGPj
 AdHp2ryHemzTvPtaqSh19/MrqRu0jqZExtJuA8xeuO3Mgv+D9gaETlEGF8mDXLW7WLWT
 pqPQ==
X-Gm-Message-State: AOAM532qMfeoKFvfiX0zhaB/dJ4BFkx0HbcnkmAKXH1BwgomuyxGFZGV
 PEmgUk3kUWkK3cyGWz8zsfx/0A==
X-Google-Smtp-Source: ABdhPJxFVIxjenBWQ4dL+giI/9f1UeSo9v0t064Em0SPBDUGBx4YI6ZLA3x6/jbmTJB3ErbMoty2mQ==
X-Received: by 2002:a63:470b:: with SMTP id u11mr20100411pga.436.1608649506157; 
 Tue, 22 Dec 2020 07:05:06 -0800 (PST)
Received: from localhost.localdomain
 (2001-b011-3814-dae9-4a2f-9772-47bc-5b94.dynamic-ip6.hinet.net.
 [2001:b011:3814:dae9:4a2f:9772:47bc:5b94])
 by smtp.googlemail.com with ESMTPSA id
 u14sm19000202pfk.111.2020.12.22.07.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 07:05:05 -0800 (PST)
From: Chris Chiu <chiu@endlessos.org>
To: tiwai@suse.com,
	kailang@realtek.com
Subject: [PATCH 1/2] ALSA: hda/realtek: Apply jack fixup for Quanta NL3
Date: Tue, 22 Dec 2020 23:04:58 +0800
Message-Id: <20201222150459.9545-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Chris Chiu <chiu@endlessos.org>,
 linux-kernel@vger.kernel.org, linux@endlessos.org
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

The Quanta NL3 laptop has both a headphone output jack and a headset
jack, on the right edge of the chassis.

The pin information suggests that both of these are at the Front.
The PulseAudio is confused to differentiate them so one of the jack
can neither get the jack sense working nor the audio output.

The ALC269_FIXUP_LIFEBOOK chained with ALC269_FIXUP_QUANTA_MUTE can
help to differentiate 2 jacks and get the 'Auto-Mute Mode' working
correctly.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8616c5624870..bb1010d78717 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8013,6 +8013,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x152d, 0x1082, "Quanta NL3", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1558, 0x1323, "Clevo N130ZU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1325, "System76 Darter Pro (darp5)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1401, "Clevo L140[CZ]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.20.1

