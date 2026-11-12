Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B684606A88B
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=VQpB5df2;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RtY1+xKB
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4EA6601E5;
	Thu, 12 Nov 2026 13:37:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4EA6601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794487079;
	bh=Lbec21uKkb9qSztzKC/P0BTj+MnFji6q1oae/S2VQJM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VQpB5df2yMrFYdSOLKf5I0JRzbovYdDWb/JgKHOkR06zhbj4OfpwnoFpTTczOpyu0
	 nRsorG0H5BzS5YHqV0clFFwa+3B8WgAEQnGNWJxsP8ay31oKYmtd6SOY31mjr32VGs
	 e04m0uHo3b+B8vSG5Er0hGsKLZb/COXdnNbRQgLE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16A43F805F2; Thu, 12 Nov 2026 13:37:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ADA3FF8067E;
	Thu, 12 Nov 2026 13:37:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CDECF80672; Thu, 12 Nov 2026 13:36:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794487008;
	b=OOWJUW8EdOFphvEIJMaFau0NcR1cV6MoAhoZj5Kan0HfELV3Y4yXz4igXHgzTttY2aSB
	 r5QyLNDavGLwke0NdX+Bdm7kC8Rty2idsCGd2ZHgKQu8S8nSm+jFWxhUOR5X1tUc2EXvo
	 zxRYb4CWIBsNn7Rv0vp21oP2YPazgqH+5SbZ04FuL6VLsJ4actIDMLeN8l3UkFhj3U028
	 HuQTQIbdVlEfUOvfsrDf1N8svVYyy6mQzvd4+yi+w2Gu0cYmGJGGUararHV3QXFSbiV8K
	 gwLRp6JbYLq1JjQ9mLqbg+b5KjcgceB+s6+BLhWdh9zU2P53/tiDRgzojWMO6Pxh2lQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794487008;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Lbec21uKkb9qSztzKC/P0BTj+MnFji6q1oae/S2VQJM=;
	b=BAw89B4oAArPYvZnlO5oXH5qPi/Xcl2Hkcym+xBQniyhZ09c+z/rQACgjW8y4/Xc9MoL
	 wHr9ESSKvcpdcjbjVKzCYhO5z298xnHssTcF6YLF1UxgeEK3kA+DcaKq5BNomcq8kkeEa
	 h3r0nm2cbKzOHrxDRZDUCtrUUn0AoYXohv/YevGhTQazI/dbMeSxCScPMSgL4f6Flil0X
	 nflErrspTntw3GnkObuUUL+TqA4DuiO0tLNwuS1TP/EppHDmhdg5fhnSS56TIDw5XPLxN
	 fLJoEptuLCQJBXlAdgc6LwFkdd0KwINd8+1yz0e5b4Uizz3M8WkCCna2v2N5BCZ5EDA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RtY1+xKB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EF260F805D6
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 13:36:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF260F805D6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RtY1+xKB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYyXIf4ac1FTyEZOeZgZbCXuCQzqEE5xV1JV5JwLIcy3KG6Q5muHpAhDHQ4SLpXiBAcd7Ab63nIri3sZcDE59VVYs3xpX8q9MORRZZo4DMrhoFX+7v5dWYLsXsxN63i1xebCig2+Fp51Znxy9oRzlhBID7h1TK8pgLFVrFguln6bdKIrw24zzBfQbkNV2yJQUXqPvTABCD5Rbe5C9NW5A0UrQ2uGXpZIshY6qbE9oMJDAhLiplB0vHrSaeC0ctA7GvbPbSuNRsox0UC6bfweZobm6mh8TKmhhPmLBjpEFW8xpErbLNvhbX+qbjycfs/iwCKmTqWBjdfXy+9RVXYHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKUlr3z/x4wXnh3YudvEQWsilYKiAL78AtC8Cr1Bv1w=;
 b=bMURilzT2yCRONDy2Uv6bbi8cMbIjm7nvZlWBZGnOhnZrzBM+3KTrU+sy7dpXN+clDq0IuRovcdSjnx+JTn8xVdAuScoFaMYi6IzbvcBZvZ3ISfVD4tGaSB7G6AADss+stE0O5N3uum9AZqNRTUCJaI7FfhXBG/pbaQiLgcsYwXyYNtp6SGC0RnJAGdMvdWQHPjwIxA30JsTcQgPNDk5C56ckoXr/BPVlfegJ2EW32nGm3ddbckdQd4ibVys5pcQfIz/5SSMnN5jrXghMPNYuSD4iMhTiDJYfKS+UON4GuvZR5CVQS89o3gpzWPRSZ1zgYFsQTaR7zgkO6XTCwt+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKUlr3z/x4wXnh3YudvEQWsilYKiAL78AtC8Cr1Bv1w=;
 b=RtY1+xKBxN9kFpNbWBNRdds3M1elg1HrZ7ujMvcCcwLP+HuLJY1jifrU/IQOnEcBP7HFBJqV+MzRqNbEQ9H8vaVrnwqy1cUCU+cu7bhcSthjvtjfp44pP/5bykoHek3kIqKp3uMvcbm6s66pitfiUmwtHKnF9YiIqQqADmOqJPU=
