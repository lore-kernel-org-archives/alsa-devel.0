Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D8DC36008
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Mar 2025 06:44:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6915D601F0;
	Sat, 29 Mar 2025 07:43:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6915D601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743230645;
	bh=v4Sq/UCThu8PpK+nmWU0q0xBu9iNNxDrfD4cmqIh4zU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Yi5/kT2qW5QR8RQ3416Y12k94h4G5jD3Qh3Ccxikjxs8Ay2h+sOqGCzQOQ5IkkUNk
	 z2k7A1Najh22kg83NzRq8SEKxfEb72zbEKIXdcQx0rL2jhXbmioU8dEaa9hfsoXCXc
	 1nJg//i2IDQ1k1T497dVcjQJbaYTbQ8WfxTTH2z4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB2FBF805B3; Sat, 29 Mar 2025 07:43:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CC2DF805BB;
	Sat, 29 Mar 2025 07:43:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F041F8055B; Sat, 29 Mar 2025 07:43:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BC21CF80538
	for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2025 07:43:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC21CF80538
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183132ff9850eb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-tools/pr/31@alsa-project.org>
References: <alsa-project/alsa-tools/pr/31@alsa-project.org>
Subject: envy24control: fix GtkSpinButton runtime warnings
Date: Sat, 29 Mar 2025 07:43:26 +0100 (CET)
Message-ID-Hash: AKEASRAOIW4H7LTCG64UBNLIMT4YPS5O
X-Message-ID-Hash: AKEASRAOIW4H7LTCG64UBNLIMT4YPS5O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AKEASRAOIW4H7LTCG64UBNLIMT4YPS5O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools pull request #31 was opened from andreas56:

Change the parameters to gtk_adjustment_new to get rid of this runtime warning from GTK:

GtkSpinButton: setting an adjustment with non-zero page size is deprecated

The change is also important when envy24control is ported to GTK 3, as the spin buttons will stop working if it's not done.

Request URL   : https://github.com/alsa-project/alsa-tools/pull/31
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/31.patch
Repository URL: https://github.com/alsa-project/alsa-tools
