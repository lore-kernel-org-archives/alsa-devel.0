Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE83C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:06:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBC420692
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bhYi1Se+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbuxulM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBC420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2927216FF;
	Thu, 21 Nov 2019 18:05:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2927216FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574355994;
	bh=Ha2ga+Bk29PP26NPcaqO4hd4kF8+EFdgNDYhU3PROOw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bhYi1Se+7UgBQckAr+jLfqoL+bkyvHObl6a8Frc88vHL0YyFymXbmyDGOkNoJzB5N
	 gBl0BJgRtOoM3pMG1FmuQ6XOztng3lvnPsNlAgpVRpQvszK2RtYl/u0fa8MUoxBVCX
	 SJDyraiaHyEpK8kae0E1Yl1aZpqrqTIitZriNZ0U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D1E3F80147;
	Thu, 21 Nov 2019 18:05:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E9FEF80146; Thu, 21 Nov 2019 18:05:41 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4276F800F0
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 18:05:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4276F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="FbuxulM5"
Received: by mail-wm1-x342.google.com with SMTP id x26so4279926wmk.4
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0re8rXYMHSap6XKSlx//AGDnlKypYxFmsmkqmIjzSJk=;
 b=FbuxulM5yi+hVol+ybHml76SOIXCFpVSfUVI7FkgIJfAy4G5Dkxc/0uXITJkNm+ph/
 FJoiCsdtojx+p2fSqm0IUy57itLCU/W25l8GqlQfv9JGPdHob42uR4nLZE5dnDRKr+kr
 Zdsut67NOhbt1vtaGEvI3Kyj/yBB0avfekXvrjNMnB6VGp0FZ9kSIJ4JoVoYrL1GSCx5
 kUrEw8ohglRcxHNKmx4zGEUl7l4wKOC1C8WwuqYHupsws7nsYwHZ410Hu22ZJ9dcL842
 DMkikLjtOXVCbAzrDHkd7nAi1xHyijbx9Ij4dh0kG5zl4dL4LdEd7/XCkJCA4khhwUpj
 ZDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0re8rXYMHSap6XKSlx//AGDnlKypYxFmsmkqmIjzSJk=;
 b=cWOEOQPS1MiBaEUqvhZU7vJlCSPbGtE1NMgx0yjt7NfDQqps6pjJyFe2HZke8KmeLt
 fqFvkqlj7GY0IimE1bcyWPzKZH2GAPFIsxO8B4mef5WyuabmCqodCux6unizgAUpLz5d
 +H4H6mCvvhGjjoM1DuAI4w3Egx4L2C1QzOtdgPhSjw60vapgBJi6XTw8N8NvnL+JyjX/
 ywmUgCkPYK2/E9ssXme90WgIELcwiJNlOMThPCwF8kJcSIuUVYAsB1adPdSYi/rnkJ4u
 twGKiHIIimPvT5C+RvCMOV/jMnKRb9BZy2533C2Sgk4+SvDTDw7SRJXElzpK1BM7C4hI
 +wEg==
X-Gm-Message-State: APjAAAXBIG6we9Ldi135Z0ww/TbzooOczdokZVhLWwy+IGGYceJ+8Uza
 Zhu7LL6UX6B9qKX2ansCG/rJbw==
X-Google-Smtp-Source: APXvYqz1k9UzXGgWztdeaaFoXm5e8fMfaN17EMD2CppOmZAXz30rABTGh6tv/m9gZZZq0G4gpP9jJg==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr11366521wmo.7.1574355937815; 
 Thu, 21 Nov 2019 09:05:37 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id i71sm4423731wri.68.2019.11.21.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 09:05:36 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
 linus.walleij@linaro.org
Date: Thu, 21 Nov 2019 17:04:57 +0000
Message-Id: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, vinod.koul@linaro.org, spapothi@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH v4 00/12] ASoC: Add support to WCD9340/WCD9341
	codec
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

This patchset adds support to Qualcomm WCD9340/WCD9341 Codec which
is a standalone Hi-Fi audio codec IC.
This codec supports both I2S/I2C and SLIMbus audio interfaces.
On slimbus interface it supports two data lanes; 16 Tx ports
and 8 Rx ports. It has Five DACs and seven dedicated interpolators,
Multibutton headset control (MBHC), Active noise cancellation,
Sidetone paths, MAD (mic activity detection) and codec processing engine.
It supports Class-H differential earpiece out and stereo single
ended headphones out.

This codec also has integrated SoundWire controller.
Patchset for this is already sent for review at
https://patchwork.kernel.org/cover/11185769/
    
This patchset has been tested on SDM845 based DragonBoard DB845c and
Lenovo Yoga C630 laptop with WSA881x smart speaker amplifiers via
soundwire and 4 DMICs.

gpio controller patch does not have any link dependency, it can go by its own.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

Thanks,
srini


Changes since v3:
 - Added new SLIMBus common bindings suggested by Rob.
 - renamed microvolts to microvolt in bindings as suggested by Rob
 - dumped pinctrl driver and added new simple gpio driver
 - few cosmetic cleanups in mfd driver.

Srinivas Kandagatla (12):
  dt-bindings: SLIMBus: add slim devices optional properties
  ASoC: dt-bindings: add dt bindings for WCD9340/WCD9341 audio codec
  mfd: wcd934x: add support to wcd9340/wcd9341 codec
  ASoC: wcd934x: add support to wcd9340/wcd9341 codec
  ASoC: wcd934x: add basic controls
  ASoC: wcd934x: add playback dapm widgets
  ASoC: wcd934x: add capture dapm widgets
  ASoC: wcd934x: add audio routings
  dt-bindings: gpio: wcd934x: Add bindings for gpio
  gpio: wcd934x: Add support to wcd934x gpio controller
  ASoC: qcom: dt-bindings: Add compatible for DB845c and Lenovo Yoga
  ASoC: qcom: sdm845: add support to DB845c and Lenovo Yoga

 .../bindings/gpio/qcom,wcd934x-gpio.yaml      |   47 +
 .../devicetree/bindings/slimbus/bus.txt       |   10 +
 .../devicetree/bindings/sound/qcom,sdm845.txt |    5 +-
 .../bindings/sound/qcom,wcd934x.yaml          |  163 +
 drivers/gpio/Kconfig                          |    8 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-wcd934x.c                   |  104 +
 drivers/mfd/Kconfig                           |   12 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/wcd934x.c                         |  306 +
 include/linux/mfd/wcd934x/registers.h         |  531 ++
 include/linux/mfd/wcd934x/wcd934x.h           |   31 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd934x.c                    | 5084 +++++++++++++++++
 sound/soc/qcom/sdm845.c                       |   86 +-
 16 files changed, 6399 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
 create mode 100644 drivers/gpio/gpio-wcd934x.c
 create mode 100644 drivers/mfd/wcd934x.c
 create mode 100644 include/linux/mfd/wcd934x/registers.h
 create mode 100644 include/linux/mfd/wcd934x/wcd934x.h
 create mode 100644 sound/soc/codecs/wcd934x.c

-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
