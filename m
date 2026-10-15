Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FCDCC6B30
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:52:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73EB460210;
	Thu, 15 Oct 2026 02:52:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73EB460210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792025558;
	bh=wrTGCYjGi1qIax1IwijF72bDm63mVCbAUQM8SGRUFj0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aPnntBqHhLw6iHfDaxVA2cA8xRfoY55BeUpMeNQyqIPb06jQRyV01r5Xd6V/PFayv
	 +Xncs2dNPjqbvjYM3zpRjZdj0o/dRX3+j+XN1nfdV2RVvpm43merb8OrxkR5cnc2Ps
	 hK0ck15Hn24soYeu1EL+uOYa7XwRBV9/MVbrNjN0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2567EF805FD; Thu, 15 Oct 2026 02:52:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D25BF805FD;
	Thu, 15 Oct 2026 02:52:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15A18F804CF; Thu, 15 Oct 2026 02:51:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792025515;
	b=IlNbIEcWfBf1oD8O941+cWPIDo9F89G1P+/b3/8AIUGy4ZunlTBzr8sk/zpmf6VWAHZN
	 a97DR9eZ4owprcnWBN7UkopUhe19xIdWrx3Epz41YoonZU1Y7/Z78Arz1k0yArZfcnIb1
	 RFLoXNU/W6kHfqedTlnXZ2/pqXVcYdMkX9P4pZPe2KKZczPn8GqH2UG2sX2KVWEU2ZkON
	 GUe77MQHld4WNt3khn95iUq6CrYVW9xAsk0uHXBDwc75kQ/0Y+L1ZWdT8SkDAwYbS49m6
	 tLtOFMpKgb8m8syeHuWXDJoQ0v5p5CAPgyfBuqWf79CbUe2Kn5W10aTsQK9LG7ZDXmw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792025515;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=wrTGCYjGi1qIax1IwijF72bDm63mVCbAUQM8SGRUFj0=;
	b=QUDd0DPHAau9sqWCo0gljcOyQFNicIpub6L5eb+TlX3xN3/o2P2b4hqcCxNzqxhoGyuU
	 vqR/uZoOLgv/9Z4LJEv7Z9OX0nRqu46ME6wTKYPknHb/wpv52JJeOAF2svJX7givm5B08
	 67ZqXhOh7o1UHaP9Tw5Grx3i9QUY7VfSbs3GYX8lT5Eto2TIvtgInQEPSzMPkevrKf5n1
	 JoYWjBASHwHi/iQGosvj2wbYIeF+WS0SiSCd29JL8AWwPxZH9H5kFPObWJ+OFRrG7pK3z
	 tqrtBsPkQBPKDh1mYLz140sglRZ3XQlIe+SUvaObeVK+sO12HEi6CTrIi5zLCdLFEbA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6170DF800FA
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 02:51:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6170DF800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de8db5d6047700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/882@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/882@alsa-project.org>
Subject: USB-Audio: Steinberg UR44: support the non-class-compliant mode
Date: Thu, 15 Oct 2026 02:51:57 +0200 (CEST)
Message-ID-Hash: CDVYBZYPJQ3DI4QXIRO7ELD6T72UKR35
X-Message-ID-Hash: CDVYBZYPJQ3DI4QXIRO7ELD6T72UKR35
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CDVYBZYPJQ3DI4QXIRO7ELD6T72UKR35/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #882 was opened from peterix:

With its [CC MODE] switch off, the UR44 enumerates as 0499:150e and has six playback channels instead of four: DAW Mix 1, DAW Mix 2 and an FX Bus that feeds the built-in REV-X reverb (the channel order was checked with the device's own meters). Match that id, split the playback PCM from 4 or 6 channels, and add an "FX Bus" device when the FX Bus exists.

The Direct use case is defined inside the condition, as UCM evaluates Macro before If blocks.

I'm working on fully reverse engineering the UR-44 tools in both CC and non-CC mode and reimplementing a Linux version of the bundled tools. This is in support of that work.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/882
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/882.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
