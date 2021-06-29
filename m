Return-Path: <SRS0=Z0V9=LX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E3C11F67
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Jun 2021 22:31:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E53961DA2
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Jun 2021 22:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E53961DA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BA8A15F9;
	Wed, 30 Jun 2021 00:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BA8A15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625005862;
	bh=I6eEFTokLaAFVDevZBm7FHbR0obMXqcDtD/YJQxrB3Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lri9LdYkUDiDk4wYmkgU7kIjtXjQN5jaZOPr7qpbAfEzlXZaL77z3pVd7H6Rwo1KG
	 sGpBXmj9t2o4JnrVMANbKePrD/DjXpGp/pTsnAYpvpirz701GskLH28NedNNva3A8N
	 tf0AKXfem+1/q2YiN4a6P1XmTL0vesc4EDMv4hD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C72F7F80259;
	Wed, 30 Jun 2021 00:30:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 344EBF80259; Wed, 30 Jun 2021 00:30:08 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09DFAF80156
 for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2021 00:30:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09DFAF80156
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="T4DpU9wN"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15TMQxMw009364; Tue, 29 Jun 2021 17:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=H5UyhAqN0xmeujqhX1InXOdFip7eksVA9W43QwJXQzA=;
 b=T4DpU9wNrUsgOu6MOiddBB+9qmAJGZmZqbyTGwnpLNJVhTzbINs5Ibt9FbW2oINd0HaN
 V/Su1EWj5QCjNfxCd8TjH3cCKxteGzp4WkKaE6xHH+ZGAxuh4TSci3CZViBHwMRFb/+2
 zPzK/Hwj6+e/OmnRwJ6BbNPgVKUqC1d0LZPKxKuZupvMmTfAB0OF6JlI9diFBc/96XYq
 uDsNrljBq+CERCoCdAvNL8IH4/yMpkvrP+OY/bSmn6G8r/AXc3N/ntMQstQU0XFprXJu
 pZXTt1vYrT6t9kMVpzn6f8k6+RnV5bu0tPDo4sOq9OOtO5ggIAAJni16c3XyW+rQe60P wA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 39fbqvajme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 29 Jun 2021 17:29:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 23:29:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 29 Jun 2021 23:29:52 +0100
Received: from localhost.localdomain (macC02XQ1DJJG5K.ad.cirrus.com
 [141.131.65.92])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 84460448;
 Tue, 29 Jun 2021 22:29:51 +0000 (UTC)
From: David Rhodes <drhodes@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <ckeepax@opensource.cirrus.com>, 
 <brian.austin@cirrus.com>, <patches@opensource.cirrus.com>,
 <alsa-devel@alsa-project.org>, <david.rhodes@cirrus.com>
Subject: [PATCH v2 0/2] Cirrus Logic CS35L41 Amplifier
Date: Tue, 29 Jun 2021 17:27:17 -0500
Message-ID: <20210629222719.1391653-1-drhodes@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T_Gs861ggNt8672FREPCocCTBlZYxXmm
X-Proofpoint-GUID: T_Gs861ggNt8672FREPCocCTBlZYxXmm
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290139
Cc: David Rhodes <drhodes@opensource.cirrus.com>
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

ASoC driver and devicetree documentation for a new
Cirrus Logic amplifier CS35L41

v2 changes:
Reduced regmap defaults to avoid collisions with patched registers
Fixed SPI setup for OTP read to avoid setting freq higher than original
Fixed entry to device_property parsing function for ACPI systems
Replaced ASP Slot Position controls with set_channel_map callback

David Rhodes (2):
  ASoC: cs35l41: CS35L41 Boosted Smart Amplifier
  ASoC: cs35l41: Add bindings for CS35L41

 .../devicetree/bindings/sound/cs35l41.yaml    |  395 ++++
 include/sound/cs35l41.h                       |   83 +
 sound/soc/codecs/Kconfig                      |   12 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/cs35l41-i2c.c                |  126 ++
 sound/soc/codecs/cs35l41-spi.c                |  152 ++
 sound/soc/codecs/cs35l41-tables.c             |  617 ++++++
 sound/soc/codecs/cs35l41.c                    | 1770 +++++++++++++++++
 sound/soc/codecs/cs35l41.h                    |  755 +++++++
 9 files changed, 3914 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l41.yaml
 create mode 100644 include/sound/cs35l41.h
 create mode 100644 sound/soc/codecs/cs35l41-i2c.c
 create mode 100644 sound/soc/codecs/cs35l41-spi.c
 create mode 100644 sound/soc/codecs/cs35l41-tables.c
 create mode 100644 sound/soc/codecs/cs35l41.c
 create mode 100644 sound/soc/codecs/cs35l41.h

-- 
2.25.1

