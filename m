Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47076CD13DF
	for <alsa-devel@archiver.kernel.org>; Sat, 31 Aug 2024 18:46:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 574DE83B;
	Sat, 31 Aug 2024 20:46:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 574DE83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725130015;
	bh=6tnKqElCBqBrgdrTJ4r8x3MfftOZ6xKYGgVT9bZ5tR4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oZEIwUZpd3yNct9ZudO1cADkXY/RnppnQN/KBUjPfpzlEBGbq1i5oZPJ2enSrBj6c
	 Q+xnp1B8UUJKu2BC6M0muNbMbIR2Dvl586e/WkCT9WAFm3xCtSnWRC2Pi97lLgAex7
	 yOT0wfIiOtCP8nmbbKvXCEwvLcJhe5rQVb5bLuoc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B84CF805B0; Sat, 31 Aug 2024 20:46:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB6B1F805B3;
	Sat, 31 Aug 2024 20:46:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DCC3F80518; Sat, 31 Aug 2024 20:46:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DF7CFF80087
	for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2024 20:46:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF7CFF80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1725129977282680750-webhooks-bot@alsa-project.org>
References: <1725129977282680750-webhooks-bot@alsa-project.org>
Subject: Fix TLV dB parser in case of used container
Message-Id: <20240831184619.8DCC3F80518@alsa1.perex.cz>
Date: Sat, 31 Aug 2024 20:46:19 +0200 (CEST)
Message-ID-Hash: LMBBIKHTCWA54VLISY7VBNZ6366RBTFW
X-Message-ID-Hash: LMBBIKHTCWA54VLISY7VBNZ6366RBTFW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LMBBIKHTCWA54VLISY7VBNZ6366RBTFW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #409 was edited from arkq:

In case when dB information does not appear as the only TLV type in the stream (it might be wrapped in a container, but the container can not have any other type), the TLV parser fails to get the dB TLV pointer.

This commit fixes it by distinguishing between TLV parse error and dB information not being found in a container, so the parser can iterate over all elements in the container.

Also, it fixes out-of-bounds read in case of malicious TLV record.

EDIT:
Other possibility to fix is to return `-ENOENT` in case where dB information was not found and handle that accordingly when iterating over items of a container.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/409
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/409.patch
Repository URL: https://github.com/alsa-project/alsa-lib
