Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A0C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:53:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8EB64EC7
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8EB64EC7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22C0C1662;
	Sat, 20 Feb 2021 00:52:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22C0C1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613778813;
	bh=/r1rJVqB8/LN1nHheftFxJIosf4eljuH9LZ8BHYzd0I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kqmxo+khdRQtf3L3uxpGI80JYdQ1HqIE4QLYGrlt902N8jSeKcNWYWxHNLJoMm1Tl
	 1i63Q2tbMWXbZQZq3M95CnOI4t7z63lEAbEjUww59DEUzc6WFE8ZplTH3ifjkuoi/C
	 C4BB24pItVOpT290qZ8h/xeo8kvVhs2RkULZlXWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A04C8F8013F;
	Sat, 20 Feb 2021 00:52:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBB73F8020B; Sat, 20 Feb 2021 00:52:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8BADAF8013F
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:52:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BADAF8013F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1613778752188235044-webhooks-bot@alsa-project.org>
References: <1613778752188235044-webhooks-bot@alsa-project.org>
Subject: What is the semantics of snd_pcm_hw_params_any?
Message-Id: <20210219235241.CBB73F8020B@alsa1.perex.cz>
Date: Sat, 20 Feb 2021 00:52:41 +0100 (CET)
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

alsa-project/alsa-lib issue #119 was opened from jpalus:

It is not really a bug report but rather a request for clarification in attempt to figure out who is to blame for incorrect pulseaudio behavior.

I've got two different cards -- one internal and one USB -- which behave quite differently for this simple high level code:
```
snd_pcm_open()
snd_pcm_hw_params_any()
iterate snd_pcm_hw_params_test_rate() to check for supported rates
snd_pcm_hw_params_set_rate_near(44100)
snd_pcm_hw_params()
snd_pcm_hw_params_any()
iterate snd_pcm_hw_params_test_rate() to check for supported rates
```

In essence supported sample rates are queried twice, always with snd_pcm_hw_params_any() before them, but separated by snd_pcm_hw_params_set_rate_near().

Now with internal card both iterations report 7 supported rates while for USB first iteration reports 4 rates and second only one (44100). Is that expected or is snd_pcm_hw_params_any() supposed to provide configuration which would result in all rates reported again?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/119
Repository URL: https://github.com/alsa-project/alsa-lib
