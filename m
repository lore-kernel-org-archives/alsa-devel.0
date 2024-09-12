Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B026CEEB566
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:35:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CA2C93A;
	Thu, 12 Sep 2024 10:34:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CA2C93A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726130109;
	bh=lsy56WWx6BVMS95bkosEBXALW2PtJ8fo1m2kbrWVRWA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=nTLYZvIAm+GfOamYqBLHji9vm/BcrgEPaNfMqeW9johK8nJBiwt064UG7am25ju7S
	 lTOU7RXXfltJw7E+Ud3LTPIxQ0rr2KIGseYwkGEBzBFQbKCeA3lLqrWmqDtmbibGxZ
	 vV9Wobj066RaORMpovzF1SNNr+azhHMFvqRwQNaE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDE85F8059F; Thu, 12 Sep 2024 10:34:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45F8EF80301;
	Thu, 12 Sep 2024 10:34:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08E6EF801F5; Thu, 12 Sep 2024 10:34:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B83CF80074
	for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2024 10:34:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B83CF80074
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1726130067482922554-webhooks-bot@alsa-project.org>
References: <1726130067482922554-webhooks-bot@alsa-project.org>
Subject: ucm2: soundwire: rt722: add ConflictingDevice in each device
Message-Id: <20240912083430.08E6EF801F5@alsa1.perex.cz>
Date: Thu, 12 Sep 2024 10:34:30 +0200 (CEST)
Message-ID-Hash: 3KOU4NZT7JURHPEID37SRSL7SGURYJ33
X-Message-ID-Hash: 3KOU4NZT7JURHPEID37SRSL7SGURYJ33
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3KOU4NZT7JURHPEID37SRSL7SGURYJ33/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #441 was opened from shumingfan:

This patch allows only one input and one output to be opened simultaneously.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/441
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/441.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
