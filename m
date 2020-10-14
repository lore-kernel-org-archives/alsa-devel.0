Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3687C433E7
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:57:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8030F212CC
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KxSvukYH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jxjvblyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8030F212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE8F6171F;
	Wed, 14 Oct 2020 16:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE8F6171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602687436;
	bh=/JCqfFPvIZQWy7zae1pFuf6ei7QWGAUqhJpcWb1CFGM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KxSvukYHSYLOkOukn0MqBlCWI8TgqlGIcEFqpEbM5z1GWTOiA4/paWlb4TbtqdLdP
	 +kHiAFCDi8U7gxGnJz3vZ2dq3Yb+UianJ3PBVSyjQPWrKmUWFHN4YiH5lj/epMFijM
	 LF48tTyw0MHQkTNsGAYCJZ/XximMZk8Y99Q9jIs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1647F8026C;
	Wed, 14 Oct 2020 16:54:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16CB5F8026D; Wed, 14 Oct 2020 16:54:50 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1DDFF80224
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 16:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1DDFF80224
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="jxjvblyt"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09EEpi82023902; Wed, 14 Oct 2020 09:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=PfQTmtHq+WI6K5BmMwZ1tOrR7fNGk/HI3b3fMtqo+rw=;
 b=jxjvblytI4yQ9MH61vjajfiLxnq2TvtBFMezOJZ38HrUGNUFoxxYV7e9JJJeSLcxp2NR
 1U0EndMf811qu5UdlBQaaJdPpn6een4Wwxeds5buMehfAmHvrvZXATghdbdw0SrbiSlN
 SCz8btFQGOu22uJq2r59DdMywQpPmktHauAuHegdjBRy75x59MLxwPMhr2xskYVsqTqV
 jb7LvTd7g3Ow6lzmnEDx9OUadrRXTXuP8M7hLLPWmbzPMPI09nXewP3m2tnuoUfEQTe6
 UzyZfIkZwfPraAFxgdrvX78ISep/HghC/3n/hXDa1MPibq6oiRTIF2WNV9nNMw6XIDs9 Gw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 343ac1wbwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 14 Oct 2020 09:54:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 14 Oct
 2020 15:54:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 14 Oct 2020 15:54:34 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com
 [198.61.64.143])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2DEFD45;
 Wed, 14 Oct 2020 14:54:34 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <nsaenzjulienne@suse.de>
Subject: [PATCH 4/7] ASoC: arizona: Allow codecs to be selected from kernel
 config
Date: Wed, 14 Oct 2020 15:54:15 +0100
Message-ID: <20201014145418.31838-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014145418.31838-1-rf@opensource.cirrus.com>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=743 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140108
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

The codec Kconfig options were hidden and intended to be selected by
the machine driver that requires them. But that means having either a
dedicated machine driver or building all codecs.

This patch makes the Kconfig options visible so that they can be
selected independently of the machine driver, allowing the codec to be
used with simple-card and other machine drivers that are not hardcoded
to use a fixed set of codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 34c6dd04b85a..4a8d503bdd38 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -661,7 +661,7 @@ config SND_SOC_CS47L15
 	tristate
 
 config SND_SOC_CS47L24
-	tristate
+	tristate "Cirrus Logic CS47L24 CODEC"
 	depends on MFD_CS47L24
 
 config SND_SOC_CS47L35
@@ -1484,11 +1484,11 @@ config SND_SOC_WM5100
 	depends on I2C
 
 config SND_SOC_WM5102
-	tristate
+	tristate "Cirrus Logic WM5102 CODEC"
 	depends on MFD_WM5102
 
 config SND_SOC_WM5110
-	tristate
+	tristate "Cirrus Logic WM5110 CODEC"
 	depends on MFD_WM5110
 
 config SND_SOC_WM8350
@@ -1657,7 +1657,7 @@ config SND_SOC_WM8997
 	depends on MFD_WM8997
 
 config SND_SOC_WM8998
-	tristate
+	tristate "Cirrus Logic WM8998 CODEC"
 	depends on MFD_WM8998
 
 config SND_SOC_WM9081
-- 
2.20.1

