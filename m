Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE40AC7EE2D
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Feb 2023 11:08:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AE02203;
	Sat, 25 Feb 2023 12:07:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AE02203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677323310;
	bh=/cyDHkurb/UU+Ew/m3yPqay/bhogmt1//AyLVjWv3pQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=uW6UkRe9k+sCwGxAC4A7x4uIaz0UGRvAo0aW9SkJHitRiCkwMAyAY1zPDSjr7OwWW
	 LpH7Ke5WPmhIR8NXFCIg5D3D3LT44nUqXcVIigbvFtKA9iFl/gf/akrb34vI/gTGqq
	 IuP1cvDS2qgMFdj7XB2daPeGlLZjaxKIstzEuaVE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95E72F80125;
	Sat, 25 Feb 2023 12:07:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BCC0F80125; Sat, 25 Feb 2023 12:06:50 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B2A6F800C7
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2023 12:06:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B2A6F800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1677323205557467461-webhooks-bot@alsa-project.org>
References: <1677323205557467461-webhooks-bot@alsa-project.org>
Subject: xone mixer
Message-Id: <20230225110650.4BCC0F80125@alsa1.perex.cz>
Date: Sat, 25 Feb 2023 12:06:50 +0100 (CET)
Message-ID-Hash: WTIKVDRPYPR6I3GRALRRX56MLYUMA5BF
X-Message-ID-Hash: WTIKVDRPYPR6I3GRALRRX56MLYUMA5BF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WTIKVDRPYPR6I3GRALRRX56MLYUMA5BF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #303 was opened from molli1312:

Having a few problems with the Xone32c though not sure if this is an ALSA
issue or general USB stack problem.

It's a USB soundcard that is supposed to have 4 inputs and 4 outputs. It
seems to have 2 USB configurations (bNumConfigurations : 0x2). When plugged
in, bConfigurationValue is 0x1 and only 2 inputs and 2 outputs show up.
Change this value to 0x2 and it shows up (as it should) as 4 inputs and 4
outputs.

I can change the bConfigurationValue with this udev rule, or with a `echo 2

/sys/bus/usb/devices/1-1.4/bConfigurationValue`:

This has all been working OK on Ubuntu 20.04 running kernel
5.4.0-33-generic. However, I just updated to 5.4.0-37-generic and now there
is only a single USB configuration (bNumConfigurations : 0x1) and
bConfigurationValue can't be changed to 0x2:

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/303
Repository URL: https://github.com/alsa-project/alsa-lib
