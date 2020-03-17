Return-Path: <SRS0=KQif=5C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E174CC10F29
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:31:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA5520663
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t1goYdsZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="uOPgc3UD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA5520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A840A186C;
	Tue, 17 Mar 2020 09:30:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A840A186C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584433901;
	bh=KcTevrJBrB/JkwuPVuCvpnN6FpA2j3dSITSH/OAKlFw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1goYdsZ19UIhr/Ya0Sz8fR5lVd/eaEirEqqyHN7nJBOFIe0B+if+KxCArmov3MMU
	 LfUawJqd7gAXc3KHLlzaky9d3LNlrmC8fWoh+U9Kf3oJRx79mK3NtbMF2U5gL90VHw
	 a2r+B/uAF77PSxgKjDpcDaRvAR5QrIrNFo2GzYQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FFDFF800C0;
	Tue, 17 Mar 2020 09:30:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87C89F80256; Tue, 17 Mar 2020 09:30:39 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7C14F800C0
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2020 09:30:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7C14F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com
 header.i=@endlessm-com.20150623.gappssmtp.com header.b="uOPgc3UD"
Received: by mail-pj1-x1041.google.com with SMTP id nu11so6927814pjb.1
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2020 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vWKGYsWLR1STHAG1GKHscN8Y99AToSvTAe2k4bSTdaM=;
 b=uOPgc3UDOEq50RlmiXosUbNRevpArFt4gocrkZOsZbw1F9SqgsoQWExkZ1v3bEvtnD
 lz7cHVpyyV9a7y6BJJ4oY4tIyPVdIlmUmHUAIjf+grInerwi7M9EEyx1y/0ZcJS5OO6L
 GNdnR+PHcvO+0wU7vEpiWrIGFxKF+wQl7H2V289TxRv1dtL1esuiEf7dEVtoeHr61HwJ
 YQrJvMYIMgM/89801c8Tk3HuW6JZv5t7nQVtPwIpQej3NlwBbh0P5tY6/JGZhtIRqKdW
 ixUez/uUt8rVrFxnnz95bOjIJ7cMsYQNwA8nvsY9wh/dA9TP65rcHCEXaJbJUhL3d7Sv
 9EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vWKGYsWLR1STHAG1GKHscN8Y99AToSvTAe2k4bSTdaM=;
 b=LT7dhQQwLzOYkMHMV96fqQZ/IEcGLxfiBe/NvEl0QqlQ+wY9lrOsQzNgvyvoxCEyDc
 Lh4PIVak8eLGvgnzXf47kt6vw31M6LEGOPk0+cNU+As1MWdgdgJELNIW8bvBNMsk6oFy
 IjgThteSY5kcro1MqQrEauIhr4Pf0oaIMMqnQUtLziUT4oJIQf9JSfQHkUH34ibgh4c+
 VqAwmTqaBgPPLsxFBhahlF69/u6AqqH3E37tLwmAz5IgXgQcgYfXTl6NCx3Zgpv71QZM
 Zg+Xo5dxbHvzvj0MTP1hDy4TTm7U3KfWfxIFEdEXnz1wxn3WGjtLGI790126YuRd6x34
 DZ8Q==
X-Gm-Message-State: ANhLgQ07E6btaH5B32zPbpdQZAslTJJxuwRUNSUoI58V9gCKf4Md9dve
 S+PZuqEm7OhIMh7G5mbEC3Hy2g==
X-Google-Smtp-Source: ADFU+vsFCy4Hl8cA7bTKABqclIVa6ikykCl2RTiTBe19VlK4hbeZjmH/loNpce/kyvIRBQObMNokgQ==
X-Received: by 2002:a17:90a:d997:: with SMTP id
 d23mr3896918pjv.187.1584433834564; 
 Tue, 17 Mar 2020 01:30:34 -0700 (PDT)
Received: from starnight.local ([150.116.255.181])
 by smtp.googlemail.com with ESMTPSA id m68sm21095679pjb.0.2020.03.17.01.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 01:30:34 -0700 (PDT)
From: Jian-Hong Pan <jian-hong@endlessm.com>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/2] ALSA: hda/realtek - Enable the headset of Acer N50-600
 with ALC662
Date: Tue, 17 Mar 2020 16:28:09 +0800
Message-Id: <20200317082806.73194-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317082806.73194-1-jian-hong@endlessm.com>
References: <20200317082806.73194-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, alsa-devel@alsa-project.org,
 Kailang Yang <kailang@realtek.com>, linux@endlessm.com,
 linux-kernel@vger.kernel.org
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

A headset on the desktop like Acer N50-600 does not work, until quirk
ALC662_FIXUP_ACER_NITRO_HEADSET_MODE is applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bb29c25f4567..0fa79eaa0b0b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8611,6 +8611,7 @@ enum {
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET,
 	ALC671_FIXUP_HP_HEADSET_MIC2,
 	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
+	ALC662_FIXUP_ACER_NITRO_HEADSET_MODE,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -8965,6 +8966,16 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC662_FIXUP_USI_FUNC
 	},
+	[ALC662_FIXUP_ACER_NITRO_HEADSET_MODE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x01a11140 }, /* use as headset mic, without its own jack detect */
+			{ 0x1b, 0x0221144f },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC662_FIXUP_USI_FUNC
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -8976,6 +8987,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0349, "eMachines eM250", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x034a, "Gateway LT27", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x123c, "Acer Nitro N50-600", ALC662_FIXUP_ACER_NITRO_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1025, 0x124e, "Acer 2660G", ALC662_FIXUP_ACER_X2660G_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-- 
2.25.1

