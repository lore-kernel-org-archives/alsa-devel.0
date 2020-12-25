Return-Path: <SRS0=e5Na=F5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEADC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Dec 2020 01:22:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA7122AAA
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Dec 2020 01:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA7122AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48E8317F7;
	Fri, 25 Dec 2020 02:21:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48E8317F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608859317;
	bh=Z/dzda6u0PE/bA2S8KZwNY46GVYWKD7yjPWHWyoWAUU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sFuPN2EroOGXxUbcutFcvWHMHrfslQmyeFXdi6lXk4suEk/OueW32HRS+Fb9JGIPr
	 9cEhC9Ayw6Ba5XX5KIiPVOJ/GAYnOvINcDTEp6iF6dROSYfrEOITbTasgRE2EqCLhh
	 6LDfEXG7j/s6Yg5QU3NQ+Kvj5MVYfBMCafcuRNH8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1B5FF80232;
	Fri, 25 Dec 2020 02:21:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC1B0F80232; Fri, 25 Dec 2020 02:21:04 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34F77F800CE
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2020 02:21:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34F77F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hAn5MJD5"
Received: by mail-qk1-x729.google.com with SMTP id c7so3290777qke.1
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 17:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eR/51XLp7HQCd5RWnkeAFXvnTVVeE+YelrG/OsehfgY=;
 b=hAn5MJD5rRItKlT/7Zl24e2BKZi0Ls8BZo0yfG0VHqNGbxZIImG5bj/Hw62Gu+mG/u
 QO7Mr9HJasfbcRh505O+zP9Cp22ZCzWUHrxmqVE9qhvWlELEdxNImMJDFxUDvwziQxI6
 NMUBe1UMHiSbY24xZSLCEC0gjY+JPmEyJJkyAQdan47NLcDaq2OjTXlOcu56PrZEf/Qj
 K3VfpTdZSMv/g56hpCEy1zR7HYWykU6U6oBzC6tznzZ8ClVF/vQitTc9y6DEuUMNcsQ3
 ql+bigyXHfDYne4ATahAJRh8V7qWXqutn0+s3hatv64QVfUd+i0A0z5k/VgcvxeTHRD+
 YW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eR/51XLp7HQCd5RWnkeAFXvnTVVeE+YelrG/OsehfgY=;
 b=nTPHxkU7N7bMKFeoqh9c6+PUkNxWe4jgcHeX70Wa7DgIZhcn/4aQbZVI2a06wMZPsi
 wXo/ao6pCjjZptBuueCy+68sswY1wVf/ekdGIpPIm3FlgkoOmJEy5bWvg4dgctV4VXzC
 TjlL2t+ilIAEGbFqNbJI4i6lKMsny6RjeoJ3ExcOr0wSbATxwYVb7GkT6czXpO/QzWgZ
 V2o3oneNlUhmYgjIA19saJCa6PmsgeE5hwsZ7dF5KstROC3DYbm/Dm4XLehMRCphm658
 W55vc4H3zw8RSX1XHTymXtKHUb82uF/rlJ/8Gd9FvzJoo61IZhnp7UOSNscriS5vdIDQ
 H6PQ==
X-Gm-Message-State: AOAM531uflrXprC15YLT2TtDUeLhZHS0LgVTShlLUG36U+e4h42HS3nS
 MgN2rQIedUQqVdh8OGiUHNI=
X-Google-Smtp-Source: ABdhPJyrNjeysbrlaGCYU+QBL1gUJ/O/dP/8CtbqfoqjVSeWYb5ZgSJ1J5pFIsmM63ClMqGEBprPBg==
X-Received: by 2002:a37:5a47:: with SMTP id o68mr21575955qkb.423.1608859257152; 
 Thu, 24 Dec 2020 17:20:57 -0800 (PST)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
 by smtp.gmail.com with ESMTPSA id x47sm17583505qtb.86.2020.12.24.17.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Dec 2020 17:20:56 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sameer Pujar <spujar@nvidia.com>,
 Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH 0/2] fix tegra-hda on tegra30 devices
Date: Fri, 25 Dec 2020 01:20:24 +0000
Message-Id: <20201225012025.507803-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-clk@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
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

The following patches fix tegra-hda on legacy tegra devices.
Two issues were discovered preventing tegra-hda from functioning:
The hda clocks on tegra30 were assigned to clk_m and running at too low of a rate to function.
The tegra-hda encounters an input/output error when opening a stream.

Since the only mainline device that used tegra-hda previously was the t124, it is unknown exactly when this was broken.
Fortunately a recent patch was submitted that fixed the issue only on t194 devices.
We can apply it universally to the tegra-hda device to resolve the issues across the board.
Note that downstream devices used the spdif device instead of hda for hdmi audio.
The spdif device lacks a driver on mainline.

Peter Geis (2):
  clk: tegra30: Add hda clock default rates to clock driver
  ALSA: hda/tegra: fix tegra-hda on tegra30 soc

 drivers/clk/tegra/clk-tegra30.c | 2 ++
 sound/pci/hda/hda_tegra.c       | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1

