Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075B4C19F32
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:39:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 612CC603D6;
	Wed,  5 Mar 2025 10:39:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 612CC603D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741167584;
	bh=yOBVye89uQjllEaBBzx0O+lcETrtI7RXOOF6It+6qLQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qCxfMOHdRti4ojjuBIJBdZa19403JDygrWV3Syl7epE40GWv5Jp6ZflnfyxcS+eqh
	 ui7h0kzTcvm66ElmNVMyArfMgI87AeSI++asltTGaaltRDufSL9g9nEB3Y3ocT4U/d
	 SnWI0CZ2gS1qF4Td5C3b81u7mcr2mNuDwGuj8iLU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9FE00F80605; Wed,  5 Mar 2025 10:36:58 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EEA8F805EB;
	Wed,  5 Mar 2025 10:36:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2728EF80424; Mon,  3 Mar 2025 10:20:18 +0100 (CET)
Received: from mail78-37.sinamail.sina.com.cn (mail78-37.sinamail.sina.com.cn
 [219.142.78.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10D65F800FA
	for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2025 10:20:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10D65F800FA
Received: from unknown (HELO
 zy-virtual-machine.localdomain)([180.159.108.137])
	by sina.net (10.185.250.31) with ESMTP
	id 67C5744300004A85; Mon, 3 Mar 2025 17:20:04 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 00615DA353774DA581D02E8452E012A5
X-SMAIL-UIID: 00615DA353774DA581D02E8452E012A5-20250303-172004
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	amadeuszx.slawinski@linux.intel.com
Cc: tiwai@suse.com
Subject: RE: [PATCH v1 1/2] ASoC: codecs: add support for ES8389
Date: Mon,  3 Mar 2025 17:20:02 +0800
Message-Id: <20250303092002.78120-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: A4XELAJXC2FYPOL4GPIUIVXQOCFQ5N56
X-Message-ID-Hash: A4XELAJXC2FYPOL4GPIUIVXQOCFQ5N56
X-Mailman-Approved-At: Wed, 05 Mar 2025 09:36:54 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A4XELAJXC2FYPOL4GPIUIVXQOCFQ5N56/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > +	/* clock inversion */
> > +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +	case SND_SOC_DAIFMT_NB_NF:
> > +		break;
> > +	case SND_SOC_DAIFMT_IB_IF:
> > +		break;
> > +	case SND_SOC_DAIFMT_IB_NF:
> > +		break;
> > +	case SND_SOC_DAIFMT_NB_IF:
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> This switch does nothing. Remove it?

Ok, I will remove it
