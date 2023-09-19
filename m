Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E00CD54B2
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 10:34:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAE7FE7F;
	Tue, 19 Sep 2023 12:33:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAE7FE7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695119657;
	bh=l09yDGcnzXEeClNs/xS4QqbqsXVO9LM/UmCa6wNknfA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nqBhLPx0TWBAbuIV/khuA9X1Nw/F14DCHN5L2xzIJljS7ZgwVgWSDqts6gYjXrPVf
	 kt7XPxkGCnKUvsQYvRbhs1vUXjIccvIblLJ8VKW0pERo83SEzPgvlAjHruIM61jaoy
	 Yua+bvCEYtS4e9/T/GwOnNaJB5httPp1mdvWeLwY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8EE80F805C0; Tue, 19 Sep 2023 12:31:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 230D5F805C1;
	Tue, 19 Sep 2023 12:31:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32CE2F805B4; Tue, 19 Sep 2023 12:31:40 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1D56F80551
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 12:31:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1D56F80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=dVKV51Ha
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38J4RRCa031661;
	Tue, 19 Sep 2023 05:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=ny+kWn1OMlivpfvutLz7uBLYoUEzNwaJVd7DQn728FU=; b=
	dVKV51Havk5/WNH/QT+i0Vnpw9LMTidMz8S21LCVuuyuDgAZl54feif4sUlfc0T7
	xM3CMZPE3a4EhHX1AZPZj+MACubTZJLaHrN0WIXOYoaZxeUw7wvDVjFQyU53CSX0
	Mm/iKKB2FkqgXqrXOytr4JgVRIcHT/+ncgQ6mrfBjT2xfUcvTFtqr1Uh8xuUjW58
	cNu5LEQ75vNmPi3FGVjbOY/9T3ZF1U1XbuWjSkOUqz5fMrHK6+XkKKmUrI97fSXE
	Ea9AXn5hfgfIF2N3OCG8ZfEgdeko6TQQGG6tx/3FB52ARKzDMjsXfl2Twqu4LF+e
	OqTse3kp9QX2K5aw66QTqg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry3p1h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 05:31:19 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 19 Sep
 2023 11:31:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 19 Sep 2023 11:31:16 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 594983563;
	Tue, 19 Sep 2023 10:31:16 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/5] dt-bindings: ASoC: cirrus,cs42l43: Update a couple of
 default values
Date: Tue, 19 Sep 2023 11:31:12 +0100
Message-ID: <20230919103116.580305-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230919103116.580305-1-ckeepax@opensource.cirrus.com>
References: <20230919103116.580305-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: adsKyA2nt2mWX-skmmLzAT8VMQg0zPlt
X-Proofpoint-ORIG-GUID: adsKyA2nt2mWX-skmmLzAT8VMQg0zPlt
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: SSYKCCKP2MR7FDBGX7HAUUJSQWE2TQBS
X-Message-ID-Hash: SSYKCCKP2MR7FDBGX7HAUUJSQWE2TQBS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SSYKCCKP2MR7FDBGX7HAUUJSQWE2TQBS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The bias sense is being enabled by default in the driver, and the
default detect time is being dropped slightly. Update the binding
document to match.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
index 7a6de938b11d1..4fa22fa70ace5 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
@@ -83,7 +83,7 @@ properties:
       Current at which the headset micbias sense clamp will engage, 0 to
       disable.
     enum: [ 0, 14, 23, 41, 50, 60, 68, 86, 95 ]
-    default: 0
+    default: 14
 
   cirrus,bias-ramp-ms:
     description:
@@ -97,7 +97,7 @@ properties:
       Time in microseconds the type detection will run for. Long values will
       cause more audible effects, but give more accurate detection.
     enum: [ 20, 100, 1000, 10000, 50000, 75000, 100000, 200000 ]
-    default: 10000
+    default: 1000
 
   cirrus,button-automute:
     type: boolean
-- 
2.39.2

