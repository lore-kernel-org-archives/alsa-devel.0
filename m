Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D208FC4167B
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Dec 2023 15:09:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 063E8A4B;
	Wed,  6 Dec 2023 16:09:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 063E8A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701875357;
	bh=KqCudYl3/I3txNCx1XUEcUYlpLbj8ZSPTiuyxOHwF0c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tHYH0L6ukOZB6dGNsHKwGmQfxf4YOfuM8erMkOtaBeR81HYQ7O7KFC+oTOSzukhs5
	 7Y3UKziBu/8DYOgp/ASBGL18zWR7ksacibz0+RxN8MUQUWiVxhA1YSWpkO/2+tdwGc
	 Syv0K3HrrJy70EsWMgDJ/3lEnrlUS1Fu9Z84hBDE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2D46F80588; Wed,  6 Dec 2023 16:08:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 116E2F80578;
	Wed,  6 Dec 2023 16:08:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB0EFF8024E; Wed,  6 Dec 2023 16:08:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 702E5F800AC
	for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2023 16:08:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 702E5F800AC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1701875316957022429-webhooks-bot@alsa-project.org>
References: <1701875316957022429-webhooks-bot@alsa-project.org>
Subject: default pcm plugin
Message-Id: <20231206150839.EB0EFF8024E@alsa1.perex.cz>
Date: Wed,  6 Dec 2023 16:08:39 +0100 (CET)
Message-ID-Hash: HIKHCBIQU5ONMEYQJIWI74AN6ZK6H764
X-Message-ID-Hash: HIKHCBIQU5ONMEYQJIWI74AN6ZK6H764
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HIKHCBIQU5ONMEYQJIWI74AN6ZK6H764/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #371 was opened from sylware:

Is there a robust programming way to know if the canonical "default" pcm is actually a pipewire/pulseaudio/jack plugin? That at a device/pcm enumeration time, namely before any pcm is actually being configured.

I was thinking about the "configuration" API, but I am not that sure it "resolves" everything including user-specific/system-specific configurations (asound rc files and env variables).

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/371
Repository URL: https://github.com/alsa-project/alsa-lib
