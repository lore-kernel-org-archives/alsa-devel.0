Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE3CEB64DC
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Jun 2023 19:59:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A6A683A;
	Sun, 25 Jun 2023 21:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A6A683A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687723164;
	bh=CuctAUe1z9vu0LpwLjMOdvgNuOMVjRdbbPTBYMpRFao=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Q7pvaGPMUAEI5yvQl+CkSuJdZngxuCoTkKh4QpPru9/AxuQMI29piqUE+VFdfwWqX
	 CbvT9px2SXqdUYZHunaJA2mnhFOacKMaIxuV7GNxO1RrgmNTSjJymeKvorJa436zRM
	 hN0fK6NDI3aKLBPXoJa1qggmTKEkGqkdfpQUPDA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EE75F8027B; Sun, 25 Jun 2023 21:58:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F10BEF80093;
	Sun, 25 Jun 2023 21:58:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6979AF80246; Sun, 25 Jun 2023 21:58:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 0554FF80093
	for <alsa-devel@alsa-project.org>; Sun, 25 Jun 2023 21:58:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0554FF80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687723083460870028-webhooks-bot@alsa-project.org>
References: <1687723083460870028-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Add Steinberg UR44C
Message-Id: <20230625195807.6979AF80246@alsa1.perex.cz>
Date: Sun, 25 Jun 2023 21:58:07 +0200 (CEST)
Message-ID-Hash: A26ZFZVKLOKNGWHK4BEQ5KYNSZWGOLIV
X-Message-ID-Hash: A26ZFZVKLOKNGWHK4BEQ5KYNSZWGOLIV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A26ZFZVKLOKNGWHK4BEQ5KYNSZWGOLIV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #330 was opened from cyberchrime:

Adds support for the Steinberg UR44C. In fact, it is similar to the Steinberg UR44, but uses USB-C with USB 3.1 and has a different USB devnum (1730 instead of 1700).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/330
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/330.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
