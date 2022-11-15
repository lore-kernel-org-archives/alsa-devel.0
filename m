Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07BAC4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Nov 2022 09:58:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9845E1695;
	Tue, 15 Nov 2022 10:58:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9845E1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668506336;
	bh=lCwmI2hziEzO2zFoLPFI8Pe7KlSgGh8cPGHQSVLnzpE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vhtjy1zdA42NEM/YKAqn2/bwqdm5Ac5NzOxCFkjHapxhXQh2GWUq4PPl0J+IzvJf2
	 V1pU2kTbDrgdyaJXDA04vE5+0IqJ6MOwQsLNjieEXLKxJaAclVgK+xGJv1oe/V6JMb
	 XTHcx1GeKVyfeYbsHhNkDZE2abBrMQ5g7xDA7Kf8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53DEEF8016D;
	Tue, 15 Nov 2022 10:58:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21517F800AA; Tue, 15 Nov 2022 10:58:04 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B303EF800AA
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2022 10:58:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B303EF800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1668506281344060898-webhooks-bot@alsa-project.org>
References: <1668506281344060898-webhooks-bot@alsa-project.org>
Subject: aplay: Fix parsing of format with WAV_FMT_EXTENSIBLE header
Message-Id: <20221115095804.21517F800AA@alsa1.perex.cz>
Date: Tue, 15 Nov 2022 10:58:04 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils pull request #178 was opened from amadeuszslawinski-intel:

WAV_FMT_EXTENSIBLE header contains valid bits per sample, which can be different than bits per sample. Make sure it is taken into account when parsing headers and choosing playback format.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/178
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/178.patch
Repository URL: https://github.com/alsa-project/alsa-utils
