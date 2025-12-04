Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01074D1CDC4
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Dec 2025 03:16:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECCC560203;
	Thu,  4 Dec 2025 04:16:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECCC560203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764818183;
	bh=3fkxZYCrUwO3toRysIoQOUqfUnyDVwUEMbi55qA/WX8=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Ipazmz+Xq+yx9h+Q428uL3y3kqraVSJgDm0vIMcodtQZ9ZZzsc66Z9XInRi3lwjCK
	 58Q8uVMgZ/wsOXmzeWqGTgf2Ka90ltZX4mCqclXRDu4rD3aERU/jfxDZYmtolXn14w
	 kaH59o3tUipCnY7cwXqb/RoLHRTIiGkJJv6DiH38=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F96CF805C0; Thu,  4 Dec 2025 04:15:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC5ADF805BA;
	Thu,  4 Dec 2025 04:15:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95AB6F80542; Thu,  4 Dec 2025 04:15:41 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 89F98F8025E
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2025 04:15:41 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ASoC: SOF: Intel: Retry codec probing if it fails
From: piokyfara@gmail.com
To: alsa-devel@alsa-project.org
Date: Thu, 04 Dec 2025 03:15:41 -0000
Message-ID: <176481814155.20.46025487402008885@mailman-web.alsa-project.org>
In-Reply-To: <163838351937.2179725.554786262652740080.b4-ty@kernel.org>
References: <163838351937.2179725.554786262652740080.b4-ty@kernel.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: WT7QK5DESSVOFY72WHM4EXR23RMKXCIJ
X-Message-ID-Hash: WT7QK5DESSVOFY72WHM4EXR23RMKXCIJ
X-MailFrom: piokyfara@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WT7QK5DESSVOFY72WHM4EXR23RMKXCIJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use headphones! They boost focus and make timing much easier because the music becomes clearer. https://geometrygame.org/online
