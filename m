Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A97C46CD2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jan 2024 22:05:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B77EEF5;
	Tue,  2 Jan 2024 23:05:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B77EEF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704233141;
	bh=QX/YU5KwlMoB7Uz4qewXRqiNNKwMUD/w9KcneFSdDTs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oqOCCBofrown/1rcviKjyTlY73F83REuesoKtBkr7yspoKFzJHwTrP+DaDZFLd7lV
	 drSpkWZFGIY74ZAs8l8YFnThZG28VYhumuPU+6sL5v9lrz7jn6Xr4+0Cm6/H578tad
	 m/BUhj0xywaED/hb3GF0mHUoHSr8NudG8REZhSRA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90872F805E4; Tue,  2 Jan 2024 23:04:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3229AF805E5;
	Tue,  2 Jan 2024 23:04:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18668F805A9; Tue,  2 Jan 2024 23:04:46 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 43957F80074
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2024 23:01:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43957F80074
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1704232900298351765-webhooks-bot@alsa-project.org>
References: <1704232900298351765-webhooks-bot@alsa-project.org>
Subject: topology: Fix dmic nhlt blob building, and fu
Message-Id: <20240102220446.18668F805A9@alsa1.perex.cz>
Date: Tue,  2 Jan 2024 23:04:46 +0100 (CET)
Message-ID-Hash: 7UJFNVVHFVHODR5SGCFDR2U45BYDY6FZ
X-Message-ID-Hash: 7UJFNVVHFVHODR5SGCFDR2U45BYDY6FZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7UJFNVVHFVHODR5SGCFDR2U45BYDY6FZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #250 was edited from jsarha:

This PR fixes two issues. FIrst it fixes https://github.com/thesofproject/sof/issues/8670 and then it adds to $[] expressions define handling in object attribute, so that we can use DMIC frequency defines in format objects, wihout ibs and obs attributes referring to those attributes breaking it.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/250
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/250.patch
Repository URL: https://github.com/alsa-project/alsa-utils
