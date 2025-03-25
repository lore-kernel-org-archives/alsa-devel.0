Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03D1C35FFC
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:32:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90972601F1;
	Tue, 25 Mar 2025 16:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90972601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742916747;
	bh=UAOSgUqLDxDJvhKoyksra926/BbESeXDw21oeLpaU/Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gkb+x7ZRITFvSdAi3KS8KJV3Vh+hvFZsZD72BtaltGjk5gjG3hweKGzaieZoaHgdy
	 a2jHBI9CKzrXyi4o5dQqr7VfZKtsdDiH35VYEmCq/AdMyj15hP7Ez4KkTropjNEDyq
	 lwNueItSwJPZYhR1BVxnyh4WlEmSgypNOnaRlFIA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 438FCF805AC; Tue, 25 Mar 2025 16:31:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A77C6F805C1;
	Tue, 25 Mar 2025 16:31:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CB98F800B6; Tue, 25 Mar 2025 16:29:40 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AD33F800B6
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2025 16:29:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AD33F800B6
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183015638513bc00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/533@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/533@alsa-project.org>
Subject: HDA: Handle better Bass speaker including 4 channel mode
Date: Tue, 25 Mar 2025 16:29:40 +0100 (CET)
Message-ID-Hash: UJX4VZMQPSD63BEYMEZ2F5YRXK2Y63OK
X-Message-ID-Hash: UJX4VZMQPSD63BEYMEZ2F5YRXK2Y63OK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UJX4VZMQPSD63BEYMEZ2F5YRXK2Y63OK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #533 was opened from perexg:

It's a follow up of #410 .

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/533
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/533.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
