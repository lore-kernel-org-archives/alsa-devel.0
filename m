Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA27BC87FCB
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:35:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27E5360244;
	Fri,  8 Aug 2025 08:35:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27E5360244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754634923;
	bh=9GoCjgvTg5cbrmGIfSoSRQkJHWIvve8MUCn71dwCykk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XksSo9hf8cVgKuxgKlQLdq8bkxlNlRIZkuoTuCRzcMz5IFBsrVNbSVahaMu9TQX8d
	 MoINi873dlvMLyFIcUvtXQgIeQ42e0ytK/KjNbHool+wHeMEwW/rbzRd2OESkFiy1L
	 COSt4G+mrFYIO7kYOjNa7i4re2CLHsDcO+KV8DLo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFAFEF805BD; Fri,  8 Aug 2025 08:34:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67F73F805D2;
	Fri,  8 Aug 2025 08:34:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15ACAF8024C; Fri,  8 Aug 2025 08:34:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E9B34F800F8
	for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2025 08:34:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9B34F800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1859b71e07cef200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/600@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/600@alsa-project.org>
Subject: ucm2: sof-soundwire: add rt721 ucm support
Date: Fri,  8 Aug 2025 08:34:31 +0200 (CEST)
Message-ID-Hash: IZ24M2TVZFTRODJSA2GBUVXEOHXOUBSA
X-Message-ID-Hash: IZ24M2TVZFTRODJSA2GBUVXEOHXOUBSA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IZ24M2TVZFTRODJSA2GBUVXEOHXOUBSA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #600 was opened from jack-cy-yu:

Add support for rt721's UCM.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/600
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/600.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
