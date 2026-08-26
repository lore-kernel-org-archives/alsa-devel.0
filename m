Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B49EC61DC2
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:58:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2C9F6026B;
	Wed, 26 Aug 2026 10:58:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2C9F6026B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787734732;
	bh=ZVL6W2UNyvicPZ9QXgmckokypO46WpurIA14XHAIGNE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GjTCih7z2JXbj8i9Pl0gHlDwmK2MEWHQZcKv5l1oH9ZF6UpNYx7B/2pQrtPswH5VL
	 8SNhB4EVeEjwwU1mnZDIpoFXIAyC1sf/3/mC+xJee+ykLR6IX3p2tj+rqSAgROaUs/
	 B3MgZrxv496pEokMvVanCbn6LCArz7YholbBYUtc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC0C7F805F8; Wed, 26 Aug 2026 10:58:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E57BFF80601;
	Wed, 26 Aug 2026 10:58:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F09DDF80525; Wed, 26 Aug 2026 10:58:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787734689;
	b=WROWnCCX7Y6GCmBuWvrYXSFx/eNucSkBmLJl3I0+CxiCLuwdIdyvWT+18cZ7hfghj2Ap
	 ewVQXJzPTpHHXTBSt5NgrkVkvZ35AtT7jW+W3x+DKwH7Aqw7g3VBnsIPGRsEMbqqHG8gM
	 6QJO9F5n16ImFsqM8LofE9lm/Yt/vP7c9gTnMau6widgH7WKEV6P3REpw2ED9PkVNxOo6
	 xPP5Jc3Jtyw1b5p7+DQwKjR4Y4xuchRyVOO1DRZHv2AriNd5xCvmD4A+GuFicyJy5G/wv
	 VlhI+hlTL6HqAkXEU8KF2ckyrfKWNWSPqPeFDMCxGh/2H4yOxKDXmIn7b0OZjkL5IlA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787734689;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ZVL6W2UNyvicPZ9QXgmckokypO46WpurIA14XHAIGNE=;
	b=c7y1hQsj1iizkWbQ94YzpzK/luYZNqX23+u9q5mYLZY1AEq7SVdJZ2ZtYhhC+gOY9BkQ
	 jjdNr1URZpUgt1vGyKdgqU3HMIhnmnGWvU897qZl+8hNEwvagH98zEG0ta4dDv9iL8ffg
	 flU2c8G1gSxNwBKj2E3AHaP3LfB5I3tnCK1Z17Pvw0jhPZX81Jquv1vzI+minZ99SBgzc
	 rCO+z4Ya/FuFg3LQ88IvagXSA0WrssPlUwhVe24Qc0NPh/e4JFi/yxICV3HjDa3ipkStX
	 HMWrKUZPL9c7cc70k1z0lnCpk44Z+a/KDZGSVaCgIkvnlVTdzxwqtfh5szq8+7n1v9Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 43399F800C1
	for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2026 10:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43399F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cf4f3a0c374b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/840@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/840@alsa-project.org>
Subject: ucm2: Qualcomm: add Radxa Dragon Q8B support
Date: Wed, 26 Aug 2026 10:58:09 +0200 (CEST)
Message-ID-Hash: LLTTDLCPITSACPNETE2PYK5CI26PH3NH
X-Message-ID-Hash: LLTTDLCPITSACPNETE2PYK5CI26PH3NH
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LLTTDLCPITSACPNETE2PYK5CI26PH3NH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #840 was opened from strongtz:

Radxa Dragon Q8B has 1x HDMI (over DP), 2x DP and Headset(Mic and speakers)
connectors.

This PR adds support for audio over these interfaces.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/840
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/840.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
