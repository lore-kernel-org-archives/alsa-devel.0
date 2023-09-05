Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D677C83F3E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Sep 2023 07:38:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31B6C84B;
	Tue,  5 Sep 2023 09:37:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31B6C84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693899501;
	bh=2+ReDN+ML+ATmyMB62GRMiu9VgAAj3RHcbqcERYbE3s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FlEZh0c1n4Rtq659M1qpxU0pxqFNwv6h17DkV4iS9PH1alhQX1oeKzFxx1yeXmofO
	 SRdupEnFt8odOygUrW/sU19e8NLPIchZRd23PTMK2Y77G32NEMDa0aRsSl79Ero+1L
	 9R+tw2Tcr4jeQxGZxJkdJfJ8AwdnCOwSDa7sFF38=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5C40F80527; Tue,  5 Sep 2023 09:37:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B0D1F8047D;
	Tue,  5 Sep 2023 09:37:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9E21F8047D; Tue,  5 Sep 2023 09:37:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 634C2F80141
	for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2023 09:37:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 634C2F80141
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1693899425924479246-webhooks-bot@alsa-project.org>
References: <1693899425924479246-webhooks-bot@alsa-project.org>
Subject: ucm2: Sync Librem 5 config with Purism's downstream one
Message-Id: <20230905073707.D9E21F8047D@alsa1.perex.cz>
Date: Tue,  5 Sep 2023 09:37:07 +0200 (CEST)
Message-ID-Hash: YLCYUDWXMFMQ4MAON44ISBY3SJPEIAQU
X-Message-ID-Hash: YLCYUDWXMFMQ4MAON44ISBY3SJPEIAQU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YLCYUDWXMFMQ4MAON44ISBY3SJPEIAQU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #347 was opened from Newbytee:

The config currently in this repo has several issues. The Purism
downstream one resolves these.

Taken from https://source.puri.sm/Librem5/librem5-base, commit f5b51beb144f76ef3bc483b74e19867bd6364d32

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/347
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/347.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
