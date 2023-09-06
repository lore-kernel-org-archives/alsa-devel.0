Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14AEEB8FB7
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Sep 2023 12:23:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66B30A4D;
	Wed,  6 Sep 2023 14:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66B30A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694003020;
	bh=Z6Me63AQwKQq5KTFeQAmPEhRXx37ZHEOhUoGZx9c1JI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Q1GMlhVwydX0MUfghg3nm+SgmUvFnmkbAl94n0axunup6cofO9xwWftpHoLpjcGJF
	 d7Ka87x8nCA2Vm4RQKP7SXFRJKI8Tt3wZ5c3l59EPBdnBJ6N0vgHy4WmEB5vUwhFZj
	 H8z0OI5uWxNy4pMioPmcKdmnrIbc738cc9yzwtok=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3ED7F80571; Wed,  6 Sep 2023 14:21:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CA27F8055C;
	Wed,  6 Sep 2023 14:21:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6001CF80494; Wed,  6 Sep 2023 14:21:45 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id EE8BBF800AA
	for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2023 14:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE8BBF800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1694002903953685045-webhooks-bot@alsa-project.org>
References: <1694002903953685045-webhooks-bot@alsa-project.org>
Subject: ASUS RoG Strix Z790-F: No SPDIF Sound output
Message-Id: <20230906122145.6001CF80494@alsa1.perex.cz>
Date: Wed,  6 Sep 2023 14:21:45 +0200 (CEST)
Message-ID-Hash: K67DTSZYLOTCZUBLKSYJPMVWU66XPPNX
X-Message-ID-Hash: K67DTSZYLOTCZUBLKSYJPMVWU66XPPNX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K67DTSZYLOTCZUBLKSYJPMVWU66XPPNX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #348 was edited from Nightwing0815:

Hey folks,

I think, I posted in the wrong section, so here another try to get rid of no SPDIF Sound on my ASUS Motherboard.
More information can be grabbed in the topic here at [alsa-lib](https://github.com/alsa-project/alsa-ucm-conf/issues/350)

Thanks in advance,

ToM

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/348
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
