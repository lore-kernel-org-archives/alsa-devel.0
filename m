Return-Path: <SRS0=20LX=PU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EFFC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Nov 2021 09:59:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9B960F58
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Nov 2021 09:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC9B960F58
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1D4116C1;
	Mon,  1 Nov 2021 10:58:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1D4116C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635760780;
	bh=I3uiSntjaIHmgV9RLNJxleVS5tsZAzTc1nMjhXDmFAo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DZ6xuDtBdDNBpqyiO1SjVDmWTi8NAxm+ovWnzk2xVC05+aVtER+IQnJmJkGjjf+zl
	 jMjrWEQrlGrBJOxOVoEUmoyfpfVLrbHERW8kSBBUcpx1+tyksNZZb9rvoWKc2UatwK
	 mCjxWqtV0EaJ9cw2huMc1j6GKpNjpiWkzbC16Xoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 630A2F8025F;
	Mon,  1 Nov 2021 10:58:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4899FF80269; Mon,  1 Nov 2021 10:58:49 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 721DAF800F8
 for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2021 10:58:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 721DAF800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1635760725163661003-webhooks-bot@alsa-project.org>
References: <1635760725163661003-webhooks-bot@alsa-project.org>
Subject: only have sound after mute and unmute and set volume in alsamixer
Message-Id: <20211101095849.4899FF80269@alsa1.perex.cz>
Date: Mon,  1 Nov 2021 10:58:49 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #113 was opened from amazingfate:

I have a x86 thinclient with debian bullseye installed. It has no sound in my headphone after boot, but I open alsamixer and then:
1, press M to mute the master
2, press M again to unmute the master
3, change the master volume from 100 to 99
After the above three steps I can hear the sound from my headphone.
Here is the alsainfo before and after the three steps:
[alsa-info_nosound.txt](https://github.com/alsa-project/alsa-ucm-conf/files/7452255/alsa-info_nosound.txt)
[alsa-info_sound.txt](https://github.com/alsa-project/alsa-ucm-conf/files/7452258/alsa-info_sound.txt)

I can see the difference in "Amp-Out vals".

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/113
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
