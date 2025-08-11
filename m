Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0090C87FCF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Aug 2025 02:43:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B54260257;
	Mon, 11 Aug 2025 04:43:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B54260257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754880235;
	bh=Vk3O7cOSnrME/aUptbIS2hDZ5FCLRKY74bVAo638txE=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HBZ1Fha8W8FzFYvPuFJuHkXv8Byk/Zd6Sr2RDEyPxuY6LKhKUQqM0iQBWEofnu9bx
	 tQEMrH8UV+v5Yh0x1NGpduPrzgci3Rd665jhsWXvGQ+Zy8Jfol7517r3tXWhxBs2Le
	 hFUGrtYcSTWFm33eQ5NlvFSUOQJGdNLO5ooiy75E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1254F805C9; Mon, 11 Aug 2025 04:43:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B8CCCF805CB;
	Mon, 11 Aug 2025 04:43:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C446CF80518; Mon, 11 Aug 2025 04:43:12 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id ADFE8F8021D
	for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2025 04:43:12 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [alsa-devel] Applied "ASoC: tlv320aic32x4: Model CODEC_CLKIN in
 CCF" to
 the asoc tree
From: rinfo4080@gmail.com
To: alsa-devel@alsa-project.org
Date: Mon, 11 Aug 2025 02:43:12 -0000
Message-ID: <175488019266.22.7389632412711969070@mailman-web.alsa-project.org>
In-Reply-To: <20190325161140.A0E0111288F1@debutante.sirena.org.uk>
References: <20190325161140.A0E0111288F1@debutante.sirena.org.uk>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: 2VIOLIR7CUTZVR7PT2KNQPVESQDCN3U2
X-Message-ID-Hash: 2VIOLIR7CUTZVR7PT2KNQPVESQDCN3U2
X-MailFrom: rinfo4080@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2VIOLIR7CUTZVR7PT2KNQPVESQDCN3U2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I tried <a href="https://textideo.com/">ai video generator</a> and was blown away — typed a single sentence and got a 1080p motion video. Game-changer for content creators!
