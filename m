Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5766C6369E
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Feb 2026 01:14:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B822E601E7;
	Mon, 23 Feb 2026 02:14:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B822E601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771809272;
	bh=fjmafbjueptRNU/tI/Wgr0LFdmnwXZzcQzOW6CY+cWU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mx1Xj41aaVd1GOh8l9uc7wqfcAXoCaIXctsvv6zwC0udXrg7cVZGXb4d+ITBvLtxU
	 G+l2+JDBVH4Ij6m2q8zSvHmQiZjBqKZvJB+cdvUdnFHL2q1vGMOWkCCUJ9GcqqecRo
	 1lAvcVBnndMr9wXMl3IJDpPu18SaZKjQpKGjpsqQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A25E9F805EB; Mon, 23 Feb 2026 02:14:04 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0832BF805EA;
	Mon, 23 Feb 2026 02:14:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DB94F8025A; Mon, 23 Feb 2026 02:13:04 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FB82F800D2
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2026 02:12:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FB82F800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1896bb0f7fc3ac00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
Subject: USB-Audio: Add Audient EVO4
Date: Mon, 23 Feb 2026 02:13:04 +0100 (CET)
Message-ID-Hash: FZAKJPX4HVL6NQHZSFWUH6JBLIWONXEP
X-Message-ID-Hash: FZAKJPX4HVL6NQHZSFWUH6JBLIWONXEP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FZAKJPX4HVL6NQHZSFWUH6JBLIWONXEP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #708 was opened from motolav:

This is a 4in/4out device with 1 analog stereo out and 2 analog mono in. 
The hardware mixed loopback interface takes up the remaining 4 channels. 
Without this UCM the device is configured as 4.0 surround for in and out. 

I copied the way Windows configures the device except for the stereo mic mix as I couldn't get it to work somehow.

The loopback interface requires software to configure what channels are mixed into its recording interface that's only available on Windows and macOS but there is an incomplete script to control the device's hardware registers at github.com/vijay-prema/audient-evo-linux-tools.

Closes: #303

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/708
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/708.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
