Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A0C88E77
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:30:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC1006023F;
	Wed, 16 Sep 2026 08:30:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC1006023F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540221;
	bh=kDlMbxzbfpUkEg5KF6YuM5b1sNPU98Tyb41guAP4tRg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Kz16EaBqero6Ti/YMmKdUAa4Dhb5UndI+cYMNzLzRCJafh0ihZM2flI07E/OmOCJe
	 ULi7l4ASLr4fA73FJpYHPcwSTU6ZHMwWW7BB8U7frWVBEBbbLulXW1i+RlhbF2NXHp
	 N3F2l5nLN6ZmRahsRvCYKHMRkPi+TQItBFjy+ieE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE7DCF80654; Wed, 16 Sep 2026 08:29:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B52DF80696;
	Wed, 16 Sep 2026 08:29:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EC3DF8049C; Mon, 14 Sep 2026 03:57:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.62
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789351027;
	b=AlHpm91iAegTjlcX9MoBn0vDaJb3EuTUO6fpmV0JoAmq++Q9T+wvhURdGVWZYNMTH5U0
	 i6JlLqMqVwTf9ULtsVT9q3nisjSqw6LGq4SUfP0sdg8dUqC3u+uZeFLv7SPSaOJNkPNsY
	 sFkNmvKpF+V7ybWazz816IngrUn9RITxiDSFkMtWhiR6sNscfpRJQecttBMy5lFLI8Kz3
	 0wGeiyWQF92X78Nzq08i4wVjy00rLd0VmIEpjJccj616v32s69Wer8t4o/+YtWudAcswN
	 PQIbtsJnLgAfP4MM5CY7LsXNXzS8/erH2R02vCz5hJolLrlDNvjK74S9aUv6roULgSA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789351027;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kDlMbxzbfpUkEg5KF6YuM5b1sNPU98Tyb41guAP4tRg=;
	b=ijn6Wa+WTRqndVC+JKb7osPy3xnPFC7TeatJssIvm2DBIGcWjHj5BRFIDo6gYXz5Ar/5
	 9WA8AQQ+ARbbLN0l3q849tfTPLRvidtJIU8SPeRKc4Bxx5Q9qKUarrTvXrmiJtGCAbZx3
	 QOLCxBKfKBQ8J+J0iqt3VrnjE9Lcv1Y1TyFBCMeAeT7tWem+z1SGra2J85gCVkb9JoBAk
	 fUjTd9AOXxzGjMQBjvP8GDZnP9gNjT5TkBCYQNFjoozTHxdw9xY8qNfAhtwjQPatzpm+3
	 bFHGfqiaZ3PFYPWNCeb50/Y3RekupW/PUw3obX6WXc5VyAKZsqltAFpxGW3JPojB8bw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=KaP3Q89B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.62
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 686C7F80217
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2026 03:57:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 686C7F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=KaP3Q89B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ7dDqZTednqqmkx10BWVlVFdzjebXInVX0WrzfAiau7tR1IFqDSgfiFwRknzhhPSdYFcK/jGQeGwYQEVtdGax1OgSzzaO+ar0/+cVTa5hAGQCVikdbYOFj1R1voAFhKtKSO/TnNIlwld0rPDrZRZeqB2DpIP7tIWzKv+G8tvMjTtX7MRpTZf342g6Cp4CnFQh4C2gGjS8CeH+7AXtU7Zo418AdclTVsPn8q/QZnmT9oERpHFas4s3akIjMxoD3IjiJen5pRL0ivvSXTxyWQiVF+XHBd797EsAr0Hq7C7I+xmBqN4+1XwN+gSn8duwjf5FaN6P/l84Gg9ENvzNwlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ijuNyx63mv5Vtx9n3EuW3O6VvF79aFEO4k2v+o3fJE=;
 b=aKnzMkjrMN65Gp01Vr5Owp84UTAuPGPWHs7OoRE2pYvANC09PFY7N1TyJCRa+rA0cirMr8mv9RWNP5CQfOdCLHBbvjX+fttvVCZjCEvz8r6Sa5CILcC+BQ7QeoG9wP406BQAX3gvUYWVxjxI+k1pV9k6TQ9Uq1VMkZXZ5V6fvwlb6kZ3FH0BbS0tmplS4BB5DPMDnd1wtnfrH+Zaeb8XLO2/ULJdsIq90l6cQTs9jKFND91gzLuU/UPzCXbwSQqWi83IK3gv6xH8VlB1zaV3GT/G8jIjcrr0W1kJGeBI/UjPzHtHeCw82/+Sqe4d3R8OLBlMU5bpo0OwdTY+9cOfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ijuNyx63mv5Vtx9n3EuW3O6VvF79aFEO4k2v+o3fJE=;
 b=KaP3Q89BWQVUQnHvhEQzbPKuOyG+O+cee3Y0FGf9VorW0Oz8fLV/ddf5Bogehcr19z2m2sqZwKLP4fMiWpvt6rHjwlAlfWLQ0T5XiIw1NOik/wztR1AtVsbaQp++H2QNnSBKtsH5hBwtz2ECGiufLQDaDrYKmHGdz514wzhHbMFECNldJIoik8yQGGnMweUgWnEEBKpDwu5LvcK0y8n/1aIoRUPNCcU3j/Ab2YH25DixeWwXrbL6HruvbXrAW3yGwgQ60EucuReLnBaZZeXkyPWRwCpolFKzL+RrQDFYghk9uy6kOr67u9ZB6QGT/sQ7AOhHPmmxBoKUcjA+/lmAZQ==
