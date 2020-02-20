Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B59C5ACC4
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 02:22:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB3724656
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 02:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="quC74Apt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB3724656
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BBFE16B1;
	Thu, 20 Feb 2020 03:21:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BBFE16B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582165346;
	bh=lB0dAJopOD70I9sOuBBn9oKUyC0f5/TFfoXCXh6acj0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=quC74AptUAwYQgugq2neRKscnreFNSSbXN8el0F5Y0PCMZ5Lgj5/iY92WTMpHArU3
	 7POUNpTP+rEgV3T8kNKUhEIRfqTMF4F7if9TYC8w+GXzHuyESEq4zh7MMEnuT7A5Z5
	 yKTLz112K9QmVJnOqwvaJNqVggqYo6g3gT6K3488=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47ED2F8028E;
	Thu, 20 Feb 2020 03:20:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E358FF8028F; Thu, 20 Feb 2020 03:20:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 94EC5F8028D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 03:20:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94EC5F8028D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1582165218427489996-webhooks-bot@alsa-project.org>
References: <1582165218427489996-webhooks-bot@alsa-project.org>
Subject: usage of snd_rawmidi_status_get_avail()
Message-Id: <20200220022020.E358FF8028F@alsa1.perex.cz>
Date: Thu, 20 Feb 2020 03:20:20 +0100 (CET)
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

alsa-project/alsa-lib issue #26 was edited from MusicMaker:

In non blocked raw MIDI, is snd_rawmidi_status_get_avail supposed to return the number of available bytes that can be read using a snd_rawmidi_read. (port is opened for input only)  It seems get_avail always returns 0 even there is MIDI data when using a read.  Else is there a(nother) way to find the number of unread received bytes in the buffer?
snd_rawmidi_status_alloca (&status);  	
snd_rawmidi_status(client, status); 
snd_rawmidi_status_get_avail(status);

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/26
Repository URL: https://github.com/alsa-project/alsa-lib
