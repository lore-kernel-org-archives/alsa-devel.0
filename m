Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5750EC77B7A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 09:40:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C678D206;
	Thu, 25 May 2023 11:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C678D206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685007621;
	bh=+Ts1YG3lmsJiHn/vctx/V37yI/z5rIb+b6fI+AhwLEg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tgMvgBx6nuiB92qBVSFcHKa6iwoBJQrooXg0B0jEluWMwqsrr64fFACI6mfl2eXCL
	 BMVPgiRjWoENs5Fic62ayoNiCQlr6VDY4NbEcYrp4aTBfPeM0RL+rGOh48OoehtJXZ
	 RvybroVVbXotCMst9LZOqDgXsDAgZSMPT9DG/tEk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66E7BF80249; Thu, 25 May 2023 11:39:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CB3FF8026A;
	Thu, 25 May 2023 11:39:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0ACF4F80249; Thu, 25 May 2023 11:39:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6485AF80053
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2023 11:38:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6485AF80053
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1685007537544146061-webhooks-bot@alsa-project.org>
References: <1685007537544146061-webhooks-bot@alsa-project.org>
Subject: Linux Mint 21 MSI Z790-A WIFI (ALC4080) no audio from spdif
Message-Id: <20230525093901.0ACF4F80249@alsa1.perex.cz>
Date: Thu, 25 May 2023 11:39:00 +0200 (CEST)
Message-ID-Hash: 3X4ZCJIFHE3NCEAUSX5FTDNNZILEJ5GJ
X-Message-ID-Hash: 3X4ZCJIFHE3NCEAUSX5FTDNNZILEJ5GJ
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3X4ZCJIFHE3NCEAUSX5FTDNNZILEJ5GJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #318 was edited from jasonzliang:

Hi,

I been troubleshooting problems with sound not coming out from my optical port and I narrowed it down to Linux having problems with the ALC4080 chipset on my MSI Z790-A WIFI motherboard. The version of alsa-ucm-conf installed on my system is 1.2.6.3-1ubuntu1.5. 

My question is, what changes do I need to make to the alsa configuration files in order to get audio working again?

Thanks

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/318
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
