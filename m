Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A16C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:08:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 842A960237;
	Thu, 17 Sep 2026 11:08:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 842A960237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789636122;
	bh=pXWIYcdG1qKP9MYbN39O3KdHYuzg/IJje/53l62UrGg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QkgZ0eJFRXPzbHDX1cdTq8WJ+uZU0yIgcFMk1+rUfMBmIlmU1WV5RoQMldJGeZ206
	 fnWXwzXF3aZ2HWqVsHmV/glwfjkOEMuytL7U+BpyXalcN2umvsmvcEj5ZAHy33Fbep
	 4xLwpOQ8YT7OIFmX98sLxUrq6YLPOuMKE3oR7QaI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55546F80756; Thu, 17 Sep 2026 11:06:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37609F80764;
	Thu, 17 Sep 2026 11:06:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14E79F806CB; Thu, 17 Sep 2026 11:06:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789635968;
	b=gYy8FfA+L/yxTvCkS1ceEnLZZryJGE18miAHGkivRPG+1P+3licXZc5Gq8uhBHe0Dn0Y
	 XoydHtaQbdKqXOATtZypWgMt26IgD8u66o70qauP8cXyf+fqLDqmd4PdOOM7/v+FnZtAt
	 3mPDp3gBSQwdKsL8ViD8iTIu5wEc2sHN0yMWKbenmCv0MZCxVa7zYl3JDyyKyeQHyt/ow
	 3TZqM+MPBEpySADLol391E3VHUCHAyt9wE+BzP6z21L7I5jsDrVD276ZaThOupDQ0JMLh
	 lARCwrsceNfUWtLzWL5zeu0N2xpOdcI9unAnKwlGTt/AdfqVeOKKIO3SAQiAZKVb6aQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789635968;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pXWIYcdG1qKP9MYbN39O3KdHYuzg/IJje/53l62UrGg=;
	b=LKTK6zI3mfh73N+TZy3upAB+hg7ZT56YWGFUd/SH8Z5OoQWKslM+qEcPfsGX3CCpEhNW
	 Heg4Hqy7/hKYWikZzp6VxWmPusUnhw/rFueNsdlwQy8OuZ4hv1pXvhUNwsA9Y9w4/YMx+
	 t99KmE7U31858ZmDE/sGkdgZtzFv7cJCxPCSJVZ8DflExyhbUoALltBBT1i477UEOmvLw
	 di47o0hHy8sXpLDelRd/X109s/FvhbFnW2POYUyxRCIqEo07EnAA2Dnec7JsWCPq7HjSV
	 dAJ3jdJyMledCqIqYOMnlqwYUroxDHizvt7/lzqhuqRPDGpTSTDew1iYKovcxrLFlxw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=eF2wkiIY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.9
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06520F806AC
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:06:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06520F806AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=eF2wkiIY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9zjKAz9zacORJM+dkBq26DhG/48wpL5o/TJ8077dJgAR4aTANRCQYqIElUJI0UVJ5WfByvr8Li4ZFeuwtH/co8+cVdNy3e9j4u0fD6SJljKXkr2nMeqw41OfQVf2a6szcCVNdrABOoXTXGYXU4Ix5XCS74ZkXiTkU8wqg2nYs2uMKMd973A+hQjNvKCEL+wT6281F9YRf75ojmlnSdBCB+MdfgD1OxOVrIIYqocV1BTTWAnHPdHBTghR/wup7CRHuF97NLm+OfHZDg4I7ioAeGhGgEyBRcIC/QQ0fZWZqZtlrunIIQz9sSRp8/AVMCgZjJ1HSxvBOzfOm02reZkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoXbQcFEfBr4GVbUdGf8HnG7o+uhYerypKlU6TNFfTk=;
 b=caXRc+FZNLkinef76vBUlgAgd6X6JCZyru6x53hjcbazSZuvId0ZNWzGf08GdrVPcnQMT/Em3dyMR/sx1j2uyVyRfzIBrV3glE5hT01Vucor2DX5iDAxVBu+FX7i2lNZtSyvDfJrXSjL3z7b4k8EGVhM8B/JBWrMuPCtUWe8op6iReZUN7FwAgFOE2br5q7zZ0mISrhiWFnnwOdjwSdqSVsKYn5s5EA19vg00qcXzPFXIIrhI568QsqnhMwbWEnMD9Cs+mWWD7yKewP/oBIfFjxmOAISV947yKWA1Aqgq4irQcrD7TYQRmHpn6f28Zbn813YQH78D3aLJCWjLs1vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoXbQcFEfBr4GVbUdGf8HnG7o+uhYerypKlU6TNFfTk=;
 b=eF2wkiIYwkg6oc0eaqFIxbW54FZ0rOaDJv9WYQH+mXgULHcPTmAFvTox+Y89h/bAkOp+nXdHVewom6OGg78QQs2VIy3I+AjXaqtErk5tDDAL/w/+LFf/UrqB7fevqdU1CHpFMIdmMEho4KUACbgN8GeRnI0XAtnyzbP0SKEuOfU=
