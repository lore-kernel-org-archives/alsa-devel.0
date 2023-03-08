Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D723C64EC4
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Mar 2023 11:21:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBB3C17D4;
	Wed,  8 Mar 2023 12:20:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBB3C17D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678274465;
	bh=TKnKrMXnxMPoJ23hCxtLyZoJPpOQiSk6IWCtybIBZSw=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZmEG0mnDFdaXcL7EoYfsEZ87y2ssc71T0Fb9pZGN9l4B3i3fnEok1PmIN30JQRaPt
	 zwbLqeCRz6YotP3VDzX2D8B5lasCB/gBpOE+0oVOXeyik6QNMRzjWooccZnBdy/1gd
	 WFyYs6RzmWVHKoaxxcvOi2zB6mE2/PZAA/k3NTVs=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A8DEF8042F;
	Wed,  8 Mar 2023 12:19:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D717FF804FE; Wed,  8 Mar 2023 08:35:32 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DB63BF80093
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2023 08:35:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB63BF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Dt82pBO6
Received: by mail-ed1-x52f.google.com with SMTP id ay14so58314846edb.11
        for <alsa-devel@alsa-project.org>;
 Tue, 07 Mar 2023 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gte2HFg34yVeA/U5OHeIizbsHhlUPWICXggwBKuVh2I=;
        b=Dt82pBO67slGMwDm1SS6/1HLw6ZpAzyD6srwgZVrAvXg86Ba82MtmdgLPLzCSDT3b9
         BN5+kNFV9aXgpZOPMK1GjuNptRtjo4oP3cbH5Ia65t+klmJvNMZKI4qxSlrYRmuOaNsk
         DsGdBVpK1l+E8cuMCRpVKGbJsuaIj6RzOhQBPzk4XXLXs+Lv9ZkGH0HFQTPswWh8RoSh
         1jvcdkiZw0oul9twRi176xsDc+cbt97a8HonmyAWHAS2Gfny3Wx7qppNirRF3FaCHOv/
         U1lUJB3hKqsYfm7LJBVMywfgJdsTyw/ddCn7P8TNNWEokX0dg5PC1Prp8+KRgSi+6XjV
         uvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gte2HFg34yVeA/U5OHeIizbsHhlUPWICXggwBKuVh2I=;
        b=q27KAbf7jTEmZopVuL8HL7BwEI5uq1KLjgb7AIBP418IeDW/W7Uz+3OG7uYlJa86Fg
         Vv5WdbEqN1CGndGmquNaJw5iWOp9NXMiC4+fj2Xisipx/Aqhat29r4d45oLPzhxGWgWw
         qn/gMkCViMGEfgGAGdYs5MX1bT7rliykiSq+egf/CCZ7QMfPpQWreTGnn28q3sQLAJ2E
         yftL6b0DxT0+B3rH6NivraNYnONoWqmaAmHnsFzz6XGR3/VKYaJs1N2EZYg0MgD7KJyJ
         cxDnFOwdBtRrRqWJBSANAOk9uYupQBSSP3FikiedL56yZ1qf/7ajiE5/vO+cFI3XrASS
         0oUg==
X-Gm-Message-State: AO0yUKVk7xah1mQsoNOI0Kr7+Zi8l1cNuRMJaHolyqvrawr0/sF0LKEm
	Ed/YPQigLLAFIChpZVbj458=
X-Google-Smtp-Source: 
 AK7set8BdlJlpmywABZUT++XuOH4ogUuKoQXSG95jB3Xk6sHLRzgk3JFLTIQsB8V/aB5j/dY/7XHjQ==
X-Received: by 2002:a17:906:ac3:b0:8f2:bcb5:bbf2 with SMTP id
 z3-20020a1709060ac300b008f2bcb5bbf2mr18581306ejf.44.1678260922879;
        Tue, 07 Mar 2023 23:35:22 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id
 h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>,
	Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 0/8] Fix sound on ASUS Transformers
Date: Wed,  8 Mar 2023 09:34:54 +0200
Message-Id: <20230308073502.5421-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: clamor95@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XHCHDJLLDQPTSV3TKXU7HUWVW5GE3SF4
X-Message-ID-Hash: XHCHDJLLDQPTSV3TKXU7HUWVW5GE3SF4
X-Mailman-Approved-At: Wed, 08 Mar 2023 11:19:36 +0000
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
 linux-staging@lists.linux.dev
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XHCHDJLLDQPTSV3TKXU7HUWVW5GE3SF4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

- add quirk for headset detection used by some T30 devices
  (ASUS Transformers, LG Optimus 4X HD and Vu);
- add RT5631 and MAX9808x machine drivers
- update bindings

---
Changes from v1
- fm34 dropped for re-work
- quirk for headset detection and rt5631 bringup splitted
- minor adjustments in binding updates
- improvement of rt5631 rate asignment
---

David Heidelberg (1):
  dt-bindings: sound: nvidia,tegra-audio: add RT5631 CODEC

Svyatoslav Ryhel (7):
  dt-bindings: sound: nvidia,tegra-audio-common: add
    coupled-mic-hp-detect property
  ASoC: tegra: Support coupled mic-hp detection
  ARM: tegra: transformers: update sound nodes
  ASoC: tegra: Support RT5631 by machine driver
  ARM: tegra: transformers: bind RT5631 sound nodes
  dt-bindings: sound: nvidia,tegra-audio: add MAX9808x CODEC
  ASoC: tegra: Support MAX9808x by machine driver

 .../sound/nvidia,tegra-audio-common.yaml      |   4 +
 .../sound/nvidia,tegra-audio-max9808x.yaml    |  90 +++++++++++++
 .../sound/nvidia,tegra-audio-rt5631.yaml      |  85 ++++++++++++
 arch/arm/boot/dts/tegra20-asus-tf101.dts      |   7 +-
 arch/arm/boot/dts/tegra30-asus-tf201.dts      |  17 +++
 arch/arm/boot/dts/tegra30-asus-tf300t.dts     |   5 +-
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts    |  17 +++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts     |  17 +++
 .../dts/tegra30-asus-transformer-common.dtsi  |   9 +-
 sound/soc/tegra/Kconfig                       |  18 +++
 sound/soc/tegra/tegra_asoc_machine.c          | 125 +++++++++++++++++-
 11 files changed, 380 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml

-- 
2.37.2

