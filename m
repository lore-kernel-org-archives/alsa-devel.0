Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E58606A333
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=npL068tn;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YnPSPZAh
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B524860238;
	Thu, 12 Nov 2026 13:38:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B524860238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794487119;
	bh=/fB9FnUQkLfsYiJJXra0Boz1DtewGbL+OpjjABkMIvI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=npL068tnpDpRCxOiqkMutHggSfJgNvRZKeGIlADES6nBCrGpzS6J9iI3k1ZJN2Wxi
	 proI6Aw1WULJHt7H00p8rKXpNa6TP+L2kLuNu+/Ji20Zb5Fy73OKBBWmvE0I3x1K3V
	 veJviOFZFcSyxR69sb6MJi6BTJcl7mlIiVfHH7lo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BF8AF8061E; Thu, 12 Nov 2026 13:37:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 78839F80620;
	Thu, 12 Nov 2026 13:37:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE61BF80615; Thu, 12 Nov 2026 13:37:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.11
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794487036;
	b=igmsGpCW5xZpvbUFbMugyZib2Z6PYouYmekbVqI8QfMmsSzJrxIARcnvwCWbd+MTTYIv
	 xh0pg1Gk+r05huBPZD44LWIeJY4WHgSouC/zLlhtc99vMT61PNsysXjzhN6jU7bp8EFJI
	 /ypYiLeBwvwrDAYmXxRQbuDpcjo8KIf26fVfqxT5fG/IH5NhG0B750G7bqzt1gzOTpiFr
	 mrU0fl7ziL4RgiM6HnCjlkejc0VHUYLDxmuPEDtTo8tP2jFOYwz7M3FMTGQevF/xKy/w0
	 dng4TbIXhFeNpcmU2tHDAyA+AUGtWd5EtvcZ4t/1xQClkttQabSd8uXloU+TiMuCenw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794487036;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/fB9FnUQkLfsYiJJXra0Boz1DtewGbL+OpjjABkMIvI=;
	b=DeI5cbkwNIbd+LLatmNCFj/798Ws+yxC9V/zX4ZjxCUxXHvfsWO5BtFZKc3wieZhdgWo
	 cw6mxMomaGVU9d03Gsf2Ys9diruVUIamdnQ0Pwq6B82oQJsk3k70Wa5k+T17irauh0lfu
	 wJVx1lByZYEodb0n+A35qP2lz32SZAeLu5s4CmUQZDuNzQxFLEDn/r7NCmlpqyMI5vJrp
	 4fdbx+aQUIIPmhMENXL7XPnXdNP8gk6vXFKiFS+lkhSWO1sQIAcNUpUpsiGLN5Lsvnvz9
	 Z/w39fHFOlTKKdIR+MMaSGnJZGg5TElM2MCuCGktsjILHcz/Te5rN49gywqqb4CZa2g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YnPSPZAh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.11
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 12387F80016
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 13:37:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12387F80016
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YnPSPZAh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5GkqfGFxFhSJ3f7hb7XndKMBJpJX/3KEpH69Z7TdWJmIvaNYHbnD1Dk622GSij0sDrpCdUiXpVThYraLSTT35IY+8OZa6sZdAhS5TdpKujjnvhEjj7yUpeRaowiWU9qbyL/gsauSSdiFUMyM+8TbA8WJ1g3u40tmU8NKF6g85YNu128/HfUK3i9r0NLYZr61pF7rsaDmcUr4R46x3GDsucWgs5BJofRMNU4J3Q/QY9SiUAZjHLDHndCAjJU/OEhhEbRy1GI9AHxZxSNes4PbbsyTb+XaZG44Pyg7bkuWY909Fo6p8jjuzkNobc/a255y5nVABx8CP0eEnJxeZ3/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5oFQseRt+fiSR99Xed21cobMb05spzKxa0Xf8/I4rI=;
 b=NFWkVxOzuA929oXmGyHedzXu30AQm7JkDFwpqWdaCwreCW6Z32A5bNW5iSJhC8ZedJmDgzyadNL5iPyvYzfOm00IRxrSJAv0PtCYiJaIP5ApL0bm6bU8vPEGNth3RvvDAEiTmbWEwQXmfVnHO8zjvTjx+0tGyoIIAPdNTuC0RBQ7U7D2HVgZgCGlz/+OGWq0Qd8PTJpRu2TVCT3tJ2Vx5/rfKHYRP+HFsZXJTXGnMY4i2OryvLZHoWziSp0QimH/aqPegU9NrEtImEWJLZgmplqeBS5BI/Obl6a/9k4e1lvEkJRT+7J/0MVNJ7Qbs+KHT5jQ6c+2nscrSMX31OL6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5oFQseRt+fiSR99Xed21cobMb05spzKxa0Xf8/I4rI=;
 b=YnPSPZAhiKbcwziM4b7xBmy/d86ngbt0H2fxNl0lPz2+G81iHz3LPVlA/hFlnmoDTvwhbxyLtQFoDBjyGq56VbOWwBkIPEJoEISmcl8qlmx4sVM7Xd2zx0hbVHW1EXQ+EUO/VKiN5Q4EgcmH9NtDSqo61aDSRrVFE/BjOVGngHA=
