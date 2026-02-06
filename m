Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4083BEE20B3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Feb 2026 16:06:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EEB4601CC;
	Fri,  6 Feb 2026 17:06:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EEB4601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770394006;
	bh=dTcq7BwjJbtjqDdrrwwTc9MW6WU4DxkfbaP6ZlwlYc0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rV7xUT1NyS5nZB5WuKqa7rAW+gerGoI2sE5VZz3wz9PvabcXXblml8++65lKsQXde
	 RSnln31MW2fUjs3rUTlsLaGoHTXR0uVO4FmyXCj/gkwfwBbPZbaXo9cV9MRc/cO1pS
	 GoaZUp85pH+f0OKU2pTMq5MHxkZH8ymjshd5FNes=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42EE1F805F6; Fri,  6 Feb 2026 17:06:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EBCA2F805EB;
	Fri,  6 Feb 2026 17:06:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8B48F804F3; Fri,  6 Feb 2026 17:05:59 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 26EC1F8016E
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2026 17:05:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26EC1F8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1891b3ec6dd39e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/703@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/703@alsa-project.org>
Subject: alsa-ucm-conf upstream update
Date: Fri,  6 Feb 2026 17:05:59 +0100 (CET)
Message-ID-Hash: Q4ZMDBMWAEKSTH3MYHGFGPCXIRIBJC7T
X-Message-ID-Hash: Q4ZMDBMWAEKSTH3MYHGFGPCXIRIBJC7T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q4ZMDBMWAEKSTH3MYHGFGPCXIRIBJC7T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #703 was opened from jackpot51:

Updates to latest version in Ubuntu 26.04, should be compatible with 22.04 and 24.04.

It would be good to do audio testing of:

- thelio-mega-r2: Upstreamed :heavy_check_mark: 
- thelio-r3: Not upstreamed :x:
- thelio-b5: Not upstreamed :x:
- thelio-major-r5: Not upstreamed :x: 
- thelio-r4: Upstreamed :heavy_check_mark:

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/703
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/703.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
