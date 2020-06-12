Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B7C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:00:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F80206D7
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vLJqLCMr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LQHBTYtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F80206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 665F9166E;
	Fri, 12 Jun 2020 10:59:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 665F9166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591952418;
	bh=DvU6P+H3FGui+zRRkpyGqss1ejPkBQSpyHH1sPtUDho=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLJqLCMra+waIzkZiz7vW3vcarlOTzcTdCvv1n1s6JjqN6PPUYa7hE554FF7CGsTw
	 N+I5ZthBP4Kkq9gHC18iwAvbwLcX5scOjpXqhDmONfWeN70AVlttymekqUEw758mU3
	 ysaSdR34dmfbuzZa3fWXRwshS1mS4d2yYtbpaYxw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAF62F800CC;
	Fri, 12 Jun 2020 10:58:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CB0CF80279; Fri, 12 Jun 2020 10:58:36 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1ECFAF80058
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 10:58:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ECFAF80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LQHBTYtc"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05C8wRRP017075;
 Fri, 12 Jun 2020 03:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1591952307;
 bh=ccAR2l5UfUJRa3XDJKA2gVG365Re+jn/ntZxzTY+wzw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LQHBTYtcQRRiMBkoBbmt5QTSCZiTxglvQmDu07rb5gbF9nUXOKZdZ/h3dcvs7JofN
 cyVz0klBPlGss0jUZu0LsV18C8w7Cc6l7zE7OAI/+QtLRnacZyUEqX4agQ2bqrwP41
 HgmSc4iw6nn+QveF9R0JFlAuRtg8nUaTyeWyaV/o=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05C8wRuu026607;
 Fri, 12 Jun 2020 03:58:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 03:58:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 03:58:26 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05C8wMMK036678;
 Fri, 12 Jun 2020 03:58:25 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH v3 1/3] ASoC: ti: davinci-mcasp: Specify stream_name for
 playback/capture
Date: Fri, 12 Jun 2020 11:59:07 +0300
Message-ID: <20200612085909.15018-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200612085909.15018-1-peter.ujfalusi@ti.com>
References: <20200612085909.15018-1-peter.ujfalusi@ti.com>
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

In order to dai stream widgets to be created the stream_name must be set.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index b93c1ee302c0..617440767c45 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1623,12 +1623,14 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		.name		= "davinci-mcasp.0",
 		.probe		= davinci_mcasp_dai_probe,
 		.playback	= {
+			.stream_name = "IIS Playback",
 			.channels_min	= 1,
 			.channels_max	= 32 * 16,
 			.rates 		= DAVINCI_MCASP_RATES,
 			.formats	= DAVINCI_MCASP_PCM_FMTS,
 		},
 		.capture 	= {
+			.stream_name = "IIS Capture",
 			.channels_min 	= 1,
 			.channels_max	= 32 * 16,
 			.rates 		= DAVINCI_MCASP_RATES,
@@ -1642,6 +1644,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		.name		= "davinci-mcasp.1",
 		.probe		= davinci_mcasp_dai_probe,
 		.playback 	= {
+			.stream_name = "DIT Playback",
 			.channels_min	= 1,
 			.channels_max	= 384,
 			.rates		= DAVINCI_MCASP_RATES,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