Received: from PH7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:510:339::18)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:37:05 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::66) by PH7PR03CA0028.outlook.office365.com
 (2603:10b6:510:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 12:37:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 12:37:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:37:00 -0600
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 06:36:56 -0600
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, "Siva Subramanian
 Ravi Saravanan" <sravisar@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"Pierre-Louis Bossart" <pierre-louis.bossart@linux.dev>, "open list:AMD ASoC
 DRIVERS" <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/6] ASoC: amd: acp: enable function topologies for ACP7.B
 and ACP7.F SoundWire
Date: Thu, 12 Nov 2026 18:05:41 +0530
Message-ID: <20261112123603.2891858-7-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112123603.2891858-1-syed.sabakareem@amd.com>
References: <20261112123603.2891858-1-syed.sabakareem@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: ee84228d-069d-448b-d01a-08df40b9a885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	b+SxkV7NmOsOqNEJ6jZTGnWcr90Uf5VmPLrldKjYjVtDUYnXWNSuLTf2wsgmQ4cUEHuJat+lRHnXhO+7daJvOg869Ezu4zFiH1bXMYYcExP3yMHpTfVpOjpONE3FT8+Q7eTsOzZAPZKqMuRksSwEZlmxE6HGuYscFKtalAUX/fUAubuq80lq76sf89EjT3dSTxcQuKQ+yvJe1v6MgQKAFWtBUdYSlmPG03OfDa3RbxPfohzuJe1zNBDCaeD5BUCS0+Dix3XKPEcHQfAnZz8SjFtm60lelNdqi43VKARXwEo462LuGgKqjC/KxCOpcsThc7TV9yZDCFspj+GejH+EYhLIHJZtJsMTTyLKmt8cFDBCWXgYZJGdfuSEf5DHyjQBBs/t7j9LcSXDHrpan441GaMDOnZVxA6gIl8p1NJAaTvVdjJgxlWL+5+5CDE1dm1ODhmz/27W0fplfksSn2xKfIYwhQr4DyKzK0svz2FGSWDUxL6N5L6RVZ8cBg80ROPvWDTId0eayzquX050p+tuHTrWea/JpdWmXQ3BbtsGDW26uCtTNlPUnr33a94zNYLvs0tI6qbSzOnFRORxEksseAlTZqFgjN/5929XnLFSkRtHnG+fno3ceOHiVuO5izrYuirLIr18rDw6cWOuj6wi/MyU0a9f5UdSqHYNeRx3gKjlLHaF70NpEeiDOXj6tYKNemqUDoMj16miYp+DA7UiEg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	133tYAw6I+yYkTLjz3Kap6IRWgpU5XCBAnl8UXlKIJqn5buroJ8/eS0kZ4WUgN2pGPc3A6YgB/Qvbh4HHLtDasD/tKjkopa6iASMjb3nfHFO7yT+IyWFdKVvzHhsNPaFNg+WVheGdzKpqEaPU3+cDuWvxeXcfVGnko9vl1Hjg58zF+Xo9RtArPo5wZjmC/A6AoIDEW2N9cOmgrjlAghl3ujigFV+dp3oLsy5KFmvJkPSmss2gprTh3LFYoJMCVo8bR1zsUxoUEkvQMo61Twt7qY3euGJG9iKe0zgVhjtebwbd3YVNTeSTWmRUuI6XJn1VbkhOFqrZe0woOfeQWUgJtPvD9Ehl7N7EUdY+za9nbuvZYIieIjHTFkQhIR53yCRn3IEdHl3rZTIi4x9gnaFgEPdVrIWYOyj3jc0KXZhYWgroT06qP7DPOb/O7BpLFqA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:37:04.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ee84228d-069d-448b-d01a-08df40b9a885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
Message-ID-Hash: KYWKFXQQGCDARNPSQXZKBKAXMESRKDSL
X-Message-ID-Hash: KYWKFXQQGCDARNPSQXZKBKAXMESRKDSL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KYWKFXQQGCDARNPSQXZKBKAXMESRKDSL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Siva Subramanian Ravi Saravanan <sravisar@amd.com>

Set get_function_tplg_files for all the ACP7.B and ACP7.F SoundWire
machine entries. The SOF core tries the function topologies first and
falls back to the monolithic topology if any of them is missing, so
existing setups keep working. The monolithic topology is still required
as its presence is checked when the SOF firmware file profile is set up.

Signed-off-by: Siva Subramanian Ravi Saravanan <sravisar@amd.com>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/amd-acp7x-acpi-match.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp7x-acpi-match.c b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
index 786ee5796ee6..b71060c9ecb0 100644
--- a/sound/soc/amd/acp/amd-acp7x-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
@@ -8,6 +8,7 @@
 
 #include <sound/soc-acpi.h>
 #include "../mach-config.h"
+#include "amd-sof-function-topology-lib.h"
 
 static const struct snd_soc_acpi_endpoint single_endpoint = {
 	.num = 0,
@@ -513,6 +514,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7b-rt721-l0-rt1320-l3.tplg",
 		.fw_filename = "sof-acp7b.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{},
 };
@@ -525,6 +527,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-rt721-l0-rt1320-l3.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(1),
@@ -532,6 +535,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-rt721-l0-rt1320-l1.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
@@ -539,6 +543,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-rt721-l0.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
@@ -546,6 +551,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-rt722-l0.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(1),
@@ -553,6 +559,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l43-l0u0-cs35l56x4-l1u3210.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(1),
@@ -560,6 +567,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l45-l1u0-cs35l63x4-l0u0246.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(1),
@@ -567,6 +575,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l45-l0u0-cs35l63x2-l1u01.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(1),
@@ -574,6 +583,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l45-l0u0-cs35l63x2-l1u13.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0) | BIT(1),
@@ -581,6 +591,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l45-l1u0-cs35l63x2-l0u01.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(1),
@@ -588,6 +599,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l43-l1u0-cs35l56x4-l1u0123.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(1),
@@ -595,6 +607,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs35l56x4-l1u3210.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
@@ -602,6 +615,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l43-l0u1.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
@@ -609,6 +623,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l43b-l0u1.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(0),
@@ -616,6 +631,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l45-l0u0.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{
 		.link_mask = BIT(1),
@@ -623,6 +639,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.drv_name = "amd_sof_sdw",
 		.sof_tplg_filename = "sof-acp7f-cs42l45-l1u0.tplg",
 		.fw_filename = "sof-acp7f.ri",
+		.get_function_tplg_files = amd_sof_sdw_get_tplg_files,
 	},
 	{},
 };
-- 
2.43.0

