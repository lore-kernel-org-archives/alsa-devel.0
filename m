Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49504CDB483
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Oct 2023 13:34:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DA1082A;
	Wed, 18 Oct 2023 15:34:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DA1082A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697636095;
	bh=jBidj6d/u0EOHlmRwKQ6RColQ7rLce5KWg+DCjsnKt0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Rwmb5uLUo5tyFjZbnDPnIGw2gpR19m1Mi/xokEIzy4098pC2hIcVa+QPb8QXKjq0X
	 QLjW0VO+oKMq7Er3upOjwm288VAqJyd8mcjkcL62RTYi8P2Gl944Wg3lnykxyj22Hv
	 sPjw/pLtoj/1o9Gly/Jmo2DRionmWflgwsPJwHCg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20898F80236; Wed, 18 Oct 2023 15:33:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CFF1F8025F;
	Wed, 18 Oct 2023 15:33:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9DFEBF8025F; Wed, 18 Oct 2023 15:33:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id E01E3F80236
	for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2023 15:33:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E01E3F80236
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1697635988054242373-webhooks-bot@alsa-project.org>
References: <1697635988054242373-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Add FiiO K11 config
Message-Id: <20231018133330.9DFEBF8025F@alsa1.perex.cz>
Date: Wed, 18 Oct 2023 15:33:30 +0200 (CEST)
Message-ID-Hash: XB6YSRFYT2CPKQIQRGQKPSNQE5YHJGTD
X-Message-ID-Hash: XB6YSRFYT2CPKQIQRGQKPSNQE5YHJGTD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XB6YSRFYT2CPKQIQRGQKPSNQE5YHJGTD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #360 was edited from ZVNexus:

Without an ALSA config for the DAC autosuspend seems to be broken, every 10 seconds after pausing audio playback there is a 1 second delay to start it back up. Added a config for it and now there is no delay. Let me know if something else would make more sense.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/360
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/360.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
