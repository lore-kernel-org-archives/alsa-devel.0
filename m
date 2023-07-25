Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB578EB64DD
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 22:00:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B930828;
	Tue, 25 Jul 2023 23:59:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B930828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690322407;
	bh=npky6XVJzzBdpvK3NCaAIcCT1nUUuwYbH6EQ/xnUAZ0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OGmCFnjvFgaD9gJKi/rMRSeXorfJAZ4p9oNJ1nFV0ldKsPKZso4HyYbZR6BtUrqhJ
	 BPzT7sItfI8q7A3RDv35qlt/7HyVoCciTQTGIKimOwRROLJonHEJUBAZCQZwvKJe3a
	 izCbLpar1D1/M0npx/wEx89Q4YjtNeLox2qzV5ys=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3004AF80544; Tue, 25 Jul 2023 23:58:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC7CCF8019B;
	Tue, 25 Jul 2023 23:58:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F46DF8019B; Tue, 25 Jul 2023 23:58:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DF4C0F800C7
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 23:58:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF4C0F800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1690322315726432562-webhooks-bot@alsa-project.org>
References: <1690322315726432562-webhooks-bot@alsa-project.org>
Subject: MSI MAG X570S TOMAHAWK MAX WIFI - microphone + front audio panel not
 working - attempt 2
Message-Id: <20230725215842.1F46DF8019B@alsa1.perex.cz>
Date: Tue, 25 Jul 2023 23:58:42 +0200 (CEST)
Message-ID-Hash: EUPH2F6RLYQSTNF4EKKRAMCJ42NSHP7F
X-Message-ID-Hash: EUPH2F6RLYQSTNF4EKKRAMCJ42NSHP7F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EUPH2F6RLYQSTNF4EKKRAMCJ42NSHP7F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #337 was edited from motomyslen:

I tried with `alsa-ucm-conf-1.2.9` but microphone still not working. Front audio panel detects headphones but no sound and mic not working as well.

If I'm not wrong ID of my device is `0db0:a073` but it was not added in 1.2.9 or 1.2.8 as I checked in changelog.


[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12165950/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/337
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
