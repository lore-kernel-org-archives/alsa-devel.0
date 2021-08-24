Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA7BC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 09:51:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48B8613AB
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 09:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B48B8613AB
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E6AB1654;
	Tue, 24 Aug 2021 11:51:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E6AB1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629798713;
	bh=EaYSRKh2tHN1kEXKcJq3BMetCuHyxR5zXHLcOOKbpuI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O0hzhtp1Am0fBo5u8NqBJ8Hk5uJiyZAvSsvyXVtJ2qhPua9aJ7OvqbfVoGlJIGQd2
	 jarLKZD4Pn78Wzdt2qj+76TclzfOUA5qcZNR3d+WNcQYFlnaUjotWpGvzESB2GmcTJ
	 epHi25kXxciRf3v6owY2Q8sopSn40Tw6la26fRbw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD196F8025C;
	Tue, 24 Aug 2021 11:51:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CFAFF8032D; Tue, 24 Aug 2021 11:51:01 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 20713F80087
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 11:50:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20713F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1629798654458581924-webhooks-bot@alsa-project.org>
References: <1629798654458581924-webhooks-bot@alsa-project.org>
Subject: Timestamp
Message-Id: <20210824095101.0CFAFF8032D@alsa1.perex.cz>
Date: Tue, 24 Aug 2021 11:51:01 +0200 (CEST)
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

alsa-project/alsa-utils pull request #108 was opened from folkertvanheusden:

Added -T / --timestamp (with parameter "realtime", "monotonic" or "raw")
    which adds a timestamp before each received message when using --dump.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/108
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/108.patch
Repository URL: https://github.com/alsa-project/alsa-utils