Received: from PH7PR03CA0025.namprd03.prod.outlook.com (2603:10b6:510:339::17)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 12:36:36 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::3a) by PH7PR03CA0025.outlook.office365.com
 (2603:10b6:510:339::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 12:36:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 12:36:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:32 -0600
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 06:36:28 -0600
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, "Siva Subramanian
 Ravi Saravanan" <sravisar@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Cezary Rojewski
	<cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/6] ASoC: soc-acpi: move common SOF topology helpers
Date: Thu, 12 Nov 2026 18:05:38 +0530
Message-ID: <20261112123603.2891858-4-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112123603.2891858-1-syed.sabakareem@amd.com>
References: <20261112123603.2891858-1-syed.sabakareem@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f5fec3-fb3b-4df5-87bb-08df40b99769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|1800799024|36860700016|376014|261102130727099003|261028144727099003|261102123227099003|10067099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|11063799006|261021121427099003|261021130227099003|261022113327099003|261022105027099003|261021135927099003|261022115727099003|261021123027099003|261022075727099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	9wtDXbWut2fTqtm0OAkCuuU6gdaTBRBKzngmHPgzzKf4yBox9Wn2mZHtjmfgOET+dyYqg5F3fr3LdJ6E/Z+wgZC4q0UuAS7GbblRb6mVSiZmYt28rWgnWDfowQ73AsToUQEhoeF1XZHeEX8t3lKDPl7UcxYRSk8+0FsuFIIviBLySJTyjJdqwDKsb5RfF8bbzYlBRNXI42jpX5Yzy++5BJ/cfrPef8NZIFE7hTQ/rZwEFsWIHmtKwt1HIxwW8mXxONV82iFIv3qySNhReu2j9mToGdajp/mVMfe7kON/jSWPRr1HJNwmxsx2IoxfrohMjPEDlDWEezXUy+HpYS7bbEhb2WSDIIzS8sOMtK6IDFERBLmOY4MJUFqznuLVCIgFYFNzZCBlFMWR/6Q+etUaJOKff9z0vkxfcz7tGWI2nAJri2pWEpuOHFdl9MUS8gfRMhOlMfuFUw4DRSpZ+0+tgBzWUoGBf5+X+2hjm3/Ac/D4fQPAH8YHg4Hb3HDNDoNpMaOBF3/go7UZEDn0DrGdnf2EYLPBUl8v8fsWrX6kw3sGyfww2jyHOEUnlsUuI2nZm1AFGKxvaCshDSVeEa8lh6VqXV15ZUNhz51BvAMGwQal6XwZrfzhB4Sj/IWkVrr/gkTlsA9BhSfijLC7u2TMy0k8IbFvdk0DVM//IEp+5y9tQ3JJuKyUHb+ZNJQfEonGiQVSUuqGcCfNyE+uCEq+dA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(1800799024)(36860700016)(376014)(261102130727099003)(261028144727099003)(261102123227099003)(10067099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(11063799006)(261021121427099003)(261021130227099003)(261022113327099003)(261022105027099003)(261021135927099003)(261022115727099003)(261021123027099003)(261022075727099003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	RYcDVKsR0d0O2nJxnllv/0AeJ8BMj9LY9MKYVr2Rex3yzB17HIvQCNBydPi/p2ck5LuPHff7735+LNs9d/MOt4Wu64/SozGwSXIhRt4NyDoJcudYZcnht07Bz+P4TwDPHqNJFF82qGYP+JnT2aBLu+JqqwKdEa4apJwU+dCrTsKnmw3uvzxef5yuYyZX4ZECNA7adYZjlqLThR5DBCZeFltBgfud8mlH4005k28+FuJQ4lAxm84NifQ3QQGyKT/VD2BXOggSqVQPs4Pp9J7xU/n9SyrhjxWNTzETIymw2/KImbo+LGKbY6eS7ov85hMjY8U1MNKdikc/mTARRTZ+Kwa1+G1q/tduWF3BXQ/bALnuW/CZtPoA160UE+JINo6aHKjruCgotY4w0fCIsbc3roYN9bjM5Wn4TYaef2Bk7yrpPW9Dm/5bLRaSS5vcBZPw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:36:36.2688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 92f5fec3-fb3b-4df5-87bb-08df40b99769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
Message-ID-Hash: PDRLLBJLCINORGI3HP4B2CTEPS2OZLR6
X-Message-ID-Hash: PDRLLBJLCINORGI3HP4B2CTEPS2OZLR6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PDRLLBJLCINORGI3HP4B2CTEPS2OZLR6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Siva Subramanian Ravi Saravanan <sravisar@amd.com>

