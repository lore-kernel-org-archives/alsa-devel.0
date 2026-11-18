Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFD606A330
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=A+xGZDhg;
	dkim=pass (2048-bit key, unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256 header.s=selector1 header.b=qLjPWWdR
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 963B4601EC;
	Wed, 18 Nov 2026 09:43:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 963B4601EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794991403;
	bh=M+yin9X5Lxhq3cxgOAhEg451nSmPyLrG1rrehhgnrho=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=A+xGZDhg7O0f+jNTqLqAv5qubq8eE7T0YxiPK0eLJIorXNSWxavhpT5K0sJoN8fSW
	 67P/S6UFGtZf5b8C7bEO2fv5yRhFzK23rXXrGeG7sgSlQ/ARcqU2AYL4Ay7EZubf89
	 hVFmWZ402Xr8j2Q0U48Rbqgu9M9uRGMp8GZjei50=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76F06F805FE; Wed, 18 Nov 2026 09:42:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65A1DF80601;
	Wed, 18 Nov 2026 09:42:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B745F805C2; Wed, 18 Nov 2026 09:42:40 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.64
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794991357;
	b=SkN5LBDiPHjCHPT8psJBQ09D9heDGKzy5wWZmzVtzjEu2qIUECt6gMgjz+Ma6vsTQtsh
	 x4d+Qn/AtMnNmjB9NQfCIRi5bPpjRNeYNmZFhysfdf6vtTPiMCehg2FtOcQZK/K2aSV3D
	 9pd6wxBvEhhBN6YIxK47PQZWtvrnvr4GJpxYt9W4EBINq0ubHNnoAF1id5+OJVGzTHFSK
	 9LcXhOyMsy3bcmcMK+MEwnXJZFo5V1y29r4fPT//4/fHcxDrUSq9MBcAxhjvmWQfOIuRW
	 hlZwXhlK+JD4PCkBwJ6tyYIPa2xaeNswGJA5mN9cnrgLVP5TEQ+Tnw4Ks0zAkVeMzIA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794991357;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M+yin9X5Lxhq3cxgOAhEg451nSmPyLrG1rrehhgnrho=;
	b=G22/za5dn33VCQkHYdefDTV45VyjENhRUrCGJwG5EtHp02KLWayknPuGCLJ+XHtH3V4W
	 7C7p00JBAJGkfmu0/I9QgmhiaUZX958bOzsQcisFbxqXQqTvHs9ibXmG7mBivuAMDYzwb
	 Keo6jRNpsYNJ6wIab1WV4AJhXlur6XtdIfbn8NetCsMAmxwN8w8CX3OSMnQiwFiQoonAY
	 n9pmOfVW0rd4yetC2F2PCt5GnoPevhvyhjbDla0l8cwvOCUSqXVy6zhwwg2kfjsoMMl2p
	 atIq/7ZTnsuX0DbfSZ8zNFLc1iXC8ISciWu+XWUR0Jri97bDfYgSui97YNd1Kr2nDyQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=qLjPWWdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.64
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 11D10F80538
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2026 09:42:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11D10F80538
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=qLjPWWdR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNth8SXwfnUof3sXlCD/+GYdVNwId1odmnTJthSHmdu2rqmqe4e1M42B+ttu/AXYhRIBWQJN6h/Wv2HkGx0lF9+zIvXCRrQM0ufdkrk5X9oQApdNB7n6mtmL7ZAyLXj/J/Nljzreu8ZDHTIMiR2OVGhwO5usnrjqVOqMi6l5b64NA4qskUXAPHjcWuPqvOXwJQZbcfI0PlxmRgq7TdQ0VUSc2IrcvSYWPC1vHq1UbuEw+l2YuN7lcdG0buS3BPGxWxqLVtq6xLykV8a24Ow0OX//KTfQwhIMr7ELL/Y/2ZXwdaoi9EG98AqZPFpyJghUeiPKPfDtkj9pvoOS+yCDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJLZ8z54W7FSywt7ESFfpP5iF3nGotPh4nJLiYum6aM=;
 b=tDQVwrknjWKYn6I/lhX4H9nz/dSg9Le4+hyPUQvtXxOOK7zbgcA0ZbSL15nWgoGewAmBOL9gaRT9gegK3Suifb64fQ/oxcsK1cBlM8k035GJpbfoRtrENRlXCty/PzvOY8SzUzTapDrtbIjydaVjwZjl7wYy+MGlqoTvu7ublKtX1y2uz3LRWrS1pwlNTJw65dKcc+EGqS9QDhKMg70p8w/1da/T39jdDg+9ru+5S8a9vp77Jy3avbhrzR9pSo5HHR7NrCLDV0cA5lNP1qhK8jPDuVmD6+c/1fSD9DlqUAOH1KWYR8FY/7bNR9Y4KbX6CfCvuxJg3LNVHshUtCakqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJLZ8z54W7FSywt7ESFfpP5iF3nGotPh4nJLiYum6aM=;
 b=qLjPWWdRNsaWEtE7TiQpX4tfZ07RVfeQVrivTC9a3szH5KBrHwvLs+DfPNzCo4LOb/a/vCzK+NusR3ZykEWX1wulYdntvaT+S/w1w9ZcKgi0trUKt5EyHJy0JXVCyX2aHxmlIfEuveGO28ufU323xqCmoreg4iOFEaZ2wE/NrMqp6iSJDDgQtAERH0jHGFJBcXbBKxo6GM9QK0Ib7dQkfrLpR17HKxYZLpOXpdmeXpKGrGfo+rSunM9khiOsj9pTznUEDLZCp+w4n3k9by0wMGl/HDQ37cJQ2bJcEBwjFf93hnDY0ltYKZQkY5TYdunZuKRySVtGboY92F5UUh46nQ==
Received: from SI1PR02CA0015.apcprd02.prod.outlook.com (2603:1096:4:1f7::18)
 by KUZPR03MB9413.apcprd03.prod.outlook.com (2603:1096:d10:4b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:42:20 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:4:1f7:cafe::61) by SI1PR02CA0015.outlook.office365.com
 (2603:1096:4:1f7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 08:42:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 175.98.123.7) smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 08:42:19 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 18 Nov
 2026 16:42:15 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Wed, 18 Nov 2026 16:42:15 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v3 0/2] ASoC: codecs: nau8310: Add NAU83G10 amplifier
