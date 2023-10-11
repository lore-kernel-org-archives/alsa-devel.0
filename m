Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E558CD98E0
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Oct 2023 00:38:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9573EEC8;
	Wed, 11 Oct 2023 02:37:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9573EEC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696984726;
	bh=sNb7tNHFs8IxsUwzQys+Y/w7K/+mNVqfH6AsNosdxYk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rD3nkFd/xu2qBaoG9RUyVriOwNXt6O6zodASa+DCvTyLCFeQ9rUHuqLMtw1+lmjoQ
	 NZL++CQQ+0Udzpveb5kVuKaZC/oTrGFok6Yht0uuAJkk8r0Qc8t+GMMbgVl5w1MFcB
	 h93DOeXz6/Vw4PIMvRufIKjJeVqw2DoN9DgF2hSg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAD82F80166; Wed, 11 Oct 2023 02:37:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58496F8027B;
	Wed, 11 Oct 2023 02:37:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E99CF8027B; Wed, 11 Oct 2023 02:37:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DEA4BF80130
	for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2023 02:37:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEA4BF80130
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1696984629860895634-webhooks-bot@alsa-project.org>
References: <1696984629860895634-webhooks-bot@alsa-project.org>
Subject: Add UCM2 configuration for Behringer UMC404HD
Message-Id: <20231011003714.0E99CF8027B@alsa1.perex.cz>
Date: Wed, 11 Oct 2023 02:37:14 +0200 (CEST)
Message-ID-Hash: VPZHMCWLJBNSDR4TJU62272225B44PU4
X-Message-ID-Hash: VPZHMCWLJBNSDR4TJU62272225B44PU4
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VPZHMCWLJBNSDR4TJU62272225B44PU4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #358 was edited from Janhouse:

The only difference between UMC204HD and UMC404HD are the 2 additional inputs and a different USB device ID. Tested with my 404HD, works great.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/358
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/358.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
