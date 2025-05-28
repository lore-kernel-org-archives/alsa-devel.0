Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92975C5AE59
	for <alsa-devel@archiver.kernel.org>; Wed, 28 May 2025 08:01:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76365601ED;
	Wed, 28 May 2025 10:00:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76365601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748419268;
	bh=THPrE6fUXi7GvE353Bd/Mb5v6dGJwwgTT0PDqoSobtI=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fQha5kxGZ2ne1lMONgA1FdkD0f3A6qGnXc/rpRnG3PeCKQ8KIquXu4bdVgt4hQZSE
	 5I6OqhJbmEllFH7516BqoEeBdpCet8ySlN3WbgU99Rq02XOQFmlYbuBq7DHflZqG4O
	 8tYMOtfH1q8979uc4B/OxMul15q2rJhP44EzCr5c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27DF0F805C4; Wed, 28 May 2025 10:00:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19FE8F805BE;
	Wed, 28 May 2025 10:00:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA4F4F80212; Wed, 28 May 2025 10:00:32 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id D2243F800D2
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2025 10:00:32 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Fix swapped left and right channels for Lenovo
 ThinBook 13x
 Gen4 sound
From: xebesex817@frisbook.com
To: alsa-devel@alsa-project.org
Date: Wed, 28 May 2025 08:00:32 -0000
Message-ID: <174841923285.20.7882190113041284599@mailman-web.alsa-project.org>
In-Reply-To: <20240701205516.22662-2-envelsavinds@gmail.com>
References: <20240701205516.22662-2-envelsavinds@gmail.com>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: MIUYTNF2RTH5GEXJDVG7MDTWEN4EG24S
X-Message-ID-Hash: MIUYTNF2RTH5GEXJDVG7MDTWEN4EG24S
X-MailFrom: xebesex817@frisbook.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MIUYTNF2RTH5GEXJDVG7MDTWEN4EG24S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

It's great to see the attention to detail—swapped audio channels can definitely be a subtle but annoying issue. Good to know it's been tested on the ThinkBook 13x Gen4. Appreciate the quick patch to get everything aligned properly. https://ragdollhit.io/
