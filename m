Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533D4CA5FA2
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:41:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 709C0601F3;
	Mon, 28 Sep 2026 22:40:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 709C0601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790628059;
	bh=n8BdvvlVZ8BOuLomXGAaxiO3VmYltEejbzbB6sW9MzM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZM+me0F4qjujFT+b5SAlzxiCBqbYvelGTY2+wKo/2m2hKAxAbUCuap/osfPREYnCM
	 oHwHjs94SBEVPNzPIS0DyNIln+l2CHo+oxs8PxaXl10nKTWmLX58+BiOstblvmawEE
	 rxoAd6OXYNTMrz9jKDslZd/IsSnU5MCtaEySrvTE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09D28F80602; Mon, 28 Sep 2026 22:40:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 444BBF80601;
	Mon, 28 Sep 2026 22:40:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE918F80525; Mon, 28 Sep 2026 22:40:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790628019;
	b=HHVqrYEsevVN01HSbUEluuTAzDs9IYeR1G+Ak1k+YDy7VNKBwEAuXcc3mZjyJw0ILMNw
	 k1CK8bkPtbwyaqLtblhTHZ4O3W6QIXCewlPCsC1vTVRicbcekd9e0jKGfur0544ZU2Kzc
	 r4Ye7y943c7EkFH0EtA/dm5rxKJJ++UG2gOt6RF+7sDbI5YwqHco28npf3MPofv6R2ulM
	 HLf1TwFq5NtnLvmcUnfXIHmij+VG3shlG2iQwxd9ao5W9D9fGIVRrVR+I0KFBglzcri61
	 xg9v6PanQi5fJWtnxm9Lav2x9iUR3gqKusFHDaSW/sTMHVIdkXfC1KCaE8K03+/XcaQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790628019;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=n8BdvvlVZ8BOuLomXGAaxiO3VmYltEejbzbB6sW9MzM=;
	b=X7JcF2zeNsLIbhA2vCwsCWNsxMyb+qO4PzV82UnIClP5IJRbR0mqG20U6w4pPZkhSAoE
	 /FiIcnCqsEK/PcNekc8y4Oh8equEZioJ9uqaB/3obfGv2fAEDhIbq+UncAjLjnimCYT0W
	 GUVOAUZXBGzmIpTl0AM/vYBZS17rZHExf2cd11GHRdQWZx13GZMH6Ne593t/26JVTkE6I
	 PWDBH7gUiuZHI+Q3bVsppa2/6O7GQ7IvPEHNedW+03DkcRRzjRBhcTONTLRDf3D1D2qlg
	 izJFaPUOqewI2j/DpET4e5emYSHFw/yadYwNlnDcUN3tRt5vs760HOqb4JchKJ/B92g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EE77CF80020
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2026 22:40:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE77CF80020
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d996b1def46700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-plugins/pr/68@alsa-project.org>
References: <alsa-project/alsa-plugins/pr/68@alsa-project.org>
Subject: pulse: fix negative PA_ERR_NODATA comparison in pulse_delay
Date: Mon, 28 Sep 2026 22:40:19 +0200 (CEST)
Message-ID-Hash: D4HGO4XI4DCDM6UGIEQKWA7FXUDHVKYE
X-Message-ID-Hash: D4HGO4XI4DCDM6UGIEQKWA7FXUDHVKYE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D4HGO4XI4DCDM6UGIEQKWA7FXUDHVKYE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins pull request #68 was opened from dirty49374:

When `pa_stream_get_latency()` returns `-PA_ERR_NODATA`, `pulse_delay()` compares it against the positive `PA_ERR_NODATA` constant and returns `-EIO`. This turns temporarily unavailable latency information into an I/O error for ALSA clients.

Compare against `-PA_ERR_NODATA` so this case follows the existing mainloop wait/retry path. Other errors still return `-EIO`.

Validation:
- Built the PulseAudio plugins with `make -C pulse -j4`.
- A local test harness exercising the actual `pulse_delay()` implementation passed success, temporary NODATA/retry, permanent error, retry followed by permanent error, and connection failure cases. The NODATA regression case fails with the original comparison. The harness is not included in this one-line patch.
- In a 20-second local CPAL/ALSA integration probe, injecting `-PA_ERR_NODATA` during capture and playback produced I/O errors with the original plugin; the source-built patched plugin continued with zero reported stream errors.

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/68
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/68.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
