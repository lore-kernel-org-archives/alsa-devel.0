Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52232C2D0CD
	for <alsa-devel@archiver.kernel.org>; Thu, 15 May 2025 07:54:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E19361B82;
	Thu, 15 May 2025 09:32:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E19361B82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747294357;
	bh=UQYPuQ4V0eo5jv/qafQ0OHy9kWYPLY7nSfMkxHI957U=;
	h=From:Subject:Date:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ax06xa274ktKokaa2BW1zcQ3Os4n2ph3L36+AKSZRBViITLMx7rvS3wlyPfMkZ0N2
	 IN6neQlgiTqKeVM7pPGwEUFQiKMcn9axYCJACc/Rk7f009oR+kPerJTb4TH8phjkPJ
	 hNLZL3vh64o8llLoX7sD7iGXHh9N3XRax8UDQqlc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86F07F89875; Sun, 11 May 2025 16:33:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59900F8986E;
	Sun, 11 May 2025 16:33:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2032F89E26; Wed,  7 May 2025 10:02:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EAB13F89E26
	for <alsa-devel@alsa-project.org>; Wed,  7 May 2025 10:02:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAB13F89E26
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=fairphone.com header.i=@fairphone.com
 header.a=rsa-sha256 header.s=fair header.b=gB6+PQoK
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so10393588a12.3
        for <alsa-devel@alsa-project.org>;
 Wed, 07 May 2025 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1746604925; x=1747209725;
 darn=alsa-project.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+u3bu7oYvpS4FSzs62hW1Jixx7IoWbryK85jVovTQg=;
        b=gB6+PQoKFDJXWBHvL/Qu4SBAYOhrqEcPcCRvu6ACCqQ6vCPm70poU3WOOCVFt0ykaN
         n06qrzFuJLtmvcPr33wXaD/be94MTu2uzftmr9SLQWjZFgR9M+llfoaY5tCA+sXL5sd3
         izdAYQl6TYUBw+uGsp7Lau2Ux+6NUbk+iXjlXR0sJAAvxbauVJHS0cKE5kI/k8HSIm67
         asNXcewzowy/dSDazJ1PJ99LJ9mG++wto18bUu2NdajvQJlKemvUm/0ybElc8vnijk1v
         7rsUmxCeiioEpgw3yMJZw03BYORoQU0WRodzejVl5gVXzrrQ45nwNw0um+8NYSE9vwu9
         5M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746604925; x=1747209725;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+u3bu7oYvpS4FSzs62hW1Jixx7IoWbryK85jVovTQg=;
        b=sgjCi3MbDP6GDA6k2N4jCDP3AU914rMDN9pdF4/Oy97Naw3gkpbWBIN4CmsMlHrcfi
         qN3RRz2Ylj+7W9pFQMux83hFwVj6U4EFfvi7EEAVCP5JTpHwXOpdAC0hNvM3ppztpXkK
         vbY5tUKvwGgE4UjssG0A+J0Js2Ikx3pGCSdPcok9oi/xQnC9G/7dV9bh9Ubc/PAInTgq
         jnlaOMWeS3MNK1Gs3B5AjxfVf2U6+++7hrV30ohA+CZE813G4sA4SqmAKqmW4sZZTzRm
         YCq+gVzvkv15ajZHQ998YAscmEW50p56VrUOI9IfmtnsJsRoHPln695WBMife+VcHR2R
         dt3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWegWwXmmrfIIzK4TRjXTIgJjnyDgRtG4jUNopih52gmiAVozg88jskgpYla/tIynA824hu/BJ4Mkv@alsa-project.org
X-Gm-Message-State: AOJu0YxkUpwVPJc2twJZflTV9XIQnQKeQKNsakzqpCcEG+06HOCuuA5U
	YUYWgqe2C3V3jwSNdUeqkr+9jW/D8iFT3uQYiUDN9iRVrN0Jm5qGpVKYEQJW4QM=
X-Gm-Gg: ASbGnctLvYHeVu8kURwCbsYKL+AryHq/Mtj63aApMc8fYjG+QCVgAcRHoMyiFUqsyfu
	2fBupAQk1F74EQd36rV+gEIerYc8P+QSr28NeeBgb+D0gWtZ+0m/fVTbsz1sYQ+lQGvASJ1V+Lg
	BLcdoZDFNTM+WxYH9/bvRHOA0CidQIJqPQbJ5xyEKucP+L/K/tSdz6jV7qf4KgUVZcR4Y+wkLfX
	ReN/U7OQduRKEbJQ/JBP82KJZcrOG+YnqK2hBqOdbnvHV9Psi5K2e1XZkbYBsZHt6B0opCrY+xl
	ldE8D6GYumMkF+8+Y43I4XwqetRyMEpJlu6wdCP8sNtMz7C+KyizEsdPpbHJpr6t/gyP7p2GcHT
	9CW6SX1UlZeacYA==
