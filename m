Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C56CC71157
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Jun 2025 16:13:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 835E7601D3;
	Wed, 18 Jun 2025 18:13:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 835E7601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1750263212;
	bh=rP/h1JSi/QnnMRy7YbSbUag0pe/FZibn9uRR6RK2DX0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DRMn+IyFWp8xSCO4XCuaAGbdpoNGSgyP+5HP0ksszMcOaIat4Jk6Hn2pLE+xbg+Gh
	 urAVIBnEyzeigvd0lOZz4b6hzveqpBaUQlI5RQxSvmt0kXuwoc+trw8xRP++552hOu
	 1FT0o1O8XHL8AB+LeEvRCQAoROLRnzE6OJrDa61Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83627F805C0; Wed, 18 Jun 2025 18:12:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6536FF805C9;
	Wed, 18 Jun 2025 18:12:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D2D8F80525; Wed, 18 Jun 2025 18:12:56 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E6CF1F800E3
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2025 18:12:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6CF1F800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184a2f1546ad1500-webhooks-bot@alsa-project.org>
In-Reply-To: <184a2f1546a38b00-webhooks-bot@alsa-project.org>
References: <184a2f1546a38b00-webhooks-bot@alsa-project.org>
Subject: Unable to see my Focusrite Scarlett Solo 4th gen
Date: Wed, 18 Jun 2025 18:12:56 +0200 (CEST)
Message-ID-Hash: 7SVWVTDHKH65EAAFAFM5YMMG7RYUUYHR
X-Message-ID-Hash: 7SVWVTDHKH65EAAFAFM5YMMG7RYUUYHR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7SVWVTDHKH65EAAFAFM5YMMG7RYUUYHR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #460 was opened from thereticle:

Hi,
a few days ago I bought a Focusrite Scarlett Solo 4th gen. It worked for a while, but since I had problems with Davinci Resolve (crackling sound) I tried to fix it without success until I could not see the Scarlett anymore.

Actually lsusb sees the card
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 0db0:0076 Micro Star International MYSTIC LIGHT
Bus 001 Device 007: ID 1235:8218 Focusrite-Novation Scarlett Solo 4th Gen
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub [...]

but alsa does not see it.

After many attempts with the help of ChatGPT and other IA, I thought I had solved it by installing the alsa-ucm-conf package, but after the next reboot the card disappeared again.

I use Xubuntu 25.04 with Pipewire (but I also tried with pulseaudio without success).
Any suggestions?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/460
Repository URL: https://github.com/alsa-project/alsa-lib
