Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3F5C79FB7
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:40:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFD1C602A8;
	Wed,  9 Sep 2026 16:39:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFD1C602A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788964797;
	bh=nXqldKj1WtwjSvBCR4xgLHn0k9Ej1P0PzqVWPKG7/4I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cJlbXElVMnLnpbAkyN6ry8v0exocgYsz7pxfYn8GU/9wvWzLBsVIh4QAqYeq3o5+f
	 YLTyBXN7Mtttm8r9+5Lv95FWmSQ4XGMcheS5u7xJM4NdYdJHBB8wygXFBDq4unszoE
	 aGI6KLEaf3lF5KDSAWHfAzy0GHZhPpehSsfN92OI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38CF5F805FD; Wed,  9 Sep 2026 16:39:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F0B2F805F9;
	Wed,  9 Sep 2026 16:39:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1900DF80549; Wed,  9 Sep 2026 16:39:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788964754;
	b=sNn2Tr5uT2U/Gix+7/r+ZxqcygC1gpcM96xEvsimxhBW83ldm6uFBy/5jb8fnPLOcUk7
	 HCVJgsH1ZkRZt+0ojOOvzyD3F0GsahgVTBFcrzh7ox9Ny2x3KpBcTXP7oG/KI+RIRcLhY
	 Ganh7FmhK/ffdniruqwoAZ/PjPEw54RNb8CxtzP4Dwk2ryVOrlAiV4IZ/Ho+OCBXRyhjy
	 QMqOKXUrF3GoFhNIMYfa041brFnY1594mAj6y7o1AYQ7VpcJsMKFbPZ9moA73yC8MhvGG
	 QP81GDrzUbJrngX6hud8TNrjdPvvaKiBEI5sqa2+cQUcq8vINyEUMOubzTcI6tQ2bHw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788964754;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=nXqldKj1WtwjSvBCR4xgLHn0k9Ej1P0PzqVWPKG7/4I=;
	b=fQmlTxvgvXQBm51RaQnZkWFLQ5sCopLyizS/BQhFQENOu0Y6+zzDDX2UOiQbz9t+qjKg
	 bD61jlkJb4FWKsEp4zLUS6K7VriKoAYBzdRoFiDfvFwBFnfrJgGejlgF9elEZwaxq3axV
	 cr1NhCw3m8Ox9VUGXvzWO4tg1+rip4y740SGTx6HIjmW+8/U74MHC5Xf3ixeQOapOsW/0
	 Q3bd4IJqPP9hR4J9NrtGdFW1eAbD3TmIs4zs35HGm8fYC/tmn+8r7GC9WW1AMImaUjPFG
	 glPvVPmrLx79/GuLMsPCcKuAVAamO2SWCmd1NnfToYiPcv5iqzNA5wf9nMzedetOlqg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 60E45F8003C
	for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2026 16:39:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60E45F8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d3adf6d4de9d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-oss/pr/4@alsa-project.org>
References: <alsa-project/alsa-oss/pr/4@alsa-project.org>
Subject: Add OSS sequencer support
Date: Wed,  9 Sep 2026 16:39:15 +0200 (CEST)
Message-ID-Hash: PAIWY75MABNC2ZO6L7VPT3CXN5ZWWAK2
X-Message-ID-Hash: PAIWY75MABNC2ZO6L7VPT3CXN5ZWWAK2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PAIWY75MABNC2ZO6L7VPT3CXN5ZWWAK2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-oss pull request #4 was opened from tiwai:

Add the support for OSS sequencer API emulation.

Mostly aligned with the kernel code in sound/core/seq/oss, translating the event handling for ALSA sequencer API.

Lightly tested with playmidi program (that is the only application I know of with OSS sequencer API).

Request URL   : https://github.com/alsa-project/alsa-oss/pull/4
Patch URL     : https://github.com/alsa-project/alsa-oss/pull/4.patch
Repository URL: https://github.com/alsa-project/alsa-oss
