Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDDEE9A048
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:52:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C7E660217;
	Thu, 19 Feb 2026 14:52:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C7E660217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771509138;
	bh=JVMiNE+AKgubBuDghWz0YkBh66uQJsP5TLVlN2RD1dA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Jim7TvghhZl7aONxOo3A39z4kNEecjSu8i5h5jLc1lKiVC5laxLHATXwfyRYJjTxK
	 SyU5m/E8n30iXAQguGz8PUJTMAIZZ4UVHfdgddFqPE/2ZVBIa3yipsavOa5+WhzTNd
	 MAI5KVxUgUQhfy2IY9sTa7aa0TrCnRD+vLuyLaT0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08107F805EF; Thu, 19 Feb 2026 14:51:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81326F805E6;
	Thu, 19 Feb 2026 14:51:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B69D3F804F2; Thu, 19 Feb 2026 14:50:25 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 214D4F80162
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2026 14:50:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 214D4F80162
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1895aa11aefc8600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/494@alsa-project.org>
References: <alsa-project/alsa-lib/pr/494@alsa-project.org>
Subject: control: ucm: add ioctl to retrieve full card components
Date: Thu, 19 Feb 2026 14:50:25 +0100 (CET)
Message-ID-Hash: WGYZMBOWK2A3UCT43PIAIITVWEQU6FYN
X-Message-ID-Hash: WGYZMBOWK2A3UCT43PIAIITVWEQU6FYN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WGYZMBOWK2A3UCT43PIAIITVWEQU6FYN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #494 was edited from mstrozek:

The fixed-size components field in SNDRV_CTL_IOCTL_CARD_INFO can be too small on systems with many audio devices. The kernel [1] will provide a new ioctl to read the full string while truncating the original in card_info if it grows too big. Make sure alsa-lib can read the full string if the original is truncated.

[1] link to v3

Request URL   : https://github.com/alsa-project/alsa-lib/pull/494
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/494.patch
Repository URL: https://github.com/alsa-project/alsa-lib
