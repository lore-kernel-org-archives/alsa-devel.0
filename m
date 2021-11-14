Return-Path: <SRS0=kuM/=QB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFFBC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Nov 2021 18:54:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC956109E
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Nov 2021 18:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BDC956109E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40A8515DC;
	Sun, 14 Nov 2021 19:53:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40A8515DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636916043;
	bh=XT2E9oh2RfpW25nKOx9Xb0vmNkEU2ClC5GZpzhSDwX8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aGsn5PMY5jbXVr0s3xqExZYPNmTj+lSfFDnE7VJH/wM+3Fho4LCiWlSXe18s1MuFT
	 8/BrGgn7qAGhdz7VznBZMznQV2Rv8I7oeXuP+QGne8fEotOJKXqiQ1wnXs0CY3xFdE
	 lS334gd9Ah81xOmuTNaylHshuLXlSe3Haq/SbECQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9051F80134;
	Sun, 14 Nov 2021 19:53:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 876BFF80272; Sun, 14 Nov 2021 19:53:10 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1C0DCF80134
 for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2021 19:53:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C0DCF80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636915981275537014-webhooks-bot@alsa-project.org>
References: <1636915981275537014-webhooks-bot@alsa-project.org>
Subject: HP Probook Mute volume + mic LED indicators not working (Audio codec =
 ALC236)
Message-Id: <20211114185310.876BFF80272@alsa1.perex.cz>
Date: Sun, 14 Nov 2021 19:53:10 +0100 (CET)
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

alsa-project/alsa-lib issue #190 was opened from antintin0:

Tested on kernel 5.13 and 5.15.2
Not sure if this is the right place to ask, but no one else seems to be able to help.
I have an HP Probook x360 435 g7 with the Realtek ALC236 codec and my mute volume + mute mic LED indicators aren't working (they do on windows). I found there were some patches mentioning mute LEDs on ALC236 on the below links:
https://patchwork.kernel.org/project/alsa-devel/patch/20210701091417.9696-1-andy.chi@canonical.com/
https://mailman.alsa-project.org/pipermail/alsa-devel/2021-November/192225.html

But obviously they're not working for me, so I tried following this: https://wiki.archlinux.org/title/Laptop#Audio_mute_LED
Theres nothing specific for ALC236 but I tried pretty much all the relevant parameters for the snd-hda-intel module option "model" under "ALC22x/23x/25x/269/27x/28x/29x (and vendor-specific ALC3xxx models)" and none worked.

Any help would be appreciated

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/190
Repository URL: https://github.com/alsa-project/alsa-lib
