Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA39ECC6B30
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 01:16:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4070D6020E;
	Thu, 15 Oct 2026 03:15:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4070D6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792026969;
	bh=eDfBdZaoCqp7jdMic4DFj8yWhybM97Cp76Nw+dF/6LI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=M1TTF6sZ+v+EjCubHHIyDIM+gBa/JlI0rZnEscUO8RE34Sm/gCol3M5afROtW7XTi
	 BdEdl8ifqYNuw6bm3C08A5TRUZ2XFpcCKEBKl4sZw88bTSXNheL83wmPdVxhANU74r
	 c8UCj5wfvm11ijTFdpc+CdcXASwzuyaws33qX7qo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AB7DF805F9; Thu, 15 Oct 2026 03:15:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C36BF80553;
	Thu, 15 Oct 2026 03:15:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24444F804CF; Thu, 15 Oct 2026 03:15:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792026926;
	b=iBOvVjhh3XZ/rvHL8y3R8g0a/KOPkQJ5hADRPC4DAlCSPBXcwtfiPzxQbwN72Qfv5cdg
	 qBx4c7zIgxQTLw+m8hQ9MUpPa/k4raLib2aECNAGwq+M9SyqTiWeenlPllvcN+2A0uCPs
	 9Qj5OcgX5C0s8lanM6enR9TrVRkfQ/SqTSfqDjmSkkdOtT0jCMErmGcQ1mxh2vVfHfo3z
	 63T7EOXSNv+cAW9lqm12O66Vz3L0L8LR5W3km4GBjhntQKBn+F/9EGw/nGCt/5iX0wdBP
	 9hexA3A6aVkTTs6kMaR/9imfXnWV66UhQZ40uwcyyEV5vHKAHp1gfCuC3qQVJn5oTHw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792026926;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=eDfBdZaoCqp7jdMic4DFj8yWhybM97Cp76Nw+dF/6LI=;
	b=ajYYo6oyl2R/xusJdR20Q9mysKO3m+OOMe+YbbsHF9zUlE9GCx4fqBW1x2Bt9jTb5MwX
	 uxD3j1Dm3+2VyuCyQLklQ4VM7MBks+256aDQLu/SUE2NX4mccu1SqTwOwhrw9Yi4BXMMC
	 bRU+/3jgub13gbxeNQGOTI6Vri5QWgAAA0nuVyW3fcUsBIsbr72cd96WiymMgmysLDRxD
	 aYPGUvilKVDte8e7lFZlpIP+ZCl5FCmdAj3A9pBWYbvmB7y9HDJfRFJx4GTPZSkcUqy93
	 TshY+1SXlP2V+aoRAiuz+ZNoHW5IVF+s1Eura4jSXmx9qIQ0nwfoxGAZv96TdAFrRhg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F04B8F800FA
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 03:15:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F04B8F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de8efe3b549000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/883@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/883@alsa-project.org>
Subject: USB-Audio: Steinberg UR22C,
 UR24C: apply the firmware channel count to Direct
Date: Thu, 15 Oct 2026 03:15:27 +0200 (CEST)
Message-ID-Hash: GENL43GOQHHA3WR5WXGHGD5P64HI6B5C
X-Message-ID-Hash: GENL43GOQHHA3WR5WXGHGD5P64HI6B5C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GENL43GOQHHA3WR5WXGHGD5P64HI6B5C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #883 was opened from peterix:

The firmware condition sets DirectCaptureChannels to 2 for firmware versions 01xx/02xx, but the Direct use case is created by a top-level Macro, which UCM evaluates before If blocks. So the Direct use case kept 4 capture channels on that firmware, while the HiFi use case (loaded later) got 2.

Define the Direct use case inside the condition instead. With newer firmware the result is unchanged.

Not tested on a UR22C or UR24C, but  it follows the same pattern as the UR44 change in #882, which was tested on the device, and was checked with alsaucm by evaluating both profiles on a UR44 whose bcdDevice (0212) matches the firmware condition.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/883
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/883.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
