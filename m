Return-Path: <SRS0=rSKw=LW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05550C2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Jun 2021 09:09:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E1F61C34
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Jun 2021 09:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E1F61C34
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96D3E1690;
	Mon, 28 Jun 2021 11:08:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96D3E1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624871340;
	bh=dbizctBF386oHj1ON1F7O0xdu9gzNHaG5uZscK84K3g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bmnBt0HjZFyYLD1Z3QeUs+lfYwDvkIkb3jCFiTbl9PoDg6LNuMkfGaca5szOFcIdK
	 DPmhtFLyOI0zUoie9BaY17COX23V5qXJYJQ8lyQRu1K7YqXOfvUC2YMTnTpU4dX8Ck
	 1tmtD5KF8XPLJXnW0zcEzFURe/lt6U4dhWeRyWzM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B774F8020C;
	Mon, 28 Jun 2021 11:08:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BB4BF80229; Mon, 28 Jun 2021 11:08:08 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0966EF8020C
 for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2021 11:07:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0966EF8020C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1624871276362214088-webhooks-bot@alsa-project.org>
References: <1624871276362214088-webhooks-bot@alsa-project.org>
Subject: Dell platform adding ucm2 conf with generic mic-mute LEDs feature
Message-Id: <20210628090808.5BB4BF80229@alsa1.perex.cz>
Date: Mon, 28 Jun 2021 11:08:08 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #105 was opened from GoPerry:

As the post-patch did, I would need to add one patch for the dell platform which has enabled the generic mic mute feature.
But I did not see the below paths. 

/sys/class/sound/ctl-led/speaker
/sys/class/sound/ctl-led/mic

https://www.spinics.net/lists/alsa-devel/msg125821.html

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/105
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
