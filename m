Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64307CFD376
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Nov 2025 16:04:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B89F8601F3;
	Sun, 30 Nov 2025 17:04:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B89F8601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764518652;
	bh=WqDaYaTpNz1KSneheOLSKe/vCEZf0U+FZxZhybxnxo0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VXm5zL2rlVN0N4EkzcuuqSRwsaTtknzmmKPHHR8WBu5etnBnEbHGYP/axjBdmwMen
	 8XsYr0+vDRE7nWUAnI1ve5FaETS45wKcP7ijWlR9q518q90po70QxS7FAmChizKtWq
	 QofJOe6pPNBt7RgxKcA0eS86P3KW0Ba+PpPDM4do=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 127BAF80212; Sun, 30 Nov 2025 17:03:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD9CFF80212;
	Sun, 30 Nov 2025 17:03:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F61CF8049C; Sun, 30 Nov 2025 17:02:40 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E6D0F800B5
	for <alsa-devel@alsa-project.org>; Sun, 30 Nov 2025 17:02:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E6D0F800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187cd44798748000-webhooks-bot@alsa-project.org>
In-Reply-To: <187cd447984f1e00-webhooks-bot@alsa-project.org>
References: <187cd447984f1e00-webhooks-bot@alsa-project.org>
Subject: Creative ZXR channels and volume messed up
Date: Sun, 30 Nov 2025 17:02:40 +0100 (CET)
Message-ID-Hash: UX7KXP6KWHSGTOMYVTBR2L57LUCFQP5G
X-Message-ID-Hash: UX7KXP6KWHSGTOMYVTBR2L57LUCFQP5G
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UX7KXP6KWHSGTOMYVTBR2L57LUCFQP5G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #484 was opened from CommonDirt:

posted this over @ Pipewire, but i'm guessing this is an ALSA issue

https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4996

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/484
Repository URL: https://github.com/alsa-project/alsa-lib
