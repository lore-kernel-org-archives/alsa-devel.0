Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA4BE9410B
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jan 2026 04:42:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B53F6601F8;
	Fri,  2 Jan 2026 05:42:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B53F6601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767328977;
	bh=We1KRh0GsmkXLY9j7A0GbpPFnksMFgrrEegsweLZEIc=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=jeY6U51CZ/xjSHX6imIZIflPi1Y1lQnH5LlVNoqTFAJOKyuU9afHkw5oH9ytMHMZ5
	 miaO25FRiwbG3YyNib4xD1UDBz0N1GUzbY3/nvHWAZZsz+fGHQvSDg4FGu47UOYZHV
	 9Jo4io8NPTv0pjNiA2b5HjWrNopnOQUkdYCJ5u80=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D975AF805E3; Fri,  2 Jan 2026 05:42:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44EA1F800AC;
	Fri,  2 Jan 2026 05:42:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 972FAF8032D; Fri,  2 Jan 2026 05:41:23 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 677A8F800AC
	for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2026 05:41:23 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [alsa-devel] MOTU Midi Express XT
From: cruel.yak.duil@protectsmail.net
To: alsa-devel@alsa-project.org
Date: Fri, 02 Jan 2026 04:41:23 -0000
Message-ID: 
 <176732888338.22.14590998045758020894@mailman-web.alsa-project.org>
In-Reply-To: <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
References: <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: 3Y2R3QPYZU4ISY7JBUD4ILM3OYMOA27O
X-Message-ID-Hash: 3Y2R3QPYZU4ISY7JBUD4ILM3OYMOA27O
X-MailFrom: cruel.yak.duil@protectsmail.net
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/762TOVLZWVVEJJUNIJRLCZ3AYADSOQV3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

That pesky parallel port, always vanishing when you need it most. Retrofitting a driver for modern hardware, now that's a challenge I can relate to. Sounds like a kernel deep-dive is in your future. A similar situation arose when I was trying to get an old scanner working on a new Linux install; wrestling with legacy drivers felt like a never-ending Connections Game puzzle. 
https://connectionsgamefree.com
