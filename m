Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA5FC531DC
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:48:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE9612BE4;
	Fri, 16 Aug 2024 15:48:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE9612BE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723816101;
	bh=a2Uu8UI8V0vvRA3hscoyzszAisM9xQQnRCyxHTEGNwM=;
	h=Subject:From:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:Date:From;
	b=SSz5KpRjXmYY61OIPh97fBe/iO91F5JMlzsm5m3SyS9VN7FsBQWa/bbtxyF5f+Ty/
	 ncWgMLENF51VBCXXBYYlKKs0NjFfxsOnjZ6rae13BWK3nnRx3kUZCzT4f3OrGFeyTH
	 xCzWvDAwY5kgsEJ5ADOrds4lfISfPgfBOfchcTUQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70ED2F805B5; Fri, 16 Aug 2024 15:48:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 87CDEF805AF;
	Fri, 16 Aug 2024 15:47:59 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [PATCH v1] ASoC: codecs: ES8326: Adjust buttons
From: zhangyi@everest-semi.com
To: alsa-devel@alsa-project.org
Message-ID: <20240816102034.48617-1-zhangyi@everest-semi.com>
X-Mailman-Approved-At: Fri, 16 Aug 2024 11:06:48 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X5RQYEYPFIWUAQ3JDNPQADELNB2W3ITH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Date: Fri, 16 Aug 2024 15:48:00 +0200 (CEST)

The content of this message was lost. It was probably cross-posted to
multiple lists and previously handled on another list.
