Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2687C79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:19:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 510EC6027C;
	Thu, 10 Sep 2026 18:19:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 510EC6027C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789057193;
	bh=GjPxU7xj5Hli+ZMf2tuWS2S7RpL9+X/wlE+GNcrZelU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ophup/twymVOeGbavEaZFE1TwxinEkcf2pme7XdV/YN7tmNieSqjwVxJcmmAFFxV/
	 mO58ARUKPh3h+UYPJaba/c2y7PTbiyJZwSshDga+XNKTqmsCHU+a3eJiUwOOs1EtSY
	 0Ah5gYR17pmzx6h5nE4PXSIMS8BJjLP/4UwwNYxI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E47D6F8062F; Thu, 10 Sep 2026 18:18:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5252DF80631;
	Thu, 10 Sep 2026 18:18:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7FD5F8051D; Thu, 10 Sep 2026 18:18:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.42
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789057125;
	b=F4zqC0iC+CRywJ/wXBtlOeIhrIsbT5bC3TtN4RWzPc4mWhs8asv1t5iRn9W/zkdjNX5I
	 Bn2OGtS/ZoA1MG4QcP9OYZlFVrMqUhOPNQFjrN6XvaWbIMTcoZr7A8uSwFlfDtEJqzfFb
	 bvXOezJy2xx7OitJhBjBe7h3i+DXDVsY/l808vvjDTAQlK66dpwuQ3AMVAaYBfyAYKJ0i
	 MEEryAVzJjxCLO2jG8OWo0MWzBT2a1oRA3Bdwqbj0N2jv45AYAUo6yUlYLacQaLqQ26Bq
	 0IG6AOH1yqLydtXC6jq87B9JhTM/0VWRqEHGKPVSPmhWhcL/k6oZrcQwb5UFpaUrNKw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789057125;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GjPxU7xj5Hli+ZMf2tuWS2S7RpL9+X/wlE+GNcrZelU=;
	b=DGsrRYCJFSkBKSixXf57eXi4uwK8cbHeSzeM78aReO3NpnmqX163FB1PqaCvpHVYu5BU
	 kLumBPlXai+TsEN7/zU2w7N0OrhaIC5x1TXjxP5ggaD7t/MHAHe2myFptLwpwG8dL6Xte
	 hSCz3F9Hzu/gju011jmud1qHsIuE6jvfKLl/3lm9UHN69H1BFZvIOZ6a7k093DtM7Sc2z
	 4pG+eS8aCuLE4kCxuPEGCDeVYe9q9KVYIere1pPd+E6q/vNS8dGRhb6GELLO9Eqc1Ifi9
	 mm3RMOTDHA+oWeIbKnQwlMHVj7PHgTx+ocSnDU7w5dZpzt63RpyoFryXgooBgHhE2Eg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Ybd5Z1kV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.42
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A9C97F80272
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 18:18:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9C97F80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Ybd5Z1kV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeGIjTGReaC/RrDY223tp5voUNbuoposlLksyiK2WOQm4Yb7Q2Mu/6DEEvRccQx4x4uupo6QnxoNl5bZEjthmEHIpgu88jVT7jIyrHmX+BL7fu1Z03c/AiZcLKlaZ/qDCzNinB5/nE11Kjfpzk4dnEGykHejvVDhzTGkkt5/bm5kGb4W9QGc2k81zpW+kCh9KxdduXYkcyqFRLDslXfJFAM93SsMyVkISgsasDj6Cm6Z7LTalNKWWwf9aOTZNcBBxjUrQqnr+iDju9PxsJhL3GHOwVw8qf0Ux3lctjVfwXvI0CjivjoNy+XMQmF4nyF5uBwdkuAGEIt/GqS9QrdClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfxu9k6miVdGyeTnIMu4ZFtOULA3ySSTTWQbMgjCKeM=;
 b=o51ATHtVYPkQ6aDquzujPHkdziwubyNIAqo7ip2yE0cxNq56E96fiq45tvCjF4t08P0uSOkycSxyzjs6D9LTN8O1L3cLoR8vybAbQcxxlTMThqJkhs/rVp/otE+WCUE/ZmfYe1MXdgHYjX440i8Pwz2DF5V7QdjG8HHTTL3SWr/H6HyNf8hey/MM5hnixn3KZHTuGSnqXfiGKsffX5Gtmh+M0F83nWRlhCuiTNll0UfKz71aLmAnzyr33EWO57VSTprSx9/lSlPSVIyHb5IzbwX3tQBe4bqvdy9lS2QWNJpE9WQoFeehWV4Dwh2ctuvPigCgIetPOATHxBOMMTeY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfxu9k6miVdGyeTnIMu4ZFtOULA3ySSTTWQbMgjCKeM=;
 b=Ybd5Z1kV39Kpjc/3OfNql4G+yVI7wTMAkr/GOgWdIDBfQTE8cD7qTs0C3DqGAU+xkBSsbSrKsWxgnxEJO800tf1zB9dnevK5PLMCI24VmWSvhrMYYzI0QQU2NsEJgg2xqvA5/LjLpD2xsi+7Y3dZxACyx6E6PRkkU2etRuUWLec=
