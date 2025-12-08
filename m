Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F8ED3B7EA
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Dec 2025 18:14:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A96E960201;
	Mon,  8 Dec 2025 19:14:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A96E960201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765217656;
	bh=rdEa0SmWsbUa7Udmjd4KLqm3Xpga+uonyJpZZtdMW8o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=IRsS/y92J0/68UusiVg+g1q9KJDMa4K4Dp1R9jiuNUpvNA1VvCz2Wu6dS8HRuHMX5
	 XqNEVT3760Uc4hsw6pp/g/lH6dBUnhTZcbzkMvhH+3bVGOg4aBY0786pQJIeHZnePy
	 5wRJua6j6TgEm0e8mG7Ej+pehP5CNMeM75Y5cwec=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00330F805DA; Mon,  8 Dec 2025 19:13:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B12AAF805D8;
	Mon,  8 Dec 2025 19:13:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 364DAF80525; Mon,  8 Dec 2025 19:13:38 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D366DF80095
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2025 19:13:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D366DF80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187f5010a78fc500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/656@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/656@alsa-project.org>
Subject: ucm2: USB-Audio: Add Rodecaster Pro II
Date: Mon,  8 Dec 2025 19:13:38 +0100 (CET)
Message-ID-Hash: N5ZCMYYLNSBMKXPH6DRCRWQ7TPDFVZDB
X-Message-ID-Hash: N5ZCMYYLNSBMKXPH6DRCRWQ7TPDFVZDB
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N5ZCMYYLNSBMKXPH6DRCRWQ7TPDFVZDB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #656 was opened from parzival-space:

This PR adds support for the RODECaster Pro II Split PCM configuration.

The Rodecaster reports as two audio devices, device 0 is always the mic/chat track and device 1 can be configure by the user to either be a multitrack device or a simple stereo input/output device.
Using the USB PID its possible to detect the current channel configuration (similar to the GoXLR).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/656
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/656.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
