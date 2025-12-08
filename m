Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DCED3B7DE
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Dec 2025 11:45:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A34246018C;
	Mon,  8 Dec 2025 12:44:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A34246018C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765194306;
	bh=XotWFd//sWUgWrDEw/DIW9SCA4jQ7tzSYX74alQnAIU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EdnjWbKCTxgMbtlxiCw9bMGNgRTHCaqVDn6saCKQsXchH0Sd2gqxHMMrZkdJyfqDQ
	 dKZ8gf5AsKBcz86xYL0nHSYB9jvH/ZtGv5WtOEeWOCjAXWyS1vwkhPHsriQCbViAEe
	 UeUsdhwGIIevjTj/KX5bkmx3cdL7zz1T9CCcbdAw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D183F805C5; Mon,  8 Dec 2025 12:44:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4BB9F805D6;
	Mon,  8 Dec 2025 12:44:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAA58F80525; Mon,  8 Dec 2025 12:41:31 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A96EF804B2
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2025 12:40:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A96EF804B2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187f3aa4bf9a2800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/655@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/655@alsa-project.org>
Subject: ucm2: sof-soundwire: Simplify cs42l45 configs
Date: Mon,  8 Dec 2025 12:41:31 +0100 (CET)
Message-ID-Hash: MZDEBKEX3C5A3RLO6AUFVU2N77W4UMOC
X-Message-ID-Hash: MZDEBKEX3C5A3RLO6AUFVU2N77W4UMOC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MZDEBKEX3C5A3RLO6AUFVU2N77W4UMOC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #655 was opened from mstrozek:

Continued from https://github.com/alsa-project/alsa-ucm-conf/pull/644

Simplify cs42l45 configs following machine driver changes [1] which bring normal switches instead of mute switches.

[1] https://lore.kernel.org/all/20251127163426.2500633-2-ckeepax@opensource.cirrus.com/

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/655
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/655.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
