Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5156C433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 14:10:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B835E61182
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 14:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B835E61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 379AA1614;
	Wed,  5 May 2021 16:09:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 379AA1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620223809;
	bh=B+ZfS/dpwG4ph/5yMgI9dlOAmAVU549C70eqmXTENDk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rdB2dgemp9qLzJ87hwhsj/iwfLZyAJkN+bf2/aRyoDyx+qHLicqJIYCLvKZp9qccE
	 f7C2lxNAy4giTnVm1D3L+RMkatqqT+56uYy9jChVXuqqf58GTNdcTeIu7dmJGcjq0u
	 Hh1tyYi9rhOz0yHl6sqBJH78ifsd6a4CzlIMl+Xw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFC10F8025F;
	Wed,  5 May 2021 16:09:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B30B2F8025F; Wed,  5 May 2021 16:09:17 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0550BF80163
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 16:09:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0550BF80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Tca7V89R"
Received: by mail-ot1-x330.google.com with SMTP id
 u19-20020a0568302493b02902d61b0d29adso999502ots.10
 for <alsa-devel@alsa-project.org>; Wed, 05 May 2021 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=poYtoBQ28iFBlsMtYMW7HQWFnHpillGEdoSkendtk9o=;
 b=Tca7V89Ry/y/4wYnVFBSFUuf0/C1C9YCRcy8/g9VqYowQPyblDEf2+7yjM99NPKpBG
 4sgSXJkzjhtwVPmJ2uALZPUe463jfYCzB82UfRlFF4zlyg6/UO3VqC/KjhywW/WxIvaN
 nh21aas9W89mAFinvip0VZCFPuKkDH1LtePmegCCsJsuzMoo3bwAdtXIbV2xBm3+MpfQ
 TpiFVpgI33CkW4ofJ6lh4tcsp+0MzHNz0VX7suZ+qyozSeXX/HJqDIKP+UM8W3kH2q8w
 gAji0XqgMULGHkUNruVwModfKfiJZevNvLZI0xaQPwA8I7FaYdEuJiJlih3gnQLldKOM
 cdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=poYtoBQ28iFBlsMtYMW7HQWFnHpillGEdoSkendtk9o=;
 b=Ov/Q4L1m9p3BqIuGpbjSq1po0ZEUgzyYWnAfKUVx9Zo9qZiz5KchAtM5MR0BusW47S
 MPo7/TMk90IGlAYaXHnT8rEIVm0PkBgD1C5W7jbzXrKjdj/ZoPAIZ39dRAdPmZTJVTYX
 RrTvvmlzd3AeTP2aPhR2WJH9c3s7s+xxgZpNHw0D3gvg/BgYWTIbHufsb6aPblfLwzQx
 ig1y9E+zIVkrLBIu1/vvkS0lu33PmAGuw0g1XBxXZ8ry6VbZItu/zD/Atq0EytXzx55x
 jAioXC3nRZnUeTLgapJAJm4XlBw3167+gHdnfIIqh8RtzMz5LETf5VeRwfJtHjKOg1k8
 dRaQ==
X-Gm-Message-State: AOAM531Y3Lt0NPpKzwd9mB6OmyaXERpjRHVPapUtspI3IuL/5ZhFn4bO
 COUsXCNygdm/yc65+2s9zuRYJS97aDE=
X-Google-Smtp-Source: ABdhPJxMy8wTe1oizpsT9wETaixL/t9MkgcgAxAs7a6hSm9qjcaGmQkTCGlBpmkbJm5WfAsVNnBb3Q==
X-Received: by 2002:a9d:6c95:: with SMTP id c21mr23128676otr.85.1620223745680; 
 Wed, 05 May 2021 07:09:05 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com.
 [76.183.134.35])
 by smtp.gmail.com with ESMTPSA id k20sm621707otb.15.2021.05.05.07.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 07:09:05 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v9 0/4] ASoC: codecs: add rk817 support
Date: Wed,  5 May 2021 09:08:50 -0500
Message-Id: <20210505140854.15929-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, heiko@sntech.de,
 devicetree@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org,
 lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, broonie@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>, jbx6244@gmail.com,
 lee.jones@linaro.org, maccraft123mc@gmail.com
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

From: Chris Morgan <macromorgan@hotmail.com>

This series is to add support for the Rockchip rk817 audio codec which
is present in all Rockchip rk817 MFD chips.

Changes in v9:
 - Add cover letter.
 - Remove documentation for interrupt parent per Rob Herring's request.
 - Remove unused MODULE_DEVICE_TABLE to fix a bug identified by kernel test
   robot.
Changes in v8:
 - Added additional documentation for missing properties of
   #sound-dai-cells, interrupt-parent, and wakeup-source for mfd
   documentation.
 - Corrected order of elements descriptions in device tree documentation.
 - Changed name of "mic-in-differential" to
   "rockchip,mic-in-differential".
 - Changed name of sound card from "rockchip,rk817-codec" to "Analog".
 - Removed unused resets and reset-names from the i2s1_2ch node.
Changes in v7:
 - Removed ifdef around register definitions for MFD.
 - Replaced codec documentation with updates to MFD documentation.
 - Reordered elements in example to comply with upstream rules.
 - Added binding update back for Odroid Go Advance as requested.
 - Submitting patches from gmail now.
Changes in v6:
 - Included additional project maintainers for correct subsystems.
 - Removed unneeded compatible from DT documentation.
 - Removed binding update for Odroid Go Advance (will do in separate
   series).
Changes in v5:
 - Move register definitions from rk817_codec.h to main rk808.h register
   definitions.
 - Add volatile register for codec bits.
 - Add default values for codec bits.
 - Removed of_compatible from mtd driver (not necessary).
 - Switched to using parent regmap instead of private regmap for codec.
Changes in v4:
 - Created set_pll() call.
 - Created user visible gain control in mic.
 - Check for return value of clk_prepare_enable().
 - Removed duplicate clk_prepare_enable().
 - Split DT documentation to separate commit.
Changes in v3:
 - Use DAPM macros to set audio path.
 - Updated devicetree binding (as every rk817 has this codec chip).
 - Changed documentation to yaml format.
 - Split MFD changes to separate commit.
Changes in v2:
 - Fixed audio path registers to solve some bugs.

Chris Morgan (4):
  mfd: Add Rockchip rk817 audio CODEC support
  ASoC: Add Rockchip rk817 audio CODEC support
  dt-bindings: Add Rockchip rk817 audio CODEC support
  arm64: dts: rockchip: add rk817 codec to Odroid Go

 .../devicetree/bindings/mfd/rk808.txt         | 186 ++++++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  36 +-
 drivers/mfd/rk808.c                           |  85 +++
 include/linux/mfd/rk808.h                     |  81 +++
 sound/soc/codecs/Kconfig                      |   6 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/rk817_codec.c                | 558 ++++++++++++++++++
 7 files changed, 952 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/rk817_codec.c

-- 
2.25.1

