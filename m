Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC02C52D7C
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:33:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1F31741;
	Wed, 21 Aug 2024 23:33:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1F31741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724275995;
	bh=L1JS0ImXgkagP4gpyEQzvi9eUSj2ohvzsQcV2h1r6Rc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZOGTOJiP1OasY0QIlZegeqeibez65jHZATYbH4fJ3m2ZN4QP4n6VuZPKawxDPjKPH
	 rj9x4BpIy+l72kxR3uFWYjpFlsUZ60POk7tAgrpG2oxHrx89aLMOySpKb9dJcPFnVo
	 Js/uySZaiPqv/aVFesxA+NARAoTHpvu/XZNDjdAY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B038DF805BB; Wed, 21 Aug 2024 23:32:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CD00F80589;
	Wed, 21 Aug 2024 23:32:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A5A6F80496; Wed, 21 Aug 2024 23:32:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 48890F8016E
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2024 23:32:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48890F8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1724275954447823524-webhooks-bot@alsa-project.org>
References: <1724275954447823524-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Add support for Focusrite 4th Gen devices
Message-Id: <20240821213238.0A5A6F80496@alsa1.perex.cz>
Date: Wed, 21 Aug 2024 23:32:38 +0200 (CEST)
Message-ID-Hash: O43UDVHMT2IXAAQ2WUYDTCAQ4MRLMCA7
X-Message-ID-Hash: O43UDVHMT2IXAAQ2WUYDTCAQ4MRLMCA7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O43UDVHMT2IXAAQ2WUYDTCAQ4MRLMCA7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #438 was opened from ChrisLane:

Extending the existing support for Focusrite Scarlett Solo and 2i2 interfaces with support for the 4th Gen devices.

I have a Focusrite Scarlett 2i2 which is what I have tested with and used to get the device ID.
For the Solo device, I grabbed the device ID from [linux-hardware.org](https://linux-hardware.org/?id=usb:1235-8218).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/438
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/438.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
