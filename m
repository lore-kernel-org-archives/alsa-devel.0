Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207B5CDB46B
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:44:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FFC660242;
	Mon, 22 Jun 2026 09:44:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FFC660242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114260;
	bh=HERKJPd7DsXyrtjjCIZpAt1ChZ+dWhH9Ft7EJglhrSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X6iGjuqO500+7cQsUVxVmj/M+Ym6u4ZTUJcK96KvW5wGIT57jZpNjtQKgz4oO2Wb5
	 uvYw5bIfrKO/V9pAp6mY9ET0tf5zuP29g1FORkCMTJbbFzsQp+pBo+ma7ST+9wQcmS
	 jW9S2aggSWcr1cORTKONcg5DmEHiueJUB1hONGMA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E500F8067F; Mon, 22 Jun 2026 09:43:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 05A0FF8060A;
	Mon, 22 Jun 2026 09:43:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1CFAFF8047D; Mon, 15 Jun 2026 08:07:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.78
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781503628;
	b=j03B5Qf0/6Bkc47NrLMyxU8o68GmDwDmbi7GWDKMC+3gGNkyeHeS1CEH+r8LNNkGUXLJ
	 xtGBYU5QilgoDAEDS7q/GZSUvuYWyQWyY+Bmonknx+yXkjX3MR+yCYZ2xJjJHAasJsItQ
	 elw0V/SFhQiyaZnSimHxy8ZifK1SCI+Fa058+FYK3agN1jiKTpFzF2YQMZbJKDyV3cyG1
	 lDynysibUGQy87BN4b83LiiZzEQVuyaQIfwKUqMqyoBFoieop9qwrYm/eT7vbQbm+owpZ
	 znAIlSYOcrWC3O7unAXyqpEhmrkMwQg5Q/Pc6tpqA7k/I678+fNgxHUEy252e23isTg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781503628;
	h=From:To:Subject:Date:Message-Id;
	bh=HERKJPd7DsXyrtjjCIZpAt1ChZ+dWhH9Ft7EJglhrSU=;
	b=apOpR88WZCO1QidjOHNgVO54L2Oxpxloo9LHw9FpvInuW0zt/DvWrivrpGhaVJArtYOg
	 kRtREl8ct2Wi8SJ9uJkk4frnHgUQ64lZ5A+oths/q0kp3Et2VwFw0jhKL8OQePobtCBWT
	 lyEWxbOmas3j+8trwWR957MCJxfynRZjTOvgtophDz3ENgeuy6CdHub+w7lhF2FTTi7rZ
	 2d7m3agAaLj8o/O6FzUVK9GdKv5fdA8Z6dbDFIv00U0e7h85iR9xcBCIqcVaaldrdIVf/
	 0vTkWFUyKyVIqsIE9gpQnORE35VsCxjDZpQGcE18JF3JVtPHyDoE/pnpbg6HZGokDjw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.78
Received: from r3-78.sinamail.sina.com.cn (r3-78.sinamail.sina.com.cn
 [202.108.3.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B74D5F8010B
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 08:07:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B74D5F8010B
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.37) with ESMTP
	id 6A2F9680000042A3; Mon, 15 Jun 2026 14:06:57 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 1BDCC139A8EC4E049F608E5CD7088C86
X-SMAIL-UIID: 1BDCC139A8EC4E049F608E5CD7088C86-20260615-140657
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	tiwai@suse.com,
	zhangyi@everest-semi.com
Subject: RE: [PATCH 2/7] ASoC: codecs: ES8389: Fix the issue about mclk_src
Date: Mon, 15 Jun 2026 14:06:54 +0800
Message-Id: <20260615060654.18725-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <fbaf1829-723b-4a87-882b-b164bb544912@kernel.org>
References: <fbaf1829-723b-4a87-882b-b164bb544912@kernel.org>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QB36XMNYGLG44UOREEAXY3NSNEQOP7MK
X-Message-ID-Hash: QB36XMNYGLG44UOREEAXY3NSNEQOP7MK
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:43:14 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QB36XMNYGLG44UOREEAXY3NSNEQOP7MK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > 
> >>>  	struct es8389_private *es8389 = snd_soc_component_get_drvdata(component);
> >>>  
> >>> -	ret = device_property_read_u8(component->dev, "everest,mclk-src", &es8389->mclk_src);
> >>
> >> Why are you changing implemented ABI?
> > 
> > In the old ABI, `mclk_src` was defined as `u8`, which meant that users could set `mclk_src` to any value in the DTS¡ªsuch as `0x02`,
> > but the code wouldn't recognize what that value represented.
> > The actual purpose of `mclk_src` is to indicate whether `sclk` should be used as `mclk`.
> > So I've changed it to bool.
> 
> You break ABI implemented by this driver, so you must clearly document
> it with reasons, why breaking is necessary. Honestly, without proper
> reason I would just answer that you must keep it backwards compatible.

OK
