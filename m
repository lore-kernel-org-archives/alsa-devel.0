Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B851C43219
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 14:46:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C72418D8;
	Thu, 25 Nov 2021 15:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C72418D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637851604;
	bh=78wliNIcyiXewLO8ULVUTRRZ0ep3uimWvT3eaHxF+ss=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q18laJjd2OrucVi9gdGYTia8j1jWyS52sl2SQnGmQcv+IdG0yPn7jHYleTzZJfw/2
	 +IS1Wzk0JL1B/ZsFltZtEWj84LE9lqI19l/E57C3pQ98dp6ptUWuagkKtNFXENNYpS
	 Gz8eVz6u74hPxKjpSU+C+fOAbMuHD08ujv94cZw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28369F804ED;
	Thu, 25 Nov 2021 15:44:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74065F804EB; Thu, 25 Nov 2021 15:44:34 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC312F8049E
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 15:44:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC312F8049E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="zZpXPufZ"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1APCh81L016649;
 Thu, 25 Nov 2021 15:44:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=5G7tjLWLKet8xg5YJsAoPpj35mAfrj/N+DMrBK+bDV8=;
 b=zZpXPufZkASztY2jj1rW/QHbzyXnoi7OuNN0mURBLSkccpu3MG9iUDx7L0urBIVmOlRN
 w9D/9ixe+6k9IECv7lVETn12rtiS5nQhttqri0GTe43zCxEUpZ5nlOh1dhUaEYLD7F77
 PrcFBPJmCiJTi8TZE8KNLlgFIOK9EWyOzR6icuR7UM6O9Y1iOqaH/tJy9WZU6VoqbDTX
 oQZ8zZq+qH3xViIevgwOiE2Pe1TUolhXSguI0UbyHmEhPQ6Jv5cRCCxPYL8UbyEWx3W/
 jquMg4FQe1nqXu7JAFmjBHxMviRcVdMsOXNxaBczP9rG8N0IEOFFDlWHFZQuA3tbpJ9U oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cjar3gq2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Nov 2021 15:44:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A76F10002A;
 Thu, 25 Nov 2021 15:44:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 957E4237D97;
 Thu, 25 Nov 2021 15:44:20 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov 2021 15:44:20
 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Olivier Moysan <olivier.moysan@st.com>, "Rob
 Herring" <robh+dt@kernel.org>, <arnaud.pouliquen@foss.st.com>,
 <amelie.delaunay@foss.st.com>, <alain.volmat@foss.st.com>
Subject: [PATCH v2 0/4] ARM: dts: stm32: merge spi and i2s nodes
Date: Thu, 25 Nov 2021 15:40:49 +0100
Message-ID: <20211125144053.774-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
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

When a STM32 SPI instance offers I2S feature, two nodes are defined
in STM32 SoC device tree to support both SPI and I2S.
Merge SPI node and I2S nodes into a single node, to avoid
hardware description duplication and compilation warnings.

Changes in v2:
- Squash some patches in the serie to avoid dtbs check warnings
  on intermediate compilation steps.

Olivier Moysan (4):
  ASoC: dt-bindings: stm32: i2s: add audio-graph-card port
  ASoC: dt-bindings: stm32: i2s: allow additional properties.
  ASoC: dt-bindings: stm32: i2s: update example
  ARM: dts: stm32: merge spi and i2s nodes

 .../bindings/sound/st,stm32-i2s.yaml          |  9 ++++-
 arch/arm/boot/dts/stm32mp151.dtsi             | 39 ++-----------------
 arch/arm/boot/dts/stm32mp157c-ev1.dts         |  2 +-
 .../arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi |  2 +-
 .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  2 +-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  7 +++-
 6 files changed, 18 insertions(+), 43 deletions(-)

-- 
2.17.1

