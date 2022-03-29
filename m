Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF5DC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Mar 2022 23:07:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 598111725;
	Wed, 30 Mar 2022 01:06:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 598111725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648595218;
	bh=3uBCuCUbcCpzJkxJm8G4XpAhoiMUYpth2uNcp0pUgAg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BnD09hqvTw/iPNfTc5d1KR0CFojKlxlzhWMvZ9AoZV14i7riiUFwFjvpy4dLZtwY7
	 hMRmu9juuQ+LOgpisfi0nSoUpR+yPmz2aMfSRaDuxIcuef2pPdn/M9Gg9Nm1VZqUzG
	 zn6z11tS3SO8pMEuImG9KBgLU9B/JRxDVjZiVu50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6CE4F8014E;
	Wed, 30 Mar 2022 01:06:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7524BF80121; Wed, 30 Mar 2022 01:06:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B7EA8F80121
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2022 01:05:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7EA8F80121
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1648595158134198904-webhooks-bot@alsa-project.org>
References: <1648595158134198904-webhooks-bot@alsa-project.org>
Subject: Fix support for sof-essx8336
Message-Id: <20220329230605.7524BF80121@alsa1.perex.cz>
Date: Wed, 30 Mar 2022 01:06:05 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #144 was opened from mchehab:

There are a couple of issues at the support for sof-essx8336, causing it to fail working.

This PR fix them. Tested on Huawei Matebook D15. Before the fix, the device was appearing as "sysdefault:0" instead of "hw:0", and there were several other problems.

 After the fix:
- the device is now identified as hw:0;
- calling alsamixer without `-Dsysdefault:0` (or `-Dhw:0`) now shows a mixer (instead of showing nothing);
- The HDMI volume controls now appear;
- Using `alsaucm load` now works fine.

There are still a couple of things to be fixed, but I suspect that at least some of them would require firmware (or driver?) changes:
- the internal microphone is not working yet;
- the headphone/headset doesn't work.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/144
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/144.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
