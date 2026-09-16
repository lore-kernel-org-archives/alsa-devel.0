Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79294C88E77
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:33:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA9A9602BC;
	Wed, 16 Sep 2026 08:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA9A9602BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540397;
	bh=4adzdkyS6XeXKbl6zU2c2shBLF3+Kon9+nbNlKt/DA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vOEs4vTRZX5OPlqW+JOmuslOFRTYlwMRlzwQiqeIhG0TfvuwrN9SXOids55jeLckQ
	 1J/paJ7uaTni3Vx7DmBiC9ccBOL1Gl8YM1dd1ayOM+DHHmqbwZ8LZfgzZpoFAYcJjT
	 H2hv03nKAuAbehwQx1/3CexpfHMIJJhqgdL8Y7zs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0E1FF80639; Wed, 16 Sep 2026 08:30:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 402C5F8064C;
	Wed, 16 Sep 2026 08:30:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B30FBF80618; Wed, 16 Sep 2026 08:30:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=188.68.61.103
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789540236;
	b=FLnu0Gw/tNEOEii3eQTPpwxkEPIWtS/t+Bg/JXBl0zcYDwOqrCJaaXFRskbZ25wQogJG
	 zzt3HuKdp6+yKVpuMmrePHZdUd5+yWBM3p8nU155ao1g6XY/RZ+3BjiQmPA3PbzpyS8Wc
	 7RDEZzS1vypJXEg6+w8c2in3rvhszugF4bSDA8i1M+vMjSst9eosDmr4L3o+f53/sePn4
	 8w9k2QZlVAxqgpgNWhEGh3nNE/rUBYApTY39cmmkaPZvC6Dan2Fok8lwAAVQv9awGmg5g
	 CEa7cv9k7IUfcZznXx45r9U+ZHwOUNsIM+Ln1MgBhltiAja/ysX4mXBeMEEbr4cROAQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789540236;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=4adzdkyS6XeXKbl6zU2c2shBLF3+Kon9+nbNlKt/DA4=;
	b=Vu0LidG8PcNNOpYHN08xQCWPct4ttiX6OAxRytI69kp5anWgYJXnOAgvSgH9wRYPKtGx
	 poil+tBB6Y34GK+w/NXHOMBOZk+jNYdKxRRr4vMTBT0+ADwJTAxhSKJy/jqIZOuXS8A+l
	 0a+2qanYonZCi2EvDE2yxpkTYS1+JVBwVpCh/edj9rnx0QnXVYZGRsBxoHqsHb5/wx2At
	 +ON4JVAUDiPPAbTYSKmW0xmPHHcA8oHAZ+XpbhkAe+enUU4t3SFyiElTdfxLVmjnGKdZJ
	 ONNzoVYxMs2nBY/zRbo4KzlLUX3g5zdK1MHqInjdYqJqeWYsly6iiDN8MlsuMgEzYxA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256
 header.s=key2 header.b=OSMi+vxm;
	arc=none smtp.remote-ip=188.68.61.103
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.61.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06733F805FE
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2026 08:30:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06733F805FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=leemhuis.info header.i=@leemhuis.info
 header.a=rsa-sha256 header.s=key2 header.b=OSMi+vxm
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hl8BD24jrz893l;
	Wed, 16 Sep 2026 08:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789540180;
	bh=4adzdkyS6XeXKbl6zU2c2shBLF3+Kon9+nbNlKt/DA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OSMi+vxmFMu49L/6pT++enzazONrFbpjM+f9UVmgA5jKltZe2l+IyM6gPMuVy2q0W
	 hfOFcwqc7UFds6O8glOw4rSjF1ILHTTOFLSYGFJ1SEiwvE3N/owj6eELo1NtlIZYfF
	 oAuwY9fr1H79UcleD2FSXeG07xPzLgoB2P0NrycXNdt00tzp1zmNHdtVhq3IAMBkKl
	 2oSE8FK+CBFolHu+OTudtqDMzt9Nzmol1UbBDpCjfZBQeG68koojteFQF6MFUUYjpw
	 AwTRo2dv/jVMQ1Bos9H1yxIMUm2ncNItgbRh0SjKlXNWTRyJoDzz/X5SjJ+Dxk7Vzm
	 VQJJdceZl6s3A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hl87b0qvvz894q;
	Wed, 16 Sep 2026 08:27:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hl87Z17F3z8tbb;
	Wed, 16 Sep 2026 08:27:22 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 58DCA5FAD7;
	Wed, 16 Sep 2026 08:27:13 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <1dba4e50-2468-4cc6-b002-907ca1438b2d@leemhuis.info>
Date: Wed, 16 Sep 2026 08:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Sound broken on Cirrus Logic CS8409 / iMac19,1
 between 7.1.13 and 7.2.4
To: Zachary Hunt <1zachhunt@gmail.com>, alsa-devel@alsa-project.org
Cc: linux-sound@vger.kernel.org, regressions@lists.linux.dev,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
References: 
 <CAOD3=bOhpz2P2+UUNeTsdxXiPtdhFQ+jZg-1WQmFAPYchSvhEg@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAOD3=bOhpz2P2+UUNeTsdxXiPtdhFQ+jZg-1WQmFAPYchSvhEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178954003376.626450.11625335250586460561@mxe9fb.netcup.net>
X-NC-CID: etn+woiEZmqizqAkoOXMdS1A8HaEHRyKKSmFE9L16HTyYLmrc4o=
Message-ID-Hash: HY6ADU2XDNRQI4HKOLY5DP5MI5MW5DP4
X-Message-ID-Hash: HY6ADU2XDNRQI4HKOLY5DP5MI5MW5DP4
X-MailFrom: regressions@leemhuis.info
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HY6ADU2XDNRQI4HKOLY5DP5MI5MW5DP4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi! Thx for the report!

On 9/12/26 20:42, Zachary Hunt wrote:
> 
> Audio output via internal speakers works on kernel 7.1.13 but stops
> working after updating to kernel 7.2.4.
> 
> Hardware & Environment:
> - Machine: Apple Inc. iMac19,1 (Board: Mac-AA95B1DDAB278B95)
> - Audio Codec: Cirrus Logic CS8409 (snd_hda_intel)
> - OS: Fedora Linux 44 (KDE Plasma Desktop Edition)
> - Sound Server: PipeWire
> 
> Symptom:
> On kernel 7.2.4, built-in speakers produce no audio. The card is
> recognized by ALSA and PipeWire is running, but sound playback fails.
> The system functions as expected on kernel 7.1.13.
> 
> Attached is the full alsa-info.sh output for kernel 7.2.4. Please let
> me know if additional logs or bisection testing are needed to help
> track this down.
Nobody replied yet, so it seems nobody has an idea what's wrong here.
Unless somebody comes around with one, I guess you'll have to do a git
bisection to find what caused this. Remember to check mainline first to
see if it maybe was already fixed.

Ciao, Thorsten
