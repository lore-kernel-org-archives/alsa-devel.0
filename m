Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AFFC2D0CD
	for <alsa-devel@archiver.kernel.org>; Thu, 15 May 2025 08:07:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4149F62F28;
	Thu, 15 May 2025 10:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4149F62F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747296182;
	bh=KrZ4FqgljugzGOOHWnrlHpqthuw8KqSjIlI83kfaWfU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rpJ/zkpWa1yPocElfar9U8gza0krXCmofThaAMY+54gCP4DHIN3Or4bEKrfAB/mxh
	 f0oOs9iN4Ltuf6r41xgtRjgmFYjnMZoqx7cw7ScL+0uTzARXpNGbzmToBFxgZ+V19G
	 ioXADDlqJ1qAIbfUr8AwwbWsLUKCQOwmXeQsQxe8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90B4EF89A5F; Mon, 12 May 2025 20:08:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 77C1EF89A59;
	Mon, 12 May 2025 20:08:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C32ABF89A46; Mon, 12 May 2025 20:08:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F3B02F89A40
	for <alsa-devel@alsa-project.org>; Mon, 12 May 2025 20:08:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3B02F89A40
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183ed9ef18a33d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/562@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/562@alsa-project.org>
Subject: ucm2: IO-Boards: Toradex: smarc: add support
Date: Mon, 12 May 2025 20:08:48 +0200 (CEST)
Message-ID-Hash: ZEITO4YBGSLV7JBWUAV3M2JEA5PZETLD
X-Message-ID-Hash: ZEITO4YBGSLV7JBWUAV3M2JEA5PZETLD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZEITO4YBGSLV7JBWUAV3M2JEA5PZETLD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #562 was opened from hiagofranco:

Add support for Toradex SMARC Development board, using the WM8904 audio codec.

This is a carrier board for the Toradex SMARC family, where any SMARC SoM can be connected to it, therefore this is being added to the IO-Boards instead of a specific hardware vendor.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/562
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/562.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
