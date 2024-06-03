Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96913C25B75
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jun 2024 18:46:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB08E850;
	Mon,  3 Jun 2024 20:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB08E850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717440403;
	bh=dg+ZcCauZkEo45zBUHmDJoaf7BTTOaIzcsU6m7Pu+pA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CavKXHcBjP9jPKMwxxbF9D+SZ/ZViAVjPsT4Nvl5Hw1YdiiB+zHzx4MqyXtwvc5Tj
	 3aJ/UredOBitybC5tzhMhVPj9Ftw1lrilPNTajamIell+VNdUz/cIMiN9SQ7WRxtBI
	 gX5ptxbd3hZ/ZkDRZR17IgYzl9/jLwPm8aaeQlPg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B359F80589; Mon,  3 Jun 2024 20:46:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5182AF805A8;
	Mon,  3 Jun 2024 20:46:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F26A1F8025A; Mon,  3 Jun 2024 20:32:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 75638F800FA
	for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2024 20:30:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75638F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1717439437545063972-webhooks-bot@alsa-project.org>
References: <1717439437545063972-webhooks-bot@alsa-project.org>
Subject: [Question] how to get underlying file descriptors
Message-Id: <20240603183240.F26A1F8025A@alsa1.perex.cz>
Date: Mon,  3 Jun 2024 20:32:40 +0200 (CEST)
Message-ID-Hash: W5JAHK2L6QXCFRCMDMVBZMR5ELJVU6DJ
X-Message-ID-Hash: W5JAHK2L6QXCFRCMDMVBZMR5ELJVU6DJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W5JAHK2L6QXCFRCMDMVBZMR5ELJVU6DJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #399 was opened from pfeatherstone:

I would like to use Alsa with the asio c++ library. I think all I need is the underlying file descriptor(s) for the device which I can then pass to Asio for polling and do all my asyncio. At the moment you're forced to use pollfd using snd_pcm_poll_descriptors(). Can I just read the fds or are there subtleties? Cheers

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/399
Repository URL: https://github.com/alsa-project/alsa-lib