Received: from SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 16:18:32 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::38) by SJ0PR03CA0370.outlook.office365.com
 (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 16:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 16:18:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 11:18:30 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 11:18:26 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<ckeepax@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/4] ASoC: amd: acp: SoundWire machine driver fixes
Date: Thu, 10 Sep 2026 21:46:45 +0530
Message-ID: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 12773e91-84b0-480c-8a3a-08df0f572804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	w6FwFL3VJU5loarAR7bLbvemfvRJ6cIWzmY92SoI9Kr08gXI7TvBVpW8HQAw9e7YFT9AsDE525v8w2beSxikWqBVCa5TdhzlghDEQNwiC/5rb5apfuW3rKyetwYRWh/ooYtLKjP9V7vps+zUUk9CCKxN9CLZ/QzbUlMHfklMLjKnkpkb9plAJ+kkmRnA8Mz55OVfEz6xo+M3ZYv/z1xilKtbh9AF/5t/NJ41nSth9wGWnoO6cC39Qc3l2EnZzX+OaaDQOUONI9IqPRFYSgtTbcKTh+v/z2gt18tvN7FEUp08GcnX3gr6awPUczRmL81eRIrUDQ/OM2yUlWHRFnSC4wU9Hdz740HY2oCWbLeYmdikOI+RwTmBz4QyUUUSQzWXfpzrIm+CdtUEg6czVjP8ZWCscNhASJNKC74SFgTyMvzIymc9cs7IXDyRa45JoFf8PnkMucf1acN9aT9H1zYL+pYoS/AE0LZITWb05lTLHF2w+mAcLEfPTOHoICkJcj+oXGFiRzT4t2apMWnTXGMUqJx7ns9vgcgAYugoMGmJaCF9ozdJSSJXcXdLLViL7m8U/Bqs1zHAouMOpflwXNN6bP6yiUUhqR1Dtd9g8W8KufkpHLQIRVnGvWZFld5FEpGpPt5z6RX5jFuGkefCEAi9Q/H3esi6ghrcZMd1L6GpA217RdAqr+bHSV68R72aKLrfBcoRttYkkZmk/8dDa1mXvA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	aD3oirp/5p9qHpEoOGXP1gM83tDXrZdVYdQW+fq4fEr28oZq7xvOmTJ+62iFNmFlz906Lvc6I5ODme4uOegpptGDAD50GFvbWX0t0IAI67qDJbwt8/cw1xrUtCh7jmOfSlBz7lh33jm7rzIac5qiZPnOQKf1jZr08v7vcD/qAwTi9NokMz8TXbIb15tMOmfhwTtOzxQgdNtYBjuWGEixsVMXQ/2/sncr+HvStoAW43eJwPzoEtH/qwc/6BE1GGiU56zJzBAYHorJiWmpglVNcC35eZHR6VZFt4/t+6VD1z6yeusbCujciQTCr/vGoXqEyHUqV29xuR+2gVLnnmiVn6QMssei5k4y9VzZVkizS70NFw5kbTg7BlpjJji20J6ItQ9hgUuqXg/W492GLgNcFFRMI515XgvZuA8Ebraqehtecv0InywVW/uxOXvrcYHq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:18:31.6568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 12773e91-84b0-480c-8a3a-08df0f572804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
Message-ID-Hash: 3R5ZY5C2F45C25HJV6SYH6GSOGWZ2RM3
X-Message-ID-Hash: 3R5ZY5C2F45C25HJV6SYH6GSOGWZ2RM3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3R5ZY5C2F45C25HJV6SYH6GSOGWZ2RM3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series fixes four defects in the AMD ACP SoundWire machine drivers
(acp-sdw-legacy-mach.c and acp-sdw-sof-mach.c).

A bounds check is added to validate the SoundWire link ID before it is
used as an array index in create_sdw_dailink(), preventing out-of-bounds
access when an unexpected link_mask value is encountered. The codec
config count in the SOF machine driver is refactored to use a dedicated
variable rather than reusing the endpoint-count variable for two
purposes, making the intent clearer and avoiding a stale value being
passed to the codec config array. An operator-precedence bug in the
ffs(link_mask - 1) expression is corrected to ffs(link_mask) - 1,
ensuring the link ID is derived from the correct bit position. Finally,
the SOF machine driver card name is shortened to fit within the 16-byte
snd_card driver[] field and eliminate a compile-time warning.

Vijendar Mukunda (4):
  ASoC: amd: acp: bounds-check SoundWire link ID in machine drivers
  ASoC: amd: acp: refactor codec config count in SOF SoundWire machine
    driver
  ASoC: amd: acp: fix ffs() operator precedence for SoundWire link ID
  ASoC: amd: acp: fix card name length warning in SOF SoundWire machine
    driver

 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 14 ++++++++++++--
 sound/soc/amd/acp/acp-sdw-sof-mach.c    | 23 +++++++++++++++++------
 2 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.48.1

