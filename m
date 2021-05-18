Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471D2C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 00:16:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E976113C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 00:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E976113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 720D81672;
	Tue, 18 May 2021 02:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 720D81672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621297011;
	bh=LEIbAauNQzrPb/oG6Uw3vFv/bwzMXWJfTh7RFc2kiaY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a30tWOEhj0zN04k/dNmyXlbwAadCJZSUSDUR+VnHX3Bj3EIwXa480kHd2oXxEPKSe
	 NPzypdsXJ5Tu32j58PVz13JFPNpECv3gN7Ao2KYP8SaSx6lOaDesXkF+/ZgYK/Qm7l
	 w+/SwzSJSn49+dcGYoBXVe+MdufKN+0CfMQsuMXE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30041F80259;
	Tue, 18 May 2021 02:15:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C2A8F80082; Tue, 18 May 2021 02:15:07 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6978F80082
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 02:15:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6978F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RUjZE5MP"
Received: by mail-lf1-x129.google.com with SMTP id j10so11341257lfb.12
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 17:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AK6TIIPIh6y8oxw77Uj9fjuC4hunUxPgnOdGH6bCmDM=;
 b=RUjZE5MPMnU2iVr8bo2G7C8zofGwrUNiBmyEAZhWDv0DtHj40AtB/SZ5GKYG/ebelm
 MI4HXjtad9eBJ9884yfDk8PhxwXwrZt4W3BIKK871K0/OgiQo05xJwBzMIA1TgU+XFpP
 Ow/OnMH8bBcca0Yi2Dfw+uffBV7XhF0taDHXkO79dJja0pGDptKeRDM69RvzbVy8UHFE
 TCYEFUaKSfzWEVO5PRGZiUAL8woxq7UPPiZ7O7LzPXa4bpYb1jF92ywMqQwfbD3y4JgP
 fvj8q/MibxkHcxrqbFL/T3jBf/5z37myOikRgz7Zp/J6QYUfogi8evtTVAC9miaeRoiL
 GxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AK6TIIPIh6y8oxw77Uj9fjuC4hunUxPgnOdGH6bCmDM=;
 b=Ofx3lwRlctP/f9FxvzPzFUX4hERmw247752ReK9ZVvl1W1RwDMKfY0gVlgqPd0nxdI
 zsGdYNBmqouct1o/Km36YxBn4zmibsgf1GNi9qeFl/NEsk0sO+gUFFbDjtGAT2dbZzBy
 HZNxRAEZ8AbOriigVFq9ixnBLW/EDuOnzsdBmrgIZ3jdgWkh1baR1hNyxTpOBVt5iZ+r
 MwOl1B271kbfQLNmdwq46/4JVD/zADhsrYH2eGVutL3fHJVJnfC5F4wB8BnQ3015Ximo
 3MrZZWoppqlFrjJxuT9+JutiphKFgaNu8VzIe8LC5DSnYIPGbX+ieCwCwTN1ntVbg8rn
 tKtw==
X-Gm-Message-State: AOAM532qmPsQ63RfYeVZHRJE2/LUZzSWBH7F2FFigeehK7OtCZuvqPDK
 K8UDvssLepbD/oeiZwXEn44=
X-Google-Smtp-Source: ABdhPJzbsk2zFIe4tOkSuRwqBARjwaY2lK/ZkieqOpkdfhgBJGYjh9TFxti9jgF1A0Pr0z+tH8es6g==
X-Received: by 2002:a05:6512:13a5:: with SMTP id
 p37mr1838318lfa.610.1621296901178; 
 Mon, 17 May 2021 17:15:01 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru.
 [109.252.193.91])
 by smtp.gmail.com with ESMTPSA id p4sm2108062lfa.155.2021.05.17.17.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 17:15:00 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v1 0/2] Unify NVIDIA Tegra ASoC machine drivers
Date: Tue, 18 May 2021 03:13:54 +0300
Message-Id: <20210518001356.19227-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

During review of the RT5631 machine driver, Jon Hunter suggested that
it will be better to squash all the current ASoC machine drivers into
a single one. This suggestion is implemented by this patchset. The
RT5631 support will come later with the ASUS Transformer changes.

Dmitry Osipenko (2):
  of: base: Export of_device_compatible_match()
  ASoC: tegra: Unify ASoC machine drivers

 drivers/of/base.c                    |   1 +
 sound/soc/tegra/Kconfig              |  12 +
 sound/soc/tegra/Makefile             |  18 +-
 sound/soc/tegra/tegra_alc5632.c      | 259 ----------
 sound/soc/tegra/tegra_asoc_machine.c | 737 +++++++++++++++++++++++++++
 sound/soc/tegra/tegra_asoc_machine.h |  44 ++
 sound/soc/tegra/tegra_max98090.c     | 276 ----------
 sound/soc/tegra/tegra_rt5640.c       | 222 --------
 sound/soc/tegra/tegra_rt5677.c       | 324 ------------
 sound/soc/tegra/tegra_sgtl5000.c     | 211 --------
 sound/soc/tegra/tegra_wm8753.c       | 185 -------
 sound/soc/tegra/tegra_wm8903.c       | 349 +++----------
 sound/soc/tegra/tegra_wm9712.c       | 166 ------
 sound/soc/tegra/trimslice.c          | 172 -------
 14 files changed, 860 insertions(+), 2116 deletions(-)
 delete mode 100644 sound/soc/tegra/tegra_alc5632.c
 create mode 100644 sound/soc/tegra/tegra_asoc_machine.c
 create mode 100644 sound/soc/tegra/tegra_asoc_machine.h
 delete mode 100644 sound/soc/tegra/tegra_max98090.c
 delete mode 100644 sound/soc/tegra/tegra_rt5640.c
 delete mode 100644 sound/soc/tegra/tegra_rt5677.c
 delete mode 100644 sound/soc/tegra/tegra_sgtl5000.c
 delete mode 100644 sound/soc/tegra/tegra_wm8753.c
 delete mode 100644 sound/soc/tegra/tegra_wm9712.c
 delete mode 100644 sound/soc/tegra/trimslice.c

-- 
2.30.2

