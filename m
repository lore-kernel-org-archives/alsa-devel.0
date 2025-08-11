Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B778EC87FCF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Aug 2025 02:25:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E478660248;
	Mon, 11 Aug 2025 04:24:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E478660248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754879105;
	bh=1uxyidhdfJ+bIsWil/noGUPH2CFS5GISLdngkglzveg=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lZEUg8ltd04j/R7aQjNs0wPycWQr4giIB4dGrcZjwy3fZvFVJ3DxdBSCgbe3xvz1x
	 eIBZg+hfCMNTIoaPCn1IzivktVQdfiRunRtmn8NW9Q4zGGIEztqnpMElhrWMl84p/S
	 ooPh01OBEI408CAg+u0Wcp2JyJr4+C7zgnNyA1/8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0CE7F805D7; Mon, 11 Aug 2025 04:24:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E196F805DF;
	Mon, 11 Aug 2025 04:24:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE692F80518; Mon, 11 Aug 2025 04:24:37 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id B461DF8010B
	for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2025 04:24:37 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [alsa-devel] Applied "ASoC: tlv320aic32x4: Model CODEC_CLKIN in
 CCF" to
 the asoc tree
From: rinfo4080@gmail.com
To: alsa-devel@alsa-project.org
Date: Mon, 11 Aug 2025 02:24:37 -0000
Message-ID: <175487907773.20.610252790119139799@mailman-web.alsa-project.org>
In-Reply-To: <20190325161140.A0E0111288F1@debutante.sirena.org.uk>
References: <20190325161140.A0E0111288F1@debutante.sirena.org.uk>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: KS6TV235UPU6RZVMLXECYED7ZX454Z3M
X-Message-ID-Hash: KS6TV235UPU6RZVMLXECYED7ZX454Z3M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KS6TV235UPU6RZVMLXECYED7ZX454Z3M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

If you want to turn text or images into videos fast, <a href="https://veo3.im/">Veo3 Video</a>  is the way to go — super simple and really powerful. Perfect for anyone looking to create videos in minutes

https://veo3.im/
