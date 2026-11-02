Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8F606B1E4
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=g4gxxmkq;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4DuzLGO1
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E900601EF;
	Mon,  2 Nov 2026 15:25:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E900601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793629569;
	bh=YiXb+qLf5b5epXvGL7RoKzCHdra2PBAGkBMxwwIJ1iU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=g4gxxmkqRYnIPzGnfHzzqLpfmodvVlRH4t/3mSM69BMKVkD6l01tIOgyhArMto3zA
	 lVFnxFlCx2nESV9bH0R7jfAHwpklnC0g5hvIfXPtYevNqQb+Ch5PdqiQS+NmXe9g1V
	 G9Ei5iq5qdwvg78T9nE4T3aOCZ4FDHMDlNF8EElU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7715F80607; Mon,  2 Nov 2026 15:22:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E057CF805F7;
	Mon,  2 Nov 2026 15:22:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73477F80272; Mon,  2 Nov 2026 15:22:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8638DF80095;
	Mon,  2 Nov 2026 15:22:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8638DF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4DuzLGO1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYIleb6vCqm+Wg+Pc45+4reeDordPTL7MThZG5z8P0q/Zy7X0wBfBFn6Hubd7QOAFGDzQh4nYScHC4oI191bJYA5XF6d7ADHL1eMLwxqWv2JgcV3apVnxXcZCo2B1aOyIJBANXhgH6REuep54grHV+/Qn4NIJAp1DhW8hCIWxo71HMpPMrCYyRFihojgRXkgwlKkyfZSd16tbfLyN+qCH9XXxDfan2GoZvVDule5M6v4O0my42ULYFSLTFmUjAUOaC9z1y4ts7M7XGTi0mb0RzUZBuLMlcmu+uiJ7acYbrMRNsfsVVpTlWCyBS1EJUqnPIWHLITkZZC+PGL0mkiI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgBaBWc2HX4Za6w+/V/y2aKfVF3RixQJiQnAB7+NibE=;
 b=JHrsRaQUZD5ZKXPWaX51VbRf5Tc85805N8nwJwE8ewSwA4T+DgZbm5dVrrR7BeV9OjAMr17IRfdnXSizUZUWEJyNYJChXb6a9KJcwVJa/qDONYQ7V7flHwy1BwIRHCNMyBAf+8e6AwYs45DxB3vvD39KHkII3oOTrak3eTNu2ihnz005mzP5KjmJhk8TSUHglZwHK2Gb2PqUxwGzRnBoRte16h8NltOurwkoOTihlesTCcwbudVoP+Yc5K7ouWoXI7gKe8kvhUxRbps0gFK2MNHKicfV6E58zzCjsR+9f/IIhs4PivrkaVkl+MTd6g/Zbxv5ML9YCbywcrmmX0TzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgBaBWc2HX4Za6w+/V/y2aKfVF3RixQJiQnAB7+NibE=;
 b=4DuzLGO1U3G5ThwlnzidlbxWlDiexXiEIU8Mm8e1KszVoyNho4nxyLnZIZNfcWv2+9dC7pXZrRlGXzH0Evr3Y4WAoTMXzxvHQAxL64/0aiTKVBjr3WsmXcGHONZ5XxGUY2jTb0E2cRgQY+QmBOgQuUQ794vjTMMCYB0FwMA00qI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:56:57 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 05:56:57 +0000
