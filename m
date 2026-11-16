Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80573606A31C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=MNUEA4Bj
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F621601E3;
	Mon, 16 Nov 2026 14:11:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F621601E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794834725;
	bh=rPHE4Ha+fwq6j9R7bqxBoO67w3sb59gb69C5O6M9+qA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=MNUEA4BjR0viZlFfGk+JEaKl5Owxg3nbTlu1SteCQ3oIe9TlJVva1wQ9Aq9p6wlii
	 dOC6g+ErgJlNp6porkSoq3POg4xn/I0H1WzysGZE90tskSlA9fOL7KYgAizfqvo9S8
	 oAlyN3mlSLEprSotqIfhYDmU2d5LsRxrPWTnD9tw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CF9CF80605; Mon, 16 Nov 2026 14:11:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 33601F805F4;
	Mon, 16 Nov 2026 14:11:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5F73F80510; Mon, 16 Nov 2026 14:11:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794834686;
	b=QPa6EhtH9K/9/qVBjql005rCm4wgfjc09DqR4Vyu6Xx9Zev4sFwDt6v77Uk8gCQUApjm
	 YYzkyKWA0AHK3Xeee+0FeH/s4LPGnpPkFzdCZkwyXczSTf0hswdRcQnJPCC8nFYAh6XwN
	 VDRqgXBk9a5qSDZC5/zfsJKXOj+0CLFRfCkrwMl3d3x3QXlN5tE1yjM6rMCX1dtM+WRUU
	 gI15AOLBijJX84QTCA7hnfiP9b+aWJVbhESklBs7vovQPYJnn6t3t9qOPwKA90vRCxCCR
	 7hI+pc+HGvOp6OLGmiSUMVh6jsrhKTM/6k8Ce0Heeo8i+4bBPDFRFUo/ZIXvBb6QRtQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794834686;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=rPHE4Ha+fwq6j9R7bqxBoO67w3sb59gb69C5O6M9+qA=;
	b=jcRkKf5J2MmcYYjAQfzSHkyfDgpg7sPef9c4TDVaQClX5Gz70vuFl9I+nb+gTUq7bIIA
	 C6DFkz6M5hFZDO36cZDYooUZ0eY4kTOT+gOnV/erS/3ec74Bt7v7I2b1Wgs0FCVwulXBN
	 o069SsuVQp9AvDGW19W2gxjOfPLrodhVcXGvMDIR4hRbth+9vMdWE6rDuIkgUor52C+8m
	 qxtg7m6jOihEU4AaH8dh/p2dXjvoRypYVSPSKCA5aN/G939x7KUsj4C14bu5Ru5d73mki
	 1pjcaCeyowWcxvpg+AlP9fIOlyejcdmwr48FlFypSocD8mXccI8pgBZfqbSmTk6bBNA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id CB27EF80095
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2026 14:11:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB27EF80095
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e888a309327b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/917@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/917@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: add Lenovo IdeaPad 5 2-in-1 (DMI "IdeaPad")
Date: Mon, 16 Nov 2026 14:11:27 +0100 (CET)
Message-ID-Hash: D4NQFAPSE33VIRMPVGUJHZV653Q2ZGPZ
X-Message-ID-Hash: D4NQFAPSE33VIRMPVGUJHZV653Q2ZGPZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D4NQFAPSE33VIRMPVGUJHZV653Q2ZGPZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #917 was opened from Marcostk:

The T14s profile is meant to also cover the Lenovo IdeaPad 5 2-in-1 (14Q8X9, type 83GH, Snapdragon X Plus X1P42100), but the existing pattern expects "Ideapad" while this device's DMI reports "IdeaPad", so the condition never matches and the card gets no UCM profile (no sound).

DMI_info on the device: `LENOVO-IdeaPad 5 2-in-1 14Q8X9-LNVNB161216`

Add `IdeaPad 5 2-in-1.*` next to the existing `Ideapad.*5.*`, which is kept unchanged so no other model is affected. Tested on the 83GH: speakers and internal microphones work with the T14s profile (headset and DP audio not tested).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/917
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/917.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
