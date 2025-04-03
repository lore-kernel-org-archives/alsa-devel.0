Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F87C36014
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:20:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22B2860206;
	Thu,  3 Apr 2025 21:20:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22B2860206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743708026;
	bh=KDddhCYnknq7o0u9HTHHceQR1oTElD5Bmvm2te5gsNY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Qy7u4gduAYxWXHNkg4OxJCOynmdwqKsRtIr4r4KSnGswYmOQwtGcPCcRIIZ55I9y1
	 xPclQcwM6mmLh30SNGgAaL5S0qBxW6Pg2qSHaRM6fVwBcdWrQHfFa7+V8ltC+HKkWE
	 AbnuHlnO8I51rjjUBQiZIc/dM+xDty4Fu1cxh0YU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C3B0F805BF; Thu,  3 Apr 2025 21:19:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 60B4AF805B6;
	Thu,  3 Apr 2025 21:19:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92B72F80236; Thu,  3 Apr 2025 21:19:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 90BB1F8003C
	for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2025 21:19:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90BB1F8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1832e52c419f0600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/536@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/536@alsa-project.org>
Subject: USB-Audio: Add Roland BridgeCast One | adapted
Date: Thu,  3 Apr 2025 21:19:46 +0200 (CEST)
Message-ID-Hash: 45K3AA53SRIUFV7KZ4JB2KQW4CY5YSH3
X-Message-ID-Hash: 45K3AA53SRIUFV7KZ4JB2KQW4CY5YSH3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/45K3AA53SRIUFV7KZ4JB2KQW4CY5YSH3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #536 was edited from Simon99de:

Add Roland BridgeCast One
uses the same config as the bridge cast v2 as it has the same outputs and it worked in my test.

0582:030d

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/536
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/536.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
