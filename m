Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A26C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 17:50:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F97760EE5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 17:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F97760EE5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A6A01657;
	Tue,  9 Nov 2021 18:49:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A6A01657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636480228;
	bh=OaNcdG5Pnc2D5M+85QjcSc0U+ILnbe4jn9W4G/CHlLk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jHNMvX1TKYO9Z/UKBghu74k1VfwV8JwO7Lf/yv/b+yqlJAcT4j/mcXhOISy7DDF7L
	 gnxHf++WpmDqclW7nyo9dpfnD9URxWe43AyLc4nmSYXa7ijUB8qlocsofsGnkqM7jH
	 Ux22YpED8/Lu4x/h5KLPzY3fCX70V3L9j67LVIxQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A70AF802D2;
	Tue,  9 Nov 2021 18:49:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28366F802E3; Tue,  9 Nov 2021 18:49:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B0417F800C9
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 18:49:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0417F800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636480169411818981-webhooks-bot@alsa-project.org>
References: <1636480169411818981-webhooks-bot@alsa-project.org>
Subject: aaf plugin not working raspberry pi  cm4
Message-Id: <20211109174936.28366F802E3@alsa1.perex.cz>
Date: Tue,  9 Nov 2021 18:49:36 +0100 (CET)
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

alsa-project/alsa-plugins issue #39 was edited from steeley:

trying to send to the ALSA device aaf0. pI cm4 with kernel setup to support avb/tsn correctly. 
(Linux cm432 5.10.76-v7l-AVB_KERNEL+ #3 SMP Sat Nov 6 22:50:41 GMT 2021 armv7l GNU/Linux).

PCIe i210 network card is the interface set up correctly according to: https://tsn.readthedocs.io/avb.html

Error is:
`sudo speaker-test -p 2500 -F S16_BE -c 2 -r 48000 -D aaf0

speaker-test 1.1.9

Playback device is aaf0
Stream parameters are 48000Hz, S16_BE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 1 to 206158430
Period size range from 0 to 206158431
Requested period time 2500 us
Periods = 4
was set period_size = 120
was set buffer_size = 480
 0 - Front Left
ALSA lib pcm_aaf.c:670:(aaf_tx_pdu) Failed to send AAF PDU
Write error: -5,Input/output error
xrun_recovery failed: -5,Input/output error
Transfer failed: Input/output error
`

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/39
Repository URL: https://github.com/alsa-project/alsa-plugins
