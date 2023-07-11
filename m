Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA029EB64DC
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jul 2023 08:30:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81C746C1;
	Tue, 11 Jul 2023 10:29:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81C746C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689064242;
	bh=aq0hZIqTywt3dgRdXIqSf8DGjhyCVtwgXtiPI96bTC0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oE/JqVJdjHoV+peAg9WNKJLE/Y+h/v9btPBUQbgx2r5sp5gRvEqwP5AFVkVmVV6xy
	 JcGwDj0TEOl/F0MUi3X3hsuWD9wElQNUbegbQzB+xjbird9+rLaP+Y7GPWnOX+uvL5
	 2SBqiKpTw84ndOQg5/cDOvC0BRfPJF3hbjXaaxW0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78B77F80552; Tue, 11 Jul 2023 10:29:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A96DF80549;
	Tue, 11 Jul 2023 10:29:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80ACDF80249; Tue, 11 Jul 2023 10:27:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D7C9F80236
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2023 10:27:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D7C9F80236
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1689064036592033386-webhooks-bot@alsa-project.org>
References: <1689064036592033386-webhooks-bot@alsa-project.org>
Subject: ALC4082 - ASRock Z790 PG-ITX/TB4
Message-Id: <20230711082734.80ACDF80249@alsa1.perex.cz>
Date: Tue, 11 Jul 2023 10:27:34 +0200 (CEST)
Message-ID-Hash: P4BYAFKCZLM36WLAMBW7SKQTXIVNX6IC
X-Message-ID-Hash: P4BYAFKCZLM36WLAMBW7SKQTXIVNX6IC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P4BYAFKCZLM36WLAMBW7SKQTXIVNX6IC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #334 was edited from Shmob1:

I have an [ASRock Z790 PG-ITX/TB4](https://pg.asrock.com/MB/Intel/Z790%20PG-ITXTB4/index.asp) which has the `ALC4082` Realtek chipset connected over USB, that has been mentioned in a number of issues, most recently #229.

It seems the configuration changes in that issue (notably, https://github.com/hwchong/alsa-ucm-conf/commit/3ec7e6e2a61240764b77c30892f0bc56803799cc) work on my board as well, with a small modification. Unlike the Taichi boards, my Realtek audio driver is at `USB26ce:0a08`, not `USB26ce:0a06`. Making the necessary regex changes in `ALC4080-HiFi.conf` and `USB-Audio.conf` enables functionality on my board.

I am happy to make a PR to merge these changes if pertinent.

Thanks for the great work!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/334
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
