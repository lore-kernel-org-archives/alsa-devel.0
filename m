Return-Path: <SRS0=5JY3=NG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F9DC4338F
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 07:32:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A314A60F4B
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 07:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A314A60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E94B172C;
	Sun, 15 Aug 2021 09:31:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E94B172C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629012737;
	bh=jPxPlaADefBc3A3kABeJNGZPnSzJ0uX47+GP1s7QCqU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c3a6iJ4SeE1Y/zUT5jlLlY61CHLrxkJlfnXHzlY0Cx+sRd/1LNb3sciR5AGyD7z0N
	 YMuUiKjTuvBgICZFG+kEUsaj88rN4zf4ytOhCDqZJrZcAen4U/NODSZOKxutzaZ1Fv
	 2xD6NChPoHoFnrCZeExcIrBPS6uDE+2c3Vm3+x6g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 477C5F804DA;
	Sun, 15 Aug 2021 09:30:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80630F8025D; Sat, 14 Aug 2021 22:12:39 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1199F80245
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 22:12:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1199F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kmjgE7HU"
Received: by mail-pj1-x1032.google.com with SMTP id
 qe12-20020a17090b4f8c00b00179321cbae7so10494376pjb.2
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hsd/ckMYl0h9h4jIiEx92sH2iR7qjMVLa0hXRt73XIQ=;
 b=kmjgE7HU3T7J012XGbvMCrPkrv8tz31/1bn7xqZnje0fVFpSCSwkJfsTbUrMFvOtSV
 2OSh/1bQViMGnQnOORcR193kJ/eZa5J/YnM1HEkAEMya6chOXLYWYx+Au0X4i1oVDMlW
 XFxuYCLTSZ1vL0BXPTDgUTA42Mbf/p40tIk9kxtqm4GjvY2GzWTz6l/Hb0pHM32pfgKW
 Ftty0BCtKttobkgqnfoSKDZnEe1RCLCDWMUvuPWqDq7ueXb8x5l+ZEUOF92mAaFX4cbS
 UlYbKHKoanVm38K9TnHfk7bJxkyljmuJrenE1yqNg2EVYy4VeaK1TbCCe0IFK0yrgnHO
 ftrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hsd/ckMYl0h9h4jIiEx92sH2iR7qjMVLa0hXRt73XIQ=;
 b=eIS4Tc7G53NxgOw8xHDuBieuc6/NuoZufr54f0r+M7RoRlXdtkfPEG7lbc5piuQ3Vn
 dbsH8dFjppMvQ7rYijh97tiwv09tQ0zr90CTmKvlYQ7H7FPYGpz94UqIMT+HVPvqQOx7
 hGDgikeTyQaJMUt/6+ZtfO5t3Vkl1+OOhQ/msvZoZ8G07f7ZbN57lfaIsKOlmzl1G9fK
 T+p40umBCe/h6n+JBAa1MbfgGq3HJ141ubmZ2Ddo/XjXl3Z+nA6orf3up74nBe2xtlZB
 nsjP+7ISNWwpgCjhfmfEUeVdkffek0hkrlLCod1R/GmPYRI0E43tT+1PaeabVt4Tvs7q
 wpbQ==
X-Gm-Message-State: AOAM530LeSkPbUkZORudXcwwfVGYZkuXePfKjBFcFP5YdGW7m4qs3z/v
 HXeYNJHU9qitl/p+/93z1X4=
X-Google-Smtp-Source: ABdhPJz4l8mdY/4NyQt+T0jscuDbRR0RflmAVmg27o5W1IKFkPgFSYkucKQaGdM4avAmmadZiZ8xSw==
X-Received: by 2002:a17:90b:104b:: with SMTP id
 gq11mr8722676pjb.64.1628971949451; 
 Sat, 14 Aug 2021 13:12:29 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
 by smtp.gmail.com with ESMTPSA id u6sm7309420pgr.3.2021.08.14.13.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Aug 2021 13:12:28 -0700 (PDT)
From: Aakash Hemadri <aakashhemadri123@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 0/2] ASoC: tegra: Use of_device_get_match_data
Date: Sun, 15 Aug 2021 01:42:17 +0530
Message-Id: <cover.1628971397.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 15 Aug 2021 09:30:27 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Helgaas <bjorn@helgaas.com>, Thierry Reding <thierry.reding@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-tegra@vger.kernel.org
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

Hi,
	Prefer `of_device_get_match_data` over `of_match_device`. This patch
replaces of_match_device with of_device_get_match_data.

This patch series will apply cleanly on for-next

Aakash Hemadri (2):
  ASoC: tegra30: ahub: Use of_device_get_match_data
  ASoC: tegra30: i2s: Use of_device_get_match_data

 sound/soc/tegra/tegra30_ahub.c | 2 +-
 sound/soc/tegra/tegra30_i2s.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.32.0

