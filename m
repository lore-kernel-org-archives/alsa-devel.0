Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1721EE93808
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2026 00:25:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD55660213;
	Mon, 13 Apr 2026 02:25:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD55660213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776039916;
	bh=YuM6OLVEYXtCQOSzeGumAoTEyasFwPPYIScyV71Iubc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rT4nO9fhORM6vZ8sbqPOhdUFLPC8WtxuyHOM0/aoaGffZn6q7fXB1LKm5F/GSYu6Q
	 6RgobcGdGzini4fRwFsRWmTfflX/ZUCeYRRHatMR5oVDUVmfGxzRfhahGRaEfu7/AP
	 9nsh4htDtPV8iEB7H2oaNMJmixd+aBqa8zL0qtDQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15906F805F6; Mon, 13 Apr 2026 02:24:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 813D2F805F2;
	Mon, 13 Apr 2026 02:24:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D003F80537; Mon, 13 Apr 2026 02:24:32 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E5CDEF8011B
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2026 02:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5CDEF8011B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a5c2d9f27edc00-webhooks-bot@alsa-project.org>
In-Reply-To: <18a5c2d9f25b7e00-webhooks-bot@alsa-project.org>
References: <18a5c2d9f25b7e00-webhooks-bot@alsa-project.org>
Subject: [hdajackretask] Every override option is "Not connected"
Date: Mon, 13 Apr 2026 02:24:32 +0200 (CEST)
Message-ID-Hash: TLAOXKMYSQYWNC3INECZGKI75OROSVIL
X-Message-ID-Hash: TLAOXKMYSQYWNC3INECZGKI75OROSVIL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TLAOXKMYSQYWNC3INECZGKI75OROSVIL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools issue #45 was opened from JoacoG:

I have a problem with jack detection. See https://discuss.cachyos.org/t/laptop-external-speakers-not-detected-in-fresh-install/26816.

I think that maybe _hdajackretask_ could help me as a work around, but when I try to override something, I only see "Not connected" option. I don't want to mess up with advanced overrides unless someone can guide me.

I have an HP 15-fd0099nr laptop running CachyOS with XFCE.

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/45
Repository URL: https://github.com/alsa-project/alsa-tools
