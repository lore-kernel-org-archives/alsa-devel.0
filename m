Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71404CD6E5A
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Oct 2023 11:03:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 042181572;
	Wed, 11 Oct 2023 13:02:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 042181572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697022181;
	bh=erxl3gpgT/cbBTE0IKG8u93FilKxMg6+BuDqE0WfY2U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=S/3GwmEb7pWjcgMYHvhDon6tt8w4/iCAAOhb12/lfb3CHizws5beWbvWd315vjVEJ
	 rrDXV6WOQC9Bm6ZdASA2rN0D6yOwV1DVStvSF8mteBQiJwHB6BXaXajaPepX5g95IP
	 G8PAkg+TsWyXFzXLfu2n1MMrgrJp49TKAt0nZ4go=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EC29F80570; Wed, 11 Oct 2023 13:01:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D812F80558;
	Wed, 11 Oct 2023 13:01:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20812F802E8; Wed, 11 Oct 2023 12:53:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id EDDA9F802BE
	for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2023 12:52:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDDA9F802BE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1697021576945346594-webhooks-bot@alsa-project.org>
References: <1697021576945346594-webhooks-bot@alsa-project.org>
Subject: Realtek ALC 4080 on MSI MPG B650 Carbon WiFi
Message-Id: <20231011105336.20812F802E8@alsa1.perex.cz>
Date: Wed, 11 Oct 2023 12:53:36 +0200 (CEST)
Message-ID-Hash: LUCFTPXEAIAKQ7CW4FAYAZ6UMYKJVMKC
X-Message-ID-Hash: LUCFTPXEAIAKQ7CW4FAYAZ6UMYKJVMKC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LUCFTPXEAIAKQ7CW4FAYAZ6UMYKJVMKC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #359 was edited from TeamFahQ:

I have Realtek ALC 4080 on an MSI MPG B650 Carbon WiFi and the chip is not getting recognized. I havve seen similar post with this exact issue on similar motherboards and the fix is to change the usb id. Unfortunately, I'm not sure which is the usb id I need

`Bus 001 Device 003: ID 0db0:70d3 Micro Star International USB Audio`

`Bus 002 Device 003: ID 0bda:0411 Realtek Semiconductor Corp. Hub`

`Bus 001 Device 004: ID 0bda:5411 Realtek Semiconductor Corp. RTS5411 Hub`

Assumably, it would be the first one I listed, but being this is a Realtek device, could it be either of the other 2?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/359
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
