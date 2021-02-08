Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05AEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 13:53:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAAA64E54
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 13:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAAA64E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A96A186E;
	Mon,  8 Feb 2021 14:52:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A96A186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612792400;
	bh=L0OVxUJtohLgkB5Wlk83Ro8iE+Ql2VikL9DULOSsZ34=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IxJPzvYSkJeoAAKBhkx1zb5KAT28LuqCXgnYbgLpGTEJ0gIAt3XbS6bi61s4av2sG
	 10GNs7cOdi4zgKf6Y2l/e6vNjblqzSJ0wtfU94tvyOz/Na1FMHhXwoNjZQC1SR5Snl
	 6dZgHgSzuAyRWZDLdUez6Omm40YQOhTt4T/vkBBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8EDEF80114;
	Mon,  8 Feb 2021 14:52:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA5F4F8013A; Mon,  8 Feb 2021 14:52:26 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5B66F8013A
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 14:52:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5B66F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="t80HXBbS"
Received: by mail-wr1-x42f.google.com with SMTP id l12so17258294wry.2
 for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2021 05:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VZVNgaBy9WtB+TiTDDQzLw294M2wGl6oNkLfrcLYn+U=;
 b=t80HXBbS3FExg9kMVN1gaqsa3JSwVXK2vC4CE1rrKREfSvvGrKQLmimOVbwOEOQODf
 Oj9A3gdqo2FqesefGE8/Bt9Oo12qD7VdCUI41sEcrnmkySfGnPUexKOnOUjO6Dc4nhU0
 26UDVl2b4XPZeHGzneLHX7r1Z68n/VTbRG6F4REpyFcmSMp5zZQs1+DAEOexQ9HLYk/J
 smQJZwb9YWzAhn8gvqmIs2Z9BDejcNdx/NxYQT8UmDQmai/VT54ZG0JWFAekXKB6WRkD
 qo/pCY1NSckjJH1v34yUjSZEwLQDrpe2Iv1CWMY6UtHdlFa5jppcVeNxqmcDOLq1rSoh
 NlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VZVNgaBy9WtB+TiTDDQzLw294M2wGl6oNkLfrcLYn+U=;
 b=Zw2/pwvH04UVcfgJ50Z2WgIwWjAXAMU2rfndWLXKydRvskzG9suPGASZ+kd7DAVau6
 M1GZUZ3jb2aRibbcoE4czAaqJWVt1ZISirc56hOAySxSHfnG76lWNHaihFvhEe7wR1i7
 UOoCmh9utpx76rXXO+JtHHu6qu1qTcoN4RyJ/HndVOj2GxwHBmz4wsSwOjV7tGR0ClKS
 PVK1j2S0zLRsucvjsf0UziSBi6cLLdHRTx/sTnW/n3XRFemTGt7R+H1+23pORXORarTJ
 Az0wxtHyXn24xiOMDsatm0ghdxP0w+xyMMqC5W16PMX1TBWAR9a4EKKZvLoQdNPFTX8i
 /v9A==
X-Gm-Message-State: AOAM533XzbpSbZ6nIZGJXRyPjDp+C0KHST3NyIdY2CAXMjy2v+kWsqJX
 CEtaH2lfPzvIfdwVwjjTKjuJew==
X-Google-Smtp-Source: ABdhPJxMZNh+0b1mhkBj7q1g5N/YxnMoEcn9o5I0XhZ7jiPHGIfC7whGXdFvq2wAcb6U1vDCAg4Dow==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr19972073wrb.205.1612792336192; 
 Mon, 08 Feb 2021 05:52:16 -0800 (PST)
Received: from dell ([91.110.221.246])
 by smtp.gmail.com with ESMTPSA id m205sm21161165wmf.40.2021.02.08.05.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 05:52:15 -0800 (PST)
Date: Mon, 8 Feb 2021 13:52:13 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] Immutable branch from MFD due for the v5.12 merge window
Message-ID: <20210208135213.GB4766@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
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

Enjoy!

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-asoc-v5.12

for you to fetch changes up to e933836744a2606e6cd42a6a83e5e43da2a60788:

  mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI (2021-02-04 13:55:34 +0000)

----------------------------------------------------------------
Immutable branch between MFD and [XXX] due for the v5.12 merge window

----------------------------------------------------------------
Hans de Goede (3):
      mfd: arizona: Add MODULE_SOFTDEP("pre: arizona_ldo1")
      mfd: arizona: Replace arizona_of_get_type() with device_get_match_data()
      mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI

 drivers/mfd/arizona-core.c |  11 ----
 drivers/mfd/arizona-i2c.c  |  11 ++--
 drivers/mfd/arizona-spi.c  | 138 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/mfd/arizona.h      |   9 ---
 4 files changed, 141 insertions(+), 28 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
