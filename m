Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18545F94CCD
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2026 06:09:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D68760205;
	Wed, 22 Apr 2026 08:09:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D68760205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776838191;
	bh=29jITf+NU+deJAe7L2ekEr66K4i4HzYQwIcUXxN6LxI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YUVC1+pXAfB6uHBG+FBtUKP/mh301YvypHskq/IwF3y1KVERYBTIVzdZHMffj74LG
	 WSqM71zHbyzgZt/5o2ekHJsMg2BMy5lVfpdZWCfGsK11UE4wT/0p7M2RRg3K4dp42J
	 GAObX5O93/NfOZuAjgFq4PWiqTWxOXLjAtzGPiHE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0167F805F3; Wed, 22 Apr 2026 08:09:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8571FF805EA;
	Wed, 22 Apr 2026 08:09:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F8AAF80526; Wed, 22 Apr 2026 08:09:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 43B8CF8021D
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2026 08:09:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43B8CF8021D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a898e19b74a200-webhooks-bot@alsa-project.org>
In-Reply-To: <18a898e19b570600-webhooks-bot@alsa-project.org>
References: <18a898e19b570600-webhooks-bot@alsa-project.org>
Subject: Lenovo P16s G7 AMD MIC Mute LED Issue
Date: Wed, 22 Apr 2026 08:09:10 +0200 (CEST)
Message-ID-Hash: 47SBWZQEGWE33IWOB3ZDE63S7I7HDTKT
X-Message-ID-Hash: 47SBWZQEGWE33IWOB3ZDE63S7I7HDTKT
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/47SBWZQEGWE33IWOB3ZDE63S7I7HDTKT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #752 was edited from saba-kareem:

After fixing this issue(https://github.com/alsa-project/alsa-ucm-conf/issues/726) mic mute state is getting reflected, but LED status is not being reflected based on mic mute status.

We are able to manually toggle the mic mute LED status by following commands 

echo 1 | sudo tee /sys/class/leds/platform::micmute/brightness
 - Mic Mute LED turns on

echo 0 | sudo tee /sys/class/leds/platform::micmute/brightness
- Mic Mute LED turns off

It seems mic mute LED trigger event is not functional as expected.

For the legacy stack(No DSP enabled) Soundwire + PDM IO combination, since the ACP PDM Mic Mute control is linked with the HDA UCM, As per our understanding LED event trigger needs to be checked from HDA UCM perspective. 

@perexg could you please share your inputs.
@mrhpearson please add if we miss any relevant information.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/752
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
