Return-Path: <SRS0=P1jl=LH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAB5C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 09:43:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6186124C
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 09:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6186124C
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E37CC1786;
	Sun, 13 Jun 2021 11:42:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E37CC1786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623577409;
	bh=NUO0xMdVKm52rbmuOqFZfCbc75dBghM5WgwV2wng190=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oIvRRVABU7HdGsbBK12YDL0kaabQ8alLEgQ6dUPMZzWEHeVa38KCukVFUcAwaowwn
	 ozVttMgjQFeDsWiQyY0YXIrQ+QufS707HQaSc87fFux64PJNmlAbu/YNeXPz/MEvhj
	 +T9jMVHgGvjOYSEOQb2c2eooiVGXfHJ7VtPAL8ZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 653ADF800FB;
	Sun, 13 Jun 2021 11:42:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58968F80165; Sun, 13 Jun 2021 11:42:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 27FACF800F7
 for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2021 11:42:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27FACF800F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623577346367939949-webhooks-bot@alsa-project.org>
References: <1623577346367939949-webhooks-bot@alsa-project.org>
Subject: alsa-lib 1.2.5 breaks espeak
Message-Id: <20210613094236.58968F80165@alsa1.perex.cz>
Date: Sun, 13 Jun 2021 11:42:36 +0200 (CEST)
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

alsa-project/alsa-lib issue #155 was opened from MrBitBucket:

In archlinux amd64 upgrading alsa-lib from 1.2.4 - 1.2.5 breaks the espeak application https://sourceforge.net/projects/espeak/.

I see extra errors in espeak output eg

```Expression 'framesAvail' failed in 'src/hostapi/alsa/pa_linux_alsa.c', line: 3629
Expression 'PaAlsaStreamComponent_GetAvailableFrames( self, &framesAvail, xrun )' failed in 'src/hostapi/alsa/pa_linux_alsa.c', line: 3989
Expression 'PaAlsaStreamComponent_RegisterChannels( &self->playback, &self->bufferProcessor, &playbackFrames, &xrun )' failed in 'src/hostapi/alsa/pa_linux_alsa.c', line: 4118
Expression 'PaAlsaStream_SetUpBuffers( stream, &framesGot, &xrun )' failed in 'src/hostapi/alsa/pa_linux_alsa.c', line: 4359```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/155
Repository URL: https://github.com/alsa-project/alsa-lib
