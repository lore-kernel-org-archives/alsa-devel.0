Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C186EC28B30
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Mar 2025 04:55:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DC63601A3;
	Wed, 26 Mar 2025 05:55:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DC63601A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742964926;
	bh=Ad8L6XXLKLczARaHQ3NFMNW5/cZMAQ/uOpxUvKQZu10=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SXCWeUqx9fCrG8b837B6W63stAi7GAUvZfNlU9oZF150MwENEWl0VwWUpvFsjUdwk
	 ezNc21yqXqQxRRqJ6GD8rab2Vlcgrzt8Wug9+YB/I7Wa1qjEP7JktNOqNfTYmh1LBc
	 JcjJsydhRfHrU7847iDMUtCZYjT/NOzM/c+z1nv4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A287F805C0; Wed, 26 Mar 2025 05:54:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D362F805B4;
	Wed, 26 Mar 2025 05:54:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0CEAF80171; Wed, 26 Mar 2025 05:54:46 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F4FDF8010B
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2025 05:54:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F4FDF8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18304153ed5b9800-webhooks-bot@alsa-project.org>
In-Reply-To: <18304153ebe6a500-webhooks-bot@alsa-project.org>
References: <18304153ebe6a500-webhooks-bot@alsa-project.org>
Subject: No output when selecting S/PDIF on Asus B850-I with Realtek ALC4080
Date: Wed, 26 Mar 2025 05:54:46 +0100 (CET)
Message-ID-Hash: RGKNXRWRGYUL7DNKFRZOUSSXYPU37YQH
X-Message-ID-Hash: RGKNXRWRGYUL7DNKFRZOUSSXYPU37YQH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RGKNXRWRGYUL7DNKFRZOUSSXYPU37YQH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #534 was opened from bcrescimanno:

Motherobard site: https://rog.asus.com/us/motherboards/rog-strix/rog-strix-b850-i-gaming-wifi/

I get no output from the S/PDIF port on this motherboard. I'm able to workaround it using `pavucontrol` and switching the USB Audio device to the "Pro Audio" configuration and then choosing "USB Pro Audio 2" as the output device.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/534
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
