Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEF610FCAF0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 22:35:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00A03601F8;
	Thu,  2 Apr 2026 00:34:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00A03601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775082903;
	bh=XQbA1wb+Q/SfU5hOK0ism5fqMHGjE4FkNiOWyKkdXi8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=c/i1pZSWCvMzBB6oX0v+1PXa4F0XVWxzx4nUDWSt6w1xV7huR5RGrhFQtq9UR/xOp
	 ypSFgMHxF7MvAdy/S2K5b5hxxNbUPdZd8hAlf9kQIB1hwFUB70HCatv9MeRPCTimHN
	 Ylm2Ew+VxMXvP4E9SEkHv3vZv3w4FUWGCdCkNoiE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC0E4F805F2; Thu,  2 Apr 2026 00:34:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 777EFF805F2;
	Thu,  2 Apr 2026 00:34:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A21D5F80496; Thu,  2 Apr 2026 00:34:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id CA002F800EE
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 00:34:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA002F800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a25c7205658800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/736@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/736@alsa-project.org>
Subject: ucm2: Qualcomm: Create missing symlink for Radxa Dragon Q6A
Date: Thu,  2 Apr 2026 00:34:18 +0200 (CEST)
Message-ID-Hash: ULDJFTBDXXVYOOQLATICN2OCBNGFT2ZY
X-Message-ID-Hash: ULDJFTBDXXVYOOQLATICN2OCBNGFT2ZY
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ULDJFTBDXXVYOOQLATICN2OCBNGFT2ZY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #736 was opened from Gelbpunkt:

The long card name set by the Linux kernel is based on the DMI information for the vendor name, product name and board revision. Create a symlink so that the configuration is correctly picked up by ALSA if DMI is enabled in the kernel.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/736
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/736.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