X-Google-Smtp-Source: 
 AGHT+IHF5b+vKZO4u0eoZyRIBjD7kg25Q5WOddOsFOZKz33BDxBpiXozlemQ76d2/Vw293ayXjtVIg==
X-Received: by 2002:a17:907:944e:b0:ace:6d53:3da3 with SMTP id
 a640c23a62f3a-ad1e8ce48dcmr237718466b.23.1746604924787;
        Wed, 07 May 2025 01:02:04 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c0310sm855236066b.88.2025.05.07.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:02:04 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v4 0/5] Add DisplayPort sound support for Fairphone 5
 smartphone
Date: Wed, 07 May 2025 10:01:36 +0200
Message-Id: <20250507-fp5-dp-sound-v4-0-4098e918a29e@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGATG2gC/3XMSwrCMBSF4a1IxkZuXm3iyH2Ig+ZlMzApiRald
 O+mBUGKDv8D55tQcTm4go67CWU3hhJSrMH3O2T6Ll4dDrY2okA5SFDYDwLbAZf0iBZr1jbSMyB
 KW1QvQ3Y+PFfufKndh3JP+bXqI1nWP9BIMGDb6o4ayn2j1cl3IQ99iu5g0g0t2Eg/gABO5AagF
 QBhG+FBcg3iF8C+ACo2AKtAazQXRAIoorfAPM9vUJe6hy4BAAA=
X-Change-ID: 20240809-fp5-dp-sound-b3768f3019bd
To: Srinivas Kandagatla <srini@kernel.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-MailFrom: luca.weiss@fairphone.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 5FTVO2VDSRZHPDVUIA3E52XJMPDL3KU4
X-Message-ID-Hash: 5FTVO2VDSRZHPDVUIA3E52XJMPDL3KU4
X-Mailman-Approved-At: Sun, 11 May 2025 14:33:16 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5FTVO2VDSRZHPDVUIA3E52XJMPDL3KU4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add the necessary sound card bits and some dts additions to enable sound
over DisplayPort-over-USB-C, e.g. to a connected TV or monitor.

The UCM files can be found here:
https://gitlab.postmarketos.org/postmarketOS/pmaports/-/tree/master/device/testing/device-fairphone-fp5/ucm

This series - in spirit - depends on the series enabling DisplayPort in
the first place, but can land pretty independently, especially the ASoC
bits:
https://lore.kernel.org/linux-arm-msm/20250312-fp5-pmic-glink-dp-v2-0-a55927749d77@fairphone.com/

The ASoC bits depend on the patches for USB audio offloading merged
through Greg's tree so this cannot easily be applied for v6.16 through
the sound tree. Either it waits for v6.17 or also goes through Greg's
tree.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v4:
- Use "sm4250" for qcom,qrb4210-rb2-sndcard (Srinivas)
- Expand cover letter to mention dependencies for ASoC patches
- Pick up tags
- Link to v3: https://lore.kernel.org/r/20250425-fp5-dp-sound-v3-0-7cb45180091b@fairphone.com

Changes in v3:
- Simplify return qcom_snd_wcd_jack_setup in machine driver
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20250418-fp5-dp-sound-v2-0-05d65f084b05@fairphone.com

Changes in v2:
- Revamp series based on comments on v1, doesn't have much too much in
  common anymore
- Use sm8250 instead of sc8280xp sndcard file, so port other required
  changes from sc8280xp.c to sm8250.c
- This also changes the sound card compatible to from
  qcom,qcm6490-sndcard to fairphone,fp5-sndcard
- Link to v1: https://lore.kernel.org/r/20240809-fp5-dp-sound-v1-0-d7ba2c24f6b9@fairphone.com

---
Luca Weiss (5):
      ASoC: dt-bindings: qcom,sm8250: Add Fairphone 5 sound card
      ASoC: qcom: sm8250: set card driver name from match data
      ASoC: qcom: sm8250: add DisplayPort Jack support
      ASoC: qcom: sm8250: Add Fairphone 5 soundcard compatible
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add DisplayPort sound support

 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 31 ++++++++++++++++++++++
 sound/soc/qcom/sm8250.c                            | 27 ++++++++++---------
 3 files changed, 47 insertions(+), 12 deletions(-)
---
base-commit: f819a667fa466d3b96b542b147053b6873f18ea1
change-id: 20240809-fp5-dp-sound-b3768f3019bd

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

