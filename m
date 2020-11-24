Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC44AC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 09:22:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5566E2073C
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 09:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BYTBAQYD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="RfMftqQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5566E2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=endlessos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9BED1670;
	Tue, 24 Nov 2020 10:21:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9BED1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606209722;
	bh=zk8yi6611uzbRMSZNDF/DHr1UUR19UijnvkB+0ibfG4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BYTBAQYDnwlij9RLFh3QYr1CeCvfCi5zRGBmx32MIiA64zUQTPrZXZRANUb7CNlS1
	 IuiEcExggete233AxCUV1Saw1XHK8J+3rMAwUi+MH3L+nImSc0q6fuWxslRnxoK0n/
	 cBtcE1ChcZN3zAaGkhl57Cm79TBwNm9usOejxpZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CD39F80161;
	Tue, 24 Nov 2020 10:21:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E2FAF80165; Tue, 24 Nov 2020 10:21:10 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EEACF8015A
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 10:21:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EEACF8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org
 header.b="RfMftqQO"
Received: by mail-pf1-x442.google.com with SMTP id b6so7452981pfp.7
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 01:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessos.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MSd8fQ2Z7XOPGPcHecwDpB20TgWxQRqNoHhLdX8IkDc=;
 b=RfMftqQOg85uPUKLl6YdeCX0mc3SF9t2JFSQ1rldu4uEdWfAXlzm41oxlWsU2wasxa
 9yT3w5ywWsqAcJ8+ghNFxDVUpTU6C14FOD7TPPNZ74gy0F9hQfgaW5GtMqEosO98gYnm
 Vq1pWRHCpEDThA5OxNUv6oeX6UurJW2gqQo6L6QRX8di5MSKFaTDasm9oU77xaafZST+
 Mx+C7cb/nPGmx8GaU6gEnn7DX1GV7aoIXyhKEDS5nOom6hDswCOrEJXLKL0VjLE6+unm
 gYe2oq9go5lPoyq1kwl0xDidIns1rvqdHqFrEhBwFRhmFVs7LGmHNVoLEaoQlU5cK8DM
 ljpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MSd8fQ2Z7XOPGPcHecwDpB20TgWxQRqNoHhLdX8IkDc=;
 b=iFlv4p63ev6qYwpq/1x3VErJu6Y84Z+GhooabqMSbixcNM/O6VDynXWOXXFeC9j/W1
 sJWNwr1uGNiuW8vufMFHn8XD9LBsxISAljDUv6cyBCsTEKIt9uVr8X6PwzUqpc2DRhfZ
 FoTPFMWJR6UoXJ6Wk0JabQaQ00iISCwnDrnXh8OtiiXEeuU8H8FgE+pqRU3kpuz6XgNy
 unQxpmGXUCkqcCPSvSZXspXr3blTUpOmdA0N7U/hajaIpikMtB5+y+7ARbWXu0VmEqkv
 VYgKxe+BsZ3JjLDGl6pppOkunbGwb5nMCSJL5whojoOlMwt3td3LYcirqN3vugG2cb8Y
 OuCw==
X-Gm-Message-State: AOAM531EDNji/iyO6sB951c1AFyWPM8sy3JD2fmmk9V5FjRr1j6Bjtbh
 wjA+YkM/tHmg7g/Ltmq6Q/8p3g==
X-Google-Smtp-Source: ABdhPJyfwkxJ8xWTVoSEl+yofIYURTHESQSLyF3ib8fdGmtTbBkmesBixh3nX12Eqvq22JXS3MALvw==
X-Received: by 2002:a63:1959:: with SMTP id 25mr2937986pgz.201.1606209658665; 
 Tue, 24 Nov 2020 01:20:58 -0800 (PST)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.googlemail.com with ESMTPSA id w9sm2417709pjq.0.2020.11.24.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 01:20:58 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headset of ASUS UX482EG & B9400CEA
 with ALC294
Date: Tue, 24 Nov 2020 17:20:25 +0800
Message-Id: <20201124092024.179540-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>,
 linux-kernel@vger.kernel.org, Jian-Hong Pan <jhp@endlessos.org>,
 linux@endlessos.org
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

Some laptops like ASUS UX482EG & B9400CEA's headset audio does not work
until the quirk ALC294_FIXUP_ASUS_HPE is applied.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 739dbaf54517..1aafc55f1505 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8585,6 +8585,9 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_HPE,
+		{0x17, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_MIC,
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
-- 
2.29.2

