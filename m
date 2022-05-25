Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F40EC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 25 May 2022 01:02:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C76FB164D;
	Wed, 25 May 2022 03:01:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C76FB164D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653440547;
	bh=DQqpYh1dxfprSDjwKN1xPrR1aB2l63fAFFoZC8B4kFE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MPb7KvAs0joDZuCH+/V/GYntsTnIGVympqpioThqaaNIP0D7MjbvIwadryHuVKJZM
	 lJOxNOCY6rhxZrcYIyHnRyoO9tJ0m+aSWMQatKuOlC70Td9BBS0wpBYom/TEArIS/Y
	 5oTuvH7KjLTtlJdFLTNzgxeZS1CC2ue0Sqsngrxk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A053F800E3;
	Wed, 25 May 2022 03:01:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB154F804D1; Wed, 25 May 2022 03:01:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 308F1F800E3
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2022 03:01:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 308F1F800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1653440492642976999-webhooks-bot@alsa-project.org>
References: <1653440492642976999-webhooks-bot@alsa-project.org>
Subject: Update mapping for the new Gigabyte Aorus Pro WiFi rev 1.2
Message-Id: <20220525010135.AB154F804D1@alsa1.perex.cz>
Date: Wed, 25 May 2022 03:01:35 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #157 was opened from 13r0ck:

Requires kernel patch from:
https://bugzilla.kernel.org/show_bug.cgi?id=215988

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/157
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/157.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
