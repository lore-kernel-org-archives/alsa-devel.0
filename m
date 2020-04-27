Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE2C54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FBC206B6
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lvspuqVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FBC206B6
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DD891680;
	Mon, 27 Apr 2020 15:39:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DD891680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587994837;
	bh=y+ClY3/qt+uQByypwWxU1QaxnQvkkLS65s7lYd4s4Y0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvspuqVyTkNww4R9CF5c7GF/9ghlI1sl2ftuzJ5tkGvCddcXGtG/fC2kWXS0ezDtR
	 vVkw7N5yVKjRdn3RU8LTUAo7ioHxEEKUUA95Q8CQJ5q6sFhakQsmT5/eyCznu2qHHk
	 hg9juWT+B8ZmqqcjDctakmvrolBG3LyiWykKhr0A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70863F80217;
	Mon, 27 Apr 2020 15:39:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28F0CF8022B; Mon, 27 Apr 2020 15:39:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1E6E7F80112
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 15:39:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E6E7F80112
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1587994776588638067-webhooks-bot@alsa-project.org>
References: <1587994776588638067-webhooks-bot@alsa-project.org>
Subject: pcm: Fix memory leak at snd_pcm_new when THREAD_SAVE_API is defined
Message-Id: <20200427133943.28F0CF8022B@alsa1.perex.cz>
Date: Mon, 27 Apr 2020 15:39:42 +0200 (CEST)
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

alsa-project/alsa-lib pull request #42 was opened from chunxuxiao:

The pthread_mutexattr_t object should be destroyed by calling
pthread_mutexattr_destroy(), otherwise it may cause a potential
memory leak due to the different implement of pthread_mutexattr_init()

Signed-off-by: chunxu.li <chunxuxiao@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/42
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/42.patch
Repository URL: https://github.com/alsa-project/alsa-lib
