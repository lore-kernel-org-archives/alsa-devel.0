Return-Path: <SRS0=yf6i=MS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D46EC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 22:51:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6BB60F6E
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 22:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A6BB60F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CE271B14;
	Tue, 27 Jul 2021 00:51:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CE271B14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627339914;
	bh=q7v1Ud+1djAbBxT9ehwBpGthj+1a4l0ja6ue+MvOFbs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pdjUxqnWm0pMsOTzoRDCOO/+ZruLY8ePC//xCZ3hcV+9QT5d6Qdm02zzsVi0atMdH
	 6t9uK4muApW9lkn4ymYwKHmGjNmvo4Vb9zcRRuqcKBKO2MuvVtwnf3T+10q8kYionM
	 KKsz0qwamRQaReiM8hIDqqeaevJBAsH+0+m11wAw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24F51F80253;
	Tue, 27 Jul 2021 00:51:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05E33F8025A; Tue, 27 Jul 2021 00:51:02 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CA48F80130
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 00:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CA48F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="ZsL/ypcd"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16QJL404019520; 
 Mon, 26 Jul 2021 17:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=vBBzwi5z8+aPsMD2cpIm4HGPY+xd+XEbMqC37rVaUG0=;
 b=ZsL/ypcdmrDE2oyXRS9bGY3GKrt4Qo0CHT1xMjizsDwyVZpHTsEPypLesTYitvjEs7FO
 g2wWx4WxXDsGfpMzSlZ//ZfGlyUVlXM2tvvooSWI4GGgXtc3VX8Au61Tfq9glFRdYtzU
 L5XALOdhxAX0G4RXRxqaUV95K2W6K6Mosdzz5Kyt3JHZdqhQQ3idT6xUWAFW1gCoUBva
 AOFKhqqm35fqQeWIwx4JcblDv3EfAq2iFoasdfU4mACec8+mhEiuym5aEYcEzzNRuXEL
 C/QiO+SOzr89H1+WiH7qWn7owORS+TI9lkyep87F77hG+p2B9JxSXD3uCi/MnbmQ24el wg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3a233y85yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 26 Jul 2021 17:50:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 23:35:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 23:35:52 +0100
Received: from localhost.localdomain (macC02XQ1DJJG5K.ad.cirrus.com
 [141.131.65.67])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6351E45D;
 Mon, 26 Jul 2021 22:35:51 +0000 (UTC)
From: David Rhodes <drhodes@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <ckeepax@opensource.cirrus.com>, 
 <brian.austin@cirrus.com>, <patches@opensource.cirrus.com>,
 <alsa-devel@alsa-project.org>, <david.rhodes@cirrus.com>
Subject: [PATCH v4 0/2] Cirrus Logic CS35L41 Amplifier
Date: Mon, 26 Jul 2021 17:34:36 -0500
Message-ID: <20210726223438.1464333-1-drhodes@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: O9LzTRnajrmMpwgHYPN-UqTcLJluQ1xU
X-Proofpoint-GUID: O9LzTRnajrmMpwgHYPN-UqTcLJluQ1xU
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107260133
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

v4 changes:
Fixed spacing for bracketed declarations
Fixed comment style in headers
Moved private struct from include/sound to local cs35l41.h
Reordered probe operations:
1) hardware errata
2) INT pin config
3) INT mask config
4) IRQ registration
Moved set_pdata from component_probe to probe
Set initial state of AMP_EN bit and corresponding DAPM widget to off
Rename invert-pcm DT prop to invert-class-d
Change return code handling in IRQ
Use constants for regulator num supplies
Error message for no SPI dev in spi_otp_setup
Restore 0 initializers in IRQ per Charles's comments

David Rhodes (2):
  ASoC: cs35l41: CS35L41 Boosted Smart Amplifier
  ASoC: cs35l41: Add bindings for CS35L41

 .../devicetree/bindings/sound/cs35l41.yaml    |  398 ++++
 include/sound/cs35l41.h                       |   60 +
 sound/soc/codecs/Kconfig                      |   12 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/cs35l41-i2c.c                |  116 ++
 sound/soc/codecs/cs35l41-spi.c                |  145 ++
 sound/soc/codecs/cs35l41-tables.c             |  612 ++++++
 sound/soc/codecs/cs35l41.c                    | 1775 +++++++++++++++++
 sound/soc/codecs/cs35l41.h                    |  777 ++++++++
 9 files changed, 3899 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l41.yaml
 create mode 100644 include/sound/cs35l41.h
 create mode 100644 sound/soc/codecs/cs35l41-i2c.c
 create mode 100644 sound/soc/codecs/cs35l41-spi.c
 create mode 100644 sound/soc/codecs/cs35l41-tables.c
 create mode 100644 sound/soc/codecs/cs35l41.c
 create mode 100644 sound/soc/codecs/cs35l41.h

-- 
2.25.1

