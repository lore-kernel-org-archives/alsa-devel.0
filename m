Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625FFCCD193
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Oct 2025 11:58:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB1FF60231;
	Sat, 18 Oct 2025 13:58:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB1FF60231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1760788712;
	bh=tu1fnjsttpwtsk8UZ7lsq2GzgNhTOfsbHt77sJrjizs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KGaYF2wsFAmZ5GjNkvlMzcs2cmlPMl3P6ftZn/cfcaNts8nTEFz80tnYnt4Z37IPC
	 2lLSoW0sIhEZ/rhvkvrfp/INwsEZtnVzf1nvYpRco82RynRQ5IeUtoB64+gZeKclzK
	 jcLMQ/Glu/zhAY8EQOjUBSA+7SbtPbxT8NPt7U5s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E659BF8061E; Sat, 18 Oct 2025 13:57:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9480F8060F;
	Sat, 18 Oct 2025 13:57:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D24FF805D5; Thu, 16 Oct 2025 16:33:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E90FEF800E3
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2025 16:33:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E90FEF800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <186eff4db4390200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/625@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/625@alsa-project.org>
Subject: ucm2: Add support for MT8196 Rauru Rev0 Chromebook with SOF
Date: Thu, 16 Oct 2025 16:33:35 +0200 (CEST)
Message-ID-Hash: HQ2PTDF2J362C3FZEQPQMY6P4KKLMASG
X-Message-ID-Hash: HQ2PTDF2J362C3FZEQPQMY6P4KKLMASG
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Content-Transfer-Encoding: 7bit

alsa-project/alsa-ucm-conf pull request #625 was opened from laura-nao:

Add support for the Google Rauru Rev0 Chromebook, powered by MediaTek Kompanio Ultra (MT8196). This machine uses NAU8825 as headphone codec and NAU8318 as speaker codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/625
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/625.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
_______________________________________________
Alsa-devel mailing list -- alsa-devel@alsa-project.org
To unsubscribe send an email to alsa-devel-leave@alsa-project.org
