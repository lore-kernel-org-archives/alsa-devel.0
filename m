Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9185C43457
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:39:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE531208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HrrRNwn3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DOEFf+BZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE531208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7DA11800;
	Fri, 16 Oct 2020 19:38:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7DA11800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602869951;
	bh=IxleBAzyaOz9FIbf0yzIQ5tTDPmJiDhyRtD44QtP7Gk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HrrRNwn3/LXXnndxQ/riUSPur7JUSHbxN9633GSq4OXIYV29YspJHJGIKP3MH10Ak
	 zI6t9Ku8ZEzn584dpDpAZ6uw0EnEGJKgvb9cM8Ybk5ZlezwzKKhrYcC2Y2VDYbtfom
	 qj7u8/Pu0rUQlZuL02KoRPO6YWUVVr0Ck5Os6x4w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CADF8F80299;
	Fri, 16 Oct 2020 19:36:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AAA6F80226; Fri, 16 Oct 2020 19:36:00 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB87CF80226
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 19:35:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB87CF80226
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="DOEFf+BZ"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09GHQLpd024369; Fri, 16 Oct 2020 12:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=rEkfyGQEhOwwT47AjLx9+bGijiBq7azRzUX3JTht/hM=;
 b=DOEFf+BZhFqkJCxsy+1swort0Ps+sidwnlrI2C3ID8aTUlmNpve+MHk9U+/Mv/48Fzs1
 XeA4SMDumxvjIztM+f68uARNMKdSs72u20rV8WphiJK8/paiV3rIxN8LWp8Cgce6bYHf
 TlGt+e3mbGn7e09k9iF601zLN+lTGmmNwLOP+t0xH3VZHb2gVCyY7gDDiTzgm26orVGA
 66IcnvJgHlntXbINvhkcDxHfNBA4qEPdNJYLb4PZ1d3vwTItmn0yFZnY5C4KVxfB4sC6
 ysj3T99BqrnkfsDMdBUUXyRTjuc1Klza36VrDhl0E9EHDxkfzBRCSQWr2H9cEEr91BrV Hw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 343ac20jk8-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 16 Oct 2020 12:35:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 16 Oct
 2020 18:35:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 16 Oct 2020 18:35:46 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com
 [198.61.64.143])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 750472C6;
 Fri, 16 Oct 2020 17:35:46 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <nsaenzjulienne@suse.de>
Subject: [PATCH v2 5/7] ASoC: madera: Allow codecs to be selected from kernel
 config
Date: Fri, 16 Oct 2020 18:35:39 +0100
Message-ID: <20201016173541.21180-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016173541.21180-1-rf@opensource.cirrus.com>
References: <20201016173541.21180-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=873 clxscore=1015
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

The codec Kconfig options were hidden and intended to be selected by
the machine driver that requires them. But that means having either a
dedicated machine driver or building all codecs.

This patch makes the Kconfig options visible so that they can be
selected independently of the machine driver, allowing the codec to be
used with simple-card and other machine drivers that are not hardcoded
to use a fixed set of codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4a8d503bdd38..e0aed608dbc3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -658,23 +658,23 @@ config SND_SOC_CS4349
 	depends on I2C
 
 config SND_SOC_CS47L15
-	tristate
+	tristate "Cirrus Logic CS47L15 CODEC"
 
 config SND_SOC_CS47L24
 	tristate "Cirrus Logic CS47L24 CODEC"
 	depends on MFD_CS47L24
 
 config SND_SOC_CS47L35
-	tristate
+	tristate "Cirrus Logic CS47L35 CODEC"
 
 config SND_SOC_CS47L85
-	tristate
+	tristate "Cirrus Logic CS47L85 CODEC"
 
 config SND_SOC_CS47L90
-	tristate
+	tristate "Cirrus Logic CS47L90 CODEC"
 
 config SND_SOC_CS47L92
-	tristate
+	tristate "Cirrus Logic CS47L92 CODEC"
 
 # Cirrus Logic Quad-Channel ADC
 config SND_SOC_CS53L30
-- 
2.20.1

