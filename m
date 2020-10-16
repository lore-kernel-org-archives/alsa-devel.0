Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9ECC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:37:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8843F208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ixR3hPF9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GqfLhYq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8843F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EF2C17F5;
	Fri, 16 Oct 2020 19:36:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EF2C17F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602869860;
	bh=rVeIX5cRNuuQ/XHKYWw0eyGqv96fmIOeulQeCbUXu+E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ixR3hPF97EMkEnXQv0LhDQ4Jmoy4uI59pW7Ac6/nBlfXNcqh9JM0fassIZK4jP75f
	 xWbcMLELuWpFD1rU4dqiiAKcOsJpxFs+QyK5HXYIDgdLGSnyrWxJP3m+6zwLkFSMe7
	 0QcpMp8C09GHfV3x3knvYT+2sCrNapsgEmrg1MaM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17504F80226;
	Fri, 16 Oct 2020 19:36:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13DEAF80278; Fri, 16 Oct 2020 19:35:58 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2775F8021D
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 19:35:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2775F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="GqfLhYq5"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09GHQLpa024369; Fri, 16 Oct 2020 12:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=5ARtZ8iuUZWTt92xPnGmGgGIFglUvN30JaId3ybKh1U=;
 b=GqfLhYq5fVpf+NH05aA5aX6efreXaoZKcOKIXf8AFjnDuhgwGvpB1ZBdaBjpsln/gC4h
 JajQmv+HrdtfuzSRUt6s0d56rZpsJrlr5b2w9tBdrsFyeTfMVxdg/hKEVTChxPzitGdu
 eDOZxAHo//3K9LsLrF990RCy/EtNOI8CnUgEec0At13WXlzHXkec6cDmo8VpzgKUoFhc
 gSsRcekD0ACXP5JEKop4s3VrbLNltWrWYda8QbtJSdkloLcHmkGdKSTurH9qYQrOPHvs
 dEp6D9CwM1cUKzqgcnPc8lQRXiQ2R2WmzjRP4t5AwdmnIoceJFvYUlpeatKfe51Lz7JB dg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 343ac20jk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 16 Oct 2020 12:35:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 16 Oct
 2020 18:35:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 16 Oct 2020 18:35:44 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com
 [198.61.64.143])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1542545;
 Fri, 16 Oct 2020 17:35:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <nsaenzjulienne@suse.de>
Subject: [PATCH v2 0/7] Add support for Rpi4b + Cirrus Lochnagar2 and CS47L15
Date: Fri, 16 Oct 2020 18:35:34 +0100
Message-ID: <20201016173541.21180-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=871 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160130
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

This set of patches provides support for using the Raspberry Pi 4b with
a Cirrus Logic Lochnagar 2 audio development platform plus Cirrus Logic
CS47L15 codec.

Patches are needed to audio-graph-card to enable support for setting the
component sysclks and plls. The codec sysclks and plls cannot be placed
under the clock framwork because they are I2C/SPI-connected peripherals
and access to the registers would cause a nested get of the I2C/SPI bus
clock. The clock framework does not support this and it would result in
a deadlock.

Richard Fitzgerald (7):
  of: base: Add of_count_phandle_with_fixed_args()
  ASoC: audio-graph-card: Add plls and sysclks DT bindings
  ASoC: audio-graph-card: Support setting component plls and sysclks
  ASoC: arizona: Allow codecs to be selected from kernel config
  ASoC: madera: Allow codecs to be selected from kernel config
  ARM: dts: Add dts for RPi4b + Cirrus Logic Lochnagar2 + CS47L15
  MAINTAINERS: Add dts for Cirrus Logic Lochnagar on RPi4

 .../bindings/sound/audio-graph-card.txt       |  44 ++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 ...bcm2711-rpi4b-cirrus-lochnagar-cs47l15.dts | 166 +++++++++++++++
 .../dts/bcm2711-rpi4b-cirrus-lochnagar.dtsi   | 201 ++++++++++++++++++
 drivers/of/base.c                             |  73 +++++--
 include/linux/of.h                            |   9 +
 include/sound/simple_card_utils.h             |  24 +++
 sound/soc/codecs/Kconfig                      |  18 +-
 sound/soc/generic/audio-graph-card.c          |  16 +-
 sound/soc/generic/simple-card-utils.c         | 184 ++++++++++++++++
 11 files changed, 703 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar-cs47l15.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar.dtsi

-- 
2.20.1

