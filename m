Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B46BC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jan 2022 08:37:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6C4E1699;
	Mon, 31 Jan 2022 09:36:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6C4E1699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643618220;
	bh=Ht8Gk5qdgVjWNJMmLNcN9hgxQlm+cwTrT9phHMRfMG0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n3YtwXYryQW/yMIetBCv9f1hAKzDWR+260/FBZSkseTr9EbIWgO2KotxNAPNPN0Vy
	 krm79AcACjgaRm2lWJLGN3ecrniV6mDFsYDikPDGwJIzpAs6VBSjVgK7KHOu5QrLeP
	 EZ3F+F4Yp9MBKZqpS8pYGDNMyV8pT0jw1uj8DxSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B149BF80302;
	Mon, 31 Jan 2022 09:35:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08FB4F8016B; Mon, 31 Jan 2022 02:06:17 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 971DAF800CE
 for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2022 02:06:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 971DAF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CSySMKgc"
Received: by mail-ej1-x633.google.com with SMTP id o12so37444720eju.13
 for <alsa-devel@alsa-project.org>; Sun, 30 Jan 2022 17:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vxCizGjPP8oXWBLfTZQwIA3YFQNWiqW6fSdu870FudY=;
 b=CSySMKgcNc2+T1xpCfJIPCDJ4KhpgmCZ1hWmTBHTQYhVvuJgw16Jat3Kf6dH3m/34w
 86H2+iryrZOB+GTP4XIfoS+145OL48L9egxcSRAyJwI+QNw5+iNvoYeBc4pkPNbOgPze
 i8u/kBM0wFKNmzjtgI9Hq3d1msjvzyenfU1utXXOcRo2/DzqZ59DZsIlSJyUzzmXaQUR
 o9lECrRSIywcSDyXDOXQcb2GhAfJsIRnTX8d9NBL3ofsnzTmJAKpJpWpLj+8P9nsOlrS
 XwTMcyUDwE/TXeUd9tBOR3NimuMNZ5ko6p4UwE/8vx9zLd7q+8EGGZnZY/l4am2POhqO
 4Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vxCizGjPP8oXWBLfTZQwIA3YFQNWiqW6fSdu870FudY=;
 b=g3J//b8eWx7Kv+bNcGZEDcgHyx0CgJjK3M9+hNsXDmLhKUJil7pSpAt/v70A+Ct6eA
 HURyVLZM7rKcPa5cb4Ppv5CexKMIpypLLW7SMjFeqGAhwLkGwlIwk0sSaOjk+kofdjPj
 RKBDeE6pTvp+oG86gAr43c8JvoCRjGSyWpp1KJ92Q8w1MYkSYWLfM8pV94ISnbBnD3wS
 O8CmCf01Aw/ST1GqZWmVlNDK+Zta1u/CQSyHDvDhRLoyRLIv6RqaAiWe7Ab2sUktCHIk
 vr6PZNyeKF5a+jyRIp/l1plSCtM4x+lw5c39LDkJprqmoVb9u80GsWOt7p3nyWF+lJYh
 +Raw==
X-Gm-Message-State: AOAM5314HbcfrdKXs8TeZhBSgkT/8JtFoBXL7XTVuMr4a3l7twvEnG1a
 AVXdeQVIIp6gK3hLu0qsmNmp0OEeyYDwCYYr
X-Google-Smtp-Source: ABdhPJzZ3O91ltE6Zbn0LtMwEL8EwSPbVn4ejvlUkMt0nskHkpvbJXrfAPS8gD4qjHOndB4tpVF9GA==
X-Received: by 2002:a17:907:2d2a:: with SMTP id
 gs42mr15239498ejc.106.1643591172753; 
 Sun, 30 Jan 2022 17:06:12 -0800 (PST)
Received: from localhost.localdomain ([188.27.63.13])
 by smtp.gmail.com with ESMTPSA id d16sm12549276ejy.135.2022.01.30.17.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jan 2022 17:06:12 -0800 (PST)
From: Albert Geanta <albertgeanta@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS GU603
Date: Mon, 31 Jan 2022 03:05:23 +0200
Message-Id: <20220131010523.546386-1-albertgeanta@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Jan 2022 09:35:34 +0100
Cc: stable@vger.kernel.org, Albert Geanta <albertgeanta@gmail.com>
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

The ASUS GU603 (Zephyrus M16 - SSID 1043:16b2) requires a quirk similar to
other ASUS devices for correctly routing the 4 integrated speakers. This
fixes it by adding a corresponding quirk entry, which connects the bass
speakers to the proper DAC.

Signed-off-by: Albert Geantă <albertgeanta@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 668274e52674..61b314c7dbc9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8969,6 +8969,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
-- 
2.35.1

