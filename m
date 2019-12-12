Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FCC43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:20:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F4321655
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JlY2OCAt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVBfRO8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F4321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7941E16BA;
	Thu, 12 Dec 2019 12:19:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7941E16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576149629;
	bh=C4IFaHCwkDINYBgBX33sucj5BD1ydmkda7sJnJhEV8o=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JlY2OCAtC7UQyXZW7Tc3KTQh5S37ZQ3+1Qy562XF44fUTdMGNoBMMeQp5i2gkTu6h
	 Uez+FdsWnWbC3gu4AV4T/y/2hfdHenrBhAcg3es87pTKdEI8+/LdwfgrZNW3VOZKy+
	 o/WYQEEXyb/3VZeHQCKqd5F5SWOu3hcr+wJJUrf0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E579EF801D8;
	Thu, 12 Dec 2019 12:19:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77A6DF8020C; Thu, 12 Dec 2019 12:19:37 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6764AF80139
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 12:19:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6764AF80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cVBfRO8m"
Received: by mail-wm1-x341.google.com with SMTP id p17so2054955wmi.3
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YvzqdcYxA2Ih2nOFsGjLKz4QF8pvHLdubZ66hDHBrao=;
 b=cVBfRO8mU1WGThZ2ndtOWSZqkIkx1um8Amx/yPLyePvs8UMXsL7fTGyLx0YxVzjh+U
 2nPg1yBkUnuCj/bJ0jzh2DT5Ay6KKumycuUvbkarnP2ScDpOgOdS8EbwJXfVCgEcy5a2
 2RfJVlCmNTNYWfI0L3AN0tYNw2ucbnwZ8MpPFzvyZMoIVrh+oYLSxaThMyGHa8Extldl
 W/Jc+ex4gYM/Xvv1BAMG62Vv6mK4dF3OU7IfXsZxPg2ivD3lNicz2OnoMe0lYSNkZkCi
 rOSkKN8kpxLSCnB0rWzXsxDp25sGZ1lWOVhB6UHnfSF/vOXAl8/BOHER5By9MkWCe4NP
 WUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YvzqdcYxA2Ih2nOFsGjLKz4QF8pvHLdubZ66hDHBrao=;
 b=HPOpmPynh8AaCElq9PdZyfaToMy5MzrDWLR4J3qN3rr9bLTOp8mKJA2BDDPXM1sTrV
 nb1DXjdAQgh4zGtsDzCNRxUgQHYvpW/uUhp+zTCBAYENFT1pJq5KItSTfT3M8w//uF4a
 HewAKtp9nSZai05RxjchXaT0RoeXvuoMBBScdSPeUewZojTG6moO1CsRbhgLnRMJcGym
 6JJGDrXWyOpehWBTHu2qrsFkIPebkZH3n8Ub5cy71OMwADkY1hUN0CFuW44roOg2iUlb
 UDiEepLEgd7sEmBDvbidtYrBQ69+h3m2hoOETz3XqfnhgXWmjCkHjOEK60Jrc1sXa3SO
 b3Sw==
X-Gm-Message-State: APjAAAW0EIcj6VhSoB+tBlhcWoFfYJN8dDzda5diss0mx8UAWVg6bS+Z
 x9cB3PbgbkTZgX4ye4NBz8jgcfSK
X-Google-Smtp-Source: APXvYqy3ADNkXi49Zs+iSOmxIDNi2tv5viAIj0F9iFvK64Elr5OIsXB08Wmm9n783/JaACLFnDVNEg==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr5775813wmi.57.1576149572891; 
 Thu, 12 Dec 2019 03:19:32 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id 2sm5727134wrq.31.2019.12.12.03.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 03:19:32 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Date: Thu, 12 Dec 2019 12:19:30 +0100
Message-Id: <20191212111930.3076101-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jon Hunter <jonathanh@nvidia.com>
Subject: [alsa-devel] [PATCH] ALSA: hda/tegra: Remove unused "bus" variable
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

From: Thierry Reding <treding@nvidia.com>

After commit f36da9406e66 ("ALSA: hda: Support PCM sync_stop"), the
local "bus" variable is no longer used. Remove it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index fc2e0a294bc1..269f242fcbfd 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -166,7 +166,6 @@ static int __maybe_unused hda_tegra_runtime_suspend(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
-	struct hdac_bus *bus = azx_bus(chip);
 
 	if (chip && chip->running) {
 		azx_stop_chip(chip);
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