Received: from BY5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:1e0::27)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:05:57 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::5) by BY5PR03CA0017.outlook.office365.com
 (2603:10b6:a03:1e0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Thu,
 17 Sep 2026 09:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:05:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:51 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 04:05:47 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 8/9] soundwire: amd: wire amd_acp63_*() call sites through
 acp_*() helpers
Date: Thu, 17 Sep 2026 14:32:56 +0530
Message-ID: <20260917090407.3828816-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5bc73d-7837-4556-cdbf-08df149ae2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	j4zc44qqkNfTMf/n0qewYd7CLvGJxS8EoIraIyqRN9vsCXCQ1vMVB0t0UssjALyCIWBokUUc+3DLRiyI2hnnD3rrAVvgkybdz1jvbBpfAX0BlzDAyEKDmVCfo1EFcwT5ovIywuKRZv03EdtFwfhq5n6xP2SGH6ykBRsDABnvR2Karj4xJz4aJPP8ma6ptWFEPoUBNjmC6KUgfGwHwRzgTEyFGW25t+IZ0U1rvCGRFEr4otd88cuKOnurngEE/idxF1VfCGi+IGrf/q0v75N6vmGiF20YPfl+jhXNH/nsdAG5GLLhY83EHGz3G8E/PlyqPV6Dvpodoy/9CR3RGK6/iukrXNz72q6AVwkKgkb2bCJ72CXOVdWSvGBNnIwles4+Sp4QTUzVEzIrT3JqSBO7isC/Vmgd6/DTa39pOnoeFGylRKqippyzLMEjiaFzfClfC/ucVjIu08jyoH6++4s5LHagn0EqdqgJFu1FpCGOqJtrDO6mYBHgjxMu91C4iNaA058hxwao4CdguzU9Tkem4lFBE2dvK4DkgiDkoPsS46f2j2L8xtm9aGP6P7G+W6huyIhNny+ZUhWKBV5eiy99fYcaDMtHZR6C5BtI2KjTsi+uHC9VA2chy7kkh7JsVcftszt0hvfjS0K7uAezNlWW/8cP+BhQX2u8TmgeoP4FAwDKbIbzVsMzn2QYOGR3k9iKjyPyd+KWor69M6SNZ+ceMQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	0eW4hhXeUVj/RRzZrViZN8KsObn2VX4GIoadCCnBKty4u+216Fvge1uJYt83UaHdKbKMqja+Wwhrj6LcMJZziTx87wDBEkhsSJJBNO66O6vaJdscg1/4FgvO1AAeiN41QMTpS5Pm41Y8GqK9TKOHUl8Ml6Ley0oJ0mhPFa15vA3TxQs1KEexoMSF1NKroK3Y6nn99gZ26EoV24UWFrBZ6xaG2l44Qlo+iv/5ztguJbukGKvYtCjh8S35qPqxMIB1fouRicCqgSIl1pFozCsTvUe42ZdItZhpw8gXyPHkLKiHMa+HEGvzZds8Vgc3xDqqw3w4guN1DY7kA5zgyoKBFsriH6BDG14TDxlCuBoaqq/8q37quo6Qbsg/aRcY5hDrNXEBgJ0a4YIk7sMJ0zGc1M/PtJQ9BtYGNljjWU+o4kSKU4AxTGOB3OAsSN5PpKTr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:05:57.2641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3d5bc73d-7837-4556-cdbf-08df149ae2de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
Message-ID-Hash: L4WWCONURC6I2UT5DBA6GJKSED4EFMUJ
X-Message-ID-Hash: L4WWCONURC6I2UT5DBA6GJKSED4EFMUJ
X-MailFrom: Vijendar.Mukunda@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L4WWCONURC6I2UT5DBA6GJKSED4EFMUJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Extract PM logic into amd_acp63_sdw_suspend(),
amd_acp63_sdw_suspend_runtime() and
amd_acp63_sdw_resume_runtime() hw_ops callbacks, each taking
struct amd_sdw_manager * instead of struct device *.

