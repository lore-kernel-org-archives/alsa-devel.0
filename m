Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA77C5AC80
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Aug 2026 05:52:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C59D60211;
	Sun,  9 Aug 2026 07:52:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C59D60211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786254761;
	bh=C3QFzJVao10m9kys/OQkMUKo97BUsT249asX2X6mPUE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gBz5Ev+/d3dQKzCgim1AK8DbV99bN8JPvgeAd+ZveQY05L9VmNnbSRFGVKM+AbrYy
	 E7ljeywq0faZM7XdVWoBemfHGxqpeyS9DsTMAKZudRl+4eRJDNqvSEqsOdOMOJsNYB
	 5CB9VoDKdTgOREuOPyzxzJGOX+f92cWzlyQd+qBk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E51BCF805FF; Sun,  9 Aug 2026 07:52:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 40703F80600;
	Sun,  9 Aug 2026 07:52:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9C6CF8026A; Sun,  9 Aug 2026 07:51:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786254718;
	b=J+NNgnSQo2cGi4Efy9Ibcwa/cdOoCdZw6bbwW6Lz31iwVVeJeDHRMwh/9sKlqg9cpar/
	 LBccdOw3KlTp6DqP6V/MczujuDczR61wp+3Sh7I9CSfNxgnNz34hAtAHL27QsRRfispYB
	 VlL4oZWVa5qjOczhXG7xbPJZIWW1dIt04Ukj3geWHY2XEsSRPdclv5aJgqcCKcNmD6zgE
	 FADds0fVvrIq31v5EJUcPHeOhX6+1aGGfK3BEJOt1aTvmwey3EytAPRpq7qhSHSudxyvf
	 7nwNPOLrRsIRHB2Tuv+EM3G4aFKHQLa6FFkWxnIpgZGAE3CAgvU/2sDBdz9WlyJE2SA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786254718;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=C3QFzJVao10m9kys/OQkMUKo97BUsT249asX2X6mPUE=;
	b=gO0+mcxiICm2ib4wlAGicj0iL6Jp3Ku+a7+5RPeGZIESxwxCOpZz44eTyMnXwhtJaajt
	 uKQg/LhKIe0qycQQm3uoRGPlr1A98jU/220I4/hGvrmgro/oREn9keVktKRR/CDGnN7vp
	 sd1KMKMgv6GETzJADRCP9rCQfClHsqKcl5XZSZ4TsrrDnCqrDtixAGC9qTuF8WFTnvcFy
	 3hClviEjNn/b4RL6UjLI8VUEKNCMUil1N7NANeEwvd2OGJrxp0j/hFqR/yHNaVkCVTDIG
	 zcptO3Y6ZEkQIfKJ+j8ikVgeth7lQ6ecCn3/kIPq6jz80fXgVQoG0ZtyAkEV3gicNiA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EF58F800BA
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 07:51:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EF58F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ca0d336a52a100-webhooks-bot@alsa-project.org>
In-Reply-To: <18ca0d336a271d00-webhooks-bot@alsa-project.org>
References: <18ca0d336a271d00-webhooks-bot@alsa-project.org>
Subject: Audio front panel does not output on motherboard: ASRock X870 Riptide
 WiFi Motherboard
Date: Sun,  9 Aug 2026 07:51:58 +0200 (CEST)
Message-ID-Hash: V2JVVOFKBCJBITS7MJUYEJFDHKBWDGOK
X-Message-ID-Hash: V2JVVOFKBCJBITS7MJUYEJFDHKBWDGOK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V2JVVOFKBCJBITS7MJUYEJFDHKBWDGOK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #519 was opened from Raj2032:

Hi everytime I boot into Linux regardless of what distro it is (such as Ubuntu, EndeavourOS and CachyOS) my headphones connected via aux connection to front panel does not output anything unless if I connect to to the back panel and then back to front panel again. I don't have the same issues on Windows.

My motherboard is ASRock X870 Riptide WiFi Motherboard using codec Realtek ALC4082 7.1 CH HD Audio Codec which on both Windows and Linux reports it to be USB audio.

I have never had issues with gigabyte motherboards on the same desktop computer's case, the audio codec is using HD audio.

Are there any plans on having this fixed in the near future?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/519
Repository URL: https://github.com/alsa-project/alsa-lib
