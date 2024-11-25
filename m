Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E60CD59D68
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2024 19:52:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E812F83B;
	Mon, 25 Nov 2024 20:52:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E812F83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732564351;
	bh=MiIC0WWRQ3F+0De9lTCKuxPgPHnaXWxxcFRaA4uThBY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=stD9ABQ0viXYTCZFIo0cf9tQJzGoNKEaS340dfZ9n+UBWgBBA1uXktCLLZ63JdEMY
	 kYTb9JxBuBa8n0wuMw6G/tsqgRKc80ROcva8WCis7AMDSs+fT2wNfO3/UmU6cfV3ru
	 Q/RCsu0M9DxQ3MD3I1gGUyhrQHV92Cv/ABfOI8P0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 443DEF805BA; Mon, 25 Nov 2024 20:51:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1EBCF805B6;
	Mon, 25 Nov 2024 20:51:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F84AF80496; Mon, 25 Nov 2024 20:51:52 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E4C5F8019B
	for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2024 20:51:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E4C5F8019B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732564309704993010-webhooks-bot@alsa-project.org>
References: <1732564309704993010-webhooks-bot@alsa-project.org>
Subject: GoXLR not working in 1.2.13
Message-Id: <20241125195152.2F84AF80496@alsa1.perex.cz>
Date: Mon, 25 Nov 2024 20:51:52 +0100 (CET)
Message-ID-Hash: BNR6JD44E3WHI6OH4T47FUHVMI3BDXXY
X-Message-ID-Hash: BNR6JD44E3WHI6OH4T47FUHVMI3BDXXY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BNR6JD44E3WHI6OH4T47FUHVMI3BDXXY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #473 was opened from AruAki:

GoXLR not splitting into multiple channels.

`alsaucm -c hw:1 dump text` returns 

```
ALSA lib parser.c:270:(parse_syntax_field) Incompatible syntax 7 in USB-Audio.conf
ALSA lib main.c:1554:(snd_use_case_mgr_open) error: failed to import hw:1 use case configuration -22
alsaucm: error failed to open sound card hw:1: Invalid argument
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/473
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
