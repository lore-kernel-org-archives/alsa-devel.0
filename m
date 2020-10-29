Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94329C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:09:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713F620738
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bBjnrS0H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByNrfm0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1176085D;
	Thu, 29 Oct 2020 12:08:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1176085D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603969778;
	bh=6Se1AfAXYp6uNOwppK855o2Y+mpIrtETUnudTSP/+AQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bBjnrS0HJH9axnT85YpX+enwuY/FeLGnJlvG++vTJPYFJ5mwi2h6Q7Wf8fCc63HPQ
	 1RrCLaTdsNRPwZ3q/NRtskmcW6YpQd6Oe0MOjEMORSrn+r/w81Tf+qvwTi6Tpc0uEP
	 uLfAXkUsinP0XuKZEuUrdb4lzGAN5LB1nn+JJxts=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3AECF8020D;
	Thu, 29 Oct 2020 12:08:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE339F80217; Thu, 29 Oct 2020 12:08:44 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2335BF80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 12:08:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2335BF80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ByNrfm0K"
Received: by mail-wr1-x444.google.com with SMTP id k10so948147wrw.13
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LmGv0yRIVyV9z98kEqM68q1Q8ecpHQ7rH5nlZRYkiqc=;
 b=ByNrfm0KwHmzFqI+B0tQDo8PL5NERMC96ssfvEmQFy8mWOSvglwJdlUljs8gLq5IQw
 olWuy0+61OM9rLSkYUUZ4FvYB19h6orusLGDrOjP4jVnMykUksmLzyi/aX5oRaYhD5Sp
 iQUY/YlQIdxWvx8IPSVzQKvEbaMyhDLzggvZFuAu77zgwWPpAvVoC6ikXP5u3CG60lLf
 S8wXkp9DHOTu+wVw1bOxEJBFLzQN9Apjemq28zT1PyZa8MIHsJ8NYoUfRBC8DH6ja3JM
 onjKeVltaGt/acvPv0Q0K/52IgWgm2lV3mepxyl+OOlpqdgyEwzLJAD1V/pNd8nRJbx6
 pc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LmGv0yRIVyV9z98kEqM68q1Q8ecpHQ7rH5nlZRYkiqc=;
 b=L5bnFXKcRpLiaW1+YRNfX2NZuJ/TrODX3INIJkkJUkSUJXlBLTDTUCZyEoCwyRXWHL
 GZmALvXy/O5ZMCuRbsXMHBRGxTc8uuGLKzl15qDXhEwIOkiqNgI3wbaP6pQMvbi5jZM2
 mXKO7BhbNiD8zrcTje1xZJyqdL8r9WGrakfDgZhKrWlfI8blOBN7cLPdNs5o0yq7uArB
 SWhmJHoWAXh/tLZFw2kLGUvpVXvl1ui/foBHZYIJPMqnmvxaYcxxO06UPKVd9gWvs+ad
 dmvuE5eMTPr1kOaVlkBszZ7rq3WBM6SUHsleQQsJMFbW2eR4T887otHqz9EuoMipgA5a
 P63g==
X-Gm-Message-State: AOAM532DlUr6WTheAwAsuzehUlY4Qh67U0g2UEeOzmLOEn+aRcrUYmLf
 IfcyvxFKIVFihDyqqZd6n4ui34LFEvg2VQ==
X-Google-Smtp-Source: ABdhPJz0GKBBs+Rqk3fG1bevQ6hm1UzIOXVocSMV4O1tP/5cPXwjjN7nvP/eRMpt7VA4KzCoGgE2aw==
X-Received: by 2002:adf:f607:: with SMTP id t7mr5236339wrp.39.1603969720660;
 Thu, 29 Oct 2020 04:08:40 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id n4sm3710830wmi.32.2020.10.29.04.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 04:08:39 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 0/6] ASoC: codecs: add support for LPASS Codec macros
Date: Thu, 29 Oct 2020 11:08:23 +0000
Message-Id: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
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

This patchset adds support for two Codec Macro blocks( WSA and VA) available in
Qualcomm LPASS (Low Power Audio SubSystem).

There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
has specific connectivity like WSA Macros are intended to connect
to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
and TX/RX for Analog codecs via SoundWire like other WCD Codecs to provide
headphone/ear/lineout etc ..

Most of the work is derived from downstream Qualcomm kernels.
Credits to various Qualcomm authors from Patrick Lai's team who have
contributed to this code.

This patchset has been tested on support to Qualcomm Robotics RB5 Development
Kit based on QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers
with onboard DMIC connected to internal LPASS codec via WSA  and VA macros
respectively.

Thanks,
srini

-Changes since v1:
 - updated code to fix cppcheck errors suggested by Pierre
 - fixed various coding style and variable initialization suggested by Pierre.
 - yaml bindings clock names replaced with constants.

Srinivas Kandagatla (6):
  ASoC: qcom: dt-bindings: add bindings for lpass wsa macro codec
  ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro
  ASoC: codecs: lpass-wsa-macro: add dapm widgets and route
  ASoC: qcom: dt-bindings: add bindings for lpass va macro codec
  ASoC: codecs: lpass-va-macro: Add support to VA Macro
  ASoC: codecs: lpass-va-macro: add dapm widgets and routes

 .../bindings/sound/qcom,lpass-va-macro.yaml   |   67 +
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  |   69 +
 sound/soc/codecs/Kconfig                      |    8 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/lpass-va-macro.c             | 1500 ++++++++++
 sound/soc/codecs/lpass-wsa-macro.c            | 2472 +++++++++++++++++
 sound/soc/codecs/lpass-wsa-macro.h            |   15 +
 7 files changed, 4135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-va-macro.c
 create mode 100644 sound/soc/codecs/lpass-wsa-macro.c
 create mode 100644 sound/soc/codecs/lpass-wsa-macro.h

-- 
2.21.0

