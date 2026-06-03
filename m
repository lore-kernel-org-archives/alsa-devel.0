Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA9BCD6E55
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:15:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB0E16023E;
	Wed,  3 Jun 2026 10:14:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB0E16023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780474507;
	bh=0hEP6azch1M1y2yMUkfUzYHYJTCWDH4sKYVsoIxJ+tE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bQS3Ef/zMtbCAUo/+EzYzxS8l8u0HrpcuqIRpp2hmCog7d51idQ8dCEIVfa0hX5Bn
	 OubdvVtOFGBqxZkmCavZUBhpPkI2u/IRyyXfyhd7HE+L43Fio4rqua/P5ZlW4tGZoi
	 /ldsLzYJ5ykugNbghvDmMOKcl2y/PibIrNJrxyhg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DDF0F805FC; Wed,  3 Jun 2026 10:14:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E950BF80601;
	Wed,  3 Jun 2026 10:14:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0FEAF8045D; Wed,  3 Jun 2026 10:14:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EF344F8015B
	for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2026 10:14:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF344F8015B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b58417cacf2a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/772@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/772@alsa-project.org>
Subject: Jg/revert t14s full mm setup
Date: Wed,  3 Jun 2026 10:14:27 +0200 (CEST)
Message-ID-Hash: 3RJ6RDYQ6PX5KAXSGDV7P6YI7DUPIVEB
X-Message-ID-Hash: 3RJ6RDYQ6PX5KAXSGDV7P6YI7DUPIVEB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3RJ6RDYQ6PX5KAXSGDV7P6YI7DUPIVEB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #772 was opened from jglathe:

Unfortunately (or thank god, your choice) [the required topology change](https://github.com/linux-msm/audioreach-topology/pull/59) was declined in Audioreach, with very valid reasons. So, although this works really great on my boxes, it shouldn't be the default ucm config for T14s and same-config laptops. Therefore revert to the previous version that matches what you get from Audioreach.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/772
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/772.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
