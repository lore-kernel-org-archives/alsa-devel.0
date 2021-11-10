Return-Path: <SRS0=1gO0=P5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99570C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 13:24:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F004561246
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 13:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F004561246
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EA031614;
	Wed, 10 Nov 2021 14:23:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EA031614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636550640;
	bh=WNhAbHwlEvgQJLgG9JQ0PhdzzzEYp8LNxu4SasB2fAQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=otW8AZ569tvvexMJ85fUHr4Jbj1WvJrb/7/GupYoi5ldXALyHYybsL8aLL0ncxxIa
	 FSIs4NRvUiy+JKkn/uMl9cy2YMo/Zvuo2tGBJfwDLy9QftZZ2OTUxj+ksjwD4Ib5G6
	 E2SPnRiCXmHIGz48KO21NrMGDCdV64OckhN06+Z8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A0E1F80054;
	Wed, 10 Nov 2021 14:23:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01BA6F8049E; Wed, 10 Nov 2021 14:23:01 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 950BFF80054
 for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2021 14:22:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 950BFF80054
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636550572299650908-webhooks-bot@alsa-project.org>
References: <1636550572299650908-webhooks-bot@alsa-project.org>
Subject: ucm2: Add support for SC7180 Trogdor Lazor Chromebooks
Message-Id: <20211110132301.01BA6F8049E@alsa1.perex.cz>
Date: Wed, 10 Nov 2021 14:23:01 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #118 was opened from kholk:

Almost all Trogdor Chromebooks are using RT5682 for headphones/headset
on 3.5mm jack, internal microphone and headset microphone, and MAX98357A
for the internal speakers (Lazor and Limozeen).

This adds support for the sc7180-rt5682-max98357a-1mic sound card found
on the aforementioned Chromebooks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Tested on sc7180-trogdor-lazor-limozeen-nots.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/118
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/118.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