Date: Wed, 18 Nov 2026 16:42:12 +0800
Message-ID: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|KUZPR03MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 1366a1f9-c7cd-40ff-943d-08df454fdb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|6133799003|261009223027099003|3023799007|11063799006|5023799004|56012099006|261102123227099003|10067099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 
	skQdCyJ9LgjijmFKPKRT6L3l3/psZyBH/F06xcYDob9vYA13gGngc+eL4BFtWew3kkJGO55YGy7G1j+507e+wXbLIFpnaeielUtlsY8YUxZ4DAxA/+M28yBfdU+7WyE2M/E/u9e5Xaj1DU8TSDlywD1zPZAdw6XGfWeZWWVzp82VbzZWTloMQzOHtfoFOYdJXiIECLYBVZGJkUw2m0x7EIzwYRPpmTaX0LwOwrKP1tdOgkvO8eTYwP3rQnTZ38lnYPlUHQl7yxPxiq0sj709B0O8zArXXXWbFCliTWBLIQQMPWp/o+5ZlbAfhz1/NRek6b7u2lQj1amLQv93COQ3rM2evxqjfV4c7HdTtDpkYt0T7APZWN5iwhp/2P02WbvDmftHJBma27mPL4zptbHynWLWhz3DpQF2kgWf4tYXbWPo9aN2hfWHXBuldDfsdz196+QMi41QtZztKdKNOkf5kCiHqlZHjqqPy8IH8GtJcwKDXyy40vlpOiIPgemkCoifX3SmWAZdekSSFOb0a2uNwre1gtltM31RlHv/KhtPalTVxeSYzM0CVHwPxxdZmqQZWLeEPiLciw2nllV74mWzfDIVKbOKIvgNHC9Xw13MkOJq5zii6dY6JU2NUJLi9aI+fOc6FlNv/qv6Bd1x4W59/ZTUIpY1vgcValhvDfFydJbTJf+i5RoxUzWBZe5QLX6Oz66KDPBRmeCUyzRN8NM9wA==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(5023799004)(56012099006)(261102123227099003)(10067099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CTsQCbEkzfkugEYeQRBJDi9gvLUxc7ch8phH2UN0jMUe2R8skycnu7LljcGWAotwswRll3/XY7yb6hGKjpbkhKNfchGajyuEavdO9TNNo6EeTyW/40DVWM1p1CICfI86S+VX87qzn4h2o82KuFz58He0tgwBERcb+z9gSVPlT6Gw1Qr6GMgO2PS4/eMenivrs5iPxBNFPrEeFNZp7WcuPg037TNOL+xqZHvu68Iempm5pmaw5dDtLr/y3mmA+7Ap0W/p0sqD1pl08TGwDRzwqyHindxFAk5BGsDSdO3UzxP26pygMQaROMYpvxdMWSReiqvCCrYyUDn1NY2VsJ3QOYnRa5OaM+/0VWU8ejJ43BCiTkD2Vwe4T7OYdbT0IJGu5gqed2I7tYcFbzLfk73FTc4fB3YqNDGUuTDI0W6NCS2OcrRrQ1rsaXZ+Os6gGjLf
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:42:19.5388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1366a1f9-c7cd-40ff-943d-08df454fdb71
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9413
Message-ID-Hash: MHC3NDKKKVX76WBUTBOFCYP6C3OXOQ5U
X-Message-ID-Hash: MHC3NDKKKVX76WBUTBOFCYP6C3OXOQ5U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MHC3NDKKKVX76WBUTBOFCYP6C3OXOQ5U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


This patch series adds support for the Nuvoton NAU83G10 audio amplifier.

The NAU83G10 is a mono boost Class-D audio amplifier with
an integrated DSP and I/V-sense support. The driver supports
I2C register access through regmap.
DAPM widgets and routes, TDM interface configuration, and DSP firmware
loading.

The series is structured asd follows:
- Patch 1: Adds the YAML device tree bindings documentation.
- Patch 2: Adds the ASoC audio amplifier driver implementation.

---
Changes in v3:

[dt-bindings]
- Utilized standard physical unit suffixes (e.g., -microvolt, -ms, -ns) for
  electrical and timing properties rather than exposing raw register values.
- Corrects the description of the clock detection disable property (disabling rather than enabling).
- Added an 'allOf' constraint block to explicitly disallow boost-related 
  properties for the NAU8320 variant.
- Adds a usage example for the NAU8320 codec in the dt-bindings yaml.

[codec driver]
- Core & Probe Initialization:
  - Updated device tree property parsing strings to match the new standard unit suffixes.
  - Replaced i2c_remove() with devm_work_autocancel() to prevent uncancelled work.
  - Added device match data to I2C ID tables and verified hardware silicon 
    ID during probe().
  - Dropped obsolete of_match_ptr() and ACPI_PTR() wrappers.
  - Resolved uninitialized `kcs_rst` variable warning by handling empty 
    DSP replies properly.
  - Fixed TDM slot corruption by preventing bitwise-ORing of encoded TX 
    slot selectors, and added bounds checks/warnings for slot configurations.
  - Updated Kconfig description to explicitly include support for the 
    NAU83G20 amplifier.
  - Removed redundant nau8310_sw_reset_chip() and sync regcache after reset.
    
- DAPM, Controls, & Power Management:
  - Fixed type confusion in nau8310_biq_coeff_put() by replacing the 
    incorrect snd_kcontrol_chip() with snd_soc_kcontrol_component().
  - Fixed race conditions in DSP mixer controls by adding DAPM mutex and expanding device lock coverage.
  - Enable and disable Sense pin control to DSP playback streams invoke snd_soc_dapm_sync() in 
    shutdown().
  - Removed nau8310_adc_event() from the "ALC gain selection mode" widget 
    to fix ADCDAT_OE power lifecycle issues.
  - Cleared the firmware loaded flag (`load_fw_done`) during system resume in 
    bypass mode to prevent DAPM from routing audio to an uninitialized DSP.
  - Removed incorrect DAC unmuting behavior in the firmware setup error path.
  - Removed redundant clock source switching from nau8310_dsp_snd_soc_dapm_put().
  - Removed redundant check_dsp_enabled() function.

- Clocks & Hardware Constraints:
  - Fixed clock configuration for 64kHz/96kHz rates, restricted NAU8310_RATES 
    to supported sample rates only, and validated `mult_sel` before executing 
    register writes in nau8310_clock_apply().
  - Added a lock in nau8310_clock_event() to prevent race conditions during 
    system resume by flushing firmware work in DAPM clock events.
  - Updated DAC oversampling control to use SOC_VALUE_ENUM_SINGLE() instead 
    of SOC_ENUM_SINGLE() to prevent exposing reserved register values to userspace.
  - Fixed the maximum ADC volume TLV gain to 2412 (24.12 dB) to match the 
    standard 0.01 dB ALSA scale.
  - Fixed the maximum DSP KCS payload length to 1024 bytes.
  - Fixed sparse endianness warnings in BIQ coefficients controls.
  - Fixed code comment formatting to follow standard kernel style.

Changes in v2:

[dt-bindings]
- No changes since v1.

[codec driver]
- Sort SND_SOC_NAU8310 alphabetically in Kconfig and Makefile.
- Fix uninitialized variable 'kcs_setup_comp.set_kcs_offset' warning reported by kernel test robot.
  Cast 'data[i]' to u32 before bit shifting in payload packing to prevent incorrect sign extension.
- Replace deprecated SND_SOC_DAIFMT_MASTER_MASK with SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK.
- Demote DSP ready status log from dev_info to dev_dbg to reduce log spam.
- Support requesting DSP firmware via 'firmware-name' property defined in device tree.
- Use snd_soc_kcontrol_component() instead of dapm lookup in standard kcontrol handlers.
- Make clock configuration stateless by passing 'fs' and 'mclk' directly as arguments.
  This prevents internal OSC switching from overwriting active user configurations set via set_sysclk(),
  ensuring stable state management during suspend/resume.
- Acquire nau8310->lock within the clock event handler to prevent race conditions during
  DSP command execution and concurrent firmware loading.
- Add NAU8310_CLK_ID_INT to set_sysclk() to properly handle internal ring oscillator configurations.

Neo Chang (2):
  ASoC: dt-bindings: nuvoton,nau8310: Add NAU83G10
  ASoC: codecs: nau8310: Add support for NAU83G10 amplifier

 .../bindings/sound/nuvoton,nau8310.yaml       |  186 ++
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/nau8310-dsp.c                |  678 ++++++
 sound/soc/codecs/nau8310-dsp.h                |  111 +
 sound/soc/codecs/nau8310.c                    | 2068 +++++++++++++++++
 sound/soc/codecs/nau8310.h                    |  635 +++++
 7 files changed, 3694 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml
 create mode 100644 sound/soc/codecs/nau8310-dsp.c
 create mode 100644 sound/soc/codecs/nau8310-dsp.h
 create mode 100644 sound/soc/codecs/nau8310.c
 create mode 100644 sound/soc/codecs/nau8310.h

-- 
2.25.1

