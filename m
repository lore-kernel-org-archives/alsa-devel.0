Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27FACD6E5B
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Oct 2023 11:02:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F34B51562;
	Wed, 11 Oct 2023 13:01:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F34B51562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697022132;
	bh=iGWVmjfdUKqM4UM8C6uGbbQLvABx5Cx/WJC+FU33Pss=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Dot5NNssNKAZ9SkHrJJCeeCIoNvhMUd+SpI1pJ4AA8NfVlqqPlIFq86WzAEaF3xd4
	 B12W9UdCsSsjHeG7lMD24TNiwVLeQbflL1cFIx1KEr9BoF9yO4qVJUtFk7rY2QutoR
	 AYk7eSm7TpKcYJYB6f6r2XXCfh8ylvQEDJ9z8pMw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B678F802E8; Wed, 11 Oct 2023 13:01:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 985ADF802BE;
	Wed, 11 Oct 2023 13:01:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59985F80310; Wed, 11 Oct 2023 12:53:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AF98F80130
	for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2023 12:52:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AF98F80130
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1697021549814815760-webhooks-bot@alsa-project.org>
References: <1697021549814815760-webhooks-bot@alsa-project.org>
Subject: Realtek ALC 4080 on MSI MPG B650 Carbon WiFi
Message-Id: <20231011105334.59985F80310@alsa1.perex.cz>
Date: Wed, 11 Oct 2023 12:53:34 +0200 (CEST)
Message-ID-Hash: Q4KS7RF55GKPIF5O4DW5COFY2EWMNUM4
X-Message-ID-Hash: Q4KS7RF55GKPIF5O4DW5COFY2EWMNUM4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q4KS7RF55GKPIF5O4DW5COFY2EWMNUM4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #359 was opened from TeamFahQ:

I have Realtek ALC 4080 on an MSI MPG B650 Carbon WiFi and the chip is not getting recognized. I havve seen similar post with this exact issue on similar motherboards and the fix is to change the usb id. Unfortunately, I'm not sure which is the usb id I need
`Bus 001 Device 003: ID 0db0:70d3 Micro Star International USB Audio
Bus 002 Device 003: ID 0bda:0411 Realtek Semiconductor Corp. Hub
Bus 001 Device 004: ID 0bda:5411 Realtek Semiconductor Corp. RTS5411 Hub`
Assumably, it would be the first one I listed, but being this is a Realtek device, could it be either of the other 2?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/359
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
