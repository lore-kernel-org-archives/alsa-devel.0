Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D74606A326
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=RAIn3G+U;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpJtY5b0
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 930EF601D3;
	Wed,  4 Nov 2026 11:44:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 930EF601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793789075;
	bh=HIYlLAkJqdrxgNhdSStAzyVh+B+7I45KFL4xTkR07aQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RAIn3G+UaEUrglqZR75OOrLzYr8bGzeeo4cuhwmEjlWNi+JJCZGRO9E165t6yLNPp
	 5jWmURGSQGSyQZSqiz6R526LLGI04spEGFF91DvhTreT3431QhYnrhHXbUtYb4oEoF
	 c+gOE/0ZwqM0i0nuqH6BGivLrY2FfeyGO1vVx/kI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D667F805C8; Wed,  4 Nov 2026 11:44:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 78F6CF80600;
	Wed,  4 Nov 2026 11:44:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFA7CF805AA; Wed,  4 Nov 2026 11:43:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793789033;
	b=m/XqqmkIoBWapRmo9vKvGDZAzdHCYsPZ5FbW8Nek516sAzhGvAnTW472C7/karbo+ZoV
	 R6uff07iD+hQI48vh66UGSxPNt44r+o6/rJqXcDPlRfXdpPeCpy+a/4hUjrLWAPSgGp1m
	 2rErltkJhi5yvbw86RjFrNCeHlRmVN8AG2zExMnHG/hOJnwI3O6GMJscOUll3N1vxRt5E
	 N1MYsi9QoLdZ2B+oSOC0ZGWq/HSAcCwNetkflXiX/RyxNvbOx/Ta5cO3sBGtMHPFqJbZb
	 1eK3wBfhKLYsjQs6iyKkQuDGLjNmYBIub1Kw2p/017qnqMIKPsby/V8DErkclw18DIA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793789033;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=HIYlLAkJqdrxgNhdSStAzyVh+B+7I45KFL4xTkR07aQ=;
	b=NEZYl4RgLz6D+wIQR6IjFjidsK18eF5C9svIQN+ZzHCmIWwfJc+B6vLk76/dOePjg/LI
	 ZGm0YC84jJ+CLhTXJAeTrIc1X7BazbfA9gW4BuIfDhRyhPWNh6ANxp3uHv4jsKrlIw4dP
	 zDmXBx4pf5p/zaVyXhdjOa8uLXX7askWnxS8uxkCqAYG26ip1M7ECkzC8noVcsVHbetZn
	 aOJTyhnQUVjppLnCMLH4SqNWia4dU14pnVsBu3HD5kJxGHQiRWmG0Dm3SmYLMkDMVfQpI
	 iMZAYdXlgch5N+/xlrlHbGGPJ+OTnnNutadsWJSxDqQ/f/oAIp5nKBpDhJk8xL4NeaQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mpJtY5b0;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1C9E1F8055B
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 11:43:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C9E1F8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mpJtY5b0
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFA5A60F10;
	Wed,  4 Nov 2026 10:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1BD1F00919;
	Wed,  4 Nov 2026 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789029;
	bh=IIZsm9nSrfcDJNQ6UJ+L0ALkXvWsQSBq6eu2iPLZ9Hs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mpJtY5b0fMuteQhm97YIpr9ScbBBmslwbNSMk25LksnLzzDCeWJ2Z2Q3OAwN44Syi
	 a9xyxTWht/GJU/O4Hu2SEv9JJOYY51erTKQlfOe/4O/ISI6XGOblWNtgyJ188qzP4W
	 Iq9rzLCCCXcgNff+KWqVDvXRnSg0jFy139cTJikYu8CsMXXuSd5aP3NLohICPVL7kX
	 yUcvUjWGUiWzOA492vg3CI3RsKLXDkOF8ckA9syJGwTHOfOI7rGgvUa9pQzrhg4ZND
	 HMdRLA/y5neaDbqQEn1OZQ98YP5eJnuYbotPDI5NQYLVkAWnNINW7SQg9t4wELorTZ
	 gPa2TzCnp1TOQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id E67C425D8BD4;
	Wed, 04 Nov 2026 10:43:46 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org,
 Qianghua Wang <qianghua.wang@senarytech.com>
Cc: Bo Liu <bo.liu@senarytech.com>, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20261103070150.115136-1-qianghua.wang@senarytech.com>
References: <20261103070150.115136-1-qianghua.wang@senarytech.com>
Subject: Re: [PATCH] ASoC: codecs: sn624x-sdca: limit DMIC capture to 2
 channels
Message-Id: <179372836634.2270148.12592297178524380653.b4-ty@b4>
Date: Tue, 03 Nov 2026 17:52:46 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HIYlLAkJqdrxgNhdSStAzyVh+B+7I45KFL4xTkR07aQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJe88Seykp52LosQX7Bku8c1yyto86u/57vq1Ggc6Y2p
 cebdWZ+RykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACbCfIPhn0bK0VNKj/qWp3MG
 r9l/O7qo2Mg1XfXH1W/cf78cU+rrvsvIcO/nu8V3vDb1hdWfNJzLH5eYeL+y4eujtUZsQQ/aNi+
 dzAgA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: CXNRQAC3M454QWUOWY6D3UCVERJEQ2OP
X-Message-ID-Hash: CXNRQAC3M454QWUOWY6D3UCVERJEQ2OP
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CXNRQAC3M454QWUOWY6D3UCVERJEQ2OP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 03 Nov 2026 15:01:50 +0800, Qianghua Wang wrote:
> ASoC: codecs: sn624x-sdca: limit DMIC capture to 2 channels

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: sn624x-sdca: limit DMIC capture to 2 channels
      https://git.kernel.org/broonie/sound/c/b54a20b671e3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

