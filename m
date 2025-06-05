Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D214AC5AE59
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jun 2025 07:45:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D80FC6022B;
	Thu,  5 Jun 2025 09:45:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D80FC6022B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749109539;
	bh=nQr3bO9OBWdEVVqDTLMp5megTGH2Oe3DWm+gJ6ZhLtw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=UyUGviGmVgLhj6teVR5pSY+KrvNFymeU8FPwiYAS1AjFeQfPBlgMlN5AMtWABGXW/
	 xngBFTx5qGKltItGDdP2WL9JczqCeK33FWYAYXuylJEJakVpWK+5R2PpRKqd6/uHmQ
	 f3uG2jhhU6WtIzgzbmt3e9f7NzDVwHcBM6AHsCM0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B0B8F806A0; Thu,  5 Jun 2025 09:44:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 268BAF8069D;
	Thu,  5 Jun 2025 09:44:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A27B9F80154; Thu,  5 Jun 2025 07:29:37 +0200 (CEST)
Received: from mail78-50.sinamail.sina.com.cn (mail78-50.sinamail.sina.com.cn
 [219.142.78.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 459EAF800C1
	for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2025 07:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 459EAF800C1
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.7])
	by sina.net (10.185.250.30) with ESMTP
	id 68412B33000035D5; Thu, 5 Jun 2025 13:29:24 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 45CBEE636B7A4BC393AC33E4F170938B
X-SMAIL-UIID: 45CBEE636B7A4BC393AC33E4F170938B-20250605-132924
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com
Subject: RE: [PATCH] ASoC: codecs: ES8326: Modify initialization configuration
Date: Thu,  5 Jun 2025 13:29:22 +0800
Message-Id: <20250605052922.5634-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: PUTGPA7A3F5JPPABWKSB2HLWVQ6W4B47
X-Message-ID-Hash: PUTGPA7A3F5JPPABWKSB2HLWVQ6W4B47
X-Mailman-Approved-At: Thu, 05 Jun 2025 07:43:59 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PUTGPA7A3F5JPPABWKSB2HLWVQ6W4B47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > -	regmap_write(es8326->regmap, ES8326_SDINOUT1_IO,
> > -		    (ES8326_IO_DMIC_CLK << ES8326_SDINOUT1_SHIFT));
> > +	regmap_write(es8326->regmap, ES8326_SDINOUT1_IO, ES8326_IO_INPUT);
> 
> Why - will this impact existing users?

No, it will not impact existing users, Because I have set this register value
to work in es8326_set_bias_level.
