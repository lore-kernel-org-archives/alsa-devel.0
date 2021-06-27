Return-Path: <SRS0=1MT+=LV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34681C48BC2
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Jun 2021 06:22:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5952661C31
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Jun 2021 06:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5952661C31
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 210521693;
	Sun, 27 Jun 2021 08:21:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 210521693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624774945;
	bh=vc4kgri94w3BZIDA4ubG0byylC66en7GXMIH7mbS0EA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GntZcjLAcK7gZxb9qkyOz7QJe+eV2EeIvWLnyxzWF5AI84CB/YAkIgIMAyLnOjX73
	 WDxIRafnwSqc7IX3hxnz9zFyFQ+o5v5uMv+U+GTl4Rt05whjbHThcvv7Nx2ytvxtjj
	 ZPh22VqO/J1dy9wHyhGpJnA2mEFoaSx+Q9uno+2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FE14F80240;
	Sun, 27 Jun 2021 08:21:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 821D4F80259; Sun, 27 Jun 2021 08:21:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B802AF80137
 for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2021 08:21:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B802AF80137
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1624774876088783026-webhooks-bot@alsa-project.org>
References: <1624774876088783026-webhooks-bot@alsa-project.org>
Subject: doc: new a52 input formats, global config
Message-Id: <20210627062124.821D4F80259@alsa1.perex.cz>
Date: Sun, 27 Jun 2021 08:21:24 +0200 (CEST)
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

alsa-project/alsa-plugins pull request #30 was opened from quequotion:

Document the new preconfiguration and libavcodec version-dependent input formats, fixes #29.

Note: I haven't documented specifically which version of libavcodec determines which input format.

I got pretty confused trying to pin the commits that switched from linear to planar, and 16bit to 32bit to specific versions of libavcodec.

If we need that documented, I need some help with that.

Let me know if I got anything wrong!

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/30
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/30.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
