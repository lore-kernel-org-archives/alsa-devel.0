Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7072AC2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:28:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E565D299D;
	Mon,  1 Jul 2024 14:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E565D299D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719836898;
	bh=xxAoEhnSkTQySCuhhUAaYn4Tm+x+IpDt4eE43HYk+20=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=T0adTURfODi/0gPC0i25233YCCLgHIeM3wBdajx/BjB74TXXpL+O1uTGCbx9bCTJa
	 c10ZZzA67AqBs82S/iNpZuRgrZremghkR7eTsRG4sLOINpRJVUngOBY9IbJr4wqBOS
	 ptFgneHZLEiv9bie1WyRD5H0DDcxJApsmrhRlHjU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 558A5F897EC; Mon,  1 Jul 2024 14:21:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86C69F80682;
	Mon,  1 Jul 2024 14:21:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEE90F80578; Mon, 24 Jun 2024 05:06:28 +0200 (CEST)
Received: from mail78-66.sinamail.sina.com.cn (mail78-66.sinamail.sina.com.cn
 [219.142.78.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C11B7F80154
	for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2024 05:06:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C11B7F80154
Received: from unknown (HELO zy-virtual-machine.localdomain)([116.227.101.59])
	by sina.net (10.75.30.239) with ESMTP
	id 6678E2A10002B8DA; Mon, 24 Jun 2024 11:06:10 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 8C3D5F56266C4568BCB670E98F8427D6
X-SMAIL-UIID: 8C3D5F56266C4568BCB670E98F8427D6-20240624-110610
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 0/4] ASoC: codecs: ES8326: Solving headphone detection and 
Date: Mon, 24 Jun 2024 11:06:03 +0800
Message-Id: <20240624030607.4307-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7UX5ZWKWOFSZVP67JNNDJIFIXIJKDUJ2
X-Message-ID-Hash: 7UX5ZWKWOFSZVP67JNNDJIFIXIJKDUJ2
X-Mailman-Approved-At: Mon, 01 Jul 2024 12:21:20 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7UX5ZWKWOFSZVP67JNNDJIFIXIJKDUJ2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

We propose four patches to solve headphone detection and suspend issues.
And there are several registers that should be read-only registers. So 
we create es8326_writeable_register, and set these registers to false.

Zhang Yi (4):
  ASoC: codecs: ES8326: Slove headphone detection issue
  ASoC: codecs: ES8326: codec can't enter suspend issue
  ASoC: codecs: ES8326: Minimize the pop noise
  ASoC: codecs: ES8326: regcache_sync error issue

 sound/soc/codecs/es8326.c | 92 ++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 40 deletions(-)

-- 
2.17.1

