Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181BAC77B7E
	for <alsa-devel@archiver.kernel.org>; Sat, 27 May 2023 11:16:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C1FB200;
	Sat, 27 May 2023 13:15:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C1FB200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685186201;
	bh=tmxAjQPNO9wb0DVyBoAkgF4+0WaqWh/HorZQiZThlac=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tuMXs93NiziQb/Gq5AQQm+awj3DcrcZDTLF8CZ7QsPA1aZyR9naiR8a9N+RUTYb2X
	 i+MVqVuNqI0YdzraVfsY4s7I9p5orEeQBw6uGgG+6wZXwk4JCXkDmnKpFMr7FFhzJO
	 lU05f+ASmP7B/kX+7MmtJS9Yw+leOBPG/S3rux/c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B72E7F80548; Sat, 27 May 2023 13:15:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67C57F80249;
	Sat, 27 May 2023 13:15:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 132CEF80249; Sat, 27 May 2023 13:15:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A516BF8001F
	for <alsa-devel@alsa-project.org>; Sat, 27 May 2023 13:15:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A516BF8001F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1685186132740300179-webhooks-bot@alsa-project.org>
References: <1685186132740300179-webhooks-bot@alsa-project.org>
Subject: Matebook 11 Intel 2021; always need to manually set config in amixer
Message-Id: <20230527111538.132CEF80249@alsa1.perex.cz>
Date: Sat, 27 May 2023 13:15:38 +0200 (CEST)
Message-ID-Hash: TMAAPLO6TVZ7PUN4UPMK3C62T7DWQJLK
X-Message-ID-Hash: TMAAPLO6TVZ7PUN4UPMK3C62T7DWQJLK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TMAAPLO6TVZ7PUN4UPMK3C62T7DWQJLK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #319 was opened from TigerbyteDev:

Hey, the drivers in sof got fixed but I still need to manually set the alsa config. My microphone also isn't working, not sure why. This got investigated a bit in the other issue too.

Config: ```bash
amixer -c 0 cset name='Headphone Switch' on
amixer -c 0 cset name='Headphone Playback Volume' 3,3
amixer -c 0 cset name='Right Headphone Mixer Right DAC Switch' on
amixer -c 0 cset name='Left Headphone Mixer Left DAC Switch' on
amixer -c 0 cset name='DAC Playback Volume' 999,999
amixer -c 0 cset name='Headphone Mixer Volume' 999,999
amixer -c 0 cset name='Differential Mux' lin1-rin1
amixer -c 0 cset name='Differential Mux' lin2-rin2
amixer -c 0 cset name='DAC Soft Ramp Switch' off
```

Issue in SOF:
https://github.com/thesofproject/sof-bin/issues/121

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/319
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
