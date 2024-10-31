Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21633E67485
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Oct 2024 22:23:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A00FF53;
	Thu, 31 Oct 2024 23:22:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A00FF53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1730413389;
	bh=kgzWVRMxgsUf/phR0/XMFVIh1OVFVQN29EM69bXtgIA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FQUY1k/tcjvKiAm+JrN52aUMS/2I9CG0XPF+NMa9IOiyH/oKNYzUwgZl4MLPEJg33
	 s5liyRwNwbdbhr4Xb9xgjT03zeaipre2WmsBQuzJtGwKayPn70ZXVmxBGCk9cm0/sm
	 tLDcMjsbEXWrZw1FwMoB2Azth69wy9wObycGMrYs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49331F805B3; Thu, 31 Oct 2024 23:22:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BBA88F805B1;
	Thu, 31 Oct 2024 23:22:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49CF2F80269; Thu, 31 Oct 2024 23:22:33 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C163F80104
	for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2024 23:22:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C163F80104
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1730413350944584846-webhooks-bot@alsa-project.org>
References: <1730413350944584846-webhooks-bot@alsa-project.org>
Subject: Add support for ASRock X870E Taichi
Message-Id: <20241031222233.49CF2F80269@alsa1.perex.cz>
Date: Thu, 31 Oct 2024 23:22:33 +0100 (CET)
Message-ID-Hash: MEMLZQXCRMU3JSIGN2OLS2YEW3VXM7KX
X-Message-ID-Hash: MEMLZQXCRMU3JSIGN2OLS2YEW3VXM7KX
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MEMLZQXCRMU3JSIGN2OLS2YEW3VXM7KX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #457 was opened from julmajustus:

Included id 26ce:0a0b to realtek-alc4080 list.
USB Audio S/PDIF Output, USB Audio Rear input and USB Audio Front Headphones seems to work now without issues with HiFi 2.0 channels.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/457
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/457.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
