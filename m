Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E0FD116F1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:30:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BD136020C;
	Mon,  1 Dec 2025 16:30:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BD136020C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764603037;
	bh=G+/Y+DicwoZBPTaQlsCxj7HmwfFaNLt8CWFmVd6GGBQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WR9MIdXpmo2wF+45KWov50Adg3cANOyJfih0B7WUHFNOKB8CIfX0tkkguD5z4tkJ+
	 huJNWzVYeO8YLmN1UzMNveDR0hOP/Js3bXFQL0uQnjooVVXCi6cL76oX3APRWz4hgV
	 ziA8xnRTbv3Lmy084g8LDclKhvcZJ/E5uV9tU9lE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47746F805D5; Mon,  1 Dec 2025 16:30:04 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C26AF805D3;
	Mon,  1 Dec 2025 16:30:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 988E2F8049C; Mon,  1 Dec 2025 16:29:51 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 389AAF8014B
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2025 16:29:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 389AAF8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187d2111e9868200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-tools/pr/42@alsa-project.org>
References: <alsa-project/alsa-tools/pr/42@alsa-project.org>
Subject: hdspmixer: fix null pointer dereference in HDSPMixerWindow:handler_cb
Date: Mon,  1 Dec 2025 16:29:51 +0100 (CET)
Message-ID-Hash: SL2XRMCM5E2SSOJ2J27QLAR4XI2C5GOR
X-Message-ID-Hash: SL2XRMCM5E2SSOJ2J27QLAR4XI2C5GOR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SL2XRMCM5E2SSOJ2J27QLAR4XI2C5GOR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools pull request #42 was edited from cheldt:

Fixes following error:
Program received signal SIGSEGV, Segmentation fault.
handler_cb () at /home/snaut/dev/alsa-tools/hdspmixer/src/HDSPMixerWindow.cxx:278

Related [Issue](https://github.com/alsa-project/alsa-tools/issues/43)

Request URL   : https://github.com/alsa-project/alsa-tools/pull/42
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/42.patch
Repository URL: https://github.com/alsa-project/alsa-tools
