Return-Path: <SRS0=cWdV=N6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BFC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 15:56:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D5661131
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10D5661131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7511316CA;
	Wed,  8 Sep 2021 17:56:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7511316CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631116613;
	bh=70oSPwu0CDcFVnqegZ4RLFFvDIQQDjpVQytrl+R0yfw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJYZ0ocjA7jzuKXHHArLQ4rgRDE+vunzHdtgfTHSK5o3jPdPp+FCX+jw22Gr/KS0c
	 ccoRRgeP56o6bpTdh8lL2CXvqtuWloEIFjn27D57GAp8G0wHHrCzgQ9ShoiFkm6WEF
	 YzNMGYd6lj3y0QUdX4o9XfVwlJfWk5xhpgDfGnwo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 177BFF804E2;
	Wed,  8 Sep 2021 17:55:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72401F804AF; Wed,  8 Sep 2021 17:55:10 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80B6AF802E7
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 17:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80B6AF802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="R74YluQh"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 188FpFAY005711;
 Wed, 8 Sep 2021 17:55:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=khSh/mrGpnueT0O2KuJdaYSLaAOHomTDvZqTp5udFB8=;
 b=R74YluQh8R8dAh95tRQmIrBjVScGow9vT4Fl4rYs2osr7ODSa4LdIv9k1RSKsOvR5mgt
 /GeiWP7gYlMuvxiFU0cZyCz4WrGbAD00LR+r2RD35Q32HAiEH4/J+G7W+h1K7YwT2CkH
 W2lTuq1JgXI++IJAKHr6/L2y04g2MXPkoymdKh4fiux6Hz0+Pe0R5fEcnMXvAaVYKJJJ
 T6ZfPvlpMjHsXjL97Md6VQ7rGqw5/Qou6QdGSbk4dQqVKLyNOm9XT4uVq1Ha4OrXbzAo
 W+QnPQyvupY4pvIWXBQCyj69NgQXLrVRQS/AG7lIk6d2RvLy6kfUern4FVPBq52mdXpq xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 3axtha2b7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Sep 2021 17:55:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9DF02100038;
 Wed,  8 Sep 2021 17:55:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8CEAB21E697;
 Wed,  8 Sep 2021 17:55:00 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG1NODE3.st.com (10.75.127.3)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep 2021 17:55:00
 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/7] dt-bindings: iio: adc: add nvmem support for vrefint
 internal channel
Date: Wed, 8 Sep 2021 17:54:47 +0200
Message-ID: <20210908155452.25458-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908155452.25458-1-olivier.moysan@foss.st.com>
References: <20210908155452.25458-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

Add support of nvmem. This allows to retrieve calibration data from OTP
for vrefint internal channel.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index a1f6cbe144ba..772e6cf95dc0 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -298,6 +298,14 @@ patternProperties:
           each channel.
         $ref: /schemas/types.yaml#/definitions/uint32-array
 
+      nvmem-cells:
+        items:
+          - description: Phandle to the calibration vrefint data provided by otp
+
+      nvmem-cell-names:
+        items:
+          - const: vrefint
+
     patternProperties:
       "^channel@([0-9]|1[0-9])$":
         type: object
-- 
2.17.1

