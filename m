Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53CC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 01:07:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870BB60F02
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 01:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 870BB60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25176165E;
	Mon, 25 Oct 2021 03:06:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25176165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635124046;
	bh=54wx2mKZjm18u9CDjBKPqRNDzu1urtI6b5dIu7LQsyY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QjkbbJrTSf8yctG8NwojiuVuGF+GxVr8RExZuoU9Ei2FmaddH2wtVwUgKKKnjG2UB
	 0A1xHsJVM6UTMqL9RU4SuA6p4PgmU0D7oZW40gq1dHigqz8nK1cS9LQLyzLQXnQCy7
	 1WSj9o44CwtQyl3G9+/dmqOc2NezaH+7CdSO40Ek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87714F80269;
	Mon, 25 Oct 2021 03:06:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B729FF802C8; Mon, 25 Oct 2021 03:06:33 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A98DF8013D
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 03:06:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A98DF8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DAYeIL98"
Received: by mail-qv1-xf2d.google.com with SMTP id v10so6217265qvb.10
 for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2021 18:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pUgFMuFWMqRkPlVa3Bg3L3JdMeXkE1iDKFTnUjQ3Sz0=;
 b=DAYeIL98GmFt5w1sG/kbhRK/o+yMnFp307KdZpZ35rFhYjdlYSnWi4YX8btq9/iUQJ
 zqoqL1zXnKhcctXDQpScuBpWYddJhbF1FQFIu6O1aOryCw9dhBnysh4t9wcdieP/ZxEl
 3c9wjVaLqwJvjeUqI8HN6dPfa8BgbIccwvbPAXiKvmv1GYXod0+KTLQKsg+gk2cbEfL2
 ivDDDV/BNgIQ5kT+LFhBWvuRC6kdUD/T6zq9arQ4Edir8Hi2XzwDV0NAjvMKDgZ3JhEy
 1FCCAJiTMtHR+5DQFJByX4TlfULgewad0wixB4sMSPkLoeDMn16Bkw8Skj51Kc7fsRt7
 Y8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=pUgFMuFWMqRkPlVa3Bg3L3JdMeXkE1iDKFTnUjQ3Sz0=;
 b=REwF5P0d35rX6kVrHuRkanr0gl8fye1fwsNd+gmX76hBBUHLZ9ksBA+sEzUe8CdPHf
 qzi8Bn2Ch8Cfa18mUDxD7HrVf4xsB36ZVQyyyTmNtkBWwy3CgTBKe4JM3Z+1zS33PFqz
 UKQhPnJgC4a1oYsuQWyLQroGP3NOoHQYoOykbJRzc2MK8S4YMU5C7rYvzxWKci7Wmnya
 gCWcKf3+A2hHv+kSKmosSWQeueicoO6Ij8Pb25oMFW0myQ+LVYq8Lj9ol6O922x6yfoi
 WPJaeWezABbk5UM2RZYL4oZQjgePDe9yaA7Oo4d73YTxpjfaeyPYWenJXrIpmug91DFX
 zK+Q==
X-Gm-Message-State: AOAM530JR8fs6S1qHbmgJl0l/snv0mR1lDbViT2TKkB72sm+L/HDNh3g
 VCsGu2C0nV1oIilVzCtdWa0=
X-Google-Smtp-Source: ABdhPJxnekBfNlKAQb4vwX0YsEcIUCoHwtP2LefYDFVm5wOt86f//qHwU2lw4nZR2VEPKC29FCl08Q==
X-Received: by 2002:a0c:fe8c:: with SMTP id d12mr8201265qvs.19.1635123982259; 
 Sun, 24 Oct 2021 18:06:22 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:1bd1:606f:798c:522:4ec4:cb93])
 by smtp.gmail.com with ESMTPSA id q22sm7906035qkj.64.2021.10.24.18.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 18:06:21 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
 cezary.rojewski@intel.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fix unmet dependency on GPIOLIB for SND_SOC_MAX98357A
Date: Sun, 24 Oct 2021 21:06:15 -0400
Message-Id: <20211025010615.10070-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

When SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is selected,
and GPIOLIB is not selected, Kbuild gives the
following warnings:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_DA7219_MAX98357A_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y]

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_DA7219_MAX98357A_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y]

WARNING: unmet direct dependencies detected for SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && SND_SOC_INTEL_KBL [=y] && I2C [=y] && ACPI [=y] && (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])

This is because SND_SOC_DMIC and SND_SOC_MAX98357A are
selected by SND_SOC_INTEL_DA7219_MAX98357A_GENERIC, which
is also selected by SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH.
However, the selectors do not depend on or select GPIOLIB,
despite SND_SOC_DMIC and SND_SOC_MAX98357A depending on GPIOLIB.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 61b71d6c44cf..87db6a80876a 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -371,7 +371,7 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
 	tristate "KBL with DA7219 and MAX98357A in I2S Mode"
-	depends on I2C && ACPI
+	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
 	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 	help
-- 
2.30.2

