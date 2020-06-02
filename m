Return-Path: <SRS0=S7Ib=7P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F080C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:26:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7FF206C3
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LfqYTu4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7FF206C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB68C1615;
	Tue,  2 Jun 2020 12:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB68C1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591093579;
	bh=GdK2lI8+4s2QKvd+0T5wR0B50aMJmms6D8Hzjv+z2y4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LfqYTu4yRELY4c9GTW2f7a6m6RPQf7seFIWRsvFHgeAuR2zK75nBtMvXB7VCZooCc
	 QRzxEbY3qE060RIHpI9RvEqfHuv1hoGRyejkQMX0S1UStMgDVC6AOspcUaUdylF2py
	 2myZiECXFxbY6qKlA0Up7A6W8dqLDbrEeD/q5MsU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 756F0F8013D;
	Tue,  2 Jun 2020 12:25:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F4156F8026F; Tue,  2 Jun 2020 12:25:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2C3BEF8013D
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2020 12:25:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C3BEF8013D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1591093521068892956-webhooks-bot@alsa-project.org>
References: <1591093521068892956-webhooks-bot@alsa-project.org>
Subject: Db845c
Message-Id: <20200602102526.F4156F8026F@alsa1.perex.cz>
Date: Tue,  2 Jun 2020 12:25:26 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #29 was opened from Srinivas-Kandagatla:

Hi Jaroslav Kysela,

I removed Lenovo ucm2 configs for now, are you okay to pull DragonBoard DB845c ucm2 for now till we resolve in general naming issues with DT.  All the drivers and DT are already in mainline since 5.6.

Thanks,
srini
Changes sinc v2:
- remove Lenovo ucm2
- remove cdev references.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/29
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/29.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
