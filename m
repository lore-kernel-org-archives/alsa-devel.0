Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB620C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Dec 2022 07:25:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 197B21696;
	Wed, 21 Dec 2022 08:24:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 197B21696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671607525;
	bh=ivksccXxVxudZyh9nTBsQsATWi1j+axSRVWNj64lycw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XO50c9OBWy7LU/HJSTeJbhsV8MArwbUxfJfCNqBNMECCrUBBewdYlH2ZGhMeIbO+s
	 mnC3DDO6hkEIjBALJgYYv9ARmqLDR3jZpCd6zMo57qHT+2pBzHrE8WAB70cNn2yVEJ
	 y2jsWHZJPIpBd9MHPGkPxugFnj89Iv5cwV6Hz2EE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB499F804AD;
	Wed, 21 Dec 2022 08:24:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C25FF8047B; Wed, 21 Dec 2022 08:24:17 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C8F8EF8024D
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2022 08:24:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8F8EF8024D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671607453083547115-webhooks-bot@alsa-project.org>
References: <1671607453083547115-webhooks-bot@alsa-project.org>
Subject: rt715-sdca soundwire micphone record no sound
Message-Id: <20221221072417.8C25FF8047B@alsa1.perex.cz>
Date: Wed, 21 Dec 2022 08:24:17 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf issue #255 was edited from KaiChuan-Hsieh:

On linux kernel 6.0, with rt715-sdca codec on Dell platform.

The internal mic can't record sound after boot.
Try $ amixer cset name='PGA5.0 5 Master Capture' 1

Then the internal mic can record sound successfully.

Upload alsa-info for reference, [alsa-info.txt.G6EnxHQlnM.zip](https://github.com/alsa-project/alsa-ucm-conf/files/10275425/alsa-info.txt.G6EnxHQlnM.zip)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/255
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
