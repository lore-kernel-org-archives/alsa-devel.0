Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE957C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 14:20:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F97E61481
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 14:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F97E61481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 763FB168B;
	Thu, 28 Jan 2021 15:19:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 763FB168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611843649;
	bh=pFy5fVaxf6M/U/9ZrNyAIJoVrBhTidBodjMoRE9cBHY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JeR+ljYX/1oxCLLVoLmMcZpqtHyLzahB7EDdMONN9HZrQbKB5rYbrFL+UmInrsWb8
	 K0ROOQS47ozbQqAPoOPKo50jnj1dWoQBy2qmf2kDEoYLkLRYDIH9this6Eq10VNyFP
	 nTmqm0MlCe3riV0Ay8q4AXi44Pjh8WeJLUMEUGSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8380F8015B;
	Thu, 28 Jan 2021 15:19:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1614CF801D8; Thu, 28 Jan 2021 15:19:58 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38E54F800D1
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 15:19:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38E54F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Of6VgqVY"
Received: by mail-wr1-x429.google.com with SMTP id d16so5532730wro.11
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 06:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x0QMpFOalwPklH2KvBPZK8bo2/fUlpNzY2SPfbp4llw=;
 b=Of6VgqVY59Jivj4WC4gyTCCQ3IptSNXlxtDlSFMJ08D9Dj64wv60fy37px1X9F3TTU
 Cf0oKu/J19OKCvtwyFfgzEWVycD5BuAfmFXbhoS2enZjEeL/0cfI6cS2scFbcArjOaVJ
 wwqhx3JIfjCK1TkQFtZum3TbDhfDSVvT/e1zgRqCYgdXnutw9MiHdmZ3WW4z3Q5SFT7A
 t6K3cwA7+zfop7kE8XO43rq8ZyC7EFCmwJJtfZK/QaP2XvdwC3HG1zkmTtB/9cRPOEXq
 jS9xPWcC7E3qiImaC+ZRGnvAgE6iBod6k3c4lD8p6NJfq8eeYP3sfR90pUJut12WjBo1
 klYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x0QMpFOalwPklH2KvBPZK8bo2/fUlpNzY2SPfbp4llw=;
 b=hnqRGLJIg2nAwuPXilDV4o3n9tyOTI8OmaCig3HczZw8HGDxW3Ybw9wAyRLEz/qNED
 NeYNsnS1ICXvgQvQWM7nT2QQZAqVeo5wqEu4enYwapegnAZC88W5HA1OVDZIrTWAcqZd
 /TkP+K43a5PVLPO9LKAjV4f0wzUCamiBKDnxyyCnXVUzdkXv/+AmXZDcEVkSmbfSe1zw
 cRW00nf9HJoRxVbI6GXBKLbqEwDNXtgXQPypNGeTZojAL3H9fq167F6X7aCKadogj5mZ
 dcuHZv7c3/jiYh018CeFUqq6kADH4f17dqoIYIbfrcvQ/gsgwamORTKluD69kJ9hcHtg
 j4oA==
X-Gm-Message-State: AOAM531CW+CMztvp2w3zJ1IkW5CX9vPqIArX5ypOKqlbR2f942EM4JYe
 Cvxq1CqYoTZa7RbeCEaA+GuORg==
X-Google-Smtp-Source: ABdhPJyGXoeIBnHZriYgJl2y6msMfQCaVd4EFZ0NkDobRVez/+f0p1PIkYV+rZL9pEjvcmJeqbO9Gg==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr16805260wrw.166.1611843594318; 
 Thu, 28 Jan 2021 06:19:54 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id d9sm7257096wrq.74.2021.01.28.06.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 06:19:53 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 0/7] ASoC: codecs: add support for LPASS Codec TX and RX macros
Date: Thu, 28 Jan 2021 14:19:22 +0000
Message-Id: <20210128141929.26573-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

This patchset adds support for two Codec Macro blocks(TX and RX) available in
Qualcomm LPASS (Low Power Audio SubSystem).

There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
has specific connectivity like WSA Macros are intended to connect
to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
and TX/RX for Analog codecs via SoundWire like other WCD938x Codecs to provide
headphone/ear/lineout/amic/dmic etc ..

Most of the work is derived from downstream Qualcomm kernels.
Credits to various Qualcomm authors from Patrick Lai's team who have
contributed to this code.

This patchset has been tested on support to SM8250 MTP Development Board.
This board has 2 WSA881X smart speakers with onboard DMIC connected to
internal LPASS codec via WSA  and VA macros respectively and WCD938x
TX and RX connected via Soundwire via TX and RX Macros reseptively.

Thanks,
srini

Srinivas Kandagatla (7):
  ASoC: qcom: dt-bindings: add bindings for lpass rx macro codec
  ASoC: codec: lpass-rx-macro: add support for lpass rx macro
  ASoC: codec: lpass-rx-macro: add dapm widgets and route
  ASoC: codec: lpass-rx-macro: add iir widgets
  ASoC: qcom: dt-bindings: add bindings for lpass tx macro codec
  ASoC: codec: lpass-tx-macro: add support for lpass tx macro
  ASoC: codec: lpass-tx-macro: add dapm widgets and route

 .../bindings/sound/qcom,lpass-rx-macro.yaml   |   62 +
 .../bindings/sound/qcom,lpass-tx-macro.yaml   |   67 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/lpass-rx-macro.c             | 3623 +++++++++++++++++
 sound/soc/codecs/lpass-tx-macro.c             | 1881 +++++++++
 6 files changed, 5647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-rx-macro.c
 create mode 100644 sound/soc/codecs/lpass-tx-macro.c

-- 
2.21.0

