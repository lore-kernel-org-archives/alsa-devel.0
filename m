Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7396FCD80A1
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Oct 2023 10:26:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04B381285;
	Tue, 10 Oct 2023 12:25:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04B381285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696933574;
	bh=Ol2n8qfwHjlN8M1tiK/TGEuDdE8TekYwXdvIb+35Ml8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I9c86zR5224cdT6oRsQLx59r2XcEJWlWaP1FHpf7swJNH/6W1niV+aKMntchZgvSd
	 bK8hSxniwG9F7uM/ttNyCKUeV2yPmHR1I+ZhAoqZBGUmNsYtIMNdkUYKW8MuWIscjS
	 dglTYLcvi6Q8euOXFzmSMRvQqCXjJh7iy9xyr6eo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1DF50F8055A; Tue, 10 Oct 2023 12:24:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A252CF80553;
	Tue, 10 Oct 2023 12:24:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D70A5F80310; Tue, 10 Oct 2023 12:24:35 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3DDAF80166
	for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2023 12:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3DDAF80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=WQjsiKww
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39A7lgWR020417;
	Tue, 10 Oct 2023 05:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=w3b3+6R0F1QShjM+MNfhDHhJ14lnXJRd0dtRxOHVNgc=; b=
	WQjsiKww/WM27AwPCANzMRLvw6hfjWL3ILGqBB83l+REtbGMfc7AWmPv7uN4kIMH
	/YnGtXCnIIhWJCk9RWQZwG5QU024KaCmm8rpyHMYWxdcUCnrHC3V/M0ZxORMJtmk
	UhH+CMO00HL1ydz9C6MTJJCyAyZNAD/ov4EseApOHoCnNHL/549nAEYTk5OUrLAW
	uQlsNQ/pQkgMwGr9SmAyl20PzmTXEk5Ig8O6NE04GJcX+veiXUAU7Qjzfei0ng7y
	PGrslwDXFFkAP2PS4prJaEVEvKnykyJsDxtpY6/cKDqoUY4Nac558+sAzV+JVd92
	xnf82B95DR5nvi34vmSFLA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tkhhaj8w1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 05:24:28 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 10 Oct
 2023 11:24:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 10 Oct 2023 11:24:26 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F61911AC;
	Tue, 10 Oct 2023 10:24:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/2] ASoC: cs42l43: Update values for bias sense
Date: Tue, 10 Oct 2023 11:24:25 +0100
Message-ID: <20231010102425.3662364-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010102425.3662364-1-ckeepax@opensource.cirrus.com>
References: <20231010102425.3662364-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Hp2yAx6ccrLF2oxyPrSAfKjc2JmtXXU8
X-Proofpoint-GUID: Hp2yAx6ccrLF2oxyPrSAfKjc2JmtXXU8
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: YUMIGADEWHJ3C72NNOD3RL4ERR7XLOSY
X-Message-ID-Hash: YUMIGADEWHJ3C72NNOD3RL4ERR7XLOSY
X-MailFrom: prvs=5647b14960=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YUMIGADEWHJ3C72NNOD3RL4ERR7XLOSY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Due to an error in the datasheet the bias sense values currently don't
match the hardware. Whilst this is a change to the binding no devices
have yet shipped so updating the binding will not cause any issues.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Just rebased on v6.6-rc5.

Thanks,
Charles

 sound/soc/codecs/cs42l43-jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index 92e37bc1df9dc..9f5f1a92561d1 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -34,7 +34,7 @@ static const unsigned int cs42l43_accdet_db_ms[] = {
 static const unsigned int cs42l43_accdet_ramp_ms[] = { 10, 40, 90, 170 };
 
 static const unsigned int cs42l43_accdet_bias_sense[] = {
-	14, 23, 41, 50, 60, 68, 86, 95, 0,
+	14, 24, 43, 52, 61, 71, 90, 99, 0,
 };
 
 static int cs42l43_find_index(struct cs42l43_codec *priv, const char * const prop,
-- 
2.39.2

