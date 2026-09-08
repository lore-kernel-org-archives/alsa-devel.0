Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9A4C79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:04:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C422601E5;
	Tue,  8 Sep 2026 05:04:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C422601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788836688;
	bh=7MFBrpbTFn0GvLKTO/t9yP/hJBIvA+VQVb8UvaJd9eM=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mrjMmtvyhqrcPCevXPem/xBzan/NUbpvk1A6tIAwCqC9xzd8ODPgAGjZ8WEzRom6U
	 v9OX3KqsoEPAQdVlD6G+/b/QtfAgITW2QFLMvON4B6SpULKyhKsUO/Uc6lVk8AI0Yh
	 FTANq1EIC4OwFQ1t23q5NZxmLVo1rT4I6WkjG9Xg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF2B9F80601; Tue,  8 Sep 2026 05:04:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0094F805EE;
	Tue,  8 Sep 2026 05:04:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E95DF80518; Tue,  8 Sep 2026 05:04:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.41
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788836644;
	b=liZdq+Vt004NRJGQbAQ9Gpgju9EnFjhsIGXcV5NsKl67dkMUE8+JWxKGTDlkbVYtjrQo
	 8SSIAH9m8T/EdFlEDZgAZHfOVry7HGqflQqmB24xWeNyDAvaMqe7fDExKpIcrd7WEQxIi
	 lMOirB92fJZjeBh9ervVyKmId0nhfwtlSSYEnJNR1RabLaeD/go1ECwyENQNRrp72r9iV
	 0VDorYA1eBwz6yzd71dTJv+xzHO95HV8PZIpKrEsZJEAuro3hDuEqrIjzFh3bSiEzyQmV
	 NFMAxBWlrL3pPTDeNummKLXScVxK37QAitvjNRQspYMrh5BJRzZCt1pXFYqylDnS5TQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788836644;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7MFBrpbTFn0GvLKTO/t9yP/hJBIvA+VQVb8UvaJd9eM=;
	b=iutgmg/Kp6weCulsg96LjtFKbxTJ+QKDmL4tZcTMEDQDXJHoDrJiJf8VBuKu1PZHDC2G
	 UVCbHH2jPrBvp1byDfvkqP5sF/Pp4TDGvA/Ci43DE/xA36OrrG/Z/MB3EOFOFaNJPQEVR
	 +SDgsrZK6pLQl3NPAisooF55iaiwVEnOa+YydwaLZS8lj384Ecz5HnD48oOIltKj5rqtP
	 jCIvVYB0lB8acLbVKBh5iyKEoRW/z3qxKsg6NuLynhUIr68VUdRzwCYvtvStf0odO9pMt
	 zxpIzN83848XTs8VXzf5R/vN1XvEmLdx10lTGhwfVIqjUkUYyMom8rqjTTHVeEARakg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=PGxPwjnE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.41
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013041.outbound.protection.outlook.com
 [40.107.44.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CC090F800FA
	for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2026 05:04:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC090F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=PGxPwjnE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPJvzcglI0TaWkWqETg3x6FpILGUZuPJLDBmVHd6oiNn7/HddK4KI8DhsKjRUDUemIpSRgsnofNTExQE87ewqQp8Ox+Oh/StLk8+x7KefF4GEJkdiph4g06gBbnqwVHzxMZ+T19IMsAVmGrLDoQp+jVU4/ugyBV1NSJ+KMUgTh9g6U1ltkc1cpCP5WZb9/G2u+jN2bwg6VUvlyDm5gd6189Sc6NXtHnIkr5DmsU6veJdSkjQzVKmaeeecHNXp4J9+uQbEMrBw5PXYEbUMzQBQcjVTpabZ0J02LPLYTr9QVPn9l19tomJiIiwO3cJBch6Rdio5Ad4iOGIfsSnhsD9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fmf730+o/s1zanwXMFJFOCewLBWM28x7A0Xw1/jsiJg=;
 b=HuryyYc6I3P71fVm+sNagegcrHcodLxdFSR8WKiwRvpUlLrRhW3z1vH1CQPRYZK4inNpflAAztciAUeuaKZkuR0nm5G4xVunDs6MKG0gZkki3I69/feL9UW+ASWjG9+ZcaYt6AgOvnI8g6L7Hl0WE50MiXGV86ByaAN/lRl+C6OCTGejm+tSos69qB25ZkkTDcGKiMni1SmHTBwQgWoEWw1a0Oqb4ybgcC4XWXVR7nNoaTPMm1yDe7a3DVX5R9+tq4oDGRQsN9C3WE5CEhxmcyA5GOrNiFaniH6M+Pq7XpjRaTB/lypmq6VvLDDvMg95Dc9xtjnmb6uyFPTX/ot1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fmf730+o/s1zanwXMFJFOCewLBWM28x7A0Xw1/jsiJg=;
 b=PGxPwjnEsrGQOkSgWo8kk94NabJEVWSok+MlWSiYU2kyhWaMT0lWtpLYWKbPxtVDS0UWUyaxYjEld7RbDFiKpT3QGpM+FgJjSp3emqVZN6WaeFS5syFB4X7flTfyistrxnxg1bnc7sR16TXUgCaspuBAXoG11CPmjsvfrrZyhMjDfmE/vwTjbblDaiVCwSoGW39KC/ETNYJ8l2gQ7AtjWQzLsevyabMRrGlG9RlimgSmKd9mldSg43fOljDX5DeJ4Q9OjWRjhioyN9Iarzki0NFPOce/ymOV2t6NXcrFqpnpyh9mUfsZYPmPKGGcACSp6QvPhwDwhRX7Iwh2CgFMlQ==
Received: from PS2PR02CA0079.apcprd02.prod.outlook.com (2603:1096:300:5c::19)
 by JH0PR03MB7808.apcprd03.prod.outlook.com (2603:1096:990:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 03:03:50 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::2a) by PS2PR02CA0079.outlook.office365.com
 (2603:1096:300:5c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 03:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 03:03:50 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 8 Sep
 2026 11:03:49 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 8 Sep
 2026 11:03:48 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 8 Sep 2026 11:03:48 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v3] ASoC: codecs: nau8360: Block DSP path selection when
 firmware load fails
Date: Tue, 8 Sep 2026 11:03:42 +0800
Message-ID: <20260908030342.222655-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|JH0PR03MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf7a77d-266e-4496-65f1-08df0d55cecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|11063799006|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Z0JeRAyQi52h5WCqZFayBaGdvBfJiKVaL0juYPxum5fLDJDG9mMuHnl9Cw2IFe4TjOPbGBXHJmA5dXmbqkSdFuAulWvLvhksZ+8yLuK7KTr5qlXjaaYd0fTmEKA2htXJxSe+dCmbVke0px7GF9K/8HNBvZKcEYz6A567oywMn0XkKoxjAnVOZu/r5ki0ODBOUcoXg1PX/XlbrwkUV19t1f4Egh/8kliicem+wD9lqc+LmlUa7XcdsfQzkurByAbPQmId9d4jvlTwguAk9sR/nxSbZL3rilg9ciOGfpL1fWe1Z8DAg609r2YQxpgSlN0kmBsp24QWR9Z3mgcc2ITkRzTvcOw2zGMZtiOYDVWWTrzJTFM0DdQtPBbMsB2T0xqocXuKczhoVlHJ4csZTtk6MQ0NJgEWm62yc04bN33CYI7rrlFvaWqHuPcdKoFWNt32mC8mn80mB6huqQIQ41ZgxK7FmG6rRzJEDKW3fIs462sRYoX3f6rhaHLxG4Oojr0loqWtBdTp9hCuqtdYAnMqFkZeIjD+EhiZtgNGZMtUW3yFeSaELazGVILo0OW0B4W4t7mKEPKbSgikTGfoddBxF55JnTmudAqTNAdreYIWm5ogciCLUFPxTyyvUz4yj+mMsY+h63vEIFu6nn5d+x5sqrH4YlwPS+GnoudjG3uptAfsfHSaA5usD+dPdXYMakp2UrRemFpQ/35lHN7W08n8fQ==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	rxZT0enew/tSSXu+W06HLLSBLrxNAXK0LRFdzdAsGsN0VLZuQX8lA6x2fjFQsfmHI840VdggjioAdTFUbY8zhFkEuocTYyBY2Ri4CRogcY3TQbotmwLxLMp0cdU67wm1SMgpjh3We3ODUtAWSgeridCqcD6JpGXMVzlTdPfq3I+CJJFbaGxxLnC6Xc9+BCWLL0xoiWQywmabfbJ69fYkr+IGm+xB7xR5ciuIibyQ/F4qAYxlaP+Wn/yt8xaHLspPleQTeqQZxdwMDgPVpU7XkkX4iaG5iQUh7bfwsBycYDvAkpGmn4yKsbmWNqFGLqHRWUytUyWKYMOLw/UOYyIVQlAAAXF1EbcazRosIwzGUC6mkopYt8Ofs6v2CRGYOqEFvXNHRP2wYrnO+D+79Bh1bJG9QV0jXuG2k5oD39pl6BlEt21vaEpbhcG/jmlXZTEa
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:03:50.1877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bcf7a77d-266e-4496-65f1-08df0d55cecb
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7808
Message-ID-Hash: AC35XOYQ2VEROCQK3OOUQFRL3O4LWBCY
X-Message-ID-Hash: AC35XOYQ2VEROCQK3OOUQFRL3O4LWBCY
X-MailFrom: YLCHANG2@nuvoton.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AC35XOYQ2VEROCQK3OOUQFRL3O4LWBCY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Block the DSP path selection if the firmware fails to load to prevent
invalid routing states.

If the firmware is not ready, nau8360_dac_mux_put_enum() will print
a warning and return 0. This rejects the invalid userspace request
and maintains the original hardware state without
causing audio wrong status.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
Changes in v3:
- Abandoned the bypass fallback in nau8360_load_fw_work().
- Added check in nau8360_dac_mux_put_enum() to explicitly block DSP path
  selection and return 0 when firmware is not ready.
 
Changes in v2:
- Replaced snd_soc_component_write() with snd_soc_component_update_bits()
  in the fallback logic to prevent overwriting other bits.

v1:
- ASoC: codecs: nau8360: Set DAC path to bypass mode when DSP firmware
  load fails

 sound/soc/codecs/nau8360.c | 5 +++++
 sound/soc/codecs/nau8360.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index 89b8ee80d6c8..57a5023fe7b7 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -719,6 +719,11 @@ static int nau8360_dac_mux_put_enum(struct snd_kcontrol *kcontrol,
 		return ret;
 	}
 
+	if (item[0] == NAU8360_DAC_SRC_DSP && !nau8360->load_fw_done) {
+		dev_warn(nau8360->dev, "Cannot enable DSP: Firmware not ready or disabled\n");
+		return ret;
+	}
+
 	mutex_lock(&nau8360->lock);
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
diff --git a/sound/soc/codecs/nau8360.h b/sound/soc/codecs/nau8360.h
index cc640ba8c838..71396747c0fa 100644
--- a/sound/soc/codecs/nau8360.h
+++ b/sound/soc/codecs/nau8360.h
@@ -870,6 +870,12 @@ enum {
 	NAU8360_TDM_TXN,
 };
 
+/* DAC Source Path*/
+enum {
+	NAU8360_DAC_SRC_HW1 = 0,
+	NAU8360_DAC_SRC_DSP,
+};
+
 /* PLL Source */
 enum {
 	NAU8360_PLL_MCLK,
-- 
2.25.1