Replace the existing amd_suspend(), amd_suspend_runtime() and
amd_resume_runtime() static wrappers with thin one-liners that
delegate to the corresponding acp_sdw_*() dispatch helpers.

Introduce a static const struct amd_sdw_hw_ops amd_acp63_hw_ops
table that populates all 19 hw_ops slots with the amd_acp63_*()
callbacks. Introduce amd_sdw_hw_init_ops() to assign a pointer
to this table based on acp_rev, and call it from
amd_sdw_manager_probe() to wire up the dispatch table at probe
time.

Convert all remaining direct amd_acp63_*() call sites in the
start, PM, interrupt, and remove paths to use the corresponding
acp_*() wrappers.

Place amd_acp63_hw_ops and amd_sdw_hw_init_ops() after
amd_sdw_manager_remove() so all amd_acp63_*() functions they
reference are already defined. Add a forward declaration of
amd_sdw_hw_init_ops() before amd_sdw_manager_probe() to resolve
the call site ordering.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 366 ++++++++++++++++++--------------
 1 file changed, 210 insertions(+), 156 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 87a2e779dd4e..834e943b040b 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -303,8 +303,7 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.buf = &msg->addr_page1;
 	scp_msg.flags = SDW_MSG_FLAG_WRITE;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
-					    &response_buf[0])) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[0])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -312,8 +311,7 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.addr = SDW_SCP_ADDRPAGE2;
 	scp_msg.buf = &msg->addr_page2;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
-					    &response_buf[1])) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[1])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -386,7 +384,7 @@ static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struc
 	u32 upper_data = 0, lower_data = 0;
 
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, msg, cmd_offset);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
 				    msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -449,7 +447,7 @@ static void amd_acp63_sdw_read_and_process_ping_status(struct amd_sdw_manager *a
 	u64 response;
 
 	mutex_lock(&amd_manager->bus.msg_lock);
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		mutex_unlock(&amd_manager->bus.msg_lock);
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
@@ -471,7 +469,7 @@ static u32 amd_acp63_sdw_read_ping_status(struct sdw_bus *bus)
 	/* Called by sdw_show_ping_status() which holds msg_lock. */
 	lockdep_assert_held(&bus->msg_lock);
 
-	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (acp_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
 		return amd_manager->ping_slave_stat == U32_MAX ? 0 : amd_manager->ping_slave_stat;
@@ -974,7 +972,7 @@ static void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_m
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
 			writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
-			amd_acp63_sdw_read_and_process_ping_status(amd_manager);
+			acp_sdw_read_and_process_ping_status(amd_manager);
 			goto update_status;
 		} else {
 			dev_err_ratelimited(amd_manager->dev,
@@ -989,7 +987,7 @@ static void amd_sdw_update_slave_status_work(struct work_struct *work)
 	struct amd_sdw_manager *amd_manager =
 		container_of(work, struct amd_sdw_manager, amd_sdw_work);
 
-	amd_acp63_sdw_update_slave_status_work(amd_manager);
+	acp_sdw_update_slave_status_work(amd_manager);
 }
 
 static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
@@ -1037,10 +1035,10 @@ static void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
 	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
 		amd_manager->instance, status_change_0to7, status_change_8to11);
 	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
-		return amd_acp63_sdw_process_wake_event(amd_manager);
+		return acp_sdw_process_wake_event(amd_manager);
 
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
-		amd_acp63_sdw_read_and_process_ping_status(amd_manager);
+		acp_sdw_read_and_process_ping_status(amd_manager);
 	} else {
 		/* Check for the updated status on peripheral device */
 		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
@@ -1056,7 +1054,7 @@ static void amd_sdw_interrupt_thread(struct work_struct *work)
 	struct amd_sdw_manager *amd_manager =
 			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
 
-	amd_acp63_sdw_irq_thread(amd_manager);
+	acp_sdw_irq_thread(amd_manager);
 }
 
 int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
