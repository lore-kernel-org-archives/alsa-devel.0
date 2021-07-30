Return-Path: <SRS0=QuHl=MW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A078C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 12:00:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2F360F5C
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jul 2021 12:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C2F360F5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52E02193F;
	Fri, 30 Jul 2021 13:59:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52E02193F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627646432;
	bh=A9bKokYt3UpyxIXrjPL+vNY+Hn2Vd+2RcCeBBzJopJE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tbsdyQ/bk6pxZNwL9DhMu1SOIbtE+8Ub+2iKRWDlWJcJ9deZ5zsyml4vBvdGlxsAR
	 Ecliz6a/20zbCTbJ+ivO7mFvIBf43u0YJsl+P6ePwqRJ00rkf6fPktNxxK9L+rJZK0
	 QZprsxBzAuhCUvLKJhtF0pzVRd7ZxOHef/dP++CA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E606CF80212;
	Fri, 30 Jul 2021 13:59:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACFFDF80253; Fri, 30 Jul 2021 13:59:40 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA8ECF800ED
 for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2021 13:59:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA8ECF800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com
 header.i=@semihalf-com.20150623.gappssmtp.com header.b="nNzA7G+Q"
Received: by mail-lj1-x231.google.com with SMTP id h11so11940494ljo.12
 for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2021 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yz5kF6DMmS/F2Ek3OiwjPMR6AkCQ12zzDtN+t3btcmY=;
 b=nNzA7G+QrYsKDtYPp4WacLy0pohEOxM30ACTb4XbKW3I2FXUAj+/KdwmBEpqXmjgtX
 us0taLYD9bRwfc04SPEVa1FZmAHS3nK2tTlIEbcskWXKB2fNDETxxI17Fkh1bNiCy5NJ
 N5Nu2jjxXzXUc3B5JYuBvCwwA+bYaTcWp2fMtGzfVS93tTPtUilFf7GQG9EtvyImsUVE
 toTUBQeriz6HYnC7LtywE4XQcFkK92FXgIki5Lf1Gw1WqYGinguxOF/Ws1W+fFs2+46s
 ptfWooud7RXcYVe5oly8+zK2FlpbjY5Ghj+YUncF4XboU4DOGB4wPhlh/3o/M/xtavhQ
 TxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yz5kF6DMmS/F2Ek3OiwjPMR6AkCQ12zzDtN+t3btcmY=;
 b=VrGTkIZ1CNiht2i1fDWcdkSRMJTiwWWuHYA0n4ERjap2Vn0PiZxxVj4jhEdPuU5RW5
 e7PK3mUkGZ/i0VvP3QkfsaltGHls1j/oqlAJPqwySRZeuc8x1y8GIbbv/mCyKnQsSkGZ
 mpPaYT6yg+ZelZkdDw/Usn8t+vXjVay7oUvuAeuawiHi8bifyIZxexFu85FZjHlE9Yde
 QMAX3loRhGKo5ZrYQWQHL6Wfb7288jqLw7Tt/CI426JvJhmJpSNcY59QYqGB3AMJ3Erw
 dTJY+WE+HuCmUi9L6+s58nvIV9OkcvffrVvXKqVm5o8e7qUyZgWJEEjH9pLsSYVwgmlf
 vY/g==
X-Gm-Message-State: AOAM531Hdhd1GpF9XXxZnacItiax5zYXAwrIukUGmbegsLGFfugY1Wsf
 0LhXrQngtkgl+Hogb4ihX/aiZg==
X-Google-Smtp-Source: ABdhPJxdLp3s/e9v5mAJRhkjnsGH+Ro2Aomhtvu0FFU8OH3ojilQ7WiMkXMAIcyREE+yS4IO3qKGOg==
X-Received: by 2002:a2e:a817:: with SMTP id l23mr1441919ljq.86.1627646373566; 
 Fri, 30 Jul 2021 04:59:33 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
 by smtp.gmail.com with ESMTPSA id p16sm134034lfr.122.2021.07.30.04.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 04:59:32 -0700 (PDT)
From: Lukasz Majczak <lma@semihalf.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v1] ASoC: Intel: kbl_da7219_max98357a: fix drv_name
Date: Fri, 30 Jul 2021 13:59:06 +0200
Message-Id: <20210730115906.144300-1-lma@semihalf.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: stable@vger.kernel.org, alsa-devel@alsa-project.org, upstream@semihalf.com,
 linux-kernel@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>
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

platform_id for kbl_da7219_max98357a was shrunk for kbl_da7219_mx98357a,
but the drv_name was changed for kbl_da7219_max98373. Tested on a
Pixelbook (Atlas).

Fixes: 94efd726b947 ("ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20 characters")
Cc: <stable@vger.kernel.org> # 5.4+
Reported-by: Cezary Rojewski <cezary.rojewski@intel.com>
Tested-by: Lukasz Majczak <lma@semihalf.com>
Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index ba5ff468c265..8cab91a00b1a 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -87,7 +87,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "kbl_da7219_max98357a",
+		.drv_name = "kbl_da7219_mx98357a",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &kbl_7219_98357_codecs,
@@ -113,7 +113,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "kbl_da7219_mx98373",
+		.drv_name = "kbl_da7219_max98373",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &kbl_7219_98373_codecs,
-- 
2.32.0.554.ge1b32706d8-goog

