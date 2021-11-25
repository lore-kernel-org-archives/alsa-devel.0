Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60D5C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 14:46:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A72E518D5;
	Thu, 25 Nov 2021 15:45:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A72E518D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637851575;
	bh=fj41v+g4RYksaKyaE+jTlOcCexnktRhing4HRngsa2c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dtMoYrhf06U+Whk/NsloRw+O5XadO7+2Lj1VAREq0Hq7o4bGN/s6NCIArEwdhiW0N
	 P2GAXIDnv0D6IhF+sUTwswpa51LnjahC2UHuYmequmQv4IUdpeybMto80zZFlmJ+9Z
	 JoTzH8BFCgctUPeQJxpgJvfEH2LDDHD3QnhQtLx4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 834D4F804AB;
	Thu, 25 Nov 2021 15:44:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7965BF804E6; Thu, 25 Nov 2021 15:44:35 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01474F80087
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 15:44:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01474F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="LUOZXEUP"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1APCgxw7016072;
 Thu, 25 Nov 2021 15:44:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=EXTlbQS8eDv4A0IJqxUFLPpP6bGa9jNKsKWAyWcl8Xw=;
 b=LUOZXEUP4DM6Rn7Z7PNeZUKLQX3x8RETUkuM77zFszn0nt9J8ODqDQ6LzAxepwC8bel+
 0+RS/NXNT2gONZl8iypAq6Lh+TAnjf2WClsLPc6uX4Ee9wAly/FDiTCdS0DuqoerMVub
 GIB0FaRRw7Tvk7IEHBgZadc2lOKExr4w3OTH1ln3hirYsZf5TJqhnd4MWljh9xLKayBV
 FVYeu9cdhcNLhvLKA0k7BhMxXv4bGoEZCJ6DGWYZfOeSFeUfj0g87rOLlDjtHUrhcQHn
 4PM7GLNCPpoY2HfFpaG1P5bmUzYMvoxUAAXEJ7+wBs/2m93AaAJebusSa5fMzH7M8V8g WQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cjar3gq2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Nov 2021 15:44:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B395100034;
 Thu, 25 Nov 2021 15:44:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 61CF8237D98;
 Thu, 25 Nov 2021 15:44:21 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov 2021 15:44:20
 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Olivier Moysan <olivier.moysan@st.com>, "Rob
 Herring" <robh+dt@kernel.org>, <arnaud.pouliquen@foss.st.com>,
 <amelie.delaunay@foss.st.com>, <alain.volmat@foss.st.com>
Subject: [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add audio-graph-card
 port
Date: Thu, 25 Nov 2021 15:40:50 +0100
Message-ID: <20211125144053.774-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211125144053.774-1-olivier.moysan@foss.st.com>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_06,2021-11-25_01,2020-04-07_01
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, fabrice.gasnier@foss.st.com,
 Olivier Moysan <olivier.moysan@foss.st.com>,
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

The STM2 I2S DAI can be connected via the audio-graph-card.
Add port entry into the bindings.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index 6feb5a09c184..64b70ac539f8 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -58,6 +58,11 @@ properties:
     description: Configure the I2S device as MCLK clock provider.
     const: 0
 
+patternProperties:
+  '^port@[0-9]':
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - "#sound-dai-cells"
-- 
2.17.1

