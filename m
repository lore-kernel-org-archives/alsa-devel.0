Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F3EC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 06:49:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 776A31F49;
	Wed, 22 Jun 2022 08:48:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 776A31F49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655880570;
	bh=ukrWRKFiRN4mDKWhjD8jA2cY2W+vJiT2M6lfbc5Cpkw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kwZ/h+CGMX1+s+uyzUsZKiCmqwCxmJXhmcn8D/PkqlvWhmxBtEVw7JqNdkYr5zrQ3
	 y2dzs+NTFoSgVx36wfsRaunXu858NHLfFqI2BEIVtypOcYmo4WTlzq0g9nMF4Ms0Ar
	 MYGaioVyf6tkHeOriAz1FWsFGdHEtdExPVOETLBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB8BFF8019B;
	Wed, 22 Jun 2022 08:48:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66274F802D2; Wed, 22 Jun 2022 08:48:37 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CC92F800CB
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2022 08:48:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CC92F800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WvjO6aEP"
Received: by mail-ed1-x52b.google.com with SMTP id e40so9937694eda.2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2022 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5vCNv91lDUYC1ObatJgypBEUspG3u2nt9MFwNwpMHlY=;
 b=WvjO6aEPHVl6NWj+rBneUsyMVQVj8b3aFD8zeW9ZRmMzMTxTn5WeXxEAz70gQh2six
 srNyRlbCfESuGMYbwR0sgUz8B/VRB2JuglPmqNm0HJyPuVN7PMo+GCfsjgGaGqZQ1VFd
 LrifXViCqSZvxo9FLNHGSiTRrtNM6Kk9M1bmK5AmkWJnv49PhTHjixEzkpv7QGpi25IX
 96yTYmjJ0sOpglNbCaW5dSUxRR5nBprHOhTmWAAvUqhsbrJeEna9OptN3BgdYK2yGCIh
 T2pdMl9ARZoBIS4FJL9aj9s8ULztEar2KKqKm9wW2uH+k/UVlVDu2KtC3+W8m0J8K7tb
 suTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5vCNv91lDUYC1ObatJgypBEUspG3u2nt9MFwNwpMHlY=;
 b=mtGAkNF8YlPgy3xNVI04Ogp9VtbGN/nXHRttTRVfEEY8fzef2ddJao9EkevnviDrX1
 T3BkvX+7RacnpTdKxGGaW5iRFINshLQnRvA7PY3bc6VmxFENxswG0x/IYcREHu6AmQEw
 e0Z9kh1ElHPLNbkjhDWKODR1e7VpG+WunaePDkbzfivfvv07IzxxOg+PcJHCtgHHekUw
 4iVLFbVeCrXBj1fUdseJyGvYjNFySp66L2CwSwNDuUb9r3LS9Ryfzur+/fdcc/cgJ5y6
 vxkX0MkTiZs96xZ0xsgwqav2K+P2E8dF6nNEPOFi5beVFnLmcRaMDRflQZma9FwSahH8
 PRrg==
X-Gm-Message-State: AJIora+zJLBlUH726Uc7Ch678UtNLjtu3GRGlQotkq3Qv21LWwJLq7oj
 vIKCQ2B2Aq0doQj5Lj9oDoY=
X-Google-Smtp-Source: AGRyM1v8YkOgNlmT2qmgJxXXbW+mbt9cVRBo3XaM5Ir9A43ZII38kJ4FcYczx0jaUtyfiCbx3bTYyw==
X-Received: by 2002:a05:6402:2788:b0:431:3f86:1d4e with SMTP id
 b8-20020a056402278800b004313f861d4emr2372103ede.238.1655880508087; 
 Tue, 21 Jun 2022 23:48:28 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
 by smtp.gmail.com with ESMTPSA id
 sd12-20020a1709076e0c00b00722e8c47cc9sm1197148ejc.181.2022.06.21.23.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 23:48:25 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Date: Wed, 22 Jun 2022 10:47:55 +0400
Message-Id: <20220622064758.40543-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Yassine Oudjana <y.oudjana@protonmail.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yassine Oudjana <yassine.oudjana@gmail.com>,
 phone-devel@vger.kernel.org
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

Add DT bindings for WCD9335 DAIs and use them in the driver as well
as all device trees currently using WCD9335.
 
Yassine Oudjana (3):
  ASoC: dt-bindings: Add bindings for WCD9335 DAIs
  ASoC: wcd9335: Use DT bindings instead of local DAI definitions
  arm64: dts: qcom: Use WCD9335 DT bindings

 MAINTAINERS                                       |  1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts       |  5 +++--
 .../arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts |  5 +++--
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts      |  5 +++--
 include/dt-bindings/sound/qcom,wcd9335.h          | 15 +++++++++++++++
 sound/soc/codecs/wcd9335.c                        | 13 ++-----------
 6 files changed, 27 insertions(+), 17 deletions(-)
 create mode 100644 include/dt-bindings/sound/qcom,wcd9335.h

-- 
2.36.1

