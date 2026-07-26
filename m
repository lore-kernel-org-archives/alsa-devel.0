Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16DEC531F9
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2026 16:45:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCA7860204;
	Sun, 26 Jul 2026 18:45:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCA7860204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785084355;
	bh=n8PXgp/VVbyqyBZtdheYo42tkM2C1m6dGUqgc79kvKk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oRl2quvGxNu2iePWY3cT/iv2xRXaWr7BdT/ZPlt0T2Cs9MMjCkA311YBrKdMyA0QC
	 FddsbaRf7+2XjHqdRCU4oFbMw9SAOauiw/TsKXEVnyCnI/XHbeGW2D6bCTxDefvre0
	 vk5bpAPTjfoaSk6jhCZNa8NS8m8j/Mp+IKySAHm4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D627F805F9; Sun, 26 Jul 2026 18:45:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F0DFF80600;
	Sun, 26 Jul 2026 18:45:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A57F6F8012B; Sun, 26 Jul 2026 03:07:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.3
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785028044;
	b=Jslf2erUqvcCL9nQh4Q6xkcJMhX66NF56NsP/+ldVP3xrOY+El1JGr9alBTsg88fAiR4
	 yLEIazZEgUZD6aERzPF48G6UiEVRKSZjcSb7noWoIUIzuDdNkZIQkfquYbbVkMZhH+VHy
	 y1qf4d1YYNKPuN1Eud7JV6UFCkxYIeuqr9UH6LQQNZxWPKyRsjztXhYxf8Zb9s6jZlLz/
	 ydepDvWA7Gu587BflBms4wkbOiO+ahvVrWAGIUQqkAWn6hHqolz2oN4lXiGIKNovvOqfp
	 29fX5KNjFttthO0H8voZAm32ICYcboyFHQsRS76bTFmIRSECbPYsCzjqXfPF3HziXqA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785028044;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=n8PXgp/VVbyqyBZtdheYo42tkM2C1m6dGUqgc79kvKk=;
	b=W6S+AOKy9DllNuchXPZ+wgbAZ/0cOb4whCh6Kc2hmR+w0MIHKdMG0iSPLHoIA613eyio
	 X60UU1APR1/dCzO1/5qnLWznp/vxAfRcOl7Wu37xCSDpSqBbQvuDmQSzzM1qNRQ1AWEwc
	 H3hpZr6zHDqciMsQ/qqQtZmc+yS9YOVw57dHPdx3h/zcmFZMYHVxL9IYalTM2V7X1l4Jy
	 dHa4w3+wxgRDRyFE3o/lmWYgIACJVjGNrfmfEeS5maY7hfkmD06w9mgC+dZnYTIrLS9Kw
	 x6UjmGYJpwzjUDPhg891++ddh902QNfGEERFNKHsUSMxDcxDgQaoMBXXRecyx2YupSA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b="JLd/EORN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.3
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazolkn19010003.outbound.protection.outlook.com [52.103.13.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9EE10F800AC
	for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2026 03:07:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EE10F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=JLd/EORN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqEcAHZLNW0rc+sdnyc6rk5DlF2ImIHwI6B0mosYF4CwgtErzujfGB62WMCg2XOslMdAjq0AYv58n52o79vqtzD3OvCpoue/08tIeGK3zZYqMyUn17GWdeQK4HL86UC0og0j86JnNOT366nbw1JYheE5C8mYrNmWKzG3PUSoDIl+qKTEc+MJcd3VLPOLADkVOsJX8aDRxBO10pkOpK/dLfNFHpVEPUsXH30fvVJ5MyYeyvawPwpZGBMBFm5rgv6+HIf/DIM7Cbwki7h4ZdrwvgVGZFaZUdF4+IcWUmpcvPHzBhtSAgqxKgreh+9QsVyJh439otCu+NGJM7TvR/LSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8PXgp/VVbyqyBZtdheYo42tkM2C1m6dGUqgc79kvKk=;
 b=rFBuw3eilBfaHIerGaFxpWXDK5v9Liz49B+SHnq37RzPRXOfQO9JL4Vt4R1+Fs9DK723I9QyMrCE6illDgYzEd0wANF0TRQzOa2flutUB/Mg+tIphDJg1xofi6Iucz/NxXNlf8X3zcNRuDoxxGRGHxc+Mi1fo1FxJXDuVyx9SDiQOgrj6n2CSFhBwDRgNUO6yKDL6TBH/qGjIc7xdSQcINwyDWqmBJJEBPOF9UmJT0EZx25FqMlFT4m72KRvj0UjRkF66Er3NQ8/27C8E3HqRsaYSqJMToeWZ71BYvAdspJi27MxsNSQ1VYi73oKOwnSDnZy+VMyvbKjoF/ZyxsjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8PXgp/VVbyqyBZtdheYo42tkM2C1m6dGUqgc79kvKk=;
 b=JLd/EORNTSthSGsO3591w2Py//zNdsmYre3XG/eJQhoQHGQExwnFs78mcWHfVYlsQC1botIG90MMxHAEIHZXs0zkeUfv5Ny3/6Ed1erTlqWvGXrNnx/moWUKitY2fGSIW+tCe7IxTUcLf3HLrZ4Lv9Lu00AJhVmNGdjIipfs8C1yNFuvnKN0xQKK5g8qm+vlTz/dzbqP50RFMblhClPOs7cYjwPekphxO62KrBG3GriAM9G7B9gZyRLYwVF+d+2hS6fgxvTQsP6SHJgTzTa6e3WMi7CNelRMd2BbtcpHg5DJGi0HJRxV2OeQAqj1HUYqwucwCjVFb65EIxttfSkCrQ==
Received: from MWHPR04MB10298.namprd04.prod.outlook.com (2603:10b6:303:29d::9)
 by CO1PR04MB8217.namprd04.prod.outlook.com (2603:10b6:303:160::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 01:07:18 +0000
Received: from MWHPR04MB10298.namprd04.prod.outlook.com
 ([fe80::826f:f28d:3ebb:895f]) by MWHPR04MB10298.namprd04.prod.outlook.com
 ([fe80::826f:f28d:3ebb:895f%6]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 01:07:18 +0000
From: Demon Player <DemonPlayer0@outlook.com>
To: Mario Limonciello <superm1@kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
CC: "regressions@leemhuis.info" <regressions@leemhuis.info>, Mingyou Chen
	<qby140326@gmail.com>, "Vijendar.Mukunda@amd.com" <Vijendar.Mukunda@amd.com>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: 
 =?gb2312?B?u9i4tDogu9i4tDogW1JFR1JFU1NJT05dIHNuZF9oZGFfaW50ZWw6IDE1cyBh?=
 =?gb2312?Q?udio_resume_delay_on_AMD_Conexant_SN6140?=
Thread-Topic: 
 =?gb2312?B?u9i4tDogW1JFR1JFU1NJT05dIHNuZF9oZGFfaW50ZWw6IDE1cyBhdWRpbyBy?=
 =?gb2312?Q?esume_delay_on_AMD_Conexant_SN6140?=
Thread-Index: AQHdG15oljGbxskmukyFauVxJSiXS7Z8iQAHgABZloCAAhwSoQ==
Date: Sun, 26 Jul 2026 01:07:18 +0000
Message-ID: 
 <MWHPR04MB102980F54F9465597DC602D4792CD2@MWHPR04MB10298.namprd04.prod.outlook.com>
References: 
 <MWHPR04MB102982652A66D828B734EBC4C92CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
 <MWHPR04MB1029801AFD77D790D33C53E1592CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
 <f8dd5c7c-7088-4860-a00f-2e63c87c78c9@kernel.org>
In-Reply-To: <f8dd5c7c-7088-4860-a00f-2e63c87c78c9@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB10298:EE_|CO1PR04MB8217:EE_
x-ms-office365-filtering-correlation-id: 6174c68f-d37f-42ed-9586-08deeab23d1e
x-microsoft-antispam: 
 BCL:0;ARA:14566002|51005399006|19110799012|22091999003|6140399003|31061999003|8062599012|8060799015|24121999003|15080799012|15030799006|19101099003|10035399007|40105399003|1602099012|26121999007|3430499035|56899033|102099032|440099028|3412199025|4302099013;
x-microsoft-antispam-message-info: 
 =?gb2312?B?RlRvQXNveUxoMml0SGoxY0xqNmVQazZ5di9SUXBWQ0ZWd1dSa3FQTWw5Zk1o?=
 =?gb2312?B?RWo1TVloNUd4djRLeWJQdno1YnoxZzJ5N1l1Z0wyOGJGZHFSK3BlYk8vSStz?=
 =?gb2312?B?a2JaU2N2bXAvcmtiVlk3KzZ0Z0M4Z1lJUTdlN1FZeE1NSkk0bmkrbVpiWHgx?=
 =?gb2312?B?azh3bmhhL2VvUUZJdlIrYklZWmVHaFJQNkY3RTlrMWlFZVZMK2M3QlN5YXB4?=
 =?gb2312?B?UTV0MytZdmpONlZwVXdoZTFyOGtud0hwQkJvZ3IrcVM0SW1KZThtUFdnNExK?=
 =?gb2312?B?cUhXRjQzNGlOd00rUDEzanNOSFhGNkdFQzdxbWZnR2tJclNjMm5Dd1diS3R2?=
 =?gb2312?B?NFgxRzk5b0ZCZnpsN043MXkvKzdBRVVhRTNram9MZmVCRzM1RWhvakVzRzJ0?=
 =?gb2312?B?bXFnQzMwKzJ3S0ZLVTl4SDlhNEtiZGUyNTNEY2lCbmtWRzJ5b202SFVTS2M2?=
 =?gb2312?B?UFRoV3NRWi9NeHRUNjVKNHc2eTI5M0dXMnlTc2VLRUJNSzdGQ1Z5RzJTUGJX?=
 =?gb2312?B?a29pTHp0OFNKWFIzeG0zNUY1UjBUVHN4WTdhbklyb2pvUllSTnhyTVJhSXlW?=
 =?gb2312?B?RmtvY3FEcVFqM0dOQ3pQMVp2Vms5TDlDYzBlUXVucXY0WXl6K3hCR2RIZG9L?=
 =?gb2312?B?UnFmNkJBOGN4SGlFZ01qYVBIck95M3Z3Z1RNaXZ2YlJ4K05HVS9jbVRJeU9p?=
 =?gb2312?B?ZnJXc2gzM0xybUl6ZjF0SStSb2ZQTUc5UWFKWjVlOVR0Nll1ZmlyTUNKUytj?=
 =?gb2312?B?MVNVZW00ZXhwSS9QaE5EWkJTMEFpckRVb204OWdJUUZERkwrQVp4ZkNYdWVU?=
 =?gb2312?B?NUVqYnliWVIwbEFCRHlOWnVpSWxVRkxqNTBNQ3gzU2xHMDBhb21OWUUvbzNy?=
 =?gb2312?B?cHJWTHJQZHhOWmhJNmVFeDFIZXRzSENoYjFxSUdnSFNSRmY2QkxVS0s1NU11?=
 =?gb2312?B?U0VxSHY2bStMTjE5bms2R2ZJUUtEVk02WDVENWk5aHphNXNZVkVRaVhDYkw2?=
 =?gb2312?B?aU1zMHREZm1jZkF2YmJaelZRNzlWdURUNGh6djVmMUVLeU01T24ramtnMkxk?=
 =?gb2312?B?MmdOMHIvaDZZNngwVjNRK245aUVwckpINWlRYW0xOFgwZk9uQTlCVE9TdGhh?=
 =?gb2312?B?NUNkLzdGTkJjNHUybTVxTGIxV0l4Y1B0SVJNY1NlNUtiZWdQaGcyeXU3UHlX?=
 =?gb2312?B?cHhNb2puYmlzTTZaL1phMk8xUnp0aWxuU2ZNT3N6MEFQKzQvdmhYeDBRekhl?=
 =?gb2312?B?TWJwWGlTV0dpZzJiM2s5b3Vvemp5RnV0S25wSnE0cmVGc1VSc1ZkMWdLTFVL?=
 =?gb2312?B?THZTbDhsRHlTQ29XQnQzMit5K2M4eVM0UnVyZ21hajVBZGJmMkxZcWxlTlla?=
 =?gb2312?B?U2lOQlpPODNRS25jUThGZWErQUVFbDJlME12Y0FscDJEZytoSW5XZmZXd2I1?=
 =?gb2312?B?aDNKWWVrZW8yY1RlZUwreWNkWklLek10R212VjJ6NmErcm0yekNBSnJ4Y1dL?=
 =?gb2312?Q?Xa65FA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?SWdOVVVxSE50MFBPblVhakVJOWI5aS9XbXpNcEc1Q0ZybWs4S3UraTRvZ3Rk?=
 =?gb2312?B?TUlaQnlTb0ZlSG4yUCs1d0dMcTV1Y09tbms4NnlwYjQzeFFMNE10OGZzZEli?=
 =?gb2312?B?Z0dhQUp6WEJjVjJ1QzJST3FNWngzdVdPLzlxZWxnemNMZm9KQ3BXeW45b0dG?=
 =?gb2312?B?ZzlWMjhIR1JEYVhwYTRNNno0TDZFMVkrWTBTY1o1RmFyUVkwMGxUa0w1cFRO?=
 =?gb2312?B?L1VmZlAvNDhyREhBU2tKeUtiRmIxaHR6YlAvL0J1NnpaaGF6Z1RUeUZBM1l6?=
 =?gb2312?B?dUFXaVcycGtza0c3b1VvdGczb1pvU0I1WklUVUVJVm94bFUzTmhHNG9Jdm44?=
 =?gb2312?B?YkcwYXhOb25RTUdrd2ZlTm1vQW5OMHNIRURMZ3Q3L0dJdmVyT2kzbm1TYnBY?=
 =?gb2312?B?eXZKS3Y5cGxlNjBBWmFmbkRWRm1ZOHg3dmdKWit3NXdXY05DWm44bDhzTEk3?=
 =?gb2312?B?MTZpWHBvMW93UXAzVjZleURhZWtFbEdCVU5yd0xqTUhIeW1RU2xMNkoxV1pE?=
 =?gb2312?B?YnorMzdCdThjZDZLb21NSDkzM0RWeWEvNnNGU3E4YURENyt2RzMxVjNGeFRz?=
 =?gb2312?B?SENrWDEvN3owTHlsNUlZS0gxR09SSnE3cUpnTGdhSTVua3hIcWxSRS9HQzJG?=
 =?gb2312?B?RjRhQmFqd3AyR3BIc1N6dStiRVVzamwwQnRxSVV1YWdwMm9SSWlNV1lRRFda?=
 =?gb2312?B?RklLWHV5amRUdUJ2d1VYTWtIWkJxcklnbGxZZmJXRW1nOFZHMUtXTjBCRzVx?=
 =?gb2312?B?N2FCcVZleXFPS04vMlRWL3VXMm9KNGNJS3FSR3h3MEtyUUZid3diTDhSS3ZK?=
 =?gb2312?B?TGhuRE1RL3kzZER1TDF1TWdEVXpXSmlhZ3MxMlJydmlVQlNsVjQzeFlITzE4?=
 =?gb2312?B?M2EvN0MzUlVHTlNqcENvQmF3V0NIY09UMVFGRTVncnBOVmovYUsvNUc2Y1lD?=
 =?gb2312?B?dWdkUFphTzM0SG9ocXhmcmo2M2kva0lDV2hubmVJdTN0YU9ZYnhtem55RzVE?=
 =?gb2312?B?blkxUCt2V3ZZZVZYcVIzRXFoNkI2YlBTRU9KYlZqcVZMenJUK0JCYUR4cVVN?=
 =?gb2312?B?ZWNUR2JzUmI5emFsMXFIL3hsRkRmYmYvb1JTNDNpbFNYYmNVY1E1ZjB6eHRX?=
 =?gb2312?B?UkJ5aUZUVXdtY2lRR3I4T3ErczU2SStRSThSRWM4NGJlOWdsNGFsQjZGaVNX?=
 =?gb2312?B?NlVweVFLVHQ0UjJJNmlzcDFLUllpZU1HYU5JcFdjTVhUdnFGNWROL2k2cVhM?=
 =?gb2312?B?QVFBeUxiWEhVaUdrTlBuSkp4RTdhM2kzYm9Zd2EweUR1T0gxbVZab2N6Vy9I?=
 =?gb2312?B?a3hnU3ZMd1dkSFp1djVGY0NRWnR1M0JxMU1VbnJQdkJXN1QzK2RadmZJNlJj?=
 =?gb2312?B?K1lYRzdYeW9wYlVqVDd6d09nZmhyb042ZGJxcjVIeWpuT0YwSjg4U09CV2c1?=
 =?gb2312?B?ZFFIeUxBVnQ0WjFOZGhGYTZpR0hqQ1JTaHRGbFNLVlEzUGM0WVFHaFB4Y2pY?=
 =?gb2312?B?Z1JIa2FVZ0VjLzI5NjdOUWpWZFRIK0JtY2c1R0VTSHYxWW5JdWtXeVVxb09E?=
 =?gb2312?B?bG5NS0plWXNobUR4empucjd5d0FuUzVnNjlrQWM2dzNLQlBtOTBaWmFCTkcr?=
 =?gb2312?B?bFNaWC9QSmljMzJBZ1kxeitmSUxMOEV2QnN2VURFcjYrek0yYWhSdGY5Y2pn?=
 =?gb2312?B?Qmt5bHVJdCtBNG5WVldMZ0FjWG15L1dBUzVKaFp2Y3BLSGlUa3pRY0dWNmls?=
 =?gb2312?B?UWUxTEFQdGdNNzZEN2VkeDlqUGtMK21NUm5acVBtOHZROXhUMW13L3kyUWtn?=
 =?gb2312?Q?0yZ6xHAcXJQcydivXuIbrecOcacxDj5mSxQSE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB10298.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6174c68f-d37f-42ed-9586-08deeab23d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2026 01:07:18.3412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8217
X-MailFrom: DemonPlayer0@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: O3NLYYAYYMLC6TYPTQMYTHRBNGTYNIPK
X-Message-ID-Hash: O3NLYYAYYMLC6TYPTQMYTHRBNGTYNIPK
X-Mailman-Approved-At: Sun, 26 Jul 2026 16:45:10 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/67VOMXZBLM6GDTI5J4LSCCGFQO2XJNQK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQpIaSBNYXJpbywNCg0KQXMgcmVxdWVzdGVkLCBJIGhhdmUgdXBsb2FkZWQgdGhlIGFtZC1zMmlk
bGUgcmVwb3J0cyB0byBhIEdpdExhYiB3b3JrIGl0ZW06DQpodHRwczovL2dpdGxhYi5mcmVlZGVz
a3RvcC5vcmcvZHJtL2FtZC8tL3dvcmtfaXRlbXMvNTUyOQ0KDQpQbGVhc2UgbGV0IG1lIGtub3cg
aWYgeW91IG5lZWQgYW55dGhpbmcgZWxzZS4NCg0KVGhhbmtzIQ0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IE1hcmlvIExpbW9uY2llbGxvIDxzdXBl
cm0xQGtlcm5lbC5vcmc+DQq3osvNyrG85DogMjAyNsTqN9TCMjXI1SAwOjUxDQrK1bz+yMs6IERl
bW9uIFBsYXllcjsgcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2DQqzrcvNOiByZWdyZXNzaW9u
c0BsZWVtaHVpcy5pbmZvOyBNaW5neW91IENoZW47IFZpamVuZGFyLk11a3VuZGFAYW1kLmNvbTsg
VGFrYXNoaSBJd2FpOyBNYXJrIEJyb3duOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcNCtb3
zOI6IFJlOiC72Li0OiBbUkVHUkVTU0lPTl0gc25kX2hkYV9pbnRlbDogMTVzIGF1ZGlvIHJlc3Vt
ZSBkZWxheSBvbiBBTUQgQ29uZXhhbnQgU042MTQwDQoNCk9uIDcvMjQvMjYgMDY6MzEsIERlbW9u
IFBsYXllciB3cm90ZToNCj4NCj4gU3ViamVjdDogUmU6IFtSRUdSRVNTSU9OXSBzbmRfaGRhX2lu
dGVsOiAxNXMgYXVkaW8gcmVzdW1lIGRlbGF5IG9uIEFNRCBDb25leGFudCBTTjYxNDANCj4NCj4g
SGksDQo+DQo+IFBsZWFzZSBhbGxvdyBtZSB0byBjb3JyZWN0IGEgZGV0YWlsIGluIG15IG9yaWdp
bmFsIHJlcG9ydC4NCj4NCj4gVGhlIHN1c3BlbmQgc3RhdGUgdXNlZCBkdXJpbmcgdGVzdGluZyBp
cyBTMmlkbGUgKE1vZGVybiBTdGFuZGJ5KSwgbm90IFMzIChTdXNwZW5kIHRvIFJBTSkuDQo+DQo+
IEkgY29uZmlybWVkIHRoaXMgd2l0aDoNCj4gJCBjYXQgL3N5cy9wb3dlci9tZW1fc2xlZXANCj4g
W3MyaWRsZV0NCj4NCj4gQWxsIGJpc2VjdCBhbmQgdGVzdCByZXN1bHRzIHdlcmUgY29uZHVjdGVk
IHVuZGVyIHRoZSBTMmlkbGUgc3RhdGUuIFRoZSByZWdyZXNzaW9uIHJlbWFpbnMgcmVwcm9kdWNp
YmxlIGV4Y2x1c2l2ZWx5IHVuZGVyIFMyaWRsZS4NCj4NCj4gQXBvbG9naWVzIGZvciB0aGUgY29u
ZnVzaW9uLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgYW55IGFkZGl0aW9uYWwgbG9ncyBhcmUgbmVl
ZGVkLg0KPg0KDQpDYW4geW91IHBsZWFzZSBjYXB0dXJlIGFuIGFtZC1zMmlkbGUgcmVwb3J0IHdp
dGggdGhlIGNvbW1pdCB2cyB3aXRob3V0DQp0aGUgY29tbWl0PyAgU2hhcmUgYm90aC4gIFRoaXMg
d2lsbCBoZWxwIGV4cGxhaW4gYSBmZXcgdGhpbmdzLg0KDQpodHRwczovL3B5cGkub3JnL3Byb2pl
Y3QvYW1kLWRlYnVnLXRvb2xzLw0KDQpJZGVhbGx5IHBsZWFzZSBhdHRhY2ggdGhlIHJlcG9ydHMg
dG8gYSBidWcgZWl0aGVyOg0KDQpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvDQpvcg0KaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS93b3JrX2l0ZW1zDQoNClRoYW5r
cyENCg==
