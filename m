Return-Path: <SRS0=XtK2=PY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9400AC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 20:24:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AA861186
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 20:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64AA861186
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71B67166D;
	Fri,  5 Nov 2021 21:23:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71B67166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636143861;
	bh=DjJKzJxL/JaZsgZ83lpSxmtbIjbBJlMLypn5HqT2UMY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M058c6w84SzOI+lCI8Msr+2/ZKA3/e8iwANBh330EnR9F5/yIZqc6lNK5HcnBW619
	 hIrppZnRe6wvUH8b/+S1XDkXdhtx6skF55+C3YAeyfyDBuiokgEm0wvIbnjNYvmdJy
	 +ZkaK45IoBsYjYe6rXOy/v3LzbzVPaYzoYP3rNqY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AD73F80148;
	Fri,  5 Nov 2021 21:23:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E00DF8026A; Fri,  5 Nov 2021 21:23:30 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B32E6F80148
 for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2021 21:23:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B32E6F80148
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636143804696264029-webhooks-bot@alsa-project.org>
References: <1636143804696264029-webhooks-bot@alsa-project.org>
Subject: Need info: How can I have conditional includes in a topology conf file
Message-Id: <20211105202330.0E00DF8026A@alsa1.perex.cz>
Date: Fri,  5 Nov 2021 21:23:30 +0100 (CET)
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

alsa-project/alsa-utils issue #118 was opened from ranj063:

For example: I want to be able to conditionally include the DMIC pipelines/DAI's depending on whether the device has DMICs or not.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/118
Repository URL: https://github.com/alsa-project/alsa-utils
