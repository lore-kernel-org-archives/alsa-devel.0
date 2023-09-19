Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1441FCD54AF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 10:35:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CE3BE91;
	Tue, 19 Sep 2023 12:34:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CE3BE91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695119730;
	bh=6F4ggMJ1W0fTmojN6EFM4umQJ1WShp6yjsPysO+2JKw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W7CSkRszoomFkMbG2AX7x3s14nKFFKLstvIhlBT5AGQhHEtOg+s1WICBmWJRj+pOL
	 o5f3ey4CZodx3sMbVTv1OEqnG3/aKW4Lvee84WVRY4mil9qPJU4hdbbavOECV5tZVL
	 iThISikcOX2+DMr/lMFuJUOSzpy/MMIt5eq6/zA0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44453F805F7; Tue, 19 Sep 2023 12:31:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB3BDF805F9;
	Tue, 19 Sep 2023 12:31:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 973F2F805BE; Tue, 19 Sep 2023 12:31:45 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C89F1F80494
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 12:31:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C89F1F80494
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=gj0IaAdg
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38J4KMBx022193;
	Tue, 19 Sep 2023 05:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=XWaDlUm1G2+lS5Ldj7tMDOZUpoSf6T1n5pH2Bcq1VbM=; b=
	gj0IaAdgfDJwXjEaX/MNjQEs6BVcWvypoLElxQRWDKIo+5ksxEsmxbWXMXloamot
	bRyBA0owMAMuYcIC9tePcnFBTOBQXf6ldA50X3CsEhbKlVGHb8xr0NyIFv2o1u+y
	5fY0cSrAP2Yb5ovcGGD+VUp6k1bgGBkoOKbJBSSLHTMQq3BZywpciAq2QD4ADZV+
	TCEa2h4SA+qTTYbXsWxD4ZVrS48i3XLvh0GufePH5P3mvwUAZbjDIwjiQcuulcGL
	jzLLTDUoi+izjgkHcLaAJe34k3NYbvmuAR5VBg0AES4jVS3LttLRsGqswff4mYq0
	4/yT6voj0ACNHuwBLZusUw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry3p1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 05:31:18 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 19 Sep
 2023 11:31:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 19 Sep 2023 11:31:16 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 687AA11AB;
	Tue, 19 Sep 2023 10:31:16 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: cs42l43: Lower default type detect time
Date: Tue, 19 Sep 2023 11:31:13 +0100
Message-ID: <20230919103116.580305-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230919103116.580305-1-ckeepax@opensource.cirrus.com>
References: <20230919103116.580305-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Vb5_nkygpPqi3BLsPa2oIiMbceG1AAnS
X-Proofpoint-ORIG-GUID: Vb5_nkygpPqi3BLsPa2oIiMbceG1AAnS
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: TEQGGNVOLV65CPGWSG4HDUK3ISJELLIT
X-Message-ID-Hash: TEQGGNVOLV65CPGWSG4HDUK3ISJELLIT
X-MailFrom: prvs=4626caf035=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TEQGGNVOLV65CPGWSG4HDUK3ISJELLIT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The current default is a little excessive, reduce the pop on insertion
by reducing the time a little. The new value of 1000uS is still pretty
conservative.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43-jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index 92e37bc1df9dc..7008e50eded96 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -110,7 +110,7 @@ int cs42l43_set_jack(struct snd_soc_component *component,
 		priv->buttons[3] = 735;
 	}
 
-	ret = cs42l43_find_index(priv, "cirrus,detect-us", 10000, &priv->detect_us,
+	ret = cs42l43_find_index(priv, "cirrus,detect-us", 1000, &priv->detect_us,
 				 cs42l43_accdet_us, ARRAY_SIZE(cs42l43_accdet_us));
 	if (ret < 0)
 		goto error;
-- 
2.39.2

