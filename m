Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A543C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:56:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AF520829
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EgP8oo9C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IOqH2X26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AF520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AD8F166A;
	Thu, 10 Sep 2020 09:55:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AD8F166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599724594;
	bh=DhKLrY4b+xFqZ5L1PR3bzgCSg1nWwMMfzNWutff8UFw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EgP8oo9C7TwM6Tf3JUqR55MVtcHxdxAWRdOaQeHWanPBaOtaWdAUJSpqTUB65bt4t
	 bkoQHP8zpwdWF4B4zKHokud3NjOtDZcyeWo9WSC5xJNEM3ItrU8kst2Bc7sfkuCYtg
	 2ziZ6stzDINxZcDkBOWDTbS7DBZIw6p/mHPPFnOQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0319F80272;
	Thu, 10 Sep 2020 09:54:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4893EF800D0; Thu, 10 Sep 2020 09:54:49 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02B0CF801F2
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 09:54:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02B0CF801F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IOqH2X26"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08A7sen9078068;
 Thu, 10 Sep 2020 02:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1599724480;
 bh=xLqhM8JuqWpOLMHetzz/8/24VkctoaW/pS2UjG1I9j0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IOqH2X26tjkpkVPLBtpXQLFa0xKbnADsV53eCehLtJlDidoAlrsbZM5oIpPkPt2Si
 33/J6ruOJ/ZuSSmsUugEAly3/FZwgxc9WHel6iN0GlnEinS5HEjWsWoaloIO+iNBMl
 Re74c0JC1DYdpZ1Dc5Mfhe/KXYJZipznuZ0xVGxk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08A7se6s086300
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Sep 2020 02:54:40 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 02:54:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 02:54:39 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08A7sXCU123142;
 Thu, 10 Sep 2020 02:54:38 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH 2/2] ASoC: ti: j721e-evm: Add support for j7200-cpb audio
Date: Thu, 10 Sep 2020 10:54:33 +0300
Message-ID: <20200910075433.26718-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910075433.26718-1-peter.ujfalusi@ti.com>
References: <20200910075433.26718-1-peter.ujfalusi@ti.com>
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
index cb074af47a7d..f66674fd5f64 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -525,6 +525,14 @@ static const struct j721e_audio_match_data j721e_cpb_ivi_data = {
 	},
 };
 
+static const struct j721e_audio_match_data j7200_cpb_data = {
+	.board_type = J721E_BOARD_CPB,
+	.num_links = 2, /* CPB pcm3168a */
+	.pll_rates = {
+		[J721E_CLK_PARENT_48000] = 2359296000, /* PLL4 */
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