Move the SOF function topology helpers out of the Intel-specific code
so that they can be shared with other SOF platforms (e.g. AMD ACP).

The helpers operate on SOF "sof-<platform>-...tplg" topology names, so
they are renamed with an "sof" infix to reflect that they are SOF
specific:
 - get_platform_name() as snd_soc_acpi_sof_get_platform_name()
 - get_tplg_filename() as snd_soc_acpi_sof_get_tplg_filename()

Both helpers take a struct device pointer so that callers that only
have a struct device (such as the AMD ACP machine driver) can use them
directly.

snd_soc_acpi_sof_get_platform_name() parses the platform name out of
the "sof-<platform>-...tplg" filename. Widen the sscanf field from
"sof-%3s" to "sof-%7[^-]" so that platform names longer than three
characters are read correctly. The old "sof-%3s" field captured at most
three characters, so for a longer platform name such as the AMD "acp7f"
it stopped after "acp". That is still one successful conversion, so
sscanf() returned 1, the "ret != 1" check passed and the helper returned
success with a silently truncated platform name ("acp"), which then
produced the wrong topology file name. The "sof-%7[^-]" field instead
reads up to seven characters up to the next "-", capturing the full
"acp7f". Existing Intel platform names are three characters, so their
parsing is unchanged.

The "%7[^-]" field can write up to seven characters plus a NUL
terminator, i.e. eight bytes, into the caller-provided buffer, so every
caller must size that buffer accordingly. Add a public
SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX (8) constant in soc-acpi.h as the
single authoritative buffer size and use it for the Intel platform
buffers, replacing the local SOF_INTEL_PLATFORM_NAME_MAX; otherwise a
longer platform name would overflow the caller's stack buffer.

The topology-file presence check only tests whether a firmware topology
file can be requested, so it is generic. Move it to soc-topology.c as
snd_soc_tplg_files_exist() and drop the SOF-specific download hint from
its warning. As the firmware request now lives in soc-topology.c, drop
the no longer needed linux/firmware.h include from
sof-function-topology-lib.c.

The enum and the helper prototypes move to soc-acpi.h. As the enum
becomes part of a public header, rename it to
snd_soc_acpi_tplg_device_id and prefix its enumerators with
SND_SOC_ACPI_ to avoid polluting the global namespace, and rename the
Intel-specific TPLG_DEVICE_INTEL_PCH_DMIC to the vendor-neutral
SND_SOC_ACPI_TPLG_DEVICE_PCH_DMIC.

