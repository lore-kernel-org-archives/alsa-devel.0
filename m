Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D8606A31F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=S23l/siK
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCEB2601FA;
	Mon, 23 Nov 2026 08:51:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCEB2601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795420318;
	bh=Mxlx8UHiGgo71MmnC8YmilZiFVH8F8XIbsKWxwnUQBQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=S23l/siKy7wYSXvQ+6AvXFPAQYlfF+rdopS67VWNhskUiZFmuCFk47ZHP326u4eBS
	 qZi6cWjd6jx0wwe3LAMUTsPMImmA9r76kFHQdBJ0iEKcVfMAsQfuk6PUzHWjVU+vZt
	 thTqAHviExmYybPK2iv82JSTNTLhDMDUzp95YpL8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E140F805FE; Mon, 23 Nov 2026 08:51:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C676CF805FE;
	Mon, 23 Nov 2026 08:51:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60859F80552; Mon, 23 Nov 2026 08:51:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795420277;
	b=G28Ix1NfhX3JJ59I3ztTAB1KEVtPxddXAdVhorae1M1TiBeSNyP11b7z5JT9ln8Xl8bY
	 HcnVHcZNfPCwMoWHnbkOQjGX453iweNirS/t7HKvLrV+mXGhXMz1M0Aq+fx2zdYeKluRX
	 H5aw9sru7416szgyFkZeSPws1NbT89KR9L3Ka/z3Rn+ec67NERhLWzdW1w4l4pVFBJUJ7
	 QXLaGcYLIVUCZiJm0tlGeGrOQ5MGK6AqiTip97GYzG7BrBmGmxkf3M1Ji3AxRa77zHaUn
	 AUSw/FXSce9EbPN0uOpWoJB/4BG6M+Ic7p9POXMZjLWzSurQn2iWuf0pG+Pim1cFKEA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795420277;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Mxlx8UHiGgo71MmnC8YmilZiFVH8F8XIbsKWxwnUQBQ=;
	b=E1yvF9A106JMRI4hoA6nOQ4mwl5zY3kJ9YChhmNfEyzH7s9G7fgwT+74KoGru9zpH12K
	 SbKuKUu5q+8RVdilNeSe6iPldcvxW+peXztN0gQF1qqryUoc7fVv6lvVeQezUEkBPUUpO
	 4aHwYnJnodlxmFTzuFlRIxdOCvtpk6qzu3bbNiB+/ilSBg55mkYHh/Z6ynHVUmT1PYL73
	 0dNxlyu/hY7pGpnpvuQ2bviP+l+iFxpn/reMtSbFk9LbN+9IXP9XOJu0Rtxlvydmn7+7S
	 9hUfvS1sxTxCWDzSnt6PWjAe92G5qMffnjF+MbN748tIOqFznqsgrkSNp0/d+RiqHGA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F2DECF80020
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 08:51:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2DECF80020
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ea9d3a4d62eb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/922@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/922@alsa-project.org>
Subject: ucm2: HDA: ignore phantom Line Out when internal Speaker exists
Date: Mon, 23 Nov 2026 08:51:18 +0100 (CET)
Message-ID-Hash: 4JRNVG3LUUXBT6CGQUNZSVFN2BHKLMUC
X-Message-ID-Hash: 4JRNVG3LUUXBT6CGQUNZSVFN2BHKLMUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4JRNVG3LUUXBT6CGQUNZSVFN2BHKLMUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #922 was opened from ridhoassuryadi:

Some laptops (e.g. Acer Aspire AG14-72P with Conexant CX11970, Subsystem ID `1025:1935`) expose an unconnected `Line Out` pin in BIOS (`NID 0x26`) without jack detection capability, causing the kernel HDA driver to create `Line Out Playback Switch` and `Line Out Phantom Jack` (instead of `Line Out Jack`) alongside the internal `Speaker Playback Switch`.

Because `ucm2/HDA/HiFi-analog.conf` unconditionally defines the `Line` device with `PlaybackPriority 300` and `JackControl "Line Out Jack"` (which does not exist when only a phantom jack is present), PipeWire ACP splits the `HiFi` profile into separate `Line`, `Headphones`, and `Speaker` profiles and reports the `Line` route as `availability: unknown` with the highest priority (`10400` > `10300` Headphones > `10200` Speaker). This causes WirePlumber to default to the non-existent Line Output and prevents automatic profile switching between `Speaker` and `Headphones`.

When both `Line Out Phantom Jack` and `Speaker Playback Switch` exist, do not define the `Line Out` device. Desktop systems without internal speakers or systems with real `Line Out Jack` detection are unaffected.

Signed-off-by: M.Ridho <ulunmuhammadridho@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/922
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/922.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
