Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F7FC35FFC
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:52:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E844601D7;
	Tue, 25 Mar 2025 16:52:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E844601D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742917949;
	bh=ee9/DH/vEAoPCU6aq9POLaiaM1gz0m/qBKIeJ65dG3U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kNmUHzQFC9Cc7k7Sa8/Mmte8MF6AjEBhvYWvKDGypC8Fh/o8rCnIQWQJGeUryJ786
	 iGIVkwVMz2zw+UWTs+WsLyD5dAwcTL5t1uUxjtxgqw65E6E7NCBsnCDtgUJlshTxuE
	 VvJ6ggDwaloilJIjeDbJRPeq49QgNnKsboTXYRaY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DF90F805BF; Tue, 25 Mar 2025 16:51:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F808F805C2;
	Tue, 25 Mar 2025 16:51:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D139F80424; Tue, 25 Mar 2025 16:50:53 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D51BF80104
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2025 16:50:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D51BF80104
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1830168c238d9a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/533@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/533@alsa-project.org>
Subject: DRAFT: HDA: Handle better Bass speaker including 4 channel mode
Date: Tue, 25 Mar 2025 16:50:53 +0100 (CET)
Message-ID-Hash: 4R2LEZJUXKK45RK3EVHQBXVNRXKTHK2W
X-Message-ID-Hash: 4R2LEZJUXKK45RK3EVHQBXVNRXKTHK2W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4R2LEZJUXKK45RK3EVHQBXVNRXKTHK2W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #533 was edited from perexg:

It's a follow up of #410 .

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/533
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/533.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