The two SOF helpers do not depend on ACPI (they only use sscanf() and
devm_kasprintf()) and are now used by the Intel match code, which is
also built on non-ACPI configurations. Select SND_SOC_ACPI
unconditionally so soc-acpi is always available (SND_SOC_ACPI is a plain
tristate with no ACPI dependency, so this does not force anything
ACPI-specific on non-ACPI builds). Because soc-acpi.c is now compiled on
non-ACPI configurations too, guard its ACPI-only matching functions
(snd_soc_acpi_id_present(), snd_soc_acpi_find_machine(),
snd_soc_acpi_find_package[_from_hid]() and snd_soc_acpi_codec_list())
with CONFIG_ACPI: they call ACPI-only APIs such as acpi_dev_present(),
acpi_fetch_acpi_dev(), acpi_evaluate_object_typed() and
acpi_get_devices(), and the header already provides stubs for the public
ones. Only the ACPI-independent SOF helpers remain exported
unconditionally. Otherwise the build fails on non-ACPI configs, either
with the helpers reported as undefined symbols or with
redefinition/implicit-declaration errors.

Signed-off-by: Siva Subramanian Ravi Saravanan <sravisar@amd.com>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 include/sound/soc-acpi.h                      |  30 ++++
 include/sound/soc-topology.h                  |  10 ++
 sound/soc/intel/Kconfig                       |   2 +-
 .../intel/common/sof-function-topology-lib.c  | 129 ++++--------------
 sound/soc/soc-acpi.c                          |  51 +++++++
 sound/soc/soc-topology.c                      |  16 +++
 6 files changed, 135 insertions(+), 103 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 2ee303b791dc..b850295e9584 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -257,4 +257,34 @@ bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 					const struct snd_soc_acpi_link_adr *link,
 					struct sdw_peripherals *peripherals);
 
+enum snd_soc_acpi_tplg_device_id {
+	SND_SOC_ACPI_TPLG_DEVICE_SDCA_JACK,
+	SND_SOC_ACPI_TPLG_DEVICE_SDCA_AMP,
+	SND_SOC_ACPI_TPLG_DEVICE_SDCA_MIC,
+	SND_SOC_ACPI_TPLG_DEVICE_PCH_DMIC,
+	SND_SOC_ACPI_TPLG_DEVICE_HDMI,
+	SND_SOC_ACPI_TPLG_DEVICE_SSP_JACK,
+	SND_SOC_ACPI_TPLG_DEVICE_SSP_AMP,
+	SND_SOC_ACPI_TPLG_DEVICE_SSP_BT,
+	SND_SOC_ACPI_TPLG_DEVICE_SSP_HDMI_IN,
+	SND_SOC_ACPI_TPLG_DEVICE_LOOPBACK_VIRTUAL,
+	SND_SOC_ACPI_TPLG_DEVICE_MAX
+};
+
+/*
+ * Minimum size, including the trailing NUL, of the buffer that
+ * snd_soc_acpi_sof_get_platform_name() fills from a
+ * "sof-<platform>-...tplg" topology file name. The "sof-%7[^-]"
+ * conversion can write up to seven characters plus a NUL terminator,
+ * so callers must provide a buffer of at least this size.
+ */
+#define SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX 8
+
+int snd_soc_acpi_sof_get_platform_name(struct device *dev,
+				       const struct snd_soc_acpi_mach *mach, char *platform);
+char *snd_soc_acpi_sof_get_tplg_filename(struct device *dev, const char *prefix,
+					 const char *platform, const char *tplg_dev_name,
+					 int dai_link_id,
+					 enum snd_soc_acpi_tplg_device_id tplg_dev);
+
 #endif
diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 1eedd203ac29..cf5c9bd1037e 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -30,6 +30,7 @@ struct snd_soc_dai_link;
 struct snd_soc_dai_driver;
 struct snd_soc_dai;
 struct snd_soc_dapm_route;
+struct device;
 
 /* dynamic object type */
 enum snd_soc_dobj_type {
@@ -181,6 +182,9 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	const struct snd_soc_tplg_ops *ops, const struct firmware *fw);
 int snd_soc_tplg_component_remove(struct snd_soc_component *comp);
 
