Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D4ED42BA2
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:14:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16CBD1930;
	Tue, 12 Nov 2024 17:14:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16CBD1930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1731428065;
	bh=GqU3TQSVIpGc6ET631wTMuyIdP/l8quS4X5eTqRFIwA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QDH8Aj+XEg7jthN5FhcAKJ17k/hIx0/PUgbmq2NJtTP/GU2xwRwz0qjqDDG1Va2Xw
	 UkujgPltwE06ri6I3faSAwyWP27T/oBYBr6msDipoQ7GfELLYv0k2RG+OW2D0W7Y+x
	 CUojgCTIbljmjl8xJGSSmIawHf0IFV9mSCs2FEUs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5748F805B1; Tue, 12 Nov 2024 17:13:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 51888F805AA;
	Tue, 12 Nov 2024 17:13:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A26E0F8058C; Tue, 12 Nov 2024 17:13:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B2E6F802DB
	for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2024 17:13:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B2E6F802DB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1731428020820724726-webhooks-bot@alsa-project.org>
References: <1731428020820724726-webhooks-bot@alsa-project.org>
Subject: ALC4082 - ASRock X870 Steel Legend
Message-Id: <20241112161345.A26E0F8058C@alsa1.perex.cz>
Date: Tue, 12 Nov 2024 17:13:45 +0100 (CET)
Message-ID-Hash: ZICWOAQ7CKRZ33PKRUZS3NEYXXH5Q72W
X-Message-ID-Hash: ZICWOAQ7CKRZ33PKRUZS3NEYXXH5Q72W
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZICWOAQ7CKRZ33PKRUZS3NEYXXH5Q72W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #462 was edited from cybik:

| Following up | Relevant PR |
| ------------------| ---------------- |
| https://github.com/alsa-project/alsa-ucm-conf/issues/334 | https://github.com/alsa-project/alsa-ucm-conf/pull/461 |



The card "works", but there is one feature missing - though I hesitate to call it "critical": S/PDIF / TOSLINK support is incomplete.

While sound works "fine" (ish), it's limited to 2 channels.
* Plugging in another USB device (CM106-type, for example) gives out a plethora of configuration options (per the screenshot), though this also comes with having to select the right output
* The "USB" audio outs (edit: *for the ALC408x*) are output-specific, which is VERY welcome, but the S/PDIF out does not allow for any advanced selection like "Supported Codecs", and the HiFi 5.1 and 7.1 do not appear to enable any IEC958/AC3 support in the background

Is there something missing in the config files to allow for such support?

![image](https://github.com/user-attachments/assets/906ea829-0210-49a8-ba16-ad1b5b1285ae)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/462
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
