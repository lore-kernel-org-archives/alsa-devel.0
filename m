Return-Path: <SRS0=5Ozn=7Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8FC433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:32:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71DF2072F
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tFo2KA6L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq5kbzaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71DF2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28E651655;
	Wed,  3 Jun 2020 03:32:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28E651655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591147971;
	bh=RC0+ca/7ACIibcFv+OsaXNhY4tPqTPm6IAu+LmdC5vQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tFo2KA6LbUBox7ktNCbljlVHzrmDO7SY3ESmIpcsUpPDtrW3hVRB9/6g2yVn9RYOo
	 R/ddD4SIhv9diTH7/1GWXmkrRI8x3yh5mXpIkfRtNSZbrMjzc9WnXyf2r9cOxqavZc
	 1zMXRCFHZ2wn4ozals/waemwenCBiCe7Dl3xKxzU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9095FF801EC;
	Wed,  3 Jun 2020 03:32:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8B14F801ED; Wed,  3 Jun 2020 03:31:58 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B95B0F800D0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2020 03:31:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B95B0F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Vq5kbzaN"
Received: by mail-qk1-x743.google.com with SMTP id b27so600777qka.4
 for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2020 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VWoHTgnci3l4TWBgdO8mZriM97FyUXlcv2kkMgvZrKw=;
 b=Vq5kbzaN4TSsdf1LrHx++BIrwSNLMoYOEuq4S3pOfYwJvfSJKz9iDIjIWrr6fyyPOc
 z+s/b6gtWhhoDzu6MMqw8W2J2w1N6+qCMXTyw8cwCYouSjWBzFhJ3GfoQ0xKqfjuKhcC
 3K4o8tXn3lZX+utOUCpfTgcAbDuz5pjwv8lz+Ym5UK95T9KqGDIImIzq/3DHZoWubvZr
 uGMuSQEg3RR0In5ekHzlMKZGw9W5o+3sPuLFPErEaYUWRHSlQupSxgd7IWEft3hPJTu2
 HL+HQZKO1veX7MMnk9qJX1QnmylXlIqc/GADcFbqqVi1UnQN/c2WN07/Z5+Tx4HSMwE0
 +rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VWoHTgnci3l4TWBgdO8mZriM97FyUXlcv2kkMgvZrKw=;
 b=FqkthNF66ffF3Eih/CFb2slp0MbC+gcEO5qcJHgbieMe7N4kCxveTknw0TIv1q/CDW
 XBGE5zLAfPALWvWl9sYfmgEpYACb3vELfKdS/QHXTnypfLcAflXO1RpE4WSTQGoK1Ksr
 vxXmkBRE5/HxzNKQZETzI6sJug97XyipDqwI91JC5H/0g0KUU31mI/tQhEo5Y+oKojRv
 G54gFWafR0LbZJj56MYDwiNle+JUqPVtNllpH9IqjulOfoQu2x1EBYaR3nYzRj8qXAML
 bB4BlCgl663QPiC2IOFzinbyCZ/hHE4qEgFiAtUEci5ABCqD54oaXavgClNTs6uHfmzO
 RwQg==
X-Gm-Message-State: AOAM532N7QBTaBQTE+/bGuripVy5DwbEWdpUmsVEn9nxv0fq0GvJvAOR
 Vqku4oCa/aGyWP0XWe3Vcgg=
X-Google-Smtp-Source: ABdhPJzUQk0OtPJhPQJH6otYZAZeAXjwRD4jhXtRHr1sFhBaG4sziuaQUq48JQgBnuO49OAc17KjXA==
X-Received: by 2002:a05:620a:200a:: with SMTP id
 c10mr26764217qka.218.1591147906938; 
 Tue, 02 Jun 2020 18:31:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p6sm610575qtd.91.2020.06.02.18.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:31:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alsa-devel@alsa-project.org
Subject: [PATCH] sound/pci/hda: add sienna_cichlid audio asic id for
 sienna_cichlid up
Date: Tue,  2 Jun 2020 21:31:37 -0400
Message-Id: <20200603013137.1849404-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alex Deucher <alexander.deucher@amd.com>, Hersen Wu <hersenxs.wu@amd.com>
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

From: Hersen Wu <hersenxs.wu@amd.com>

dp/hdmi ati hda is not shown in audio settings

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 92a042e34d3e..4188bc4bd4e2 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2643,6 +2643,9 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	{ PCI_DEVICE(0x1002, 0xab28),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	/* VIA VT8251/VT8237A */
 	{ PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
 	/* VIA GFX VT7122/VX900 */
-- 
2.25.4

