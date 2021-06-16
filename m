Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D13EC48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 09:09:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3DB61241
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 09:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3DB61241
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C91FF1671;
	Wed, 16 Jun 2021 11:09:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C91FF1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623834590;
	bh=Xl8niPPwCIdbSULQ0W2n+JZW12wma+/AaBIuLMaCrYs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fqCtlagjOyuf8VCVXuM3qXZMe6qIWBPDTosvowz0FakH/dRV4GTn2iIsio3oe9LuT
	 +BGZdmFYcvTjJEJa9PTdxG2D/CLg8cxmzNNkxl/oBxHaGWT7zbUWRXGwXG14FzqGkB
	 noTocf+kADrXSsE0OtCgKck++wJvsYxl4hFQt62c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69428F802E8;
	Wed, 16 Jun 2021 11:09:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 974D5F8028B; Wed, 16 Jun 2021 11:08:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6210FF8028B
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 11:08:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6210FF8028B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623834530946352005-webhooks-bot@alsa-project.org>
References: <1623834530946352005-webhooks-bot@alsa-project.org>
Subject: ThinkPad T14 AMD microphone LED always ON
Message-Id: <20210616090859.974D5F8028B@alsa1.perex.cz>
Date: Wed, 16 Jun 2021 11:08:59 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #100 was opened from miquecg:

I'm running Arch Linux with `alsa-ucm-conf` 1.2.5.1. This problem was present in previous versions and it's being discussed on a [forum thread](https://bbs.archlinux.org/viewtopic.php?pid=1977273) among other things.

So the problem is that microphone LED is always ON but mute/unmute behaviour still works.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/100
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
