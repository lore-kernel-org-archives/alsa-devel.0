Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AED9EDF17E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:41:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46BE660218;
	Fri, 13 Feb 2026 18:41:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46BE660218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771004487;
	bh=CDpFdcG2JlGiilwq9OrTxomnpUDybg7pYjrt8++i0EI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cfzxtZi/y83JN0ikgCXyBEj5AW3/F2Ud7f3HGvFH7C68LQ2fFQ09Ib5rnx3CJJ9fz
	 lUtwY98D1n2s8GUnx0T2QoFBa28vSLI4QPpOa5AZs34w769ijz3Cb4Spu0czvVjnJ0
	 uR202BYmYXlu9Jah2b67bSF5DvFKh4IFOpFkk+UA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7825F805E0; Fri, 13 Feb 2026 18:41:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7420FF805E0;
	Fri, 13 Feb 2026 18:41:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D590F8025A; Fri, 13 Feb 2026 18:40:15 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D55FF8014E
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2026 18:39:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D55FF8014E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1893df1d34d4fd00-webhooks-bot@alsa-project.org>
In-Reply-To: <1893df1d331d3200-webhooks-bot@alsa-project.org>
References: <1893df1d331d3200-webhooks-bot@alsa-project.org>
Subject: ASUS X870-F STRIX - no front panel/headphones audio
Date: Fri, 13 Feb 2026 18:40:15 +0100 (CET)
Message-ID-Hash: LBLENXZVK3W4BAFXCCAHG3NDRK3AFAP7
X-Message-ID-Hash: LBLENXZVK3W4BAFXCCAHG3NDRK3AFAP7
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LBLENXZVK3W4BAFXCCAHG3NDRK3AFAP7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #705 was edited from dosiek:

Hello, I have an issue where I can't get my headphones/front panel jack to work - it is being detected upon connecting the headphones but no audio is being transmitted.

My motherboard is ASUS ROG STRIX X870-F GAMING WIFI, using the ALC4080. `Bus 001 Device 007: ID 0b05:1b9b ASUSTek Computer, Inc. USB Audio`

I am using Fedora 43 KDE and I have tried a lot of different fixes (such as disabling drivers, modifying the ALC4080 and ALC4080-HiFi files and way more) and nothing has worked out.
The motherboard is already in the UCM conf list for the ALC4080 (addressed as X870E-E but it's the same ID), but the front panel audio still does not work.

I am at the state where I freshly installed the system, and updated the alsa-ucm-conf using the commands provided (even though the default version already had the ID), and getting this error in alsaucm -i

`alsaucm>> listcards
ALSA lib parser.c:270:(parse_syntax_field) Incompatible syntax 8 in USB-Audio.conf
ALSA lib main.c:1554:(snd_use_case_mgr_open) error: failed to import hw:0 use case configuration -22
ALSA lib parser.c:2978:(uc_mgr_scan_master_configs) Unable to open '-hw:0': Invalid argument
alsaucm: error failed to get card list: Invalid argument`

My alsaucm version is 1.2.14 (upgrading it to 1.2.15 does not fix it), and I am attaching the alsa-info.sh output.

[alsa-info.txt](https://github.com/user-attachments/files/25296874/alsa-info.txt)

Thank you.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/705
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
