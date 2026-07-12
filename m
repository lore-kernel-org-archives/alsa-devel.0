Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E30C43458
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jul 2026 01:32:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78016601D3;
	Sun, 12 Jul 2026 03:32:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78016601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783819970;
	bh=zFftdC0gCmji9UyLgQvL+zaSnqvma7Yi7SV0ku0Xc0k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ksYhgH/DwQhWST1YxmSb/mHXvGPogg0q0brrt2lU7Yu58Ic0J3o9KnO6oiEUfpkNB
	 KLAVPWY2hqAnFAyRGb5koe3jDqat0/fv6Dcsi7FuDskyUN3tF8acNLCUcEXuKSuxBn
	 rujs/mxY7sPnhG1zuDsU2Gf9Bc5IYyQ/vkWgMkNg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0625F805F4; Sun, 12 Jul 2026 03:32:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61CA3F805F9;
	Sun, 12 Jul 2026 03:32:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58C2AF804B2; Sun, 12 Jul 2026 03:32:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783819933;
	b=YMWt6hTR9Bk1uUfJ2ODvYzQVQ00vkGvj5GKFOlcTcMO9SuTKoP8/UURqYxFopg++P4Rq
	 KUkM7a7jlLyUsOCzlljNzDL2lkIn0Es+vjwv34hVoktNFFx0Y1mZNPFS1Ji6vMX8JVbCc
	 HKWhITUjHN7qTYImpGbIL3rrIxbQEKDdw87MrdV3QvBFWLKTTKh6gSfP9hXw+U1oulH3D
	 k0b+jGG6FAO+Ex8MjhfkK36ctzqVGPBLO2/1w5z4QOPuJdjW09o2KpX+pisatn4E9a/TY
	 EowWoSsnUR8GepBdOmXDmfzGH/vm2+zf3A7EH38UbMq5FHuscxQifLiBsCqTnICo6FA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783819933;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=zFftdC0gCmji9UyLgQvL+zaSnqvma7Yi7SV0ku0Xc0k=;
	b=GNyr7vqxyNQ9wdqRQbKU9ZTwQcQjLni1trJ+HcxDPN/zpur2nM56EQ5HOmfPJYryeVsx
	 /JHSa1zIojUNqWZTy4i4L+deZyRUw7KTvxn58HRLvnECDrbx1W2itj9KbC+n3/DapBrO9
	 Pe5lABDdhWHokdfMSbpRiHSbAcmFXhyYVGTcpITYMmaJ+1tlPepBpt+JYokz2k5qYpRb5
	 lYxXrUY/YQ39Ph3MGheaq7su1uOHQJtIV7Lqgksd2STU5RCg6Wb5/yQdn9EbQfgFYS81/
	 w+6C4Y7FLWh3FyQ/E3rtQlm/iqvUWh6DWM59fOFI7zC5ICHYhKN5USujnmWgl5y0+Uw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 27145F802BE
	for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2026 03:32:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27145F802BE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c166c6c220f600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/809@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/809@alsa-project.org>
Subject: ucm2: USB-Audio: Add RODECaster Duo
Date: Sun, 12 Jul 2026 03:32:14 +0200 (CEST)
Message-ID-Hash: F4KW3NGTQNCIL67HCXM2Z62ENM7P2O5P
X-Message-ID-Hash: F4KW3NGTQNCIL67HCXM2Z62ENM7P2O5P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F4KW3NGTQNCIL67HCXM2Z62ENM7P2O5P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #809 was opened from parzival-space:

This PR adds support for the RODECaster Duo Split PCM configuration.

The RODECaster Duo is technically very similar to the RODECaster Pro II, they even share the same firmware, although channel mappings are sightly different.

This profile has been successfully tested by @csanthiago in [parzival-space/rodecaster-pro-2-virtual-devices-pipewire #7](https://github.com/parzival-space/rodecaster-pro-2-virtual-devices-pipewire/issues/7).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/809
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/809.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
