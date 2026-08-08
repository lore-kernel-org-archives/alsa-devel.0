Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C9BC5B56A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:24:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 588C46021C;
	Wed, 12 Aug 2026 11:24:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 588C46021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526692;
	bh=0Tbbs51vW7OseNJd0r3C83XNgiogc27K9VWDFO0zlS8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JMa1PVlNsvfYnNmfb3cQ142MNTYveyMyZx2rzOw9pXqd74wd469HcDFjKpXvlYk8K
	 jfKO2B8buSnSGvuR8hpTfJ8FZ0eSugj/4GZQHAiBCBgpvqt7/25vFjeF5lHcTdUlDj
	 IA8Dcal/Ou01FoJBz/MrZU+QD4slh/f9zHlOekqY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45021F8061F; Wed, 12 Aug 2026 11:24:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEBE2F80630;
	Wed, 12 Aug 2026 11:24:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3893F80571; Sat,  8 Aug 2026 09:09:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.113
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786172960;
	b=PQpP12Tg4hxfv7Nvb8YpusnMh3t+2bNwBvEnaQVoqkCVTdHplkq7Cb2UkT9fzvPsXqFu
	 1TXlElwlRogzr87ZH+zdyQttChwMwY1GmlziXBKxUopgSebKInI63hhuBMCAcHkyhIrd9
	 TJ34ALCx+QvO0MvpyjEQAvcAaNun7becHq4afu4w0gqoYNqi5foNTungI74FpQBWIt9SH
	 c6YBh/u0sCdcobko4h06zlocIVf/u+dtbZbPzvMdw6WeAU50xa/InY6VzcH6mwSJVH5+V
	 MQQqiC0t67MXkYb0eeQhB2lWkIisQB7DbXxtLQbOxs2fN+L/EupgyEyqzlmfVxrjVnQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786172960;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0Tbbs51vW7OseNJd0r3C83XNgiogc27K9VWDFO0zlS8=;
	b=EvBSRGdcUR1zuemQ+ezWcE/ELRYQjYFEqyHecBDNUhY357DN9+ZdhscNncxHg5mGftfa
	 E3kETYEoWGQPoKW3547n50wIFqPT4xoBe5FqyQnir/4Gkbx8oVd1V3MxxDW8aVWzrgOT0
	 UEBprqnW/cFuodrxeLoMnKo5yBmn7Yqws0K9f4mOllC+GOn4rLkqRIgpRM9qbq5/SXe2h
	 KlJnjXgLCQbb5CifAHT1EqwbCBF1dGNXzCkUPTb6jlIcuAZutfss2ghLE6U5aKjnIfelj
	 bOEotui3erVWLLpH3/UB3YqDkacxC1YVi/QHZvMQf8oEquZZWYxZH9xYm724aB9BMNQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=macalinao.org header.i=@macalinao.org header.a=rsa-sha256
 header.s=selector1 header.b=wLSalINh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.113
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023113.outbound.protection.outlook.com
 [40.107.44.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5400EF8012B
	for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2026 09:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5400EF8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=macalinao.org header.i=@macalinao.org
 header.a=rsa-sha256 header.s=selector1 header.b=wLSalINh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDU840Bq4lyPgwW6+LaEbkjiGMbiuj7zuXjvAeuIFYcKAw9sF+FvH2zLrmTMyX7hb0x83zt1IaWGY2h0mhNlAEPiySLhwStCRbbDB/nrg99hELqS6DuT8AMur0cDd3veteCq+BtGh1EZbN3mkT2u/Zei8EjJWoIsKj0vt9QVVC/fTkReV0cmMSZPE1i13exRTuH9xQiAlO4lVedIqKRYUsFL+LH3xY5wVO/fupAcgrycdbuCO7ZDUVqKkyoyGsvTRarM7skgegXF/bbSVep/+fGlI13jjFfjUpGBfGaj0dLHf89VEbhnlliqW+drSon6gm03bEZuVcl0z5+TxoURbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9NWncwrzylm9J7OoMsJ9xn47fuNXBCJzj5n8b3nWpw=;
 b=D26W7xOWj3e5fOVrhpgkF8WFLIgqP5drcY2ZbAl/CSeKCOxMfP2Rv1XFgZ1maq+ZApniMbcPyeR2iXYCF+/GvO1xax6Cn0SaFiY4RddW1WzDY0rvpydVeELzlTENwPitk+sLt3KoBAv3n1RYNVU10zLt7UUdmwQlRvR3ZkPR+xZKe87mTOZkBW7CL0Rcv7/3CfK2j0NpM6EnA4NkoJ/4fKX6tldSs0R+Do5Q0omqkpJXYf/npKnUMIOL7ePcqOkTxqs+zpsecQXMY4lwVjFQN24zYGV+mty8munHy44yPskB1+8snn/y780HbjEFU1DKog+xo/9uk/b994MYMDYEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=macalinao.org; dmarc=pass action=none
 header.from=macalinao.org; dkim=pass header.d=macalinao.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macalinao.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9NWncwrzylm9J7OoMsJ9xn47fuNXBCJzj5n8b3nWpw=;
 b=wLSalINhrdLW0zg3ZwSB5PR3vNiHUtVB5Pn+K47gC1U33G4hTuFVyBfsNOOmlbbq26kApU6lqjWYghhWz3/ThesD74LXo4iq8ppZ5pREcREKm8p2YPBmE679G5GOhBoloVXb9mA9RsnmdwAREwpupYv5boV0U3osiif47YDh0LaAsNJ+BYQgEeI44XQtrC1fqyDBxUzr5z5o8GolVraDZelmaqF8GQG61ekFEcJgqnkcgBdrCDWraa6SXUVaCUYp2VLSb3tFJkb/xTZKPbo9V25YkTbQvot8MQlpHk5UW6F1etkZddN8I4BUviQA6fdnWaA+FSxSwZML6gYBFLBBmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macalinao.org;
Received: from SI2PR03MB5290.apcprd03.prod.outlook.com (2603:1096:4:102::11)
 by SEZPR03MB6959.apcprd03.prod.outlook.com (2603:1096:101:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 07:09:10 +0000
Received: from SI2PR03MB5290.apcprd03.prod.outlook.com
 ([fe80::5923:f4d6:70b1:270c]) by SI2PR03MB5290.apcprd03.prod.outlook.com
 ([fe80::5923:f4d6:70b1:270c%4]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 07:09:10 +0000
From: JJ Macalinao <jj@macalinao.org>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	JJ Macalinao <jj@macalinao.org>
Subject: [PATCH] ALSA: usb-audio: add QUIRK_FLAG_ALWAYS_SET_RATE for Mackie
 DLZ Creator XS
Date: Sat,  8 Aug 2026 15:09:02 +0800
Message-ID: <20260808070902.835360-1-jj@macalinao.org>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To SI2PR03MB5290.apcprd03.prod.outlook.com
 (2603:1096:4:102::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5290:EE_|SEZPR03MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ca09c5-2e4f-4cbd-7a08-08def51bf1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|786006|376014|23010399003|41320700013|18002099003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 
	C0B7dKIVPyBHWQdsIXEyhvU+2gKjrGcgNKvVLrIsnaJtp03UcXXxcD59haWl/CiHsjE9ZiMn52YojEoxY17za5EjnDEUhc2qUDzWauD8oDiX6f5ZcJ+zJPGTXq8ktWlIU+JK3ojoq22+WJ6GiDMZxGKP/SVGWVkKI5JoAFqEADOlso3k8dHqep8YVxPu/g/DQj1u6OeEpdfpBP2ljc71tfL+0uKjUa1akdP05xcWMXAfjn0TEiayC3qi7SXWfMEgTxUPDkbntRaKwBavfG4UkE/+Z3SCqSvjAWyqLYc8VncTgxPucxi95ZWtpnHGrbTd56H3VxQ9kaUlJok23z3hL4yevjkgLGFuMKV9PqWRJ1Bdo7s15+2JLuMLk0QxQg9TheGVeJ7oCvFYjnSMjKerQyAAL50cB6EHT7O9hXvEe9wKggTiHqZYN/dIrTHNbm5iHc0xQgWwMspvwC6x533a4nBsu6EsAHfSbZrzZdYmKWR/ksiedAxRSEHYbSvnAPF5aAqhChWYCvttL8wilkDKuOLfGTANtOlpVXz2n7Z1jCmABmu8w4DlRMKFrPJ/Ei80LH2sJLFsMHsbGrL73yT7lZwqFI4i2zZuKvb4Wun9VaW63BDgEoN7+XSpIohVq3CZM9mjV4SBdZsf7R+4kRNl1abjLRbw7E0YTNNp55QtLKI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5290.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(786006)(376014)(23010399003)(41320700013)(18002099003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ERyCXgM5ouNtMvlna4HWI2szZLNEwy+Jm65EsWB6ckAK5TAj0cyYxw2Ap/A5?=
 =?us-ascii?Q?cDPKseyz6iq631s5t7lzvcpaQzT62Lk8SHCSI4bNAsVvh98kvLwHBMCP1hua?=
 =?us-ascii?Q?FiUtyRxnAYrQaWr/oLp3lqi6k754DsS6BeX5wgpwP7AtJCzGMnDdDWAUaMu2?=
 =?us-ascii?Q?U5EFQPWijxemWO+TUcd42ca4npdgLXN/DkbaKnOnvDFNKNlRayMP0llMZ9nN?=
 =?us-ascii?Q?xL2VW/6lWB0JPU6gedoSjFrz2+IFS/bc4jgCq6Dnj6ewFiPiHJtGEhm3mh6D?=
 =?us-ascii?Q?QoCdjAiCFlqOGpnzM9AgHtje7S54SkoTPXIy2gKBb3pg/4s1JlBhi1D4FQ3Z?=
 =?us-ascii?Q?U5sk9bcuDMpE3DFfPPJKFO40GRrp4y96aay57H8KpQTdJEKiGprQ7Ib/N8az?=
 =?us-ascii?Q?6JL3ds1Z8/YyAHT5Ay+nIYOerv98UPINoSsJuySY9kmPCjMVaWu9YTAT2QgZ?=
 =?us-ascii?Q?+Y5Y3AYOyj7LFaqVSJrAnE6H6QRtxkLm0r2q1cIVFj562WLDOOrZPv9EvIX2?=
 =?us-ascii?Q?lJzDS3lpiOkgYcaBWuFC/Mmug/VIjJIwAOqplV3HWiSjwvXZUGebedYRq6p2?=
 =?us-ascii?Q?sJDRwkTBgForukHFwp2HlSN3+b1jLUuYVtk155ykrcqUeLHT1zFMSX4zpsQN?=
 =?us-ascii?Q?N7h4DybxgieaBKMnNUmIPN7bAjXoVkencQ6NYqOSvky1I9AT0U0YT2tNUaHf?=
 =?us-ascii?Q?9ZX6YXrSQsZQM3ZXYh6MsPp8mZf36S5QwiiELJJJOu1V0WPJ2JJP9/aF31Th?=
 =?us-ascii?Q?mlVtmp8TAISDxbtsaNwAW7G8lEYFywVZYea2tHrQHvxzLsxJJ+URV0O+miGp?=
 =?us-ascii?Q?jjzf35yZNzHFq64hD/IbRYZya2oy31Gb7v23tUVtvqDbLJLDo/Y1khd74waG?=
 =?us-ascii?Q?taFPGubankZ2IvSF7d7wN/A4TMidEleZlMfQ8lV7oXgNIPhspyQSmBjMIjgj?=
 =?us-ascii?Q?b4aUxyGCAZ7Wc8NjRUYGomkucvo6tlTFMRP8NVFqyhWDdhV7IgUeQDugZIgF?=
 =?us-ascii?Q?kuSAHew8swrZX0GvBq71UozeXsSIz9JI9gIFZdJL8KQdV4pzKdkM2oCUSjXL?=
 =?us-ascii?Q?aqsk2paNanx7R/q9/hoam0f+2KIsGsbLz7LTdHFxWUMwoZbAHJClQdZyodAd?=
 =?us-ascii?Q?3PxKoD34nmmaPWg/c05pVg2TB0SHStxsE9g+bYVhBrOUODWYlWZp4I5JJ24P?=
 =?us-ascii?Q?TEBO69L7jrxzr4yVhkegQ7XtIahzu66dCoTmmfotL0UH3+loEIq9cc26wccb?=
 =?us-ascii?Q?pJ7aqnvFe+xpPc2lzC4jMJTPz38bkSpyjaI+fhr8HaFPUnAcydyr8Zoct3mc?=
 =?us-ascii?Q?iBAJwH+9V3+uM4fC8no1+/77yX6K5WMzt75mQcQQSKHd/YJhputUSHTODhb8?=
 =?us-ascii?Q?18RWe7zpN+/E5Y6Al2aBTgsFgHQ0wtVxo8Z0Heo8m8U37luFpoa5RMDA5PKZ?=
 =?us-ascii?Q?pllL2EPrdOXsk1li4Z8y/F0lc8J5ikbkOnckvC7QNY/k8DCWuJO0tKV6UkMv?=
 =?us-ascii?Q?Er5q6CC0QuCTAhtY1RM4HEZpQobRbJMwORKbBtbkIidP8hv1tgurtqupiVAQ?=
 =?us-ascii?Q?4DPMDOI6I3zymLmtV21/OpQaGTZ/JImmHq0JMG8KgxZ5bojzd1wIL5ASlEkU?=
 =?us-ascii?Q?TBExr121uT9fy5bLmNv+c7nnX9kLSEj9Io9WDuLP+A7d59jE2e9xd555MGT1?=
 =?us-ascii?Q?BPhcUj/RCoBU8CToj/HV4TN8twJ99yIal4vaHt46bO51ImJRe+xHp3pl7V09?=
 =?us-ascii?Q?Cqjey89kwQ=3D=3D?=
X-OriginatorOrg: macalinao.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a1ca09c5-2e4f-4cbd-7a08-08def51bf1d9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5290.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 07:09:10.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87e58715-deae-490b-8b96-6d6239d507f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 vaaYzTioDxM9FUwqU7zlXaRMT8wxzEDt6yF/pkUJbYWONVrcIoShBL3vfpZI63PV4tRmeCQhMDGC20MOGPT8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6959
X-MailFrom: jj@macalinao.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: UQEGCEO5OZRELYK7PAEZAJBOHGQAX6QT
X-Message-ID-Hash: UQEGCEO5OZRELYK7PAEZAJBOHGQAX6QT
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:23:59 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UQEGCEO5OZRELYK7PAEZAJBOHGQAX6QT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

set_sample_rate_v2v3() returns early when the clock already reports the
requested rate:

	prev_rate = get_sample_rate_v2v3(chip, fmt->iface,
					 fmt->altsetting, clock);
	if (prev_rate == rate)
		goto validation;

A device advertising exactly one sample rate always takes this branch, so
it never receives a SET_CUR for CS_SAM_FREQ_CONTROL at all.

The Mackie DLZ Creator XS (0a73:003a, 14 in / 4 out, 48 kHz only) requires
that write.  Without it the device drops off the USB bus roughly 0.2-1.8 s
into any stream, clearing its port CONNECTION bit; captured audio is
byte-correct until the instant it vanishes.

USBPcap traces of a cold-booted device on Windows show SET_CUR 48000 issued
unconditionally on every stream start, followed by clean streaming.  The
device is otherwise driven with plain class-compliant UAC2 - it also works
on iOS, which cannot load a vendor driver - so no vendor-specific
initialisation is involved.

The device is self-powered, so the resulting state survives a USB replug:
initialising it on any host that issues the write leaves it working on
Linux until it is power-cycled, which made the failure look intermittent.

Add a quirk flag rather than dropping the early exit, since the opposite
requirement also exists in-tree: QUIRK_FLAG_FIXED_RATE suppresses rate
setting for single-rate devices (JBL Quantum610/810).  The two behaviours
are device-dependent and cannot both be the default.

A/B on identically cold-booted hardware, same kernel, same port, repeated
twice:

  without the flag  device dropped after 5-6 s, then again after 3-4 s
  with the flag     20 s playback followed by 20 s of 14-channel capture,
                    960000 frames, zero re-enumerations

This change was developed with an AI coding assistant.  The assistant did
the trace analysis that located the bug and wrote the patch and this
changelog; the hardware testing, the cold-boot cycles and the decision to
submit were the author's.  Several earlier hypotheses it proposed - URB
queue depth, isochronous packet under-allocation, endpoint start ordering -
were disproven by measurement before this one.

The bug was located with usbmon on Linux and USBPcap on Windows, by
diffing an enumeration capture of a cold-booted device on each host.
Verified on physical hardware by the A/B above.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: JJ Macalinao <jj@macalinao.org>
---
 sound/usb/clock.c    | 3 ++-
 sound/usb/quirks.c   | 3 +++
 sound/usb/usbaudio.h | 6 ++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 2e0c18e352..647bf55b1b 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -626,7 +626,8 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip,
 	}
 
 	prev_rate = get_sample_rate_v2v3(chip, fmt->iface, fmt->altsetting, clock);
-	if (prev_rate == rate)
+	if (prev_rate == rate &&
+	    !(chip->quirk_flags & QUIRK_FLAG_ALWAYS_SET_RATE))
 		goto validation;
 
 	cur_rate = snd_usb_set_sample_rate_v2v3(chip, fmt, clock, rate);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3330eb6049..d00d6a543a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2333,6 +2333,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0951, 0x16ad, /* Kingston HyperX */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0a73, 0x003a, /* Mackie DLZ Creator XS */
+		   QUIRK_FLAG_ALWAYS_SET_RATE),
 	DEVICE_FLG(0x0b05, 0x18a6, /* ASUSTek Computer, Inc. */
 		   QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
@@ -2638,6 +2640,7 @@ static const char *const snd_usb_audio_quirk_flag_names[] = {
 	QUIRK_STRING_ENTRY(IFB_SILENCE_ON_EMPTY),
 	QUIRK_STRING_ENTRY(MIXER_GET_CUR_BROKEN),
 	QUIRK_STRING_ENTRY(PLAYBACK_URB_FIXUP),
+	QUIRK_STRING_ENTRY(ALWAYS_SET_RATE),
 	NULL
 };
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 31e6125000..c49709d7ad 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -260,6 +260,10 @@ extern bool snd_usb_skip_validation;
  *  to insufficient buffer depth combined with xHCI scheduling variability.
  *  The larger buffer (MAX_URBS = 12, ~64ms) absorbs system scheduling
  *  jitter during boot, while URB_ISO_ASAP ensures consistent xHCI scheduling.
+ * QUIRK_FLAG_ALWAYS_SET_RATE:
+ *  Issue SET_CUR for the sample rate even when the clock already reports the
+ *  requested rate.  A device advertising a single rate is otherwise never sent
+ *  the request at all, and some require it before streaming will start.
  */
 
 enum {
@@ -295,6 +299,7 @@ enum {
 	QUIRK_TYPE_IFB_SILENCE_ON_EMPTY		= 29,
 	QUIRK_TYPE_MIXER_GET_CUR_BROKEN		= 30,
 	QUIRK_TYPE_PLAYBACK_URB_FIXUP		= 31,
+	QUIRK_TYPE_ALWAYS_SET_RATE		= 32,
 /* Please also edit snd_usb_audio_quirk_flag_names */
 };
 
@@ -332,5 +337,6 @@ enum {
 #define QUIRK_FLAG_IFB_SILENCE_ON_EMPTY		QUIRK_FLAG(IFB_SILENCE_ON_EMPTY)
 #define QUIRK_FLAG_MIXER_GET_CUR_BROKEN		QUIRK_FLAG(MIXER_GET_CUR_BROKEN)
 #define QUIRK_FLAG_PLAYBACK_URB_FIXUP		QUIRK_FLAG(PLAYBACK_URB_FIXUP)
+#define QUIRK_FLAG_ALWAYS_SET_RATE		QUIRK_FLAG(ALWAYS_SET_RATE)
 
 #endif /* __USBAUDIO_H */
-- 
2.55.0

