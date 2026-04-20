Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C19F5580B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:57:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2CC060202;
	Mon, 20 Apr 2026 12:56:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2CC060202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776682617;
	bh=F5F0hk4unMY9f9SWNkFGdVNf9cc7Nmd+IrFh6J/M7h0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=iXb18Tfc42iQ8eOGVsVrm2JnAkNWtpHYj2TOxzTjGVpFDEeq/uYJ+OH86etcQBmAt
	 SgpBr501vSyUN21EenrfP4E+Kn0WjW0kT8kJvMVhe0vNQD/VdPVtOgEBIJNlw1WV2T
	 WmmK/mC1cqRmMu3h/bsYQ7ddJu5kvK8zIyMCR/Mw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E89FCF805F1; Mon, 20 Apr 2026 12:56:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF43CF805E3;
	Mon, 20 Apr 2026 12:56:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D07BDF80524; Mon, 20 Apr 2026 12:56:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A10AEF8001F
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2026 12:56:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A10AEF8001F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a80b630d6a2400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/750@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/750@alsa-project.org>
Subject: Enable headset mic on kanaapali and sm8750
Date: Mon, 20 Apr 2026 12:56:15 +0200 (CEST)
Message-ID-Hash: N6PJQMIK3WM3HOG7MWXGYQ2HFLIUDKKN
X-Message-ID-Hash: N6PJQMIK3WM3HOG7MWXGYQ2HFLIUDKKN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N6PJQMIK3WM3HOG7MWXGYQ2HFLIUDKKN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #750 was opened from mohsRafi:

Enable missing Headset Microphone support on sm8750 and kaanapali mtp boards.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/750
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/750.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
