Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4450C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 00:34:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3B122D08
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 00:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3B122D08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFAC118BE;
	Wed, 20 Jan 2021 01:33:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFAC118BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611102838;
	bh=jzWu79fuBUcHU3BojTRMlMRo9rha/HcvD4TCy2UryP4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OpAGEGuYoVSy0AQEcvZC7x3KJF/rSdwnl0JUJTMqJfP1/trO+cJorTkz3OgJe2rWi
	 r/s3KT/MyK8f3UruZhbP9HqeSErAcCKHywPuQRJDecIFOnJf1IGFePsSRQwJegP0rl
	 hH50KYZQQOmVWaPlcPXx5QBjRTAD1OhFBY2iSWmA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A37DF8026A;
	Wed, 20 Jan 2021 01:32:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C195F8029B; Wed, 20 Jan 2021 01:32:12 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E27CCF80137
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 01:32:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E27CCF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UfwaWr1L"
Received: by mail-lf1-x12d.google.com with SMTP id h7so2502943lfc.6
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 16:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yicVcioy3NHi4/FpPSm/VNwWX+j3sMZfurtCccDfD1k=;
 b=UfwaWr1L5LewNfH5tPGaIPEpfDELXTNCv4RkE8uU1iidYd+RoXeDimeuJlRFEENNKQ
 F6sWmllixCA5G2TJgxrArNLfFblitYuiSi0YjLokri6ZDLWdE0zis1dJLbBlObtut/At
 AqqW/PB9g8B0ntIbN/ISB7OC0rQ+Y9cxrZoAL2FNQy4eQESHNdXE2fZV9oKzy+zfAW4s
 lCWAO8YKLwEzqBDOrFfGkGxLmd/7YFiFxNHN/MkZc2fcGgCy+6eqMyR3qhj4CYvtxEle
 1i3UIRktAl/uONze7wceTxDhxhOFMteIio0XsI8i06F2xlHgkfxau3scSk6EymrApnjP
 p0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yicVcioy3NHi4/FpPSm/VNwWX+j3sMZfurtCccDfD1k=;
 b=GhlRG85Ci9/grNvBImhNSPjoBIFzz4QpEWoAtjq3f1pLojo5GLq0L6gqP/hMxLqJlL
 Crm3z80Yw4WoOz2WM26eLo+Uu8P+QePZchUSK/m17l6+6qQJrwkC6cRBdcfjFUQw9ZDD
 Kmic+VfhcKDk362EealeHvmg/mkD9Yr6RO3gaHD7kFuC33eKW6f3/Rnbx+Owl45xjFLK
 6MCJuVc/JLNL5QS/cuotqtj9FSU7ICL8Fd1GgLekjP9HiMI39yIS0/fBMjc14fQ+Y0TM
 bIuPfqUdDJz6Pl1M7DVwcT5wTpC8KnlAFT/Abm6yaUZa9C9NgISpLITuRkZEoqqMiBUk
 eGcg==
X-Gm-Message-State: AOAM530EdhbWw7aZ7f7wAZi2zn1XGX7/vYBzKmyqNqTywh4y9GcSHYqM
 Mp2z5naggPNDhcF/5hzrjY8=
X-Google-Smtp-Source: ABdhPJxmTKVzbvYAflmcu14BOAbwwAuIv8vrnA2qcbWISAZZGdAxl4L/T1qztTNKxALT+c+i6M21cA==
X-Received: by 2002:a19:7109:: with SMTP id m9mr2833504lfc.351.1611102724843; 
 Tue, 19 Jan 2021 16:32:04 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.gmail.com with ESMTPSA id s27sm17710ljd.25.2021.01.19.16.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 16:32:04 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 Peter Geis <pgwipeout@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Matt Merhar <mattmerhar@protonmail.com>,
 Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v3 2/6] ALSA: hda/tegra: Reset hardware
Date: Wed, 20 Jan 2021 03:31:50 +0300
Message-Id: <20210120003154.26749-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120003154.26749-1-digetx@gmail.com>
References: <20210120003154.26749-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
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

Reset hardware on RPM-resume in order to bring it into a predictable
state.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30 audio works
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30 boot-tested
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # TK1 boot-tested
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/pci/hda/hda_tegra.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index a25bf7083c28..04dcd4cdfd9e 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -17,6 +17,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/string.h>
@@ -70,6 +71,7 @@
 struct hda_tegra {
 	struct azx chip;
 	struct device *dev;
+	struct reset_control *reset;
 	struct clk_bulk_data clocks[3];
 	unsigned int nclocks;
 	void __iomem *regs;
@@ -167,6 +169,12 @@ static int __maybe_unused hda_tegra_runtime_resume(struct device *dev)
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 	int rc;
 
+	if (!chip->running) {
+		rc = reset_control_assert(hda->reset);
+		if (rc)
+			return rc;
+	}
+
 	rc = clk_bulk_prepare_enable(hda->nclocks, hda->clocks);
 	if (rc != 0)
 		return rc;
@@ -176,6 +184,12 @@ static int __maybe_unused hda_tegra_runtime_resume(struct device *dev)
 		/* disable controller wake up event*/
 		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
 			   ~STATESTS_INT_MASK);
+	} else {
+		usleep_range(10, 100);
+
+		rc = reset_control_deassert(hda->reset);
+		if (rc)
+			return rc;
 	}
 
 	return 0;
@@ -441,6 +455,12 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	hda->reset = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR(hda->reset)) {
+		err = PTR_ERR(hda->reset);
+		goto out_free;
+	}
+
 	hda->clocks[hda->nclocks++].id = "hda";
 	hda->clocks[hda->nclocks++].id = "hda2hdmi";
 	hda->clocks[hda->nclocks++].id = "hda2codec_2x";
-- 
2.29.2

