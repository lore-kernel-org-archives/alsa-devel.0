Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB39EB64D7
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Jun 2023 17:32:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 842F3832;
	Sun, 18 Jun 2023 19:31:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 842F3832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687109557;
	bh=69yUkpoaksTMswJztAUwNVTSuFHKxmp6XCG300kYdfA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=somdt1ZJfR1i6JFNX5IgQ1USHacZN4IKnuTXaExZol7pbhM/kZIptd6ndNQuftqln
	 cLs/JVgX1XV55VnW3k+kwSVdrcC79StbjCgu1Eh/Xn57NxDBc8KqAT2xVlVMKD7h8f
	 v7ESlFOooEI5IUNimhFhAr7IJR7wN9mEmw7zr/iE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CE97F80130; Sun, 18 Jun 2023 19:31:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98863F80132;
	Sun, 18 Jun 2023 19:31:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB3D3F80132; Sun, 18 Jun 2023 19:31:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 72CD4F800E5
	for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2023 19:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72CD4F800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687109473855322123-webhooks-bot@alsa-project.org>
References: <1687109473855322123-webhooks-bot@alsa-project.org>
Subject: ucm2: PinePhone: use "Mix Mono" routing for earpiece
Message-Id: <20230618173116.CB3D3F80132@alsa1.perex.cz>
Date: Sun, 18 Jun 2023 19:31:16 +0200 (CEST)
Message-ID-Hash: F2ANO7XE2B7N5DLQQRGAUWVRTARKLQOE
X-Message-ID-Hash: F2ANO7XE2B7N5DLQQRGAUWVRTARKLQOE
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F2ANO7XE2B7N5DLQQRGAUWVRTARKLQOE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #324 was opened from a-wai:

The earpiece speaker is a mono device, using only a single channel (in our case, the left one) from the DA0 output. This causes loss of information as the right channel is completely discarded when playing stereo audio.

In order to avoid this issue, set `AIF1 DA0 Stereo Playback Route` to `Mix Mono` when using the "Earpiece" output port (and only in this case).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/324
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/324.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
