Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F327C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:49:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD9E207DD
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hX8Hu6cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD9E207DD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5965615F2;
	Wed, 22 Jul 2020 12:48:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5965615F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595414971;
	bh=jd7Rsmkdci5xlJ+4sVbEUvJ19v3MxaRX+y7a95nIhyU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hX8Hu6ccbRiFvokZDBHgF38W1AZ9cDz3sum+pldhss1dEyb82pxXlvwko4SgXm2qD
	 +NtKRjX5j0UyBSdXHtmjaTWX9xa1ks7vk7UlhKMv8C4TMcgY7fZzGLWIT5Z15nYz6c
	 ptHOZEdURlFuI7nC8ogsnEk241FMedaVkOt5MxXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 035A8F80141;
	Wed, 22 Jul 2020 12:48:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07A27F8014C; Wed, 22 Jul 2020 12:48:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 19083F80087
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 12:48:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19083F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1595414913076913118-webhooks-bot@alsa-project.org>
References: <1595414913076913118-webhooks-bot@alsa-project.org>
Subject: Several issues with HP OMEN dc-0019-ur
Message-Id: <20200722104840.07A27F8014C@alsa1.perex.cz>
Date: Wed, 22 Jul 2020 12:48:40 +0200 (CEST)
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

alsa-project/alsa-lib issue #73 was opened from UnicodeMan:

Hi. I am using HP OMEN dc0019ur laptop with linux 5.7-xanmod kernel and KDE neon system. 
Laptop has combined 3.5mm jack and a seperate stereo microphone jack.

With no modprobe changes:
mute led does not work, headphones work, but microphone is not detected, and if i plug anything into microphone jack, it switches to microphone in combined jack.

With hp-line1-mic1 quirk: mute led works fine, headphones are detected, except microphone, though it works anyway. Seperate microphone jack does not work at all.

With headset-mic quirk:
mute led does not work, headphones jack works, microphone (from headphones jack) is not detected when present but works when switched to anyway
Microphone jack works perfectly (detects a plugged in mic, works in stereo).

no quirks: http://alsa-project.org/db/?f=a73a83ba0610e3fd88310999b197fdde4372249a
hp-line1-mic1: http://alsa-project.org/db/?f=f4d08dec7918c79a391fb1898d50c57a2448d872
headset-mic: https://alsa-project.org/db/?f=4b1eeef821f39eea28071ac2f2c0babcf515ef14

aaand, I hope I am writing this issue in correct place :D

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/73
Repository URL: https://github.com/alsa-project/alsa-lib
