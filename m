Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CF606A683
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=c9Q2ZNS5
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09CFE60214;
	Mon, 23 Nov 2026 15:56:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09CFE60214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795445807;
	bh=3Q7bTZWHSY5+Uzr0KDSAgRzN2ekqNsuq+pOrvsyESYs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=c9Q2ZNS5O+rpMLPvIm6zsi9HzVAiqj5UZNa67X0kYOP+kmo4j7YMXGu6w2w9U6RCu
	 BBo1tX1UeKs4sJB6WlcOjGjQdga3bnWdsduf2dGXHwekcfBbR8uosh/fU6YLDKukQt
	 ZFkvAOzE5zIVnDLj76yx7p8Iadktyu3EqZgKCpX4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A74A4F80603; Mon, 23 Nov 2026 15:56:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A949FF805FD;
	Mon, 23 Nov 2026 15:56:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C780F80552; Mon, 23 Nov 2026 15:56:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795445763;
	b=klHT9pmsNBAJ0896HWXeQAexSqRapIbDkFFXwRudE+oPfNgoK57EUZuNhm4n9CougeKt
	 V2pohMP/AoWVWTQ/fHeVdT4ahB+d0JfEZ9DQBHVCFNeK/J3q3i10063OhmOuKM8au6wyD
	 09D1Xt7ZMtrJBPE9yxNgyf5sENXOdGAmf45pYM5078kkGPEJ3h5hsvru8mU1nFBMBctvW
	 YXSc1rIZFQO7dKs6Gmwan+f0enu1lNpt+n9zTyXVJsRyb52hV4cRUxjDY9FN5OCqCC1IC
	 YNCk8V6JMTl0wRFENIK8YlLDBCm9c9p9Hd8im17wjea87Dtd/lQlMdZP6fQ1P3DrIxw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795445763;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=3Q7bTZWHSY5+Uzr0KDSAgRzN2ekqNsuq+pOrvsyESYs=;
	b=OoJfluZm1XJxJFcNQeBuGx4qUi7HigU8JX1cL1z9ZKOHT0XJxqDXViFP+Tn1bVZwTnLy
	 RtFAk5o319zMk1CDU7GkmDpRrFtqRpLXJ+jl78DXzDG8Sw/3HQxMwf1prrJI4p49xcICZ
	 Bq1/dlRMbMdeEAyTMrYzMywkTSm1j2CgXPz9ovxYaRd+OMc8ZtlJoNmWdfD+cz+41eUfA
	 SbkMlnAMXoP7sopM2SrdxFYuj+c+3fnfCh80i9F75L6qupdSvnnyA4QTJWgHV+PCHp75H
	 obWOR8AHqu7Rl7bHj22MrWzqDlHEnex8GbqxOZCvTmfNnbETQx7Co19gABobPVFVLdQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 610D5F800B5
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 15:56:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 610D5F800B5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eab4685f8f1f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/924@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/924@alsa-project.org>
Subject: USB-Audio: Creative: Add Sound Blaster Audigy Fx Pro profile
Date: Mon, 23 Nov 2026 15:56:05 +0100 (CET)
Message-ID-Hash: Q4WHLRA4P3ZY4W6KHY4RUJAGE76KJLMG
X-Message-ID-Hash: Q4WHLRA4P3ZY4W6KHY4RUJAGE76KJLMG
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q4WHLRA4P3ZY4W6KHY4RUJAGE76KJLMG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #924 was opened from galpar:

Add a UCM2 profile for the Creative Sound Blaster Audigy Fx Pro (041e:32b7):

Outputs: Rear Speakers (HiFi 2.0 / 5.1 / 7.1 on hw:X,0), Rear Headphones (HiFi 2.0 on hw:X,0), Front Panel Headphones (hw:X,1), and Optical S/PDIF (hw:X,2).
Inputs: Rear Microphone & Rear Line Input (hw:X,1), Front Panel Microphone (hw:X,0).

Integrates with the kernel mixer controls (Rear Output Mode, Rear Input Mode, Rear Mic Boost Volume).
[audigy-fx-pro-alsa-info.txt](https://github.com/user-attachments/files/35282217/audigy-fx-pro-alsa-info.txt)

Related kernel patch: https://lore.kernel.org/r/20261123-audigy-fx-pro-quirk-v1-1-5fbc574e25d3@proton.me

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/924
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/924.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
