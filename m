Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76889C432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:59:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D0C20692
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ixowNoOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D0C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7232B169D;
	Tue, 19 Nov 2019 11:58:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7232B169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574161148;
	bh=J4nrlZG4aU+d3nJ4dhmsqBT63iyU9+s4Qin1khVZDzA=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ixowNoOQo19E+tDNkL9qfzrrRHy9dJPmAWRlNJgvqnNHPMHH5UZnWsCGciStMqNpi
	 mR50AJYT0mCBY9cw/+ANJPvJv2OHa2JonTcrJxc77IhAaak2pidNL/7ryHIkyRd38y
	 PUeDRNRuQNadlg9WENepQFUQcnpfmhFGZidzHdPw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0473DF80137;
	Tue, 19 Nov 2019 11:58:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BCB5F80119; Tue, 19 Nov 2019 11:58:16 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C8B53F80119
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 11:58:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8B53F80119
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1574161093148889065-webhooks-bot@alsa-project.org>
References: <1574161093148889065-webhooks-bot@alsa-project.org>
Message-Id: <20191119105816.0BCB5F80119@alsa1.perex.cz>
Date: Tue, 19 Nov 2019 11:58:16 +0100 (CET)
Subject: [alsa-devel] Flac
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/tinycompress pull request #2 was opened from vinodkoul:

This adds the header file for FLAC and also adds the .pc file for the library so that users can discover details about the library

Request URL   : https://github.com/alsa-project/tinycompress/pull/2
Patch URL     : https://github.com/alsa-project/tinycompress/pull/2.patch
Repository URL: https://github.com/alsa-project/tinycompress
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
