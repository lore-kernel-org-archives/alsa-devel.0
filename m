Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B0C388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:42:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A0420FC3
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bBbPAPNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A0420FC3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9AAD1801;
	Fri, 23 Oct 2020 12:41:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9AAD1801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603449729;
	bh=8+sNEFALbIiMGdPzsu6KzyB9KaYGvEb8eJiXJ9L/JYw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bBbPAPNVWNJW7HF9SHb/lnjB/bHGsLb/ee9e7hpL3sLjlBctRTEUygqfpI9FWZkZ/
	 R+derwXZMJM7lvbjxA1mmHkWLy6GFDBo3RRQxZFbxDp7SQ6/Ams91Udjte/zx2c+Pr
	 OZZZinEepuXan6B2wQy4eNm4Qb89/lZgBWsDVeJI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EBF5F80253;
	Fri, 23 Oct 2020 12:41:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17DF0F8025A; Fri, 23 Oct 2020 12:41:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B0B9EF80245
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 12:41:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0B9EF80245
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603449674682427883-webhooks-bot@alsa-project.org>
References: <1603449674682427883-webhooks-bot@alsa-project.org>
Subject: PA poll wakeup issue (was: bug in the ALSA driver 'snd_hda_intel')
Message-Id: <20201023104118.17DF0F8025A@alsa1.perex.cz>
Date: Fri, 23 Oct 2020 12:41:18 +0200 (CEST)
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

alsa-project/alsa-lib issue #90 was edited from Mysgym:

Hello,
after spending some time troubleshooting an issue with an audio interface (using snd_hda_intel). I've stumbled upon this message from PulseAudio in the journal :
`Oct 17 18:30:58 LaptopName pulseaudio[1782]: E: [alsa-sink-ALC256 Analog] alsa-sink.c: ALSA woke us up to write new data to the device, but there was actually nothing to write.
Oct 17 18:30:58 LaptopName pulseaudio[1782]: E: [alsa-sink-ALC256 Analog] alsa-sink.c: Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developers.
Oct 17 18:30:58 LaptopName pulseaudio[1782]: E: [alsa-sink-ALC256 Analog] alsa-sink.c: We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.
`
So I filed a bug report

This is Manjaro on Kernel 5.8

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/90
Repository URL: https://github.com/alsa-project/alsa-lib
