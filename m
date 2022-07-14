Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8586AC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jul 2022 02:08:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4C66174C;
	Thu, 14 Jul 2022 04:08:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4C66174C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657764538;
	bh=ur7+8tdcnWf8Ps7m4KlMxD+5+2e8hcO05zs8mHf7oAo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h+wcCB8zNw11LVmjFqt4URUTj8+4g6OpMEnR7p2NW+C22Q2EYTgEHQAprDCxKo+KR
	 grWZNPV+BrGkUVgE8h74CuVK0ZU4/xuniiugsWXsCrQ5OwnYStqWJZ1qY30K+RPg9d
	 CQ5veswhfsfYWvegHOGj2ohGflml9MbAtZRLqiHA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41A7BF8014E;
	Thu, 14 Jul 2022 04:08:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6297F80152; Thu, 14 Jul 2022 04:08:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 606E0F800AA
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 04:07:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 606E0F800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1657764476274471998-webhooks-bot@alsa-project.org>
References: <1657764476274471998-webhooks-bot@alsa-project.org>
Subject: [Enhancement] axfer: survive system suspend/resume while streaming
Message-Id: <20220714020805.B6297F80152@alsa1.perex.cz>
Date: Thu, 14 Jul 2022 04:08:05 +0200 (CEST)
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

alsa-project/alsa-utils issue #157 was opened from aiChaoSONG:

If we suspend the system while axfer is doing playback/capture, after system resumed, axfer stopped playbak/capture with:
```
Fail to process frames: Streams pipe error
PLAYBACK: Expected 4611686018427387903frames, Actual 143392frames
snd_pcm_drain(): File descriptor in bad state
snd_pcm_hw_free(): File descriptor in bad state
```

You can get the failure by playing in a terminal with `axfer transfer playback -Dhw:0,0 -f dat -i -vvv -c 2 /dev/zero`,  and run `sudo rtcwake -m mem -s 5` in another terminal.

axfer should survive system suspend/resume, just like aplay.

@takaswie FYI, thank you for creating this tool. here is how aplay handle this: https://github.com/alsa-project/alsa-utils/blob/a566f8a0ed6d7ca5fd6ae2d224f3f28654a2f3be/aplay/aplay.c#L1738

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/157
Repository URL: https://github.com/alsa-project/alsa-utils