Message-ID: <3a96ed5e-a031-421d-b958-79fef8d3e39b@amd.com>
Date: Mon, 2 Nov 2026 11:29:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] ASoC: amd: acp: add ACPI machine tables for
 ACP7.F SoundWire
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <20261030094714.1123396-14-Vijendar.Mukunda@amd.com>
 <fe3eecdc-eb7f-4b1a-947c-fa05c4602fd1@linux.dev>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <fe3eecdc-eb7f-4b1a-947c-fa05c4602fd1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::6) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 930d1ba7-0e5e-49ae-5173-08df38a61a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261021121427099003|261026121527099003|261022113327099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 
 DducQvkcpTkpv8i08Ep05AyvHL6Tn1cgczPl33KG3va64H9/3eds69C91HyYKBYs8rJl4OIpOHYMSCtUQLXWM9UCrGdJ/jasPGxqlF6I04PPRb12sqNs0gGqfYctbLmuIpNKcvF1jhMSjFUk61YZxYUCB1x0OBT+v/68JYBg7XxVM0Jj5pHlN2bFNHGclcio5+vMi756NKq5oW9r5MpRcJkZ4J8doGkdOtUwgTLUgzKtbzhHTZ+zquQ9g78nncSBH3aJB9YfyGNofFW3gLo3wBljAW97ulc9ZHB8Y+5FCuRk0bifs5wAt3YPcRlt8pVMOt5jy6icb4/VbH+khbRup33VXhTWuV8MjvyiDkmQ1anMy+uAmMzhzpIMOQ43W1ZVHiAR+Zv2GUn8tXIa/AD+wMQqKphr8IqiR28uY7UZbbhwznyAjMSphrSKaeo8yDqOCdk/4Wxayk35LTP4Ik3rK9LNzGMSJJ0CfPaz0W43iSNBvVwIRkerAa7C25wfWkSX2036M/Q4nc7D/i9ebBtinlT+QKx9DAzrnfxsetfVwadzx6FZ8tc8R4z8KKfiyFkhbFjdfNDGOoLAzgjiQsc1MLVwZTLMJpG1Rhvl8ta89V6G0w/PslTnfIXX6iQq8/TYCajx1RbgxZSKhTwgNSuUL/c3J4nqP8x24cGwwu5hXdA=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261026121527099003)(261022113327099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?b0x6aXdUbHM2VVNEQVVBekdKL0IwdlI3NHJ1dXU4WjNKK2lSaWhEU2dzbExL?=
 =?utf-8?B?WUZhd09hZnRmNnVJZzhIYTE5WmxXK3Yva21jaFQ1L1BaM1V6d0x5VDZFZEV4?=
 =?utf-8?B?dmkwU3Z2UzVpQ2ZxN1RTOWlkaWNHTVRSTmVMQWo2Q1FKSlh1Z0crdTBzbFFP?=
 =?utf-8?B?cU1aandwck5XZnpOTld5bWYzdVQ4Wi9iaWI0T2dzbGtzbGVhcjJvbEJ6TDVh?=
 =?utf-8?B?bnZ6eU5OL01WY1gxZmE5bU1pOFExSG93SWNDSGY0ZVVhQkVpSllOMXlJZlF6?=
 =?utf-8?B?RGl3MTZBNkpLY3R3RURvcDlHSnB6aTVGcTVBbi8xckFMd0VOOEttMkJoUG8y?=
 =?utf-8?B?eDF1eks3cmpOV2tUaUliemtPVDFiY2dQcS9OM3FJWUxLVzhWd1BZd080SDAw?=
 =?utf-8?B?TDlDTVhYTXoyam1ZMWZoMzJKTFR2bkUzZzQ3U2VSUUtXd2VtUzRwM3g5NnNw?=
 =?utf-8?B?M2N6YkNxdlBmYzI4NC84aG91dmsrUEdvcnJvS1BCTTh3d1EwNTd5RVU2VHc5?=
 =?utf-8?B?SytQb1hZNkZXQkZhVm5VQ3laY2JBMW1iK2hlc1Z1bWR2QitzLzJiRWs3NWQ5?=
 =?utf-8?B?aU42N25iMHVqMEhadnZzaDkzVWVnUTIzZklwV01YcGN1YzJBRGhWTWNYanpv?=
 =?utf-8?B?VG1OQXlHTTVZcjN6RlZjdGVnV09jMjRyd3UwcDJKcjNVcExmcmdZWTNycUtQ?=
 =?utf-8?B?aUtlMXFqZmNMSTJVWUYyNnhTZ3FqMXp5d1lNRlZQLzNOWWZFK1dSZzNwTVQ2?=
 =?utf-8?B?UnVtRmdOQUxFM245VGZpcjNFS0piLzdIYytTZnlYY2N6VGpTVjdVd3Q0aFF6?=
 =?utf-8?B?RTA0anZXeEorbEVmeWw3bTZXZG5HM0ZIeGpkMk5IN2N4L2hicE1DTTBSVWwr?=
 =?utf-8?B?RDQwa0VIVlZDTDY2UmNBK2FqeWZGN1NFTkI3alhOVFQ1cXVmUzlZSWk2cWZu?=
 =?utf-8?B?aDR0czNjRlV6TW9kU0RybkpvbVVCQVBhOFhjMjZFYzV6cWNvdWVHL1lSQk04?=
 =?utf-8?B?YVhoR3hzcytNNEYxbzBlQzhHWGRZTm54T1MvcUhleUJJSHFwTXc2V1hTODgv?=
 =?utf-8?B?QjV4WCtDNDR1ZzI1SEdQbTlDTDI3djFiOHYxdTRnS3FhZjZsVmFYU3Bpb3p4?=
 =?utf-8?B?SFY3RnBPY084UzJyN3VNTmN5ZEVhSkZpOVFkL2wvZGJXN0pDRjViYXFkREtr?=
 =?utf-8?B?Mk11Q1ZkKzJVWk5QOXFURGFxWlNNK2wyeHdwUVRSVlhaWFozUlFLVWllWTdR?=
 =?utf-8?B?YVVCQUQ0VjB0dnM1bzZMQ3hRRDFMTmdDSGtsOSsyZlRtZjB2eGROcTh6UWtU?=
 =?utf-8?B?N09Pc21Mem5UTktDZ2krNHFkdXZ5RXZqSHBqai8zTnZMamVsczJvdm1meU1Z?=
 =?utf-8?B?ZEdQWmhYZjcwd1RuVGFiNUlKc1hYVmhPeE5SWWh0dUxvelZnd0dWM215TTVm?=
 =?utf-8?B?RituMDRJK0ZwQVI1YkJYa3lBNms4Ym94UGxmQ0FLL1FRd1ROeU9lY2Z2aE1z?=
 =?utf-8?B?TTVkcHhJZTk5V0R6S25MN3loaTFPUFF5eXdyZ2hjS21jUWZtOGdlWG5TckVJ?=
 =?utf-8?B?MGh4WVZpY2ZKbUd4R3Y0V1VxeE15ZHpmQnRXUmpKZ1BtcWNsT3ZXa1Yvbk9C?=
 =?utf-8?B?QzAvM1hkMXBLUTJWeXB2NXJBSjhabnNZSEZvWGRXRVFySlhaM05PeTkxL0VX?=
 =?utf-8?B?WnZpY0pyb3BlNllvOHVKdHViL2IxQUpGWlN1QTdzcC81U1hkZzg3Ly9zNWVS?=
 =?utf-8?B?eWJrVERwVVhSaHJyb2xRQVlhMUNPOTM0dU5WTHllK0ZLZXA3bGVtVkVQNFcv?=
 =?utf-8?B?S1lMVFJZNE1wZG1TWVRiQU1NdHozYmdRTDdYOCtheHNqZ0RaUFJjTXNpaFhz?=
 =?utf-8?B?ZHk3YTFobTZXSkZRNHBZRHUxVm8yZ0p2SFZRQVE5aC9HbFI0UHF5cE9vT0Rm?=
 =?utf-8?B?RktPd0YveFdMTW1kaDdLVUFaYzhPY2d1WHUyYTBLUDBlZDIycVJPUG5jZlpw?=
 =?utf-8?B?TDRpUHB3TXFlNUhKNTBibkwzYmxKMTg2anhBSW5BeVNqcXBudjMvVU9sU3hQ?=
 =?utf-8?B?SmgvNGVZbm5xUGVUQ0pYUHVMb0I2dFMzSVhabURJZHZDQWlPeVFNTHZpTW1E?=
 =?utf-8?B?ZUpPSkNHYTZBMy9UK3MxTldWMFZINDluNis1eDRHQ2RaZHhXQzlNZFJtd0Z5?=
 =?utf-8?B?YUNCQTNBMDQ2Q09CY1ROb0tWWURWRTZSc3AxYTNoMGx2T2ZPK2ZjWXZDYVBo?=
 =?utf-8?B?eElib2VtQjRPb3B4UXFzQUoxRU9DcElnRnQ5M1JPMTJMdklKNy85UjJibk41?=
 =?utf-8?B?Ukp1ekhZcUdEaExma3JCREdobmd3aG15cmRzQ0hsajBsRFVHckhOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 930d1ba7-0e5e-49ae-5173-08df38a61a6e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:56:57.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 +grNdRhiSdC2YfeSv+B4hGpVcVO4m8ZxwEAE1riut0y7Ph0cLyOP6ZUXCngxk7ZCXgjkanS3s4htuuduMl5m0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
Message-ID-Hash: JN7JAJ2GIRTHEDCBDRK66CI4EIWHYFP2
X-Message-ID-Hash: JN7JAJ2GIRTHEDCBDRK66CI4EIWHYFP2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JN7JAJ2GIRTHEDCBDRK66CI4EIWHYFP2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 01/11/26 23:54, Pierre-Louis Bossart wrote:
> On 10/30/26 10:45, Vijendar Mukunda wrote:
>> Add amd-acp7x-acpi-match.c with four snd_soc_acpi_mach entries for
>> ACP7.F SoundWire configurations:
>> - RT721 + RT1320 on SoundWire links L0+L3
>>   (jack+dmic on RT721, spk on RT1320)
>> - RT721 + RT1320 on SoundWire links L0+L1
>>   (jack+dmic on RT721, spk on RT1320)
>> - Standalone RT721 on L0 (jack, amp and dmic endpoints)
>> - Standalone RT722 on L0 (jack, amp and dmic endpoints)
>>
>> RT721+RT1320 combo configurations use jack_dmic_endpoints for RT721,
>> skipping the internal amp since RT1320 provides amplification on a
>> dedicated SoundWire link.
> [...]
>
>> +static const struct snd_soc_acpi_adr_device rt721_l0_single_adr[] = {
>> +	{
>> +		.adr = 0x000030025d072101ull,
>> +		.num_endpoints = ARRAY_SIZE(jack_dmic_endpoints),
>> +		.endpoints = jack_dmic_endpoints,
>> +		.name_prefix = "rt721"
>> +	}
>> +};
>> +
>> +static const struct snd_soc_acpi_adr_device rt721_l0_only[] = {
>> +	{
>> +		.adr = 0x000030025d072101ull,
>> +		.num_endpoints = ARRAY_SIZE(jack_amp_dmic_endpoints),
>> +		.endpoints = jack_amp_dmic_endpoints,
>> +		.name_prefix = "rt721"
>> +	}
>> +};
> nit-pick: The naming conventions aren't self-explanatory and don't match
> the explanations above. The difference between l0_single_adr and l0_only
> are related to the endpoints used, and they don't match what's used for
> rt722 below.
Agreed. The naming is inconsistent. Will fix the naming to make the
usage clearer and post a supplemental patch.
>
> [...]> +static const struct snd_soc_acpi_adr_device
> rt722_l0_single_adr[] = {
>> +	{
>> +		.adr = 0x000030025d072201ull,
>> +		.num_endpoints = ARRAY_SIZE(jack_amp_dmic_endpoints),
>> +		.endpoints = jack_amp_dmic_endpoints,
>> +		.name_prefix = "rt722"
>> +	}
>> +};

