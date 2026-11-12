Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992A606A331
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=UZbFWI7K;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=33VB8fCB
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 464FB60207;
	Thu, 12 Nov 2026 13:38:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 464FB60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794487105;
	bh=zlQsjEeWmu/s0JV0ekK2QgOJBtuygRa2KReFIMxGiLk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UZbFWI7K5WuWOOSzN5EIoqxt0hf1n66TJJqJG/XcLDDn4j/juwujZqU7S8ibdtzBo
	 tx4yMqFuHVOyMaB8+n2L0Dxz0BfgU6rzg3UNPhqZXmClGiKg5u4Et79WQcXu0Aeck/
	 s5S/omTpbwjVi4PBek1OTTNPDRe+PQptgM6Hok+s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9FE5F8069E; Thu, 12 Nov 2026 13:37:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED879F8069F;
	Thu, 12 Nov 2026 13:37:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60841F80697; Thu, 12 Nov 2026 13:37:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.66
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794487024;
	b=Z3nJuODk93Wgq/28fUuYralnwnOmkXfdxg+So+a5ZZ1Po8kKqFba5aSGwMuxsO+0u8qT
	 a8wtfAXIq2qXZP1mM7Ww1h8SoplAYavppBKYGoS4fK6bjHg6QLKQGG/K4lSVXRcpM/tP/
	 csm5EUUQBpCZXxXWd/XaXE42l3k929jIBkFKjobMwSShHwkrdzWC39f9uxdQlQjHmyBG0
	 PUKnNOtwWPJ/Cw1WuI5KfMHhOWv6PGB9ZgAzZyvjym8RHptfVpGNFQE9rYG1DjJ94G6NR
	 lFXetNCyqwJP+prmJcBihAdCQmHUi/G+5ExmZuTOzGuyaHcTKgJunUarTVBPK01yxiQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794487024;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zlQsjEeWmu/s0JV0ekK2QgOJBtuygRa2KReFIMxGiLk=;
	b=iqMhHm6L58HHwm9r8Gy9HcnguCuKk/EmcUo4hXt337ntDY36j9oVQZJNa+yWclSjk6Wq
	 FB6xby8W/DS1V48PKJ+5hHlT0kUTnEAEISjbfYxqn5xz5zjk7GEArc8m1ETF0Hcbj35Q5
	 uwuqaWK6sEwDMyUmyOB6iol9ZxAyDnc7mRoJxCNQvFJRBjlrHYgSNoGA8BmH9CMg0vxzm
	 /gLClddFsvxP7fdgxprV437wvpKOHGFtBNJxpfFKk934LF/dumU1YhAwzVAJ+EOIaDMMT
	 gG/tamcJfujwjYlOaG4DZ2YGeum1VLNVxWeAMAGeT5w6DvjEaQUYpKf4SaJTAzNEHSg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=33VB8fCB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.66
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B52F3F80607
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 13:37:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B52F3F80607
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=33VB8fCB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnDC1V4EGCbr/BkAadL6/oLAPTc5XUbdaWIieBsL3p5zGkNWsPEadj3JvB+vziEsgjT1ciOjQUwl3OlM3F+JthuAB+NOTTW5S3NIGU5nnTC70kcjxjBkjK5u+DP8Jvc1ckNC7fb7xIaEs6RltZ4dyKNlcbQM1JX4D4kKRzp/FKwLR2Ud361lTv5wQc5w56diR5ExXt8FGaAON6JnlEaB57w6hDYeEodQ07UiJsSnHaFta/nMxn7OD/KFCPs4nVblCEjxn/p1sPJLMmZKn91uiqtrbAou8KoGjnE0arHx5x7aecIhWni3knzm2iGmvbU9AmneyYywO8esFBwFdtL1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlsTjPB4FHrL9dZx1lKWgPS6GT9zn1PyHZ0WJGRr86E=;
 b=R5kRfZqZWhe8cbOn7MSlskEWqihchXWbUUdF4YIVgw0omFTYHYE0r0x8o2t1Wqe60CfVJEfM0xXscTImWm2slgREsErP15Fz7cRjRxvEMjsgwW8HLf4gAE1WkF0z0vx58MS7HseIYFQrLUXQrReRTcTglsqgiSGJNVYQtRnBgAv19f63Wt3Vn5i4U9lG0Yv2LlsXO/YConPg20JVw/3xxRrqN7Qbjd5rxz61RXAlI/64ThnAZF9HJbqagnooWUBOcw82NsSedkBOenydWeIEX9ztsGQ+5/VxBMvFtIjTqcYeDD8EVHFXo2x6rFXYnFIkF/E8Or6xf+0TGa6y4eCj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlsTjPB4FHrL9dZx1lKWgPS6GT9zn1PyHZ0WJGRr86E=;
 b=33VB8fCBiz7cRuK8BB0sjmBeoILVRAhYkQ+31bZwqTz0yEUSmjBrg8g430V+mn6imgq/gmbJprvCyPd+l0uk9itUQnrfQ6eVj9sOQoyXX1ZG0u9E7rUvjhGdQ1nPgl4CL51osK9KRJKxZYbvfpyYHLQQEgyGfoI/hGWBpW/eJ5Y=
