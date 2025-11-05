Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE11CCFA0D
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Nov 2025 21:58:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 119C760202;
	Wed,  5 Nov 2025 22:58:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 119C760202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762379929;
	bh=4XfEzJMFTsQsv2VHiliqUmWShtKHaSIuU5ICfF4L5d0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=INHOWFTACqQarfx6frS1bquftSdFjF+LRN8ZOoA8U2zLjjaHqsi8FCQ6tMiz2BYQB
	 AeflrxD4s6aVOQSSnKQn0P6tMnIKFtQrhhvIjnCG1NFuxGwRGCW9rTFaR1Hmm6eXbY
	 BtUlCN5EpZzgXZiosA0lGlbPGycT668//rLRuuPU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EBB6F805B4; Wed,  5 Nov 2025 22:58:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6AC9F805D3;
	Wed,  5 Nov 2025 22:58:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89672F8020D; Wed,  5 Nov 2025 22:55:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D7F9AF800FA
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2025 22:55:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7F9AF800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18753b096ae79d00-webhooks-bot@alsa-project.org>
In-Reply-To: <18753b09659aec00-webhooks-bot@alsa-project.org>
References: <18753b09659aec00-webhooks-bot@alsa-project.org>
Subject: MOTU UltraLight mk5 USB mode switching
Date: Wed,  5 Nov 2025 22:55:45 +0100 (CET)
Message-ID-Hash: PLTATM2V6ZOTDCV6RMFS3F4TE2IR2UXJ
X-Message-ID-Hash: PLTATM2V6ZOTDCV6RMFS3F4TE2IR2UXJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PLTATM2V6ZOTDCV6RMFS3F4TE2IR2UXJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #635 was opened from TeeTeufel:

Hi,

I am currently stuck getting higher sample rates work with the MOTU UltraLight mk5.
Automatic switching between 44.1 and 48khz works fine, but anything higher not.

For 88.2/96 khz and 176.4/192 khz the USB mode must be switched, but nothing happens.

When setting the sample rate on the audio interface itself, audio output stays silent.

**System**:
- Fedora 43
- Pipewire
- Latest firmware on the interface

What do you need from me?

Could this be an issue with pipewire rather than alsa or ucm?
If yes, do you maybe have any resources that could give me some hints?
Consulting existing issues, forums, chatgpt and perplexity did not result in any improvement.

Thank you very much for anything that could help.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/635
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
