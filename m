Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62635D6406B
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Dec 2025 02:06:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2528E6021D;
	Wed, 17 Dec 2025 03:05:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2528E6021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765937163;
	bh=DFK8sXxyXvgePTs5ac/4VCRNOfyrGRZrniLanC8sbAg=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hWm48evDMB6rFDDcCLmaygEOSmbvOJYbp+J407aQ+GQ7HPNXqQ3FjaghnNgN8VOpO
	 2pl7tOl4dwlJ7Xq2VAYSh/w9wnSjNjjl0XnjlTiKkbq2wR39+aN2dK8xZf47Om9bcq
	 pDDvTqzeJaDYT0qqhEl2URvaYfky21IhreKuGmFY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B51B8F805E0; Wed, 17 Dec 2025 03:05:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45281F805DF;
	Wed, 17 Dec 2025 03:05:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C84C2F805A9; Wed, 17 Dec 2025 03:04:36 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 98511F8013D
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2025 03:04:36 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ALSA: usb-audio: Update for native DSD support quirks
From: otiscavin3@gmail.com
To: alsa-devel@alsa-project.org
Date: Wed, 17 Dec 2025 02:04:36 -0000
Message-ID: <176593707654.20.9197518324825807731@mailman-web.alsa-project.org>
In-Reply-To: <20251211152224.1780782-1-jussi@sonarnerd.net>
References: <20251211152224.1780782-1-jussi@sonarnerd.net>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: JNFU7PIJB5AKAVMBTIQ66SOIBAYZDLGW
X-Message-ID-Hash: JNFU7PIJB5AKAVMBTIQ66SOIBAYZDLGW
X-MailFrom: otiscavin3@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JNFU7PIJB5AKAVMBTIQ66SOIBAYZDLGW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch updates the quirk table / handling logic for USB audio devices that support native DSD (Direct Stream Digital).
