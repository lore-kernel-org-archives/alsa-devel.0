Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C01CC28B28
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Mar 2025 07:47:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5D796042F;
	Sat, 15 Mar 2025 08:46:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5D796042F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742024824;
	bh=+trdX42qc7gCiNVcbR/OIDuxhBrAxRTkHhj0AhcAOx8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Xfieg3HVV8gaB/LUD2qX3QIJ3TSmyYnl0Om3NTId3C+khueT50Sg9KLVBi33bYiei
	 lZJ+p9IhzcJiDC0teV5YpJaB5ff5MKORymrCHAyEU2FO1Kz+wUpsDIJzj653iRfO9v
	 CUz98wsNIgmlKd47GpUk2ddMesg37LpFciTr70UU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1950F805A8; Sat, 15 Mar 2025 08:46:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C087F805B2;
	Sat, 15 Mar 2025 08:46:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42D01F8023A; Sat, 15 Mar 2025 08:46:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8252DF80095
	for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2025 08:46:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8252DF80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <182cea4fbb510c00-webhooks-bot@alsa-project.org>
In-Reply-To: <182cea4fbb3cbf00-webhooks-bot@alsa-project.org>
References: <182cea4fbb3cbf00-webhooks-bot@alsa-project.org>
Subject: pyalsa.alsamixer.Element.get_volume_dB returns error status instead
 of actual value
Date: Sat, 15 Mar 2025 08:46:26 +0100 (CET)
Message-ID-Hash: X5ZFALJ6PGVPLPMM5NS2SPIKHQWPNLA6
X-Message-ID-Hash: X5ZFALJ6PGVPLPMM5NS2SPIKHQWPNLA6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X5ZFALJ6PGVPLPMM5NS2SPIKHQWPNLA6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-python issue #16 was opened from tespent:

I am writing a status collector for my PC, and I noticed that `pyalsa.alsamixer.Element.get_volume_dB` always returns 0 in my test, which lead to invalid result for the collected status.

After digging into code I notice that the following code returns `res` instead of `val` as the result:
https://github.com/alsa-project/alsa-python/blob/f8f9260282eb9c97f53e4689e04182dc87a4810e/pyalsa/alsamixer.c#L983

I am able to workaround this issue by using `elem.ask_volume_dB(elem.get_volume())` but this looks silly.

Btw, I'm willing to contribute and subscribed to alsa-devel mailing list but I didn't figure out exactly how. Can someone tell me?

Issue URL     : https://github.com/alsa-project/alsa-python/issues/16
Repository URL: https://github.com/alsa-project/alsa-python