+/* Check for presence of topology firmware files */
+bool snd_soc_tplg_files_exist(struct device *dev, const char *tplg_files);
+
 /* Binds event handlers to dynamic widgets */
 int snd_soc_tplg_widget_bind_event(struct snd_soc_dapm_widget *w,
 	const struct snd_soc_tplg_widget_events *events, int num_events,
@@ -193,6 +197,12 @@ static inline int snd_soc_tplg_component_remove(struct snd_soc_component *comp)
 	return 0;
 }
 
+static inline bool snd_soc_tplg_files_exist(struct device *dev,
+					    const char *tplg_files)
+{
+	return false;
+}
+
 #endif
 
 #endif
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 63367364916a..af08efa0ac1d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -72,7 +72,7 @@ if SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
 
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
-	select SND_SOC_ACPI if ACPI
+	select SND_SOC_ACPI
 	select SND_SOC_ACPI_INTEL_SDCA_QUIRKS
 	# this option controls the compilation of ACPI matching tables and
 	# helpers and is not meant to be selected by the user.
diff --git a/sound/soc/intel/common/sof-function-topology-lib.c b/sound/soc/intel/common/sof-function-topology-lib.c
index 57e089f8e721..aa36b9961977 100644
--- a/sound/soc/intel/common/sof-function-topology-lib.c
+++ b/sound/soc/intel/common/sof-function-topology-lib.c
@@ -8,92 +8,15 @@
 
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/firmware.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
+#include <sound/soc-topology.h>
 #include "sof-function-topology-lib.h"
 
-enum tplg_device_id {
-	TPLG_DEVICE_SDCA_JACK,
-	TPLG_DEVICE_SDCA_AMP,
-	TPLG_DEVICE_SDCA_MIC,
-	TPLG_DEVICE_INTEL_PCH_DMIC,
-	TPLG_DEVICE_HDMI,
-	TPLG_DEVICE_SSP_JACK,
-	TPLG_DEVICE_SSP_AMP,
-	TPLG_DEVICE_SSP_BT,
-	TPLG_DEVICE_SSP_HDMI_IN,
-	TPLG_DEVICE_LOOPBACK_VIRTUAL,
-	TPLG_DEVICE_MAX
-};
-
-#define SDCA_DEVICE_MASK (BIT(TPLG_DEVICE_SDCA_JACK) | BIT(TPLG_DEVICE_SDCA_AMP) | \
-			  BIT(TPLG_DEVICE_SDCA_MIC))
-
-#define SOF_INTEL_PLATFORM_NAME_MAX 4
-
-static int get_platform_name(struct snd_soc_card *card,
-			     const struct snd_soc_acpi_mach *mach, char *platform)
-{
-	int ret;
-
-	ret = sscanf(mach->sof_tplg_filename, "sof-%3s-*.tplg", platform);
-	if (ret != 1) {
-		dev_err(card->dev, "Invalid platform name of tplg %s\n",
-			mach->sof_tplg_filename);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static bool tplg_files_exist(struct device *dev, const char *tplg_files)
-{
-	const struct firmware *fw;
-	int ret;
-
-	ret = firmware_request_nowarn(&fw, tplg_files, dev);
-	if (!ret) {
-		release_firmware(fw);
-		return true;
-	}
+#define SDCA_DEVICE_MASK (BIT(SND_SOC_ACPI_TPLG_DEVICE_SDCA_JACK) | \
+			  BIT(SND_SOC_ACPI_TPLG_DEVICE_SDCA_AMP) | \
+			  BIT(SND_SOC_ACPI_TPLG_DEVICE_SDCA_MIC))
 
-	dev_warn(dev,
-		 "Failed to open topology file: %s, you might need to\n",
-		 tplg_files);
-	dev_warn(dev,
-		 "download it from https://github.com/thesofproject/sof-bin/\n");
-	return false;
-}
-
-static char *get_tplg_filename(struct device *dev, const char *prefix,
-			       const char *platform, const char *tplg_dev_name,
-			       int dai_link_id, int tplg_dev)
-{
-	char *filename = NULL;
-
-	/*
-	 * The tplg file naming rule is sof-<platform>-<function>-id<BE id number>.tplg
-	 * where <platform> is required for functions that depend on NHLT blobs (e.g. DMIC/SSP)
-	 * as the nhlt blob is platform dependent.
-	 */
-	switch (tplg_dev) {
-	case TPLG_DEVICE_INTEL_PCH_DMIC:
-	case TPLG_DEVICE_SSP_JACK:
-	case TPLG_DEVICE_SSP_AMP:
-	case TPLG_DEVICE_SSP_BT:
-	case TPLG_DEVICE_SSP_HDMI_IN:
-		filename = devm_kasprintf(dev, GFP_KERNEL, "%s/sof-%s-%s-id%d.tplg",
-					  prefix, platform, tplg_dev_name, dai_link_id);
-		break;
-	default:
-		filename = devm_kasprintf(dev, GFP_KERNEL, "%s/sof-%s-id%d.tplg",
-					  prefix, tplg_dev_name, dai_link_id);
-		break;
-	}
-
-	return filename;
-}
 
 static int get_dmic_tplg_dev(struct device *dev, int dmic_num,
 			     int *tplg_dev, char **tplg_dev_name)
@@ -111,7 +34,7 @@ static int get_dmic_tplg_dev(struct device *dev, int dmic_num,
 			 dmic_num);
 		return -EINVAL;
 	}
