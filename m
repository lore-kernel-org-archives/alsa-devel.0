Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45553E668B6
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Nov 2024 14:59:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34CE0839;
	Sun, 24 Nov 2024 15:59:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34CE0839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732460388;
	bh=6e5z0TAy4rvbY/TdMV1S7aiuw65BW36NObwA1K9qUu0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UVxmusG9l7PyNrmUTs2cXBa3YyPAlw5tKQZsF6GjKNTaPw09MJli4DTz8gXzEr8Z8
	 8+j5B9314FK1Jc5c8iAvEkPKn58XW7eyISrlWG3s4iG71njZWrl9S1aqRFFqoxijD6
	 HKjaTwm5ADvnYQqtsHGTbNV8agMyvd3d8xOdDHsA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41F2FF805C0; Sun, 24 Nov 2024 15:59:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81FC1F80496;
	Sun, 24 Nov 2024 15:59:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33141F80496; Sun, 24 Nov 2024 15:59:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 7940CF8019B
	for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2024 15:59:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7940CF8019B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732460360917246580-webhooks-bot@alsa-project.org>
References: <1732460360917246580-webhooks-bot@alsa-project.org>
Subject: amd-soundwire: add support for AMD generic legacy machine driver
Message-Id: <20241124145923.33141F80496@alsa1.perex.cz>
Date: Sun, 24 Nov 2024 15:59:23 +0100 (CET)
Message-ID-Hash: YVWIIAKSY4AU32B53UAHNTMS26BY6Q7V
X-Message-ID-Hash: YVWIIAKSY4AU32B53UAHNTMS26BY6Q7V
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YVWIIAKSY4AU32B53UAHNTMS26BY6Q7V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #470 was opened from vijendarmukunda:

Add support for AMD generic legacy(No DSP) machine driver for ACP6.3 platform using RT722 codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/470
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/470.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
