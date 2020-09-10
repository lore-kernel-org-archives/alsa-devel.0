Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F66C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:43:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A3D208FE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lkq+d26C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aDN7IJvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A3D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C0A616A9;
	Thu, 10 Sep 2020 14:43:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C0A616A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599741833;
	bh=WqqZH0xAnODqJ6/xfeqrewIqPRF+xxip69n19e1OJ7w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lkq+d26Cc6BNYiQ6Sc2D6y3AvnbUEsuUGH2RZ3e1NM7IlX0CS+ZNj+eSwj9Z4fD02
	 YXj5U8o+1msZgsNyA0VARHSCh/+Yqmv2HvVFwg+jGJqVT3B7SSq2gc31oGZu4wJMmd
	 mdCsF6RXEUrXtY3XzV2vtQAti7KiK6KX4EcKYRZw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AABEF802C2;
	Thu, 10 Sep 2020 14:41:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A7B0F802C3; Thu, 10 Sep 2020 14:41:28 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F1E9F80272
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 14:41:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F1E9F80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aDN7IJvE"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfGmB058834;
 Thu, 10 Sep 2020 07:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1599741676;
 bh=IUYzQQqshxSh8qleqqCtf7r2HRvFn42iOSU0wPIKUbo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aDN7IJvEekqZAiO7vsV+56kEMaWvcSm9rJJkdH7790BCE0ZYsdrYdaBo2rVK/cyHi
 p85pkBzHAhFIVEjxL6qsb/Fzo6j++uanEGsbydPseAhdu1v+ktp89PEBEz4xFVAQYW
 sPoF9+YrMbeOj0A099XALkM77q9TPy8/nZJMpobM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08ACfGgt058080
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Sep 2020 07:41:16 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 07:41:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 07:41:16 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfAGO024223;
 Thu, 10 Sep 2020 07:41:14 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] ASoC: ti: j721e-evm: Add support for j7200-cpb audio
Date: Thu, 10 Sep 2020 15:41:10 +0300
Message-ID: <20200910124110.19361-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910124110.19361-1-peter.ujfalusi@ti.com>
References: <20200910124110.19361-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

When j7200 SOM is attached to the CPB we only have parent clock for 48KHz
family and the rate of the parent clock is 2359296000Hz.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/j721e-evm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index cb074af47a7d..29b73303f3fc 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -525,6 +525,14 @@ static const struct j721e_audio_match_data j721e_cpb_ivi_data = {
 	},
 };
 
+static const struct j721e_audio_match_data j7200_cpb_data = {
+	.board_type = J721E_BOARD_CPB,
+	.num_links = 2, /* CPB pcm3168a */
+	.pll_rates = {
+		[J721E_CLK_PARENT_48000] = 2359296000u, /* PLL4 */
+	},
+};
+
 static const struct of_device_id j721e_audio_of_match[] = {
 	{
 		.compatible = "ti,j721e-cpb-audio",
@@ -532,6 +540,9 @@ static const struct of_device_id j721e_audio_of_match[] = {
 	}, {
 		.compatible = "ti,j721e-cpb-ivi-audio",
 		.data = &j721e_cpb_ivi_data,
+	}, {
+		.compatible = "ti,j7200-cpb-audio",
+		.data = &j7200_cpb_data,
 	},
 	{ },
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

