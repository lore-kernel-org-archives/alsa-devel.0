Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498BFC2BD09
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:14:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC6DBEC7;
	Sat,  6 Jul 2024 21:13:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC6DBEC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720293239;
	bh=yH9sIVVWfoLovOVsfG2IArUOV9Xa+vzSyF6Wsvsa1r8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ncignbdSOEvsunpCp9fORITK+FEw5mwMdNSiXmLzon3RcUn5dWSsXSZw7L/zedvzN
	 DpLujc50uwmLj9JAfXYq6/IJLEdfTFUfoJYN9uoNXbyXvn6MVBX9Iu+9gc95AFIWqy
	 ICgPiHeTyGeb0BJUT1cNRwNMR7BeSDjFcEa3smJs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60E25F80588; Sat,  6 Jul 2024 21:13:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB321F805B4;
	Sat,  6 Jul 2024 21:13:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7FBACF8025E; Sat,  6 Jul 2024 21:10:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id AD0A2F800F8
	for <alsa-devel@alsa-project.org>; Sat,  6 Jul 2024 21:10:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD0A2F800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1720293044699448347-webhooks-bot@alsa-project.org>
References: <1720293044699448347-webhooks-bot@alsa-project.org>
Subject: Fix labeling of BOSS Katana ports
Message-Id: <20240706191048.7FBACF8025E@alsa1.perex.cz>
Date: Sat,  6 Jul 2024 21:10:48 +0200 (CEST)
Message-ID-Hash: Y53H5QXNR3F3PPYOBF5HSOLCIGFPCFJN
X-Message-ID-Hash: Y53H5QXNR3F3PPYOBF5HSOLCIGFPCFJN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y53H5QXNR3F3PPYOBF5HSOLCIGFPCFJN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #430 was opened from aledomu:

I'd like to rename the MIDI ports as well but I don't know how. If you can point me where I can learn about it, I'll be glad to do so and mark this PR as finished.

I guess this fix works the same for all Katana models from all generations, but I don't have the PID available to enable it, nor the devices for testing.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/430
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/430.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
