Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EFCC43461
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:50:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367E82137B
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VYy5JwlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367E82137B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F5101759;
	Wed,  2 Sep 2020 17:50:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F5101759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599061850;
	bh=Svchi+49uSN3qGrSwGxlcTGQPwPd1OGRnR9WMOm3onE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYy5JwlAJN22VmgPkT/Y/OrG2OPRvh7agNcbJj1DAYuNvgL/oWRVomOvjGE+Kc0D4
	 gxEqzPL+cXQZmsrMh5Szul8WkGGWRAejfqHJtVYPJhXe8C1uZnO4nptGZmIwopNMuh
	 hqsXXzNBxGzdF9bg6YlJqMT3OqVYLOgaaGbSR17Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 478F2F80212;
	Wed,  2 Sep 2020 17:50:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B596F800BA; Wed,  2 Sep 2020 17:49:58 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CDFCAF800BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 17:49:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDFCAF800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1599061788242712975-webhooks-bot@alsa-project.org>
References: <1599061788242712975-webhooks-bot@alsa-project.org>
Subject: Miss mapping to unmute the middle speakers for Creative X-Fi with 20K1
 chipset cards in analog-output.conf
Message-Id: <20200902154958.8B596F800BA@alsa1.perex.cz>
Date: Wed,  2 Sep 2020 17:49:58 +0200 (CEST)
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

alsa-project/alsa-utils issue #54 was edited from deathxxx123:

Hi there. I want to report some bug, that is present from long time and i think that can be fixed now.
With any configuration that uses center/subwoofer, that center gets muted by default for Creative X-Fi with 20K1 chipset cards, but if you have other card, that will not happen, because of missing configuration in `analog-output.conf`.
The missing thing in `analog-output.conf` is:
```
[Element Center/LFE]
switch = mute
volume = merge
override-map.1 = center,lfe
```
You can see my issue and fix there:
https://github.com/gamer-os/gamer-os/issues/131

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/54
Repository URL: https://github.com/alsa-project/alsa-utils