-	*tplg_dev = TPLG_DEVICE_INTEL_PCH_DMIC;
+	*tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_PCH_DMIC;
 
 	return 0;
 }
@@ -131,16 +54,16 @@ static int get_ssp_tplg_dev(struct device *dev, struct snd_soc_dai_link *dai_lin
 		 * machine drivers
 		 */
 		if (dai_link->id == 0) {
-			*tplg_dev = TPLG_DEVICE_SSP_JACK;
+			*tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_SSP_JACK;
 			*tplg_dev_name = devm_kasprintf(dev, GFP_KERNEL,
 							"ssp%d-jack", ssp_port);
 		} else {
-			*tplg_dev = TPLG_DEVICE_SSP_AMP;
+			*tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_SSP_AMP;
 			*tplg_dev_name = devm_kasprintf(dev, GFP_KERNEL,
 							"ssp%d-amp", ssp_port);
 		}
 	} else if (strstr(dai_link->name, "BT")) {
-		*tplg_dev = TPLG_DEVICE_SSP_BT;
+		*tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_SSP_BT;
 		*tplg_dev_name = devm_kasprintf(dev, GFP_KERNEL,
 						"ssp%d-bt", ssp_port);
 	} else if (strstr(dai_link->name, "HDMI")) {
@@ -149,7 +72,7 @@ static int get_ssp_tplg_dev(struct device *dev, struct snd_soc_dai_link *dai_lin
 		if (hweight16(*hdmi_in_mask) != 2)
 			return -EINVAL;
 
-		*tplg_dev = TPLG_DEVICE_SSP_HDMI_IN;
+		*tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_SSP_HDMI_IN;
 		*tplg_dev_name = devm_kasprintf(dev, GFP_KERNEL,
 						"ssp%x-hdmiin", *hdmi_in_mask);
 	} else {
@@ -173,7 +96,7 @@ int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 	 */
 	struct snd_soc_acpi_mach_params mach_params = card_mach->mach_params;
 	struct snd_soc_dai_link *dai_link;
-	char platform[SOF_INTEL_PLATFORM_NAME_MAX];
+	char platform[SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX];
 	unsigned long tplg_mask = 0;
 	u16 hdmi_in_mask = 0;
 	int tplg_num = 0;
@@ -182,7 +105,7 @@ int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 	int ret;
 	int i;
 
-	ret = get_platform_name(card, mach, platform);
+	ret = snd_soc_acpi_sof_get_platform_name(card->dev, mach, platform);
 	if (ret < 0)
 		return ret;
 
@@ -191,30 +114,30 @@ int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 
 		dev_dbg(card->dev, "dai_link %s id %d\n", dai_link->name, dai_link->id);
 		if (strstr(dai_link->name, "SimpleJack")) {
-			tplg_dev = TPLG_DEVICE_SDCA_JACK;
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_SDCA_JACK;
 			tplg_dev_name = "sdca-jack";
 		} else if (strstr(dai_link->name, "SmartAmp")) {
-			tplg_dev = TPLG_DEVICE_SDCA_AMP;
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_SDCA_AMP;
 			tplg_dev_name = devm_kasprintf(card->dev, GFP_KERNEL,
 						       "sdca-%damp", dai_link->num_cpus);
 			if (!tplg_dev_name)
 				return -ENOMEM;
 		} else if (strstr(dai_link->name, "SmartMic")) {
-			tplg_dev = TPLG_DEVICE_SDCA_MIC;
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_SDCA_MIC;
 			tplg_dev_name = "sdca-mic";
 		} else if (strstr(dai_link->name, "dmic")) {
 			if (get_dmic_tplg_dev(card->dev, mach_params.dmic_num,
 					      &tplg_dev, &tplg_dev_name) < 0)
 				continue;
 		} else if (strstr(dai_link->name, "iDisp")) {
-			tplg_dev = TPLG_DEVICE_HDMI;
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_HDMI;
 			tplg_dev_name = "hdmi-pcm5";
 		} else if (strstr(dai_link->name, "SSP")) {
 			if (get_ssp_tplg_dev(card->dev, dai_link, &hdmi_in_mask,
 					     &tplg_dev, &tplg_dev_name) < 0)
 				continue;
 		} else if (strstr(dai_link->name, "Loopback_Virtual")) {
-			tplg_dev = TPLG_DEVICE_LOOPBACK_VIRTUAL;
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_LOOPBACK_VIRTUAL;
 			/*
 			 * Mark the LOOPBACK_VIRTUAL device but no need to create the
 			 * LOOPBACK_VIRTUAL topology. Just to avoid the dai_link is not supported
@@ -235,13 +158,14 @@ int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 		if (tplg_mask & BIT(tplg_dev))
 			continue;
 
-		tplg_file = get_tplg_filename(card->dev, prefix, platform, tplg_dev_name,
-					      dai_link->id, tplg_dev);
+		tplg_file = snd_soc_acpi_sof_get_tplg_filename(card->dev, prefix,
+							       platform, tplg_dev_name,
+							       dai_link->id, tplg_dev);
 		if (!tplg_file)
 			return -ENOMEM;
 
 		/* Check presence of sub-topologies */
-		if (!tplg_files_exist(card->dev, tplg_file)) {
+		if (!snd_soc_tplg_files_exist(card->dev, tplg_file)) {
 			devm_kfree(card->dev, tplg_file);
 			if (best_effort)
 				continue;
@@ -266,7 +190,7 @@ int sof_i2s_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 {
 	struct snd_soc_acpi_mach_params mach_params = mach->mach_params;
 	struct snd_soc_dai_link *dai_link;
-	char platform[SOF_INTEL_PLATFORM_NAME_MAX];
+	char platform[SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX];
 	unsigned long tplg_mask = 0;
 	u16 hdmi_in_mask = 0;
 	int tplg_num = 0;
@@ -275,7 +199,7 @@ int sof_i2s_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 	int ret;
 	int i;
 
-	ret = get_platform_name(card, mach, platform);
+	ret = snd_soc_acpi_sof_get_platform_name(card->dev, mach, platform);
 	if (ret < 0)
 		return ret;
 
@@ -292,7 +216,7 @@ int sof_i2s_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 					      &tplg_dev, &tplg_dev_name) < 0)
 				continue;
 		} else if (strstr(dai_link->name, "iDisp")) {
-			tplg_dev = TPLG_DEVICE_HDMI;
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_HDMI;
 			tplg_dev_name = "hdmi-pcm5";
 		} else {
 			/* The dai link is not supported by separated tplg yet */
@@ -307,13 +231,14 @@ int sof_i2s_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 		if (tplg_mask & BIT(tplg_dev))
 			continue;
 
-		tplg_file = get_tplg_filename(card->dev, prefix, platform, tplg_dev_name,
-					      dai_link->id, tplg_dev);
+		tplg_file = snd_soc_acpi_sof_get_tplg_filename(card->dev, prefix,
+							       platform, tplg_dev_name,
+							       dai_link->id, tplg_dev);
 		if (!tplg_file)
 			return -ENOMEM;
 
 		/* Check presence of sub-topologies */
-		if (!tplg_files_exist(card->dev, tplg_file)) {
+		if (!snd_soc_tplg_files_exist(card->dev, tplg_file)) {
 			devm_kfree(card->dev, tplg_file);
 			if (best_effort)
 				continue;
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 270f9777942f..1c6e20e00dca 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -4,10 +4,12 @@
 //
 // Copyright (c) 2013-15, Intel Corporation.
 
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <sound/soc-acpi.h>
 
+#if IS_ENABLED(CONFIG_ACPI)
 static bool snd_soc_acpi_id_present(struct snd_soc_acpi_mach *machine)
 {
 	const struct snd_soc_acpi_codecs *comp_ids = machine->comp_ids;
@@ -124,6 +126,7 @@ struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
 	return mach;
 }
 EXPORT_SYMBOL_GPL(snd_soc_acpi_codec_list);
+#endif /* CONFIG_ACPI */
 
 #define SDW_CODEC_ADR_MASK(_adr) ((_adr) & (SDW_DISCO_LINK_ID_MASK | SDW_VERSION_MASK | \
 				  SDW_MFG_ID_MASK | SDW_PART_ID_MASK))
@@ -200,5 +203,53 @@ bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(snd_soc_acpi_sdw_link_slaves_found);
 
+int snd_soc_acpi_sof_get_platform_name(struct device *dev,
+				       const struct snd_soc_acpi_mach *mach, char *platform)
+{
+	int ret;
+
+	/* platform must hold at least SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX bytes */
+	ret = sscanf(mach->sof_tplg_filename, "sof-%7[^-]-*.tplg", platform);
+	if (ret != 1) {
+		dev_err(dev, "Invalid platform name of tplg %s\n",
+			mach->sof_tplg_filename);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_acpi_sof_get_platform_name);
+
+char *snd_soc_acpi_sof_get_tplg_filename(struct device *dev, const char *prefix,
+					 const char *platform, const char *tplg_dev_name,
+					 int dai_link_id,
+					 enum snd_soc_acpi_tplg_device_id tplg_dev)
+{
+	char *filename = NULL;
+
+	/*
+	 * The tplg file naming rule is sof-<platform>-<function>-id<BE id number>.tplg
+	 * where <platform> is required for functions that depend on NHLT blobs (e.g. DMIC/SSP)
+	 * as the nhlt blob is platform dependent.
+	 */
+	switch (tplg_dev) {
+	case SND_SOC_ACPI_TPLG_DEVICE_PCH_DMIC:
+	case SND_SOC_ACPI_TPLG_DEVICE_SSP_JACK:
+	case SND_SOC_ACPI_TPLG_DEVICE_SSP_AMP:
+	case SND_SOC_ACPI_TPLG_DEVICE_SSP_BT:
+	case SND_SOC_ACPI_TPLG_DEVICE_SSP_HDMI_IN:
+		filename = devm_kasprintf(dev, GFP_KERNEL, "%s/sof-%s-%s-id%d.tplg",
+					  prefix, platform, tplg_dev_name, dai_link_id);
+		break;
+	default:
+		filename = devm_kasprintf(dev, GFP_KERNEL, "%s/sof-%s-id%d.tplg",
+					  prefix, tplg_dev_name, dai_link_id);
+		break;
+	}
+
+	return filename;
+}
+EXPORT_SYMBOL_GPL(snd_soc_acpi_sof_get_tplg_filename);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ALSA SoC ACPI module");
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 35cbe29d2275..eb72cf741b8e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2245,3 +2245,19 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp)
 	return !list_empty(&comp->dobj_list);
 }
 EXPORT_SYMBOL_GPL(snd_soc_tplg_component_remove);
+
+bool snd_soc_tplg_files_exist(struct device *dev, const char *tplg_files)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = firmware_request_nowarn(&fw, tplg_files, dev);
+	if (!ret) {
+		release_firmware(fw);
+		return true;
+	}
+
+	dev_warn(dev, "Failed to open topology file: %s\n", tplg_files);
+	return false;
+}
+EXPORT_SYMBOL_GPL(snd_soc_tplg_files_exist);
-- 
2.43.0

