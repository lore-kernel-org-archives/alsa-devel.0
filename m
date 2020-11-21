Return-Path: <SRS0=zJPj=E3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594DFC63697
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Nov 2020 16:17:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C297420936
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Nov 2020 16:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lM5F6gQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C297420936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 570C616C1;
	Sat, 21 Nov 2020 17:16:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 570C616C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605975422;
	bh=2Uz++c+3eNf83e7X4VaWRqvvh2dumvwumyjr6NfDMd4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lM5F6gQIOSCVEP5iO4Aw9NWpRHDSbROHNhX9MmOwC3CzM2LCcrXkCdR3frL1uI94o
	 0xmHswnaJzF7L3D+vwA8y1fzul4izyu5P6WHa8TKNfYLX4v1GB4zXSPzaVD8j5VLJ1
	 bfXRbalLnD5sVtDkp3r+z7Xp3IzdAEjvY38SDgBI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07E0EF80169;
	Sat, 21 Nov 2020 17:15:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C253F80249; Sat, 21 Nov 2020 17:15:22 +0100 (CET)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BE29F80169
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2020 17:15:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BE29F80169
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0ALGB6O2011816; Sat, 21 Nov 2020 11:15:12 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com with ESMTP id 34y08urk58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Nov 2020 11:15:11 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0ALGFA1M012651
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
 verify=FAIL); Sat, 21 Nov 2020 11:15:10 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Nov 2020 08:15:09 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Nov 2020 08:13:43 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Nov 2020 08:15:08 -0800
Received: from NSA-L01.ad.analog.com ([10.32.226.88])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ALGF2x4028455;
 Sat, 21 Nov 2020 11:15:06 -0500
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To: <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH 1/2] ASoC: stm32: dfsdm: add stm32_adfsdm_dummy_cb() callback
Date: Sat, 21 Nov 2020 17:14:56 +0100
Message-ID: <20201121161457.957-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201121161457.957-1-nuno.sa@analog.com>
References: <20201121161457.957-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-21_04:2020-11-20,
 2020-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210111
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Olivier Moysan <olivier.moysan@st.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi
 Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@kernel.org>
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

Adapt STM32 DFSDM driver to a change in iio_channel_get_all_cb() API.
The callback pointer becomes a requested parameter of this API,
so add a dummy callback to be given as parameter of this function.
However, the stm32_dfsdm_get_buff_cb() API is still used instead,
to optimize DMA transfers.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 sound/soc/stm/stm32_adfsdm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index ec27c13af04f..fb9df3caba12 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -295,6 +295,16 @@ static int stm32_adfsdm_pcm_new(struct snd_soc_component *component,
 	return 0;
 }
 
+static int stm32_adfsdm_dummy_cb(const void *data, void *private)
+{
+	/*
+	 * This dummmy callback is requested by iio_channel_get_all_cb() API,
+	 * but the stm32_dfsdm_get_buff_cb() API is used instead, to optimize
+	 * DMA transfers.
+	 */
+	return 0;
+}
+
 static struct snd_soc_component_driver stm32_adfsdm_soc_platform = {
 	.open		= stm32_adfsdm_pcm_open,
 	.close		= stm32_adfsdm_pcm_close,
@@ -337,7 +347,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iio_ch))
 		return PTR_ERR(priv->iio_ch);
 
-	priv->iio_cb = iio_channel_get_all_cb(&pdev->dev, NULL, NULL);
+	priv->iio_cb = iio_channel_get_all_cb(&pdev->dev, &stm32_adfsdm_dummy_cb, NULL);
 	if (IS_ERR(priv->iio_cb))
 		return PTR_ERR(priv->iio_cb);
 
-- 
2.17.1