Received: from PH0PR07CA0116.namprd07.prod.outlook.com (2603:10b6:510:4::31)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 12:36:57 +0000
Received: from PH3PEPF00059617.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::2b) by PH0PR07CA0116.outlook.office365.com
 (2603:10b6:510:4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 12:36:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059617.mail.protection.outlook.com (10.167.243.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 12:36:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:53 -0600
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 06:36:48 -0600
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, "Siva Subramanian
 Ravi Saravanan" <sravisar@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"Pierre-Louis Bossart" <pierre-louis.bossart@linux.dev>, "Mario Limonciello
 (AMD)" <superm1@kernel.org>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Charles Keepax
	<ckeepax@opensource.cirrus.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>, Aaron Ma <aaron.ma@canonical.com>,
	"open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/6] ASoC: amd: acp: always append the DAI type to
 SoundWire DAI link names
Date: Thu, 12 Nov 2026 18:05:40 +0530
Message-ID: <20261112123603.2891858-6-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112123603.2891858-1-syed.sabakareem@amd.com>
References: <20261112123603.2891858-1-syed.sabakareem@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059617:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 490ec153-4a56-4b01-23d9-08df40b9a330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|261026140227099003|261028144727099003|56012099006|11063799006|261102123227099003|261021121427099003|261009223027099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	l1zp7tnb5DTkak8KisU9wmEiurHq2SyuyHRq33JyUb91YInPxl/G5+fHRQzjdyEx5ekijAuXBx9Lz/fxllkEjCWQYyKwLpELYAFUK6FiG70XahyAyci3Y+hyiFr+O4m8vuQP/bRqtYbXVieVnhIeNlY15+vb7jbGd6xRVDffF/f5aOk+XE+DgbfC37//5sWdm9Mk+ikJKQXxC1N06GSdNPao/meLXrIrKrE98k3ZMANtJFhb030lysIf5k70CUgeeqRDVCk2t4V8JiULjJanOzXIrFjnkqyjtM2CtgKyicGdEWleqg/NsOAfw6maYXH4XwuNHAl/diVfqHTAjIErNE5DB3DGvpvs12XzsrFgIMAxvA7xQnBe5xCIOr21OqZ78nxD6v0YQEyFhsiY55itH1QQgnmwZ7Dx4z6yb9xuIeXp3Hlvs+z3m7xZtq9i5TYwYL24+KZEKAqm8H6TXRhQbHJD/oHd69ip3ZEArwiciwqt392/2+Vlj8JfdCU537xAQO7wQRHOA5j7Y8/H5JNT2P3aQQeX/E0jRUQd3G0dqglzRIo8kFaKAYryqMr7E465ntraVpuOnLDjjNPSZlK6RHEiR6oVi6fw5CR6bPNQzfSRI1aOOu+Z4AqtZK29Sx38lS04WmB9KZztYX9J4K8PrZJjwajv0DETpZQdJD6zdFaTM7TNPOSEHt6Ib/6TGm0WlDPQ3mHo0TJDihjHGqw5lA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ujgcQjdBWU+owjrDZtwi05ua9ggFrNWh54/ZgVDY6U3FS8pJY2cnict5mUhwfcLkhxxn9nX2AnSBW/I+xEMQ2MSU5+JtClFdiVauyNFKu0n7ru8qmhq7tZvjH4Kcl28wxFAvcwJBPXVACrwbiNK+nHtNHHgJaMpIXOy5CthYPcWhJpsRb7sqzQtRZjQzRhmMyLmBZoyqtTQW607r7cxfpILhrmJiHjtAbRfd3RsYnYjvD7XWLxOG3h3cgKi99OE8/RYmsErVJ/XCvfjfYaoMhY0TgErxzd5d945w15xcM3bBEoKvE6qLAWtbg53GlRWsTu3q9vbOdI2fxrsJ3bMyzfzJzfPFR/q2DBtE4qPGPrGuuHIMCkO0Ki2+QfrPMFvHyre50V9p2WVOt+kpCkSSkrjwd8EcS/Fv7LgiU13Kbf1ADMxhI2QF4mI6dLAJcnaA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:36:56.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 490ec153-4a56-4b01-23d9-08df40b9a330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	PH3PEPF00059617.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
Message-ID-Hash: GW2S23DHLLIE4PQSIWOI7MYPFUZLZXIU
X-Message-ID-Hash: GW2S23DHLLIE4PQSIWOI7MYPFUZLZXIU
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GW2S23DHLLIE4PQSIWOI7MYPFUZLZXIU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Siva Subramanian Ravi Saravanan <sravisar@amd.com>

Function topologies are selected from the DAI type (SimpleJack,
SmartAmp, SmartMic) in the DAI link name, but the SoundWire SOF machine
driver only appends it when a link has more than one DAI link. Always
append it so the DAI type is available as selection metadata for the
function topologies.

This does not regress the platforms that keep using a single monolithic
topology (such as ACP6.3 and ACP7.0, which do not set
get_function_tplg_files). The SOF core binds a topology DAI widget to a
BE DAI link by testing whether the topology stream name is a substring
of the DAI link stream name (strstr() in sof_connect_dai_widget(),
sound/soc/sof/topology.c), i.e. the match is partial. Appending the
"-<type>" suffix only makes the DAI link stream name longer, so the
shorter monolithic topology stream name is still found as a substring
and the binding keeps working. This mirrors the Intel sof_sdw machine
driver, which also appends the DAI type unconditionally.

Signed-off-by: Siva Subramanian Ravi Saravanan <sravisar@amd.com>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index bb35c696a66d..b175cb67d3c7 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -398,6 +398,9 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 
 	sdw_be_num = ret;
 
+	/* the dai_type in the DAI link name selects the function topologies */
+	ctx->append_dai_type = true;
+
 	/* enable dmic */
 	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC || mach_params->dmic_num ||
 	    amd_ctx->pdm_sel) {
-- 
2.43.0

