Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6406BC5B552
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Jun 2025 18:59:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DA62601E5;
	Tue, 10 Jun 2025 20:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DA62601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749581962;
	bh=ZWEKmprNVf+9CHo6eSo5P+VPu2X1nKwh4UIgw7gYZJw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=M+CYzLbMZ9oyQNFbJF5DCGmjJsge3u0jEwjcCvDej7kw8U1bQIaH+o28M8X+B16RJ
	 Kl6I2pogzapejOFVUUurX41UXhZFgSsP0ybnk8R4wrCw4PAh95QH2ylPnHCnwFFCn4
	 WOhW/voWD1c5i7eHHlmofrPbeOjk+MNSwSUjV7AQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C791F805B3; Tue, 10 Jun 2025 20:59:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37C49F805C7;
	Tue, 10 Jun 2025 20:59:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FFACF8051F; Tue, 10 Jun 2025 20:58:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B14A5F8025F
	for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2025 20:58:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B14A5F8025F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1847c3802f71b200-webhooks-bot@alsa-project.org>
In-Reply-To: <1847c3802f6f8d00-webhooks-bot@alsa-project.org>
References: <1847c3802f6f8d00-webhooks-bot@alsa-project.org>
Subject: Asus Zephyrus G16 2025 GA605KM (AMD)
Date: Tue, 10 Jun 2025 20:58:57 +0200 (CEST)
Message-ID-Hash: R4MLVEI7QEUC5STMAVUYH6TZZFWWDR6B
X-Message-ID-Hash: R4MLVEI7QEUC5STMAVUYH6TZZFWWDR6B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R4MLVEI7QEUC5STMAVUYH6TZZFWWDR6B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #578 was edited from nefelim4ag:

[alsa-info](https://alsa-project.org/db/?f=eca30fae9c2bfca031f9cc921462dd7bc864d8fb)

I'm not too familiar with the audio stack to really make a fix.
>From my small investigation, it seems like there is no UCM for my card (generic_1):
```
~ cat /proc/asound/cards
 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xd0080000 irq 128
 1 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xb02c8000 irq 129
 2 [Generic_1      ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xb02c0000 irq 130
```

My issue is that audio control from KDE is borked.
![Image](https://github.com/user-attachments/assets/0636ad48-7edf-4de0-bb68-e8669e2ab5e2)

Instead of just adjusting the PCM volume, it adjusts the master, then the speaker, and then the PCM.
Other knobs seem to do no useful work, except the speaker balance (AMP1/AMP2).

(also, I'm not sure that master and speaker actually do what they are named; they both seem to just make the sound "dull")

I can clone repo, test PR & etc.

Thanks.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/578
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
