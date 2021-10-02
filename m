Return-Path: <SRS0=qlOX=OW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A580C433F5
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Oct 2021 02:49:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44C461A81
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Oct 2021 02:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A44C461A81
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 306AE16F6;
	Sat,  2 Oct 2021 04:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 306AE16F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633142990;
	bh=GbBsnq29YNcF5ddwc/oZRjltlWqvyb0WBG4rCUaXKbg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KUdRpuXdZ++Ev7A9zygOJyGgJT3Uy+whTIr5J7e8ioA8eQeo/4iUzulSP2aCzw5gJ
	 xBDQsVAXz++GxU5V9QqfefK0K90H2ZQRd+EME459k/Uu5uaRFkbNLjaQDNNGQSVR+T
	 YWQDJ13hX3W1GQqtboeXfVjewvyzHOjlAZp84Eks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 887ACF800D8;
	Sat,  2 Oct 2021 04:48:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81A3AF804BC; Sat,  2 Oct 2021 04:48:56 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4A8A9F800D8
 for <alsa-devel@alsa-project.org>; Sat,  2 Oct 2021 04:48:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A8A9F800D8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1633142927797873020-webhooks-bot@alsa-project.org>
References: <1633142927797873020-webhooks-bot@alsa-project.org>
Subject: mpv segfaults in a52 plugin
Message-Id: <20211002024856.81A3AF804BC@alsa1.perex.cz>
Date: Sat,  2 Oct 2021 04:48:56 +0200 (CEST)
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

alsa-project/alsa-plugins issue #35 was opened from ykurlaev:

When using mpv with the option `audio-device=alsa/<a52 device>` it gets a segfault on this line https://github.com/alsa-project/alsa-plugins/blob/da157e978d73f1947bb77637c324e19d003366d4/a52/pcm_a52.c#L566 because it calls `dump` before `prepare` has been called and `rec->avctx` is NULL.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/35
Repository URL: https://github.com/alsa-project/alsa-plugins
