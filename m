Return-Path: <SRS0=AXAa=7N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1FC433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2020 21:59:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14663206F1
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2020 21:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bm+LKGKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14663206F1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CDE31671;
	Sun, 31 May 2020 23:58:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CDE31671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590962347;
	bh=xj/NZ+Yx/wSajVEL00WvE5+sw3hm5sBWNTQv4NM4NOU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bm+LKGKiRe6g271/d8wNt9e+hp4O7BltuKEl8kY+3fGiXGHkhlcrxvkzZJjYDsapj
	 OGJhGjI4xs22VJeSFVY8pE9253xnTpNLOprqRQlVKv7coS6bCZR8GhWki8uqGoB0kq
	 jjP87Sv/o9tAyAZIjhxnzjLMFti0yLdttc96LaX4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5F41F80213;
	Sun, 31 May 2020 23:58:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39F94F8023F; Sun, 31 May 2020 23:58:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DD527F8013D
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2020 23:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD527F8013D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1590962284985236883-webhooks-bot@alsa-project.org>
References: <1590962284985236883-webhooks-bot@alsa-project.org>
Subject: Missing hotplug support
Message-Id: <20200531215811.39F94F8023F@alsa1.perex.cz>
Date: Sun, 31 May 2020 23:58:11 +0200 (CEST)
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

alsa-project/alsa-lib issue #55 was opened from wm4:

Hotplug support is mandatory in any modern system. But in ALSA there is no way to be notified by audio device changes.

I'm aware that as a hack, one could listen to udev notifications. But this is not appropriate, because:
- udev is a different API, which makes this is inelegant and messy
- it requires a dependency on udev, which may not be a workable solution even if the host OS is Linux
- there may be devices that do not have anything to do with udev (for example network audio interfaces implemented in userspace)
- changes in udev may not be reflected in ALSA at the same time (creating the need to avoid race conditions with timeouts or whatever)
- it's ALSA's responsibility to provide this; I don't know any OS where you have to go to a completely different API for this

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/55
Repository URL: https://github.com/alsa-project/alsa-lib
