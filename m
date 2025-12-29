Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58FDE92724
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Dec 2025 14:12:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF57660203;
	Mon, 29 Dec 2025 15:12:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF57660203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767017567;
	bh=LhTH9ECxUzjU/iGAqT0UCdfsXu51zl+oUGRhcv7tpU4=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CM9S97nQtESBa5DltIyblIH/y+7PQVfroK0+44WvXuKm1+61W4pVM7YjuNSWaKZMF
	 u4r+aEqfNfismnNnOPXj+RNx4Q7eflGKo+qkQU2stwrsT9lA5Nn9ktDQ61Zh3sa6dY
	 GSuTQhsRwEhT535wd/5wz/lzHXRrtqaGKz8may1k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03F62F805D8; Mon, 29 Dec 2025 15:12:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 82801F805D3;
	Mon, 29 Dec 2025 15:12:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E880F80533; Mon, 29 Dec 2025 15:11:56 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id E98B2F8007E
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2025 15:11:55 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [alsa-devel] Applied "ASoC: tlv320aic32x4: Model CODEC_CLKIN in
 CCF" to
 the asoc tree
From: rekod13481@gavrom.com
To: alsa-devel@alsa-project.org
Date: Mon, 29 Dec 2025 14:11:55 -0000
Message-ID: <176701751589.20.8580249908878430873@mailman-web.alsa-project.org>
In-Reply-To: 
 <176464587496.22.3926790229994363966@mailman-web.alsa-project.org>
References: <176464587496.22.3926790229994363966@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: N5TOYOYPBTZPOEGIAAFJMRQ2XZHBUYX2
X-Message-ID-Hash: N5TOYOYPBTZPOEGIAAFJMRQ2XZHBUYX2
X-MailFrom: rekod13481@gavrom.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N5TOYOYPBTZPOEGIAAFJMRQ2XZHBUYX2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thanks for sharing this discussion! I’m new here, but from what I’ve seen on the ALSA-devel list and related kernel audio threads, it’s really helpful when issues are broken down clearly with steps to reproduce and logs where possible. I would like to share live result here https://kolkataffresult.net/ it's very helpful for those users love to play kolkata FF game.
