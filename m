Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0237DC7EE22
	for <alsa-devel@archiver.kernel.org>; Thu, 11 May 2023 07:01:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6CAAF88;
	Thu, 11 May 2023 09:00:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6CAAF88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683788458;
	bh=OyUoy/Tj83kuwAZ4I7lCcO6drkPltX2TnRwjjzcGeFs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eL9+T2bMzU0oO2dWeOmBNsFmCUzKhmgq67VQApei2eth/UT5aesPKOY1BpQna9O4s
	 H638CiQmn8UD520iUj7bnS4uwQJnjFFDFYnnmfrdl54Yl3DhbKy9ZhSUwP30PlagKS
	 5UFUJvFgNxdxH4bMye1VIMUSlIZWdmpcDZaaT5a4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3057AF8032D;
	Thu, 11 May 2023 08:59:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22CFEF8032D; Thu, 11 May 2023 08:59:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 26210F800BF
	for <alsa-devel@alsa-project.org>; Thu, 11 May 2023 08:59:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26210F800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683788366418167353-webhooks-bot@alsa-project.org>
References: <1683788366418167353-webhooks-bot@alsa-project.org>
Subject: Can't play 44100hz, 88200hz files Natively.
Message-Id: <20230511065937.22CFEF8032D@alsa1.perex.cz>
Date: Thu, 11 May 2023 08:59:37 +0200 (CEST)
Message-ID-Hash: F54SK6B6WC5F5EELYMWDZAQRV6AZH55P
X-Message-ID-Hash: F54SK6B6WC5F5EELYMWDZAQRV6AZH55P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F54SK6B6WC5F5EELYMWDZAQRV6AZH55P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #313 was opened from RenEH01:

Can't play audio files at native sample rate. Everything using the Hifi 2.0 output configuration forces a sample rate of 48000hz. When I switch to the Pro Audio driver under pavucontrol, 44100 hz can play natively. Is there a forced resampling occuring in the UCM2 driver?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/313
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
