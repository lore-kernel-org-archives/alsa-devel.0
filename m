Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D616C61CE7
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:50:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C2A4601F5;
	Wed, 11 Jun 2025 09:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C2A4601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749628214;
	bh=wDrs7T2+UYL9DxAe4onS8Gfsgf5jwHn3EyY2Irecl8E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=utFo3WWAyf7kaYEda4q8s247YaumnVLiZWJnsNSI/LbL5InpYuKtwIqzIDRZ6uYrh
	 68nsv5v+KEfh6pWjx7BVrGhCF9Q0yC6tMKTT3PrnlBe9Y4sj/V8EmvlXfhdKE6qbL1
	 nJucv61MpOdUkzpPWNf4JBED/4WuDmwy8XRy5MKQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A3D4F805D2; Wed, 11 Jun 2025 09:49:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26153F805C1;
	Wed, 11 Jun 2025 09:49:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0D1AF80269; Wed, 11 Jun 2025 09:49:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 36848F800BD
	for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2025 09:49:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36848F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1847ed8d6a259e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/28@alsa-project.org>
References: <alsa-project/tinycompress/pr/28@alsa-project.org>
Subject: tinycompress: fix compress_read API
Date: Wed, 11 Jun 2025 09:49:33 +0200 (CEST)
Message-ID-Hash: XREVFUDUDBI7XHPSQL2U6V5ZWQNLR5M6
X-Message-ID-Hash: XREVFUDUDBI7XHPSQL2U6V5ZWQNLR5M6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XREVFUDUDBI7XHPSQL2U6V5ZWQNLR5M6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #28 was opened from quic-ajender:

In blocking mode:
  read is blocked until it reads some bytes
In Non-blocking mode:
  read as much as available bytes, if available.

Request URL   : https://github.com/alsa-project/tinycompress/pull/28
Patch URL     : https://github.com/alsa-project/tinycompress/pull/28.patch
Repository URL: https://github.com/alsa-project/tinycompress
