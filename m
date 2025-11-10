Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5315CCFA13
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:16:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01BE460289;
	Mon, 10 Nov 2025 16:16:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01BE460289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762787807;
	bh=NA3lf5yDlS5P9EGiBST334r62EfSXrwHeXFsNN6MTqo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QUKMdVbjHRb+HY6ABdznFbUR5WQwtRpm9TnXp87MRSdYV44HQjTt+6BT8SRCaNmwJ
	 iA6YerQY2pCU+ln1A3tdOiBW1EPq5mmc+kD/I8j5LRuzwvIOfOB/ANMj++Yfhd9IPN
	 VrCAQL8mPhoF5q9/xh17AmyEev4pQbjy4TwiQnHA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E112F805B4; Mon, 10 Nov 2025 16:16:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 262ECF805C9;
	Mon, 10 Nov 2025 16:16:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52A26F8021D; Mon, 10 Nov 2025 16:14:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 966FAF8007E
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2025 16:14:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 966FAF8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1876ae11076c1900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/641@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/641@alsa-project.org>
Subject: ucm2: IO-Boards: Toradex: aquila: add support
Date: Mon, 10 Nov 2025 16:14:58 +0100 (CET)
Message-ID-Hash: VQYPW3FYC5H6FTI5JJCP2ELKXDJ3KWRI
X-Message-ID-Hash: VQYPW3FYC5H6FTI5JJCP2ELKXDJ3KWRI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VQYPW3FYC5H6FTI5JJCP2ELKXDJ3KWRI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #641 was opened from hiagofranco:

Add support for Toradex Aquila Development board, using the WM8904 audio codec.

This is a carrier board for the Toradex Aquila family, where any Toradex Aquila SoM can be connected to it, therefore this is being added to the IO-Boards instead of a specific hardware vendor.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/641
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/641.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
