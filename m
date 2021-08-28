Return-Path: <SRS0=nf9P=NT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A5C432BE
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Aug 2021 14:03:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F65608FB
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Aug 2021 14:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7F65608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93C571704;
	Sat, 28 Aug 2021 16:02:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93C571704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630159389;
	bh=kduzx720wg/IJtE1BkEMQmEmQa02BQsH02cTD9WQaro=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qHwohkkmCMepSoWdEe7E0IpgcOOwGgFrq7qB0uUSv5A/uO91swBmixVh64cbl+zQj
	 7K8WBIrpqpCj6PKb4AgEl7OWMO05kjzphju/u2Mk7SdhuJvqdWPFz1A9wnzzKNhiLh
	 ttMY1jyzmqYyx73rlSccKxn/wrSc1XjXpIH1SqM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A777F80229;
	Sat, 28 Aug 2021 16:02:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22E09F80240; Sat, 28 Aug 2021 16:02:18 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03BCEF800EE
 for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2021 16:02:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03BCEF800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="GbNbCHzh"
Received: by mail-ej1-x633.google.com with SMTP id me10so20285970ejb.11
 for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2021 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dGMD8G1jIPuTkP7k4fL/JNaabjrqckiKTYDIJ4uuuE0=;
 b=GbNbCHzhYOTSJwpk8QpPayaXfLVMx3hzQag0i1ovxDU8buCO+kdz7SVUxd++BPbnuQ
 h/fqLmzZgFg+t6vs4plyajV/fX4vK05/eEZiFkXIWWpgISSy2DBiZKR254KJoby7WkwX
 jt8TclTBhwiwfGP9JqjNk2UoH2QiTQm+Fox+LgfWm38So4gzzxVxBqEZMwhlwSdgr6Im
 6jjnr3TQVFVnwvXkXDp0x3lPLWaKFOmKowOaRGd4C8A5nOIynhqCrXCLfpCIZ2W6SqUK
 eHKGIXO7z25tbuxJqD61mqaCSrF6xpm4z3lHbFMSrLjWmrzdi3RKWSqzFMO3b5MF4stg
 oyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dGMD8G1jIPuTkP7k4fL/JNaabjrqckiKTYDIJ4uuuE0=;
 b=jShZ1/89q5Qfp/azSRmGMBifKBfZq5bag9IbgxfibT8dxhz5VmpdeMXm7G99EN/wyl
 L96F/5bPhP+wQwa4GupUjY7xFEibxIs3Zw1XGQYIjKQmpARGHjRGBkwHMs85mJDM8SGu
 bI7O3buRPnNUAcbQ+l+I07Lz1b1GwnwoATaEb9Uc2sT9TjR9H66AySywBs1Eywxbr990
 8uVwPnwRR26P9uWlbCdxQBpxPuyfUh774mFYqRS6kLIEHcxSovXq4FCbTYlTUyYnHYaF
 o7zLbAY/1rYdx+vza4mMGNkqw4L07vWp4H3VMTMHQjNWP64xju5Q1TqbrL872HBNvUPr
 HFAQ==
X-Gm-Message-State: AOAM533OGLh7a20ogPDcxdTTAqGgRjtzFdh4tSJTJLPdrHfpFg4QybDM
 voWSV5PKzYDmAbzDcEqBzgKX8USU60xZT8TU
X-Google-Smtp-Source: ABdhPJw6u0+tq5UMYxj/3pOPrn8zfR/ErHG3LVTAGGRJqwoXlKkcOEk6Mimyf1b4/vxX247Xe2v0TA==
X-Received: by 2002:a17:906:3383:: with SMTP id
 v3mr10421811eja.213.1630159330279; 
 Sat, 28 Aug 2021 07:02:10 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch.
 [84.72.105.84])
 by smtp.gmail.com with ESMTPSA id cn16sm4953982edb.87.2021.08.28.07.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Aug 2021 07:02:09 -0700 (PDT)
From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To: 
Subject: [PATCH v3 0/4] Rockchip I2S/TDM controller
Date: Sat, 28 Aug 2021 16:02:00 +0200
Message-Id: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

