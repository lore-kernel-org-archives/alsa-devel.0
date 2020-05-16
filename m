Return-Path: <SRS0=yPb/=66=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DE7C433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 02:58:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AEC2074D
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 02:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I+6r9cS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AEC2074D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5999950;
	Sat, 16 May 2020 04:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5999950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589597907;
	bh=bkuFGWd7/MzlCcg5lCWnV1UnpiXT3G0gvpbDZfXCC04=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+6r9cS9KXAiFr7omf/GfRHQyXZXKQorJUd1W2/C4NKoXZxXPjRvVxKNapDEGc5Bh
	 KK2YbRGXEu2CRubvWYg6YwSWaKGf2U0xOqY0j0jhgZVI6XKcs+wDE9rwoegUYtzTco
	 /W63B2nalQkdbL1glulNA4afhxLvQYeJ33hvwuFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50E24F8014C;
	Sat, 16 May 2020 04:57:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 510E7F80158; Sat, 16 May 2020 04:57:29 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7DC11F800FE
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 04:57:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DC11F800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1589597841794750929-webhooks-bot@alsa-project.org>
References: <1589597841794750929-webhooks-bot@alsa-project.org>
Subject: Alsa doesn't respect XDG Base Directory standard?
Message-Id: <20200516025729.510E7F80158@alsa1.perex.cz>
Date: Sat, 16 May 2020 04:57:29 +0200 (CEST)
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

alsa-project/alsa-lib issue #49 was opened from luxintra:

My .config is set to $XDG_CONFIG_HOME and moving asoundrc to $XDG_CONFIG_HOME/alsa ...does not work for me.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/49
Repository URL: https://github.com/alsa-project/alsa-lib
