Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFFBC072A2
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Nov 2023 14:27:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B15AA4E;
	Fri, 17 Nov 2023 15:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B15AA4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700231240;
	bh=ra8TU//8GQtJeBI7U6EIbaMeeiY30lG/aap2py210dE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZoYSgcBhj5courpgr08TQTkxJFcsYhEiaL9nBWbRIKie7eZDwTpZorue4UWTsvbwy
	 I0OxuXv558RX+Rs4hVQ2LqgIGmPvCcZFWuH7av4dY5JbKAhxxqXzoHH7xVucumcTJo
	 3NPbg5PpbjX4TJr7jiPDn90oycs3s1Ditg/MgmWc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B66DFF8055B; Fri, 17 Nov 2023 15:26:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5444FF80249;
	Fri, 17 Nov 2023 15:26:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83659F80249; Fri, 17 Nov 2023 15:26:25 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id BB35EF80152
	for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2023 15:26:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB35EF80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1700231172997710228-webhooks-bot@alsa-project.org>
References: <1700231172997710228-webhooks-bot@alsa-project.org>
Subject: Speexrate linking build artifacts in installation directory?
Message-Id: <20231117142625.83659F80249@alsa1.perex.cz>
Date: Fri, 17 Nov 2023 15:26:25 +0100 (CET)
Message-ID-Hash: 4YBWWCDENBRGWQYSR5K3ELE7MCUNLAXU
X-Message-ID-Hash: 4YBWWCDENBRGWQYSR5K3ELE7MCUNLAXU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4YBWWCDENBRGWQYSR5K3ELE7MCUNLAXU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins issue #55 was opened from MIvanchev:

It seems to me that the [Makefile](https://github.com/alsa-project/alsa-plugins/blob/master/pph/Makefile.am#L31) is linking build artifacts instead of copying them... Also the install hook is assuming those `.so` files exist which seems to be the case but should not be copied over when `--enable-static --disable-shared` is specified. It happens only for that plugin.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/55
Repository URL: https://github.com/alsa-project/alsa-plugins
