Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA0FC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 18:21:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1A464E2E
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 18:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1A464E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C57331662;
	Tue, 23 Feb 2021 19:20:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C57331662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614104456;
	bh=GBe+nfolHP1HoMBuIE6VpxRNBdrPXQDsJGxdyHkZzMw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rLdMyVe906CjLw/iUnP5jvyzb6O9nIyFWnQW7kOJAsVPi2QzN1X4sokpauNl5G9Mm
	 R82KgOZqtybHnhAWCCeng7ZtbWJMKZ7IKIRqKQukCGoToIYYLPBNI0SiPMGgtcRqR7
	 QZFvmk7ouH2lGYecWsyj0vT+FOoJgoOqRJf8Isqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31E36F80169;
	Tue, 23 Feb 2021 19:20:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E4BEF800B4; Tue, 23 Feb 2021 19:20:04 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C1D4F800B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 19:20:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C1D4F800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="Ol7vVZ9h"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1614104402; x=1645640402;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GBe+nfolHP1HoMBuIE6VpxRNBdrPXQDsJGxdyHkZzMw=;
 b=Ol7vVZ9hrLSslb2PNg4OuD99pDp11y/ISWj25e2Jg2poiQ0ygwx9mMGk
 DQn2hJrGEfPszUWiNC4OY+rfmgg+OiB5voKUtSUw35XfqStNdq+Q7dZCU
 gMExyqHa/RSs5XbnbxdM6CmFkI0sqOv3k3zbQrK51aO1b+MM0rP4thNgy
 2G0Q+sDre5NqkvD+StQ6P9mXOu+B+WDfQwl2JL2/vq/r4b/KhxPaIStJc
 FQd3plXnXha8+oYD1MJFVsmSJ43NWtcSaOqMkLvZnqvC/Ci3Cp2uC9K45
 dE7mylKMEf9hypIpyP3/oN8ynF+0JeJKQeI1Wksu+MhWiO63q4m1+xjrI A==;
IronPort-SDR: z2NKsbUfd3lPqoh1x9m8eFTR6xWDkNnvlGU/ZFnczGZkTKiuP5nY5QRT9qGyULh2h7oyVdnt9E
 5P8WdXAJA6oQ8A5/uD7iRWNb+oFgQqZPEMmc63PEiMmnDoUX83q0Jn3dA6DLEnUKA+OTpFnSik
 WScvrEN0ck2+1L9zZzCGkdatyeqQG2R61KrAE05cei7rhmAJ4lJ9GTAnd43K6OYSbgJidf/Xke
 lOOACTpURXHWG5P/HrUui5LiFl6IfPLXUIDGL/dj+urIez6i7hTgP5uUsmp4cfA1JEEV6/G/d8
 PpQ=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; d="scan'208";a="110827418"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 23 Feb 2021 11:19:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:19:57 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:19:54 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/7] Add I2S-MCC support for Microchip's SAMA7G5
Date: Tue, 23 Feb 2021 20:19:22 +0200
Message-ID: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
 nicolas.ferre@microchip.com, robh+dt@kernel.org, tiwai@suse.com,
 ludovic.desroches@microchip.com, broonie@kernel.org, Codrin
 Ciubotariu <codrin.ciubotariu@microchip.com>
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

SAMA7G5 includes an updated version of I2S-MCC, found previously on
SAM9X60. This controller includes 8 data pins, 4 for playback and 4 for
capture. For I2S and LEFT_J formats, these pins can be used to
send/receive up to 8 audio channels. For DSP_A, with TDM, any pins pair
(DIN/DOUT) from these 4 can be selected to send/receive data. This
version also includes 2 FIFOs (send and receive).
This patch set starts by moving the driver's bindings to yaml and
continues with adding a new compatible for the SAMA7G5 variant, followed
by the changes needed for I2S/LEFT_J support, TDM pin pair selection and
FIFO support, exclusively for SAMA7G5.

Codrin Ciubotariu (7):
  ASoC: convert Microchip I2SMCC binding to yaml
  dt-bindings: mchp,i2s-mcc: Add SAMA7G5 to binding
  ASoC: mchp-i2s-mcc: Add compatible for SAMA7G5
  ASoC: mchp-i2s-mcc: Add multi-channel support for I2S and LEFT_J
    formats
  dt-bindings: mchp,i2s-mcc: Add property to specify pin pair for TDM
  ASoC: mchp-i2s-mcc: Add support to select TDM pins
  ASoC: mchp-i2s-mcc: Add FIFOs support

 .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ++++++++++++
 .../bindings/sound/mchp-i2s-mcc.txt           |  43 -----
 sound/soc/atmel/Kconfig                       |   3 +
 sound/soc/atmel/mchp-i2s-mcc.c                | 161 +++++++++++++++---
 4 files changed, 252 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

-- 
2.27.0