Received: from OSTP286CA0104.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:219::18)
 by SEYPR03MB7681.apcprd03.prod.outlook.com (2603:1096:101:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 01:56:56 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:604:219:cafe::2e) by OSTP286CA0104.outlook.office365.com
 (2603:1096:604:219::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 01:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 01:56:54 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 14 Sep
 2026 09:56:52 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 14 Sep
 2026 09:56:51 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Mon, 14 Sep 2026 09:56:51 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <error27@gmail.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>, Sashiko AI <sashiko-bot@kernel.org>
Subject: [PATCH v5 2/2] ASoC: codecs: nau8360: Fix AB-BA deadlock in mux
 update
Date: Mon, 14 Sep 2026 09:56:48 +0800
Message-ID: <20260914015648.311986-3-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
References: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|SEYPR03MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f18ab0b-f820-4a56-9950-08df120373bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	RYJc7Mk494Sz8aAti94ZAFNf0++euf6yCQjJeLp0OfHnbi9kmLroEPZXS8W2Zhh/wkdVq2wZHQtCC0q+MTENVRIgsGN+kwVtG8oD+i0lN/ehjL0+9DDiDBSX7856L2j7ksHRTRIlMbHRgKHf9p9fkursB0hM36xBMkqIUEBCUJ8xa1Dy/YmoVbADpZ6f5V2MyR7To7h2lZSxV+omhKV4QRrI3qDwKHuhpVtezAOV+oe2oUxid/OogUM8qIvvuJ43KcxhJaouj0Gqqm5cKRftqOtKZYoaGzXYTQ0hmeoh76g1c2pNelBJYRJwqTc4VEzD4DfqUfxA9u3l3lQ3jR5IKDUVXB5YGRniW/N7XIin2vhyK1kgoX4PbzRfOn9HTQA5XrY0tZJgtuVJ/63Bh6SooW6YNo7LP75V1TnGKDdYew2T1q5dwhZQv2mP1ejBsB8YeLdLKc7JFQE4DYGsVrOH7iP0dUNgMLBS/SU/krWuW0S8a8EJaSzQpD7tAvBMEf2Vwh4adFNKasHoqkhgy+mDY5E03BuqIhIT2zLG/Xgqjsgy7x554fwlY3v1Nr8z6YpS24fmdjfQpyZwKR59VfGlkOQEDhDIxehbTlyliTDA8Qly+OSY1+Br5XyWq6hiprBdLmwjeZUoxk7Rgk8h+MCiFw==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	a1M5y28RhkRSe3thHOAfh2hl4RMPErs7roA7PtrAm6r3ZKb0sWLXXDRvPKr7kY2C1YUamjafh+D4e07Kej2svirmZJ4UvSVMOHBSI11T+UFhrQ/9rNApTljMGseUGLiu3BPMx1nMnnMyn2w7xBZMorgQv2XgHf7dYMA2JykXwI9pJHQ/se99Wui3jxASz3xdLwa8ifTqyRT6yYiPdPML/dHNJXCsSNap2O46Kk2vp9l8NWckwle4bU76tAlLq60CAmziEQcI37NrE6TFpdN6i3DuyGzsfmR43uicyfqfjitLDVo1ff7+FPfwqXJRWJuZnyyCFea4DPq0QUqYoiAj/uC5v51qD6StnKsMJriA7+s+nYDP/XuDOaDXGYDAOdNLjvtXaSCKt73RdlIwAfktenGnEpJlRpaPS4Lte+/ashOs9ny8M2+LdIv8f3w4cRhR
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 01:56:54.5102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0f18ab0b-f820-4a56-9950-08df120373bf
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7681
X-MailFrom: YLCHANG2@nuvoton.com
X-Mailman-Rule-Hits: implicit-dest
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: 4E4O5NFCO5QEBLFY5NDVMZFLK3RPLYZG
X-Message-ID-Hash: 4E4O5NFCO5QEBLFY5NDVMZFLK3RPLYZG
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:29:07 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4E4O5NFCO5QEBLFY5NDVMZFLK3RPLYZG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

nau8360_dac_mux_put_enum() acquires nau8360->lock before the DAPM mutex,
causing an AB-BA lock inversion. This deadlocks with concurrent stream
startups or mixer updates, which acquire locks in the reverse order.

Fix this by replacing nau8360->lock with the DAPM mutex to protect
pre-checks, releasing it before calling snd_soc_dapm_put_enum_double().

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260908030342.222655-1-YLCHANG2@nuvoton.com?part=1
Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index f5dee12127cd..f0942739d7ab 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -689,6 +689,8 @@ static void nau8360_dsp_switch(struct snd_soc_component *component, bool enable)
 	struct regmap *regmap = nau8360->regmap;
 	int value = NAU8360_PEQ_BAND_8;
 
+	mutex_lock(&nau8360->lock);
+
 	/* If DSP is enabled, unstall HW3 engine and DSP, loading DSP firmware,
 	 * and configure PEQ after dsp reset.
 	 */
@@ -702,6 +704,7 @@ static void nau8360_dsp_switch(struct snd_soc_component *component, bool enable)
 	regmap_update_bits(regmap, NAU8360_R9D_PEQ_CTL, NAU8360_PEQ_BAND_MASK,
 		value << NAU8360_PEQ_BAND_SFT);
 
+	mutex_unlock(&nau8360->lock);
 }
 
 static int nau8360_dac_mux_put_enum(struct snd_kcontrol *kcontrol,
@@ -714,27 +717,26 @@ static int nau8360_dac_mux_put_enum(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	int ret = 0;
 
+	snd_soc_dapm_mutex_lock(dapm);
 	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
 		dev_warn_ratelimited(nau8360->dev, "changing path is not allowed during playback");
+		snd_soc_dapm_mutex_unlock(dapm);
 		return -EBUSY;
 	}
 
 	if (item[0] == NAU8360_DAC_SRC_DSP && !nau8360->load_fw_done) {
 		dev_warn_ratelimited(nau8360->dev, "Cannot enable DSP: Firmware not ready or disabled\n");
+		snd_soc_dapm_mutex_unlock(dapm);
 		return -EBUSY;
 	}
-
-	mutex_lock(&nau8360->lock);
+	snd_soc_dapm_mutex_unlock(dapm);
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
 	if (ret <= 0)
-		goto unlock;
+		return ret;
 
 	nau8360_dsp_switch(component, snd_soc_enum_item_to_val(e, item[0]));
 
-unlock:
-	mutex_unlock(&nau8360->lock);
-
 	return ret;
 }
 
-- 
2.25.1

