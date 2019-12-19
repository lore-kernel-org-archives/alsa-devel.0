Return-Path: <SRS0=OsOn=2J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A581C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:29:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880502068F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k0vBH1u0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srWIczF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880502068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95CF01616;
	Thu, 19 Dec 2019 10:29:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95CF01616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576747796;
	bh=MQEpWU4nG4njhrLNb9Zx6V28WtjjTlc6YSCYoFfqLFQ=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k0vBH1u0ZGFyFjecjFR6nULjVWWkCFiVUydabNN+kQ7MNJLBoXqqEwmH4RsgHJ/Uu
	 0bwdOlrPPlA2mg8IZX9Wtwp4jowmBzjmWgijz4qHjnXUCkftg8pF+ZF2ebtDUC4rj7
	 xna/1g3dE0oQys0H4PpN4+kBa7Gab93STV7yRVz8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01FF6F8014F;
	Thu, 19 Dec 2019 10:29:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD00FF80256; Thu, 19 Dec 2019 10:29:04 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3DEF3F8014F
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2019 10:29:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DEF3F8014F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="srWIczF+"
Received: by mail-wm1-x342.google.com with SMTP id p17so4854707wmb.0
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2019 01:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AwcynCAB8dmhDVrPZzNhCAtkvCBJgVaLCigdZVhu4dI=;
 b=srWIczF+g/KZIcwnNxAcr05vmE5y1j1isQTSU8xSC0bnypoPSXtRS5nYWyD/w1tGnH
 sgWwM5VXdGF+v0DetE0l0Awa46q562zigMi1bsFlEsbfpXjw6qx81NaVj7fqnCmM8JGS
 Ge1O2FAchSvZcTvMp4HTB3eX5zRex92sJQrgoZI+O2PfPDG6+8/W+7eKoXRbGD7JRwdl
 fepNQvdjsFMwX9vQEtKOCQD6ZyEthF4p/E1ZZnbyEngW80Hl9bDfz6XCmE8twr05Ixbw
 Gco9hufwR4t28tIrxVoL/gvqpLZcm3vHtjg3pJgAwWm5pNqZqCYwesgkudFUBuAljeG/
 gRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AwcynCAB8dmhDVrPZzNhCAtkvCBJgVaLCigdZVhu4dI=;
 b=dJH8kHoNIK8Ps/5lfixIl5Uoq+VvyoZxy0K43+4Imtabr38oD0IjUA3TK7zkt1mxte
 E9z3ooEib3yj+QU70esGGJLov0/slOLhiMfJHeMhK5a+t6xKW0nvhewqaGigrjz2qFWl
 JelWgvscEVuE4iZC/U4PYCdzT5zPuNaQdMaDh549UULhIZ7qwBPFrL6MGP7IqXqNnAHv
 d76NtivCq6J86W9iiuPU+JYjTPkq/9Q/N9S5NhGUQytX3V79N/zA2fai9k3fp5fcRvgA
 jCGuAQpTVqxpLu7+5NJ8q3JeAJX4p/6Dn+0fSQWQ6UQjP4rDCkLoW7aP/YbwO2Nb6+rh
 mSlw==
X-Gm-Message-State: APjAAAUva8qopbyw9+W18pVN1Ixr0UAJiZ0a5cdhELH/pnx/6k/aESZ2
 MV0VRI9xdHu59hcmZbR9VnmMSw==
X-Google-Smtp-Source: APXvYqyZvNDj+IC2Bkj9K9Nk41cpwvkkMxBfTULUwaN7stMhyACDzuUZKubB++Qm1tIFf+FaSdxq6g==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr8492440wma.72.1576747741029; 
 Thu, 19 Dec 2019 01:29:01 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id s1sm5627356wmc.23.2019.12.19.01.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 01:29:00 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Date: Thu, 19 Dec 2019 09:28:40 +0000
Message-Id: <20191219092842.10885-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH v5 0/2] soundwire: Add support to Qualcomm
	SoundWire master
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Thanks for reviewing the v4 patchset.
Here is new patchset addressing all the comments from v3

This patchset adds support for Qualcomm SoundWire Master Controller
found in most of Qualcomm SoCs and WCD audio codecs.

This driver along with WCD934x codec and WSA881x Class-D Smart Speaker
Amplifier drivers is tested on on DragonBoard DB845c based of SDM845
SoC and Lenovo YOGA C630 Laptop based on SDM850.

SoundWire controller on SDM845 is integrated in WCD934x audio codec via
SlimBus interface.

Currently this driver is very minimal and only supports PDM.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Test and add PCM support.

Thanks,
srini

Changes since v4:
	- moved stream handling to codec as there is a strong hw requirements
	 on port and PA enable sequence on codec side
	- removed dummy runtime pm 
	- cleaned up code as suggested by Pierre


Srinivas Kandagatla (2):
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

 .../bindings/soundwire/qcom,sdw.txt           | 167 ++++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 856 ++++++++++++++++++
 4 files changed, 1036 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
