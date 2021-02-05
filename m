Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD7C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 10:46:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FFD60230
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 10:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FFD60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 294F11688;
	Fri,  5 Feb 2021 11:45:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 294F11688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612521982;
	bh=7k7dmHzEHksl1FtH81jBRsSKSJCXwWwVcpomq8ZNa14=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVrnyatjWByobvSIJmBkJ8UMDCRkv/oeje9U3xckNyR4pdGcRSwgHJNVP7pyKD9oO
	 aelZNNgTYcklwb9EpnM6i008dH4OV1mvuLj34EW/nxTq4rt/TB4OqFgiOnson5nr5D
	 bEB+16EWGvNNBegRQbV1o3xF+6TScbbooxty1NNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA8A9F80264;
	Fri,  5 Feb 2021 11:44:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97A7DF80139; Fri,  5 Feb 2021 11:44:43 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CBD0F80139
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 11:44:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CBD0F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="zi0YUXr6"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 115AbKPS013481; Fri, 5 Feb 2021 11:44:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Qa7QSCQdCnvBgqG8mjLC1ghulWEhp4Q3PlR+4amm4RE=;
 b=zi0YUXr64YqlsbWNjXsUZOEf0rqYXnNpFJM6/eWMWWvxcHj46oCGVt5CSxFeVJTCOtuN
 nJg0+P00nNcE30zorQFGHy4IxtMQRXLG9PEilQz+HDh/gREkjVs5yovjj8oqVgogTvpt
 x4xyUptrS7qTa5waBQpscDUmvLmDfmxh9cg4ZdpB5HQSKn+gCrC5M6Wc02no+3qKVLVk
 mKP8ITEZnuHWUThOgZKBxNs04E3M+28sk/5CDXBI9OpWM11pXahBZ9IxAQ9Y0tljLfS4
 n46rw6mS8yZAXTiuAV0nVPFZXPn/veZp7k84vErjAuD8YxkzvsGMSO54sxjEo2QFCImk mA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 36h1ke9d48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Feb 2021 11:44:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43B1D10002A;
 Fri,  5 Feb 2021 11:44:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 357552298CD;
 Fri,  5 Feb 2021 11:44:31 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 11:44:30
 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@st.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Olivier Moysan <olivier.moysan@st.com>, "Rob
 Herring" <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: [RESEND PATCH 1/2] ASoC: dt-bindings: add mclk provider support to
 stm32 i2s
Date: Fri, 5 Feb 2021 11:44:03 +0100
Message-ID: <20210205104404.18786-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205104404.18786-1-olivier.moysan@foss.st.com>
References: <20210205104404.18786-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-05_06:2021-02-05,
 2021-02-05 signatures=0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>,
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

From: Olivier Moysan <olivier.moysan@st.com>

Add master clock provider support to STM32 I2S.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index f32410890589..6feb5a09c184 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -54,6 +54,10 @@ properties:
   resets:
     maxItems: 1
 
+  "#clock-cells":
+    description: Configure the I2S device as MCLK clock provider.
+    const: 0
+
 required:
   - compatible
   - "#sound-dai-cells"
-- 
2.17.1

