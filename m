Return-Path: <SRS0=uvWr=PX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9342DC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Nov 2021 08:08:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81E96109F
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Nov 2021 08:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E81E96109F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 538831685;
	Thu,  4 Nov 2021 09:08:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 538831685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636013334;
	bh=7wBWPUC3ijYVBCMwsE2Yvm2zU9deB0nYVWBkCQ17x7Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EyJhVefwb2bfbiqGM4vW39T2y0YdhNCy+sJU8nvLNKHi5tk5POLmWYVBw7KddnTgo
	 TL2Ccktf3rK1bxtpIIWpHX9veVJrxVSD8IWAIKzhuJ1iXwmfZMkIXxlxPONtjoxvtP
	 MQ7/zAE77TPmG8k9by+1AhW+fdIuXVd2t2KkhPx0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6104FF8027C;
	Thu,  4 Nov 2021 09:07:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A746F802E8; Thu,  4 Nov 2021 09:07:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9F55CF8025D
 for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2021 09:07:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F55CF8025D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636013255463222980-webhooks-bot@alsa-project.org>
References: <1636013255463222980-webhooks-bot@alsa-project.org>
Subject: Intel SOF HDA: Lenovo m920sff support (Realtek ALC 233)
Message-Id: <20211104080745.3A746F802E8@alsa1.perex.cz>
Date: Thu,  4 Nov 2021 09:07:45 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #114 was edited from perexg:

More info: https://github.com/thesofproject/linux/issues/3088

```
Simple mixer control 'Master',0
Simple mixer control 'Headphone',0
Simple mixer control 'Headphone+LO',0
Simple mixer control 'Speaker',0
Simple mixer control 'Front Mic',0
Simple mixer control 'Front Mic Boost',0
Simple mixer control 'Line Out',0
Simple mixer control 'Mic',0
Simple mixer control 'Mic Boost',0
Simple mixer control 'IEC958',0
Simple mixer control 'IEC958',1
Simple mixer control 'IEC958',2
Simple mixer control 'Capture',0
Simple mixer control 'Auto-Mute Mode',0
Simple mixer control 'Dmic0',0
Simple mixer control 'Dmic1 2nd',0
Simple mixer control 'Loopback Mixing',0
Simple mixer control 'PGA1.0 1 Master',0
Simple mixer control 'PGA2.0 2 Master',0
Simple mixer control 'PGA3.0 3 Master',0
Simple mixer control 'PGA4.0 4 Master',0
Simple mixer control 'PGA7.0 7 Master',0
Simple mixer control 'PGA8.0 8 Master',0
Simple mixer control 'PGA9.0 9 Master',0
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/114
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