Hello,

this is version 3 of the I2S/TDM driver patchset. A big thanks
to everyone who has provided their valuable feedback so far.

I've decided to omit the original cover letter for this version,
as it got quite long and had some things that are outdated or
weren't the case as I've discovered from better understanding
the driver code.

I've decided not to remove the synced reset code. The udelay
matter has been settled, and it is code that most likely works,
even if I cannot test it right now. The implementation of half
a reset controller is ugly, but specifying a generalised n-reset
synchronised reset is a bit more complex to do than just doing it
for 2, so I'd prefer putting that work off until later.

Changes in v3:
 driver:
 - alphabetically sort includes
 - check pm_runtime_get_sync return value, act on it
 - remove unnecessary initialisers in set_fmt
 - use udelay(15) in retry code: 10 retries * 15 = 150, so at worst
   we wait the full i2s register access delay
 - fix some weird returns to return directly
 - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP, also put
   __maybe_unused on the runtime callbacks
 - use (foo) instead of foo in header macros for precedence reasons
 - when using mclk-calibrate, also turn off/on those clocks during
   suspend and resume operations
 - remove mclk_tx and mclk_rx reenablement code in remove
 - move hclk enablement further down the probe, and disable it
   on probe failure
 - make reset controls mandatory, since the bindings state this too
 - use _exclusive for getting the reset controls
 - change reset assert/deassert delays to both be 10 usec
   (thank you Sugar Zhang!)
 - properly prepare and enable all mclks in probe, especially before
   calling clk_get_rate on them
 - if registering PCM fails, also use the cleanup error path instead of
   returning directly
 - bring back playback and capture only but in the way Sugar Zhang
   suggested it: set those modes depending on dma-names
 - rework clock enablement in general. Probe now always enables these,
   instead of relying on the pm resume thing
 - add myself to MAINTAINERS for this driver
 dt bindings:
 - fix a description still mentioning clk-trcm in the schema
 - document rockchip,io-multiplex, a property that describes the
   hardware as having multiplexed I2S GPIOs so direction needs to
   be changed dynamically
 - document rockchip,mclk-calibrate, which allows specifying
   different clocks for the two sample rate bases and switch between
   them as needed
 - dma-names now doesn't have a set order and items can be absent to
   indicate that the controller doesn't support this mode
 - add myself to MAINTAINERS for these bindings

Changes in v2:
 - remove ad-hoc writeq and needless (and broken) optimisation in
   reset assert/deassert. This wouldn't have worked on Big Endian,
   and would've been pointless on any other platform, as the
   overhead for saving one write was comparatively big
 - fix various checkpatch issues
 - get rid of leftover clk-trcm in schema
 - set status = "okay" in example in schema instead of "disabled"
 - change dma-names so rx is first, adjust device trees as necessary
 - properly reference uint32-array for rx-route and tx-route
   instead of uint32
 - replace trcm-sync with two boolean properties, adjust DT changes
   accordingly and also get rid of the header file
 - get rid of rockchip,no-dmaengine. This was only needed for
   some downstream driver and shouldn't be in the DT
 - get rid of rockchip,capture-only/playback-only. Rationale being
   that I have no way to test whether they're needed, and
   unconditionally setting channels_min to 0 breaks everything
 - change hclk description in "clocks"

Nicolas Frattaroli (4):
  ASoC: rockchip: add support for i2s-tdm controller
  dt-bindings: sound: add rockchip i2s-tdm binding
  arm64: dts: rockchip: add i2s1 on rk356x
  arm64: dts: rockchip: add analog audio on Quartz64

 .../bindings/sound/rockchip,i2s-tdm.yaml      |  218 ++
 MAINTAINERS                                   |    7 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |   35 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   26 +
 sound/soc/rockchip/Kconfig                    |   11 +
 sound/soc/rockchip/Makefile                   |    2 +
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 1845 +++++++++++++++++
 sound/soc/rockchip/rockchip_i2s_tdm.h         |  398 ++++
 8 files changed, 2541 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.c
 create mode 100644 sound/soc/rockchip/rockchip_i2s_tdm.h

-- 
2.33.0

