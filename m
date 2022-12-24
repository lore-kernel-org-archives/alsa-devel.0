Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BA8C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Dec 2022 10:32:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7CECAD6A;
	Sat, 24 Dec 2022 11:31:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7CECAD6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671877922;
	bh=XZi46/kY5JnAG62i3oPNbXYT0hv0xPaTi9kqsSqWKBA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kz6F3zvV1KSSf5bSSkrfa64fqQ+SRfcOd0JY02qOZE7UoFXp14XaV5JolxxW738DH
	 OvQQ0S/C9wnOPw+S94hBDZ0Mzm9tjl6Iz57Z6Ni+CtqMM3qYQcPTvB5WEqM+GP+aNU
	 mTTAY+bQRXkpIIe8TNSnPKGCKgXZZfvo0XMRVHpI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75361F8027C;
	Sat, 24 Dec 2022 11:31:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A6F3F8032B; Sat, 24 Dec 2022 11:31:06 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7F559F802E0
 for <alsa-devel@alsa-project.org>; Sat, 24 Dec 2022 11:31:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F559F802E0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671877861936239958-webhooks-bot@alsa-project.org>
References: <1671877861936239958-webhooks-bot@alsa-project.org>
Subject: ucm2: sof-essx8336: don't use disdevall for this device
Message-Id: <20221224103106.1A6F3F8032B@alsa1.perex.cz>
Date: Sat, 24 Dec 2022 11:31:06 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf pull request #258 was opened from mchehab:

disdevall causes undesired side effects on this device, as it breaks main microphone's detection, and makes hdmi outputs invisible at pavucontrol (tested with pipewire-pulse).

So, rely on cset to disable what's not needed at the enable sequence.

Fixes: 15a12508003c ("ucm2: put disdevall to HDA/Soundwire configs")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/258
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/258.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
