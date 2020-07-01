Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DDAC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:36:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D511206C3
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dx+z9KSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D511206C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBDB01663;
	Wed,  1 Jul 2020 11:36:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBDB01663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593596210;
	bh=Lv7ANtQzK2NVurjb3qzM7gDvWxqHHpfusSuZTzY8rL0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dx+z9KSLeL8sS1eYU7Yaukt2xQIkeOLUhl2H0wwE4zZIDKZA0OF7KE3o72YnFkdMv
	 8WYSrJ0w1l9qzfHjeXP0dSsDqMOaJ8+ZBCbUAmuhbLwz6h1aIglMGb/i0abB6mQSjo
	 6atu6rF+m0V3xYAVbc+LOg0TOJfBRR+s4FAFPYCs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A042F8020C;
	Wed,  1 Jul 2020 11:36:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B5CFF80217; Wed,  1 Jul 2020 11:35:58 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D76E6F800C1
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 11:35:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D76E6F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1593596155128421068-webhooks-bot@alsa-project.org>
References: <1593596155128421068-webhooks-bot@alsa-project.org>
Subject: Translation for alsa-utils
Message-Id: <20200701093558.5B5CFF80217@alsa1.perex.cz>
Date: Wed,  1 Jul 2020 11:35:58 +0200 (CEST)
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

alsa-project/alsa-utils issue #41 was opened from Porrumentzio:

I found the [po folder](https://github.com/alsa-project/alsa-utils/tree/master/po) but seems that there are not all the translations (I know there's a Spanish localization for example). 

Is it enough to translate the po files and PR them? Or is there any other procedure?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/41
Repository URL: https://github.com/alsa-project/alsa-utils