@@ -1066,17 +1064,17 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 
 	prop = &amd_manager->bus.prop;
 	if (!prop->hw_disabled) {
-		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
+		ret = acp_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_init_sdw_manager(amd_manager);
+		ret = acp_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
-		ret = amd_acp63_enable_sdw_manager(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
+		ret = acp_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_sdw_set_frameshape(amd_manager);
+		acp_sdw_set_frameshape(amd_manager);
 	}
 	/* Enable runtime PM */
 	pm_runtime_set_autosuspend_delay(amd_manager->dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
@@ -1087,117 +1085,6 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int amd_sdw_manager_probe(struct platform_device *pdev)
-{
-	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
-	struct resource *res;
-	struct device *dev = &pdev->dev;
-	struct sdw_master_prop *prop;
-	struct amd_sdw_manager *amd_manager;
-	int ret;
-
-	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
-	if (!amd_manager)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOMEM;
-
-	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
-	if (!amd_manager->acp_mmio) {
-		dev_err(dev, "mmio not found\n");
-		return -ENOMEM;
-	}
-	amd_manager->ping_slave_stat = U32_MAX;
-	amd_manager->instance = pdata->instance;
-	amd_manager->mmio = amd_manager->acp_mmio +
-			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
-	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
-	amd_manager->acp_rev = pdata->acp_rev;
-	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
-	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
-	amd_manager->dev = dev;
-	amd_manager->bus.ops = &amd_acp63_sdw_ops;
-	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
-	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
-	amd_manager->bus.clk_stop_timeout = 200;
-	amd_manager->bus.link_id = amd_manager->instance;
-
-	/*
-	 * Due to BIOS compatibility, the two links are exposed within
-	 * the scope of a single controller. If this changes, the
-	 * controller_id will have to be updated with drv_data
-	 * information.
-	 */
-	amd_manager->bus.controller_id = 0;
-	dev_dbg(dev, "acp_rev:0x%x\n", amd_manager->acp_rev);
-	switch (amd_manager->acp_rev) {
-	case ACP63_PCI_REV_ID:
-		switch (amd_manager->instance) {
-		case ACP_SDW0:
-			amd_manager->num_dout_ports = AMD_ACP63_SDW0_MAX_TX_PORTS;
-			amd_manager->num_din_ports = AMD_ACP63_SDW0_MAX_RX_PORTS;
-			break;
-		case ACP_SDW1:
-			amd_manager->num_dout_ports = AMD_ACP63_SDW1_MAX_TX_PORTS;
-			amd_manager->num_din_ports = AMD_ACP63_SDW1_MAX_RX_PORTS;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case ACP70_PCI_REV_ID:
-	case ACP71_PCI_REV_ID:
-	case ACP72_PCI_REV_ID:
-		amd_manager->num_dout_ports = AMD_ACP70_SDW_MAX_TX_PORTS;
-		amd_manager->num_din_ports = AMD_ACP70_SDW_MAX_RX_PORTS;
-		break;
-	default:
-		return -EINVAL;
-	}
-	amd_manager->max_ports = amd_manager->num_dout_ports + amd_manager->num_din_ports;
-	amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
-						    sizeof(int), GFP_KERNEL);
-	if (!amd_manager->port_offset_map)
-		return -ENOMEM;
-
-	prop = &amd_manager->bus.prop;
-	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
-
-	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
-	if (ret) {
-		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
-		return ret;
-	}
-	ret = amd_sdw_register_dais(amd_manager);
-	if (ret) {
-		dev_err(dev, "CPU DAI registration failed\n");
-		sdw_bus_master_delete(&amd_manager->bus);
-		return ret;
-	}
-	dev_set_drvdata(dev, amd_manager);
-	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_interrupt_thread);
-	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
-	return 0;
-}
-
-static void amd_sdw_manager_remove(struct platform_device *pdev)
-{
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
-	int ret;
-
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	amd_acp63_disable_sdw_interrupts(amd_manager);
-	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
-	cancel_work_sync(&amd_manager->amd_sdw_work);
-	sdw_bus_master_delete(&amd_manager->bus);
-	ret = amd_acp63_disable_sdw_manager(amd_manager);
-	if (ret)
-		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
-}
-
 /*
  * AMD SoundWire clock-stop sequence shared across all ACP revisions.
  * Differences between revisions in this path are minimal; a switch/case
@@ -1327,7 +1214,7 @@ static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager,
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		return amd_acp63_sdw_host_wake_enable(amd_manager, enable);
+		return acp_sdw_host_wake_enable(amd_manager, enable);
 	default:
 		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
 		return -EINVAL;
@@ -1335,9 +1222,8 @@ static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager,
 	return 0;
 }
 
-static int __maybe_unused amd_suspend(struct device *dev)
+static int amd_acp63_sdw_suspend(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
 	struct sdw_bus *bus = &amd_manager->bus;
 	int ret;
 
@@ -1348,22 +1234,22 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, false);
+		acp_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, false);
+		acp_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
@@ -1374,7 +1260,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_disable_sdw_manager(amd_manager);
+		ret = acp_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1384,7 +1270,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = acp_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		break;
@@ -1395,9 +1281,8 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused amd_suspend_runtime(struct device *dev)
+static int amd_acp63_sdw_suspend_runtime(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
 	struct sdw_bus *bus = &amd_manager->bus;
 	int ret;
 	u32 val;
@@ -1408,29 +1293,29 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		return 0;
 	}
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, true);
+		acp_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_acp63_disable_sdw_interrupts(amd_manager);
+		acp_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_acp63_sdw_wake_enable(amd_manager, true);
+		acp_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_disable_sdw_manager(amd_manager);
+		ret = acp_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1440,7 +1325,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = acp_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		if (amd_manager->wake_en_mask) {
@@ -1459,9 +1344,8 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused amd_resume_runtime(struct device *dev)
+static int amd_acp63_sdw_resume_runtime(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
 	struct sdw_bus *bus = &amd_manager->bus;
 	int ret;
 	u32 val;
@@ -1473,7 +1357,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		ret = amd_acp63_sdw_clock_stop_exit(amd_manager);
+		ret = acp_sdw_clock_stop_exit(amd_manager);
 		if (ret)
 			return ret;
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
@@ -1508,17 +1392,17 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			}
 		}
 		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
-		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
+		ret = acp_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_acp63_init_sdw_manager(amd_manager);
+		ret = acp_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_enable_sdw_interrupts(amd_manager);
-		ret = amd_acp63_enable_sdw_manager(amd_manager);
+		acp_enable_sdw_interrupts(amd_manager);
+		ret = acp_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_acp63_sdw_set_frameshape(amd_manager);
+		acp_sdw_set_frameshape(amd_manager);
 	}
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
@@ -1526,7 +1410,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
+		ret = acp_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
 		if (ret)
 			return ret;
 		break;
@@ -1537,6 +1421,176 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused amd_suspend(struct device *dev)
+{
+	return acp_sdw_suspend(dev);
+}
+
+static int __maybe_unused amd_suspend_runtime(struct device *dev)
+{
+	return acp_sdw_suspend_runtime(dev);
+}
+
+static int __maybe_unused amd_resume_runtime(struct device *dev)
+{
+	return acp_sdw_resume_runtime(dev);
+}
+
+static int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager);
+
+static int amd_sdw_manager_probe(struct platform_device *pdev)
+{
+	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct sdw_master_prop *prop;
+	struct amd_sdw_manager *amd_manager;
+	int ret;
+
+	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
+	if (!amd_manager)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
+	if (!amd_manager->acp_mmio) {
+		dev_err(dev, "mmio not found\n");
+		return -ENOMEM;
+	}
+	amd_manager->ping_slave_stat = U32_MAX;
+	amd_manager->instance = pdata->instance;
+	amd_manager->mmio = amd_manager->acp_mmio +
+			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
+	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
+	amd_manager->acp_rev = pdata->acp_rev;
+	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
+	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
+	amd_manager->dev = dev;
+	amd_manager->bus.ops = &amd_acp63_sdw_ops;
+	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
+	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
+	amd_manager->bus.clk_stop_timeout = 200;
+	amd_manager->bus.link_id = amd_manager->instance;
+	ret = amd_sdw_hw_init_ops(amd_manager);
+	if (ret) {
+		dev_err(dev, "Failed to initialize hw ops (%d)\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Due to BIOS compatibility, the two links are exposed within
+	 * the scope of a single controller. If this changes, the
+	 * controller_id will have to be updated with drv_data
+	 * information.
+	 */
+	amd_manager->bus.controller_id = 0;
+	dev_dbg(dev, "acp_rev:0x%x\n", amd_manager->acp_rev);
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		switch (amd_manager->instance) {
+		case ACP_SDW0:
+			amd_manager->num_dout_ports = AMD_ACP63_SDW0_MAX_TX_PORTS;
+			amd_manager->num_din_ports = AMD_ACP63_SDW0_MAX_RX_PORTS;
+			break;
+		case ACP_SDW1:
+			amd_manager->num_dout_ports = AMD_ACP63_SDW1_MAX_TX_PORTS;
+			amd_manager->num_din_ports = AMD_ACP63_SDW1_MAX_RX_PORTS;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_manager->num_dout_ports = AMD_ACP70_SDW_MAX_TX_PORTS;
+		amd_manager->num_din_ports = AMD_ACP70_SDW_MAX_RX_PORTS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	amd_manager->max_ports = amd_manager->num_dout_ports + amd_manager->num_din_ports;
+	amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
+						    sizeof(int), GFP_KERNEL);
+	if (!amd_manager->port_offset_map)
+		return -ENOMEM;
+
+	prop = &amd_manager->bus.prop;
+	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
+
+	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
+	if (ret) {
+		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
+		return ret;
+	}
+	ret = amd_sdw_register_dais(amd_manager);
+	if (ret) {
+		dev_err(dev, "CPU DAI registration failed\n");
+		sdw_bus_master_delete(&amd_manager->bus);
+		return ret;
+	}
+	dev_set_drvdata(dev, amd_manager);
+	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_interrupt_thread);
+	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
+	return 0;
+}
+
+static void amd_sdw_manager_remove(struct platform_device *pdev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_disable(&pdev->dev);
+	acp_disable_sdw_interrupts(amd_manager);
+	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
+	cancel_work_sync(&amd_manager->amd_sdw_work);
+	sdw_bus_master_delete(&amd_manager->bus);
+	ret = acp_disable_sdw_manager(amd_manager);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
+}
+
+static const struct amd_sdw_hw_ops amd_acp63_hw_ops = {
+	.init_sdw_manager		= amd_acp63_init_sdw_manager,
+	.enable_sdw_manager		= amd_acp63_enable_sdw_manager,
+	.disable_sdw_manager		= amd_acp63_disable_sdw_manager,
+	.enable_sdw_interrupts		= amd_acp63_enable_sdw_interrupts,
+	.disable_sdw_interrupts		= amd_acp63_disable_sdw_interrupts,
+	.set_frameshape			= amd_acp63_sdw_set_frameshape,
+	.send_cmd_get_resp		= amd_acp63_sdw_send_cmd_get_resp,
+	.wake_enable			= amd_acp63_sdw_wake_enable,
+	.host_wake_enable		= amd_acp63_sdw_host_wake_enable,
+	.set_device_state		= amd_acp63_sdw_set_device_state,
+	.read_and_process_ping_status	= amd_acp63_sdw_read_and_process_ping_status,
+	.process_wake_event		= amd_acp63_sdw_process_wake_event,
+	.irq_thread			= amd_acp63_sdw_irq_thread,
+	.update_slave_status_work	= amd_acp63_sdw_update_slave_status_work,
+	.clk_init_ctrl			= amd_acp63_sdw_clk_init_ctrl,
+	.clock_stop_exit		= amd_acp63_sdw_clock_stop_exit,
+	.suspend			= amd_acp63_sdw_suspend,
+	.suspend_runtime		= amd_acp63_sdw_suspend_runtime,
+	.resume_runtime			= amd_acp63_sdw_resume_runtime,
+};
+
+static int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager)
+{
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_manager->hw_ops = &amd_acp63_hw_ops;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static const struct dev_pm_ops amd_pm = {
 	.prepare = amd_pm_prepare,
 	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
-- 
2.48.1

