Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7FEC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:46:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6912076C
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Lvg/3+ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6912076C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C4B415E4;
	Mon,  8 Jun 2020 16:45:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C4B415E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591627558;
	bh=hGAzYI4wu29VX/b/nCBr/8rvlL9SNATpRZpuPzX2bZw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lvg/3+evXQDuzBXEedUg6HQC5tyxj7HU/A1qwDSkVOnevcKOBfDqdsbtj8PyDtrbP
	 l0JKRIo3gqqRVQJuuYYK/Kz3wzpf+7wK31i2HNWUkAILvnnNDouSJFqUjIF17co6Bd
	 NhhnqN4lm2j7nz4PjbpeiGAUQsaagvnnWODGQU0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2877BF80125;
	Mon,  8 Jun 2020 16:45:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF57BF8021C; Mon,  8 Jun 2020 16:45:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 780CCF80125
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 16:45:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 780CCF80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1591627495485512972-webhooks-bot@alsa-project.org>
References: <1591627495485512972-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: seq: introduce container of events
Message-Id: <20200608144504.DF57BF8021C@alsa1.perex.cz>
Date: Mon,  8 Jun 2020 16:45:04 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #25 was opened from takaswie:

Hi,

This patchset adds a new GObject-derived object; ALSASeqEventCntr to obsolete usage of ALSASeqEvent, ALSASeqEventFixed, and ALSASeqEventVariable.

At present, ALSASeqUserClient processes events per each. It brings recursive calls of scheduling API or recursive handling for emitted GObject signal for received events. It's inconvenient in a point of memory usage and signal frequency.

The ALSASeqEventCntr includes a flat memory to represent a batch of events. The object includes many accessor methods to properties of event according to given index number. The object enables applications to handle a batch of events without the recursive calls or the recursive handling.

This patchset obsoletes ALSASeqEvent, thus event structure is not produced itself. Applications can define its own event structure so that it's convenient in a point of chose programming language. It's probable to design collection in the languages with the object.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/25
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/25.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
