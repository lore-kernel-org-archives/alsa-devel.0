Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0DC4332D
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 01:18:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F03520752
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 01:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jsgx2EUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F03520752
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA792173B;
	Thu, 19 Mar 2020 02:17:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA792173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584580707;
	bh=B1WPfO3fpyyTSTqbl4fUqPfLDBgaa20Y+5+D/eAlINc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jsgx2EUIkBfG9iFUDsW+Vo/e7/H1U5qtot5tv3QGtAG0eo35z3EbUhbv6k00bIm8L
	 MDjxP2977OlccQUE3R9UJJwBvs/wnb9z9fcUoIXxz3Fv60sRcCDhv9JneeqRNqXa/f
	 yhWfiTxTBs8m3BnmKK0o2n7YTJaSd6LyjbfTOPwI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21A01F800C0;
	Thu, 19 Mar 2020 02:17:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C901DF80139; Thu, 19 Mar 2020 02:17:31 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 94261F800C0
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2020 02:17:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94261F800C0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1584580647081017971-webhooks-bot@alsa-project.org>
References: <1584580647081017971-webhooks-bot@alsa-project.org>
Subject: Corrections for pcm_a52 to work with pulseaudio
Message-Id: <20200319011731.C901DF80139@alsa1.perex.cz>
Date: Thu, 19 Mar 2020 02:17:31 +0100 (CET)
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

alsa-project/alsa-plugins pull request #8 was edited from amotzkau:

Hi there,

First this is my first contact with ALSA programming, so please forgive me for any obvious mistakes I made.

On my computer Pulseaudio didn't work with the pcm_a52 plugin (Digital Surround 5.1 profile in Pulseaudio), everything was played with 30x speed (approximately). So I looked into the cause of this. Pulseaudio uses the zero-copy mmap interface of ALSA and expects that snd_pcm_mmap_commit() will accept all frames that snd_pcm_mmap_begin() allowed to send. If snd_pcm_mmap_commit() accepts less frames or none (-EAGAIN) then Pulseaudio didn't remember that or even saved those frames. They were just discarded.

I thought that it would be a sound contract to guarantee that snd_pcm_mmap_commit() will always take those frames. Therefore I looked into pcm_a52, why it doesn't promise that, and changed the a52_pointer() function to offer such a guarantee.

These are my patches to make it work.

Best regards,
Alex

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/8
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/8.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
