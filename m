Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC8CC77B78
	for <alsa-devel@archiver.kernel.org>; Wed,  3 May 2023 15:21:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3FEB12DE;
	Wed,  3 May 2023 17:20:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3FEB12DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683127269;
	bh=3IwhjS9qkQ91bj61qm5pyCPrrEwto3HyX7BlhQ4xTdM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Cc0yzG1BDBAQ2DK3nOmnM0Cwsq9LkjEo921MPd3QXhTiGZG7Aze7XSnXbUknVpRP6
	 DVzZi1GXJol0UcFyACbHaml/BUVSvRYOaclACqW8e4+mXEGDjdqsaiXEiYkHmbNMv+
	 xclf8QrFVbMlZXDAOJxv/QveJGHYLLgNLqHGy4S4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35E9CF8032B;
	Wed,  3 May 2023 17:19:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBCA6F8032B; Wed,  3 May 2023 17:19:49 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 72D13F800EC
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2023 17:19:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72D13F800EC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683127187539551497-webhooks-bot@alsa-project.org>
References: <1683127187539551497-webhooks-bot@alsa-project.org>
Subject: ucm2: USB-Audio: Add support for Focusrite Scarlett Solo devices
Message-Id: <20230503151949.DBCA6F8032B@alsa1.perex.cz>
Date: Wed,  3 May 2023 17:19:49 +0200 (CEST)
Message-ID-Hash: AVP6YWX77AUKAZLZ2JR3MDGQHEQEQ6U3
X-Message-ID-Hash: AVP6YWX77AUKAZLZ2JR3MDGQHEQEQ6U3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AVP6YWX77AUKAZLZ2JR3MDGQHEQEQ6U3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #309 was opened from kepstin:

These are basically identical to the Scarlett 2i2 devices of the same generation; the difference is that the first input can only be used for a mic, and the second input can only be used for line/instrument. (On the 2i devices, both inputs are the same - they both have mic preamps, and both support line/instrument input.)

I've added a new profile for them so the Comment can be set to the correct device name, but because of the similarity between the Solo and 2i devices, I've re-used the existing Scarlett-2i-HiFi use case to set up the split input devices.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/309
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/309.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
