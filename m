Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7240CCD1292
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:08:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC49522A8;
	Mon,  8 Apr 2024 19:08:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC49522A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712596095;
	bh=E+wB5ZHF4GVEnNNb0BzYJdW4Sc6ETPzpjxZ9DawPvKk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bDwZIsgZSWck98P3OR8+ho7nkycWLrvjIK31CAeg2BWXA0mslQO1bMVbTye00/Vb8
	 C2cvB5V0pG2H+emZXNX8iq5qpbgekshnNmgh+JT8+z+fkYuIfXhzuBT4m+j8dc2+T+
	 Xm29qBqfA+sQcvDiEiKrzQraEiL5DuzizHSciFvU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3026CF805A9; Mon,  8 Apr 2024 19:07:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84104F805AA;
	Mon,  8 Apr 2024 19:07:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E4A5F8026D; Mon,  8 Apr 2024 19:07:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B9939F800C9
	for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2024 19:07:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9939F800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1712596049329668760-webhooks-bot@alsa-project.org>
References: <1712596049329668760-webhooks-bot@alsa-project.org>
Subject: Add support for opus to aplay
Message-Id: <20240408170737.4E4A5F8026D@alsa1.perex.cz>
Date: Mon,  8 Apr 2024 19:07:37 +0200 (CEST)
Message-ID-Hash: Z267ETDDIDNE44CGUYJH37VDGMYD4CMG
X-Message-ID-Hash: Z267ETDDIDNE44CGUYJH37VDGMYD4CMG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z267ETDDIDNE44CGUYJH37VDGMYD4CMG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #261 was opened from bmariuszb:

I would like to use aplay to play Opus audio files.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/261
Repository URL: https://github.com/alsa-project/alsa-utils
