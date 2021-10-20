Return-Path: <SRS0=Jips=PI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990CEC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 11:30:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64BB61354
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 11:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A64BB61354
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D11E016EA;
	Wed, 20 Oct 2021 13:29:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D11E016EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634729443;
	bh=Fz3ygdUJ934kcDuzg8knHQVm/YPyNYRvm3+6oI8rmo4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iaHL8nLPdKJe5zPOL7MEMAFXF3XJfORAa8QA8mpBMJYTIc2Jl3MZwk2tmAqJzxjli
	 73Nt6exBhnBmUYzFID7if/kSlZKySlFkEIWvA/833havxb7co8sa6ie9hgM2jdjNOn
	 O0LpmdphKh+VjVxywShI41QG9oZXO6/hs/R4qoGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B5EFF802DF;
	Wed, 20 Oct 2021 13:29:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 044B8F80224; Wed, 20 Oct 2021 13:28:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9290FF800ED
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 13:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9290FF800ED
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1634729304180670023-webhooks-bot@alsa-project.org>
References: <1634729304180670023-webhooks-bot@alsa-project.org>
Subject: No output for AC3
Message-Id: <20211020112841.044B8F80224@alsa1.perex.cz>
Date: Wed, 20 Oct 2021 13:28:40 +0200 (CEST)
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

alsa-project/alsa-plugins issue #36 was opened from mizapf:

Sorry if this is not the proper place to ask, I'm gratefully taking any other suggestions.

I use a toslink table from my computer to a Logitech z906 system, which can decode AC3 (as proven in Windows which is installed in parallel). If I select "Digital Stereo (IEC958)", I'm getting stereo output. Also, I can play a special AC3 test file (avi) via VLC and get a proper decoding of 5.1 (obviously passed thru).

I assume that if I select "Digital Surround 5.1 (IEC958/AC3)", the A52 plugin is used. However, I get nothing but silence from the 6 speakers when I do the test, and when I try any other application. I am using pulseaudio (probably as in most installations today); I don't know whether this is important.

I thought that the A52 plugin must be configured in .asoundrc before I learned that this is already done in /etc/alsa/conf.d/60-a52-encoder.conf. Moreover, the manuals for A52 and configuration do not reveal a lot, in particular for troubleshooting.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/36
Repository URL: https://github.com/alsa-project/alsa-plugins
