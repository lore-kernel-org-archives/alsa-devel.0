Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60042CF9C64
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:48:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7B98DFA;
	Sun, 22 Sep 2024 14:48:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7B98DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727009302;
	bh=Utf2Jp3/BqPGrFdmWDcgQUZyoyxbjmvvR3/f3Yhfo5Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WBQ3gbOpTgoZAJHop2IjpDz2UsDlzO/OhjsCNvreksO8Ya+hoaKS4TxhplP54hCSs
	 +F84LSOMS1rJiVqah3RlrypBG1RKm9xE5LbiC4j091t1I3erOZa77wfMBmLSaclw5o
	 UrERI0dSRDuAgw727gtdN5GymIsEJOuriky8ENP8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FD90F805B0; Sun, 22 Sep 2024 14:47:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A641F805B4;
	Sun, 22 Sep 2024 14:47:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F24AF802DB; Sun, 22 Sep 2024 14:47:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id CE31EF8010B
	for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2024 14:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE31EF8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1727009256946110964-webhooks-bot@alsa-project.org>
References: <1727009256946110964-webhooks-bot@alsa-project.org>
Subject: Plugin for windows sound api
Message-Id: <20240922124742.1F24AF802DB@alsa1.perex.cz>
Date: Sun, 22 Sep 2024 14:47:42 +0200 (CEST)
Message-ID-Hash: WCMQAUJEEDNG2KRJDMWL4ZWACYUSUWUC
X-Message-ID-Hash: WCMQAUJEEDNG2KRJDMWL4ZWACYUSUWUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WCMQAUJEEDNG2KRJDMWL4ZWACYUSUWUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins issue #61 was opened from uis246:

There is already OSS plugin for alsa to support BSD, there are many sound server plugins for alsa. Is it possible to make such plugin for sounds api used in windows?

Not sure what is better place to start this discussion.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/61
Repository URL: https://github.com/alsa-project/alsa-plugins
