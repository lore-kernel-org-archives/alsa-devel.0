Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9A9C7EE29
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:20:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C260382A;
	Wed,  7 Jun 2023 11:19:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C260382A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686129619;
	bh=a2Uu8UI8V0vvRA3hscoyzszAisM9xQQnRCyxHTEGNwM=;
	h=Subject:From:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:Date:From;
	b=u8VbSs69FrHnKlhq3oJIMqokYbd/4kOzxhW2WS6fuKSswwCneV3qBH0rKukJREV5v
	 N9V0okxmXnMUUrzxEiDnFKX7/UOxnin0WfiXPRbw0xnwwdZN9qQnkP+XRNmX71UXS2
	 aNXAQItKoscmkm2dT0/YOJ5b7SvuQcij9ZiL0O2A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C08D9F80553; Wed,  7 Jun 2023 11:18:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E1E1F80553;
	Wed,  7 Jun 2023 11:18:41 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [PATCH v4 2/3] ALSA: Implement the new Virtual PCM Test Driver
From: ivan.orlov0322@gmail.com
To: alsa-devel@alsa-project.org
Message-ID: <20230606193254.20791-2-ivan.orlov0322@gmail.com>
X-Mailman-Approved-At: Wed, 07 Jun 2023 09:18:35 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SCZ274SBN2K2DFGAH3JNGOBSKQIT65MQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Date: Wed,  7 Jun 2023 11:18:41 +0200 (CEST)

The content of this message was lost. It was probably cross-posted to
multiple lists and previously handled on another list.
