Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16108C4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Dec 2022 15:19:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B63299CD5;
	Thu, 29 Dec 2022 16:19:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B63299CD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672327190;
	bh=QRsoloeh5yoDsVfFAz62YFeWxqU1uyZTVQKLC8vGCcs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Cm/2v21OaAP0JiM1toEmUae876nMLIGSjzhlXqrj+P7sfV95csWZ5FFNGd/w5ftjY
	 6LAE/9AyTnuYn9GDxKn2qZqOzaBziC92j1MFRNFnLuHrBo33OEnPJ8ad11PZ8R4Ov8
	 rkojVngqAm+DKDseDdxdjSL7pqXPlfmsZMPrqSeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5F4FF804E7;
	Thu, 29 Dec 2022 16:18:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A42D3F802A0; Thu, 29 Dec 2022 16:18:07 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7A2AF802A0
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2022 16:17:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7A2AF802A0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=gerhold.net header.i=@gerhold.net header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=f41wZQ8Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672327076;
 s=strato-dkim-0002; d=gerhold.net;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=NhDVal3cY5RtflAGfuXYwWRxbBcys6vmGS1S3kTpu58=;
 b=f41wZQ8Qo2p5DjOKrnomUd4pigBHedDdR1p0/2XTzWfZ1eN+Jv6m88JRbmhLr394lB
 +DkT755r4yFoZKar1SZiIJlNkuph+GF1ElZxCsDIG16zFth/CYTcgrBjJNQSsUJfIaS9
 0n4Er9YU8VyNiJrfFb33N34jC5aO5nl4mZZaTp7E/yNJOlz/h3GNsJIfs0uscyRAr7RI
 ZzxMcFTo/t1C4/SGbRungnLfsVBPpJBDVCvSvRGLbidWHN5dACyAsoN51b2nxDqgmiWQ
 ukINmxETOvAOhAXNYLbj5JfecGucA9VikUDNX4NbbLmZiGIaxExUtk1hMdmQDV90HR7h
 yEFw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIRvweF+KLA=="
X-RZG-CLASS-ID: mo00
Received: from droid.. by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
 with ESMTPSA id Yce349yBTFHtXT2
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 29 Dec 2022 16:17:55 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>
Subject: [PATCH 0/2] Fix APR audio regression on 6.2-rc1
Date: Thu, 29 Dec 2022 16:16:46 +0100
Message-Id: <20221229151648.19839-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@quicinc.com>, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

These two patches fix regressions in the Qualcomm APR driver that 
prevent audio from working on MSM8916 (and likely MSM8996). In previous 
kernel releases the "qcom,protection-domain" property was optional, in 
6.2-rc1 it is now required. It should remain optional because the 
protection domain functionality is only supported starting with MSM8998
and is not present on older SoCs [1].

These patches should go as fixes into 6.2 to fix the regression.

[1]: https://lore.kernel.org/all/20200312120842.21991-1-sibis@codeaurora.org/

Stephan Gerhold (2):
  dt-bindings: soc: qcom: apr: Make qcom,protection-domain optional
    again
  soc: qcom: apr: Make qcom,protection-domain optional again

 .../devicetree/bindings/soc/qcom/qcom,apr-services.yaml      | 5 ++---
 drivers/soc/qcom/apr.c                                       | 3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.0

