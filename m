Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CC4C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:52:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12A536025F;
	Wed,  1 Jul 2026 20:52:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12A536025F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782931945;
	bh=9xP0juVBuaTNdYCFVEgPnPOejqvgopH5b9i7i4Cf6wY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=m71k6SeSwjh3LHlz4ukGfibNBCMFqi5ndGHYBiQiuss+cM5/XSUTFdNFC0QL5ob4e
	 R76e9yK9MCYeG0PDrxg6DBbgMEV6NAvjpvJCVudf/P60Vp/ZDUJSIKz0LCtdk6dG2+
	 oFtMKI8ZQTChIJ80H6316w1Bgn2QlykGqZHJEU/w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B38AF805FA; Wed,  1 Jul 2026 20:51:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 653C3F805CA;
	Wed,  1 Jul 2026 20:51:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5955EF804D6; Wed,  1 Jul 2026 20:51:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782931905;
	b=VpILpxPTRzLb/Gfc7gGGbIhDA1DefPMaqRLJWfXUKJX2xhwZUpvPvocS7dh9Oq5S7hAb
	 pMXjucA7rZShTsEg2WLrxadWZ76Dmrae0TlD3q4jLUP07Ej8rAXef5vLXhMpdcRQdFYVV
	 PUpKR89kDJdZNTrN55jlHi7K96ULxSmwDQPgYB0RYP+GJ19EO1cTxfH566ciW9qNK6KyD
	 4a1Wz3vWBo0cATuvWdn/3f1AIPgQfSHWqopSwbu0jgq9XpxIDXPZI76Jg29O3uFpFWs+j
	 xHYEVPi2xbOvCgjyrMUARCASxiD4zbuYsUjXa2CzP5+Ta2Zw3X9AU5uoE9RRkiPqIwQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782931905;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=9xP0juVBuaTNdYCFVEgPnPOejqvgopH5b9i7i4Cf6wY=;
	b=XkhorqhnAPU7wGWEoHHSLs8n6mJlLwNQTvotKrWRFtqhYRcfj9Kri9CmGG2O1wUvsnDh
	 3BgyLP6XeDFTac4n5iFzh0Y7zkmBeXpBrJo/og4qvM/xTbIOtLhwcjBZZEcohkzZbcTZC
	 s5Cdq93DigvcKK6BVzhoA3OE6cUMOQkcHVGhkjdlLsvBZo+PsjW3B9nXrsPjA55RFAhtw
	 d2Hb0PEEUp91JWk4zvB6QbT5s0as57DjMe5Hd5rwvqW56ajX2nFSzU+qb2Z391EXjfrPE
	 qTq54ygqo8l9uOz4s1pZSvYj1IYWz6nQ0jmL8JMRS2JZHI7UudBhJqqdBtXaiC9d2dg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 51685F80152
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 20:51:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51685F80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18be3f1eb7cc0e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/803@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/803@alsa-project.org>
Subject: Add Topping E2x2 ucm support
Date: Wed,  1 Jul 2026 20:51:46 +0200 (CEST)
Message-ID-Hash: 2GM32MNNRRHLFEWRONOB6HKGCSYOHCQP
X-Message-ID-Hash: 2GM32MNNRRHLFEWRONOB6HKGCSYOHCQP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2GM32MNNRRHLFEWRONOB6HKGCSYOHCQP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #803 was opened from oxiadenine:

The Topping E2x2 is an USB audio interface from Topping Professional.

The audio interface has two Microphone/Line/Instrument inputs (1L, 2R), two Line outputs (1L, 2R) and one headphone output.

The "problem" with this audio interface is that by default it exposes 6 hardware channels and ALSA recognizes it as a 5.1 audio system, so the files `E2x2.conf` and `E2x2-HiFi.conf` are to create convenient and user friendly profiles.

Also, a `SectionVerb.EnableSequence` has been added to the file `E2x2-HiFi.conf` to disable the exposed hardware channels that are not used.

USB identifier: `152a:8752`

[alsa-info.txt](https://github.com/user-attachments/files/29563789/alsa-info.txt)

I tested it in several applications like Firefox, Telegram, Discord etc, and also I recorded audio from Ardour (DAW), and all is working as expected.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/803
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/803.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
