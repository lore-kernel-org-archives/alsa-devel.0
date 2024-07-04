Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2461AC30653
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:29:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3556614E4;
	Thu,  4 Jul 2024 20:28:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3556614E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720117749;
	bh=JujhFe59mhr8xS9BtyfacrfTUrmOPSDyMjq3PFl1uO8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CLxKYkrOhgqFlynxSaR4lYwWKOm3rsr8/d4iRsiLX0ihFDA6Ffp+VSF8JgEaQ7jeO
	 lpumgsyKSDf7AOFSI3A+X6N0Qs3bq5olXA1PtKYuVIMNAMgilv7XXUC6Ozi0e8JY9l
	 AVEWzXWnkXAwJ1b7oHwrpIMPvH/j5bIek9KJwkOA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B924F805B6; Thu,  4 Jul 2024 20:28:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE667F805B3;
	Thu,  4 Jul 2024 20:28:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1325FF8025E; Thu,  4 Jul 2024 20:28:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 07E9BF800F8
	for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2024 20:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07E9BF800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1720117699071914434-webhooks-bot@alsa-project.org>
References: <1720117699071914434-webhooks-bot@alsa-project.org>
Subject: [A52] Pipeware errors
Message-Id: <20240704182825.1325FF8025E@alsa1.perex.cz>
Date: Thu,  4 Jul 2024 20:28:25 +0200 (CEST)
Message-ID-Hash: BKOPPX7ZDFEDZDDPET5G2YTHD5NG5352
X-Message-ID-Hash: BKOPPX7ZDFEDZDDPET5G2YTHD5NG5352
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BKOPPX7ZDFEDZDDPET5G2YTHD5NG5352/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins issue #59 was opened from ManuLinares:

https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4085

I'm getting this errors:

```
jul 03 21:12:38 thought pipewire[63110]: ALSA lib confmisc.c:165:(snd_config_get_card) Cannot get card index for %f
jul 03 21:12:38 thought pipewire[63110]: spa.alsa: 'plug:{SLAVE="a52:0,'hw:%f,3'"}': playback open failed: No such device
jul 03 21:12:38 thought pipewire[63110]: mod.adapter: 0x5b856abf1c30: can't get format: No such device
jul 03 21:12:38 thought pipewire[63110]: mod.adapter: usage: node.name=<string>
jul 03 21:14:21 thought wireplumber[63111]: wplua: [string "alsa.lua"]:182: attempt to concatenate a nil value (local 'node_name')
                                            stack traceback:
                                                    [string "alsa.lua"]:182: in function <[string "alsa.lua"]:175>
```

could this be related to the this commit? https://github.com/alsa-project/alsa-plugins/commit/dfc65f2d1f239256c201c68b70a5d08e6afa879f

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/59
Repository URL: https://github.com/alsa-project/alsa-plugins
