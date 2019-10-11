Return-Path: <SRS0=IN0D=YE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03391C47404
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:45:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3869218AC
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FmWFCqBR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxN1NFTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3869218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 544AB1654;
	Fri, 11 Oct 2019 17:44:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 544AB1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570808742;
	bh=7uLYAW1j9kXSJ7Ff6R2KKQWeeJcgtKHD8GQXdZtyoFc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FmWFCqBR+de6GMNClqIRDK7PbmLsINCTv8MylSFrDvuMFan7KLm7Y8AAT/9/cXJxa
	 E7ulF+rhtPei0jVgmz/rHi4zEn/gNsZPlGnan/+aCy499i0iEZGPzxEOBAxsD5l3Ir
	 ITiZTUmtaGQxLz58u3ZkP/egN+6BaRW4w8iV3mH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D624EF8026F;
	Fri, 11 Oct 2019 17:44:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04691F802BE; Fri, 11 Oct 2019 17:44:49 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B792CF8026F
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 17:44:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B792CF8026F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="UxN1NFTc"
Received: by mail-wr1-x444.google.com with SMTP id p14so12464998wro.4
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kvfCxVclTy6ShzV/vDD4x14oYnHfjCHog9kicmW4dcM=;
 b=UxN1NFTc47siaqQofM9vtgi+trRicCmJOy0vprOyEv1qhi6BHxkXaXA/2b02UUh0Mt
 tYwxRkBK3tE71JJtISGt0m4royxB+4o9x4Ox7RcFiGh7LiLzT84IO7z7ffGNgReKWtMN
 3dcMaxEYTuD7fkjQVVooBjt6JISkUED3abo8L3H9cmGjoJRYFNybplWC2k084IPjGXoX
 oQomlBvIjM750TSEz/ulYnH/4UfIOrIdO5J1jQ37XGH7iweoklsJmMppGms98b7AZmd2
 Mnu/2UgrZN9E0vfDmsuUOltT7ZfEFo7tkwWKfQJ7XenrOSe8GnLqG1lC7KR8P1gQeDHH
 5p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kvfCxVclTy6ShzV/vDD4x14oYnHfjCHog9kicmW4dcM=;
 b=j0d1wbLuepRO37fy8plUd55EntATv/Qf7nh8Qg5q/U7nuroS77wxe1LSV3WYhowMwa
 3JBpQaVnGjXHZ/Fmlu4xGo5vw3u8PezR1K4pLHeHbWmeD632KJzGcMiieQCNIYB/rf5x
 fq9UqG5PWPnybCT+MH81c1DphUanvaV3gEpWTSgeXix+NUxR34BjTwYq3kTAEr/YCAcm
 Ak28vQSz7KIwdubsX6KiEHIgi/EUHwgOPg7RE+2kY2wA34WNy6IRFu54eb5M7XbLmdcD
 pZZVIXVbx75hNvKSUtOgtbUnUWHFIziBmy0Ax3HlvCVjv9VIhn5sPNjiBwQize3HmslM
 thLA==
X-Gm-Message-State: APjAAAUoptek7zPnwV5TuWOAJlFYH7dAX8ckkx68HDQzIBnKDXOQKP18
 kuwOpc3N/V4avBNPm/ZSJGmnbg==
X-Google-Smtp-Source: APXvYqwIhb0tYcjlG6emnKIqHFasuJrequA13bxaiRFpYFxvsgNTAQ0iUDkvvpWFO/LV54MurBnajQ==
X-Received: by 2002:adf:e646:: with SMTP id b6mr13267380wrn.373.1570808686953; 
 Fri, 11 Oct 2019 08:44:46 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id y3sm3453044wro.36.2019.10.11.08.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:44:46 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh@kernel.org,
	vkoul@kernel.org
Date: Fri, 11 Oct 2019 16:44:21 +0100
Message-Id: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH v3 0/2] soundwire: Add support to Qualcomm
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

Thanks for reviewing the v2 patchset.
Here is new patchset addressing all the comments from v2

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

Changes since v2:
- Added support to set_sdw_stream

Srinivas Kandagatla (2):
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

 .../bindings/soundwire/qcom,sdw.txt           | 167 ++++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 935 ++++++++++++++++++
 4 files changed, 1115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
