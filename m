Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB237F433C7
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2026 04:30:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18A40601F9;
	Thu, 16 Apr 2026 06:29:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18A40601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776313800;
	bh=y7ZB1XV5++2r0LhuIAX2pSplgZTwn8mYoT3ShnZBtuY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AZBGoMELw/jXUsEHYgeolBzv+fIvTbwVgA6FfNmOD/W05zdmJTI+VM9odF/KpqlPN
	 pFf2N5YrPulCwpbvT/lsmRyXAvEPD4ahu+F1nw2aHtt3J3Hbb3PfjMPinxtDTCyDlt
	 udqxyTNg5F8X0ha/+YgkPbvCAuFenp62vC38awiY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87962F805E1; Thu, 16 Apr 2026 06:29:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5024F805F2;
	Thu, 16 Apr 2026 06:29:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3BA85F8049C; Thu, 16 Apr 2026 06:29:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 56578F80071
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2026 06:29:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56578F80071
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a6bbf401b00100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/747@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/747@alsa-project.org>
Subject: ucm2: sof-soundwire: support dual-codec cs42l43-spk + cs35l56
 speakers
Date: Thu, 16 Apr 2026 06:29:23 +0200 (CEST)
Message-ID-Hash: 53YWX6QGJNM7ALBPW6GJPXGQPKRNUSHK
X-Message-ID-Hash: 53YWX6QGJNM7ALBPW6GJPXGQPKRNUSHK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/53YWX6QGJNM7ALBPW6GJPXGQPKRNUSHK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #747 was opened from pma1:

Some machines have both cs42l43 and cs35l56 speaker amps on SoundWire. Only the first spk: tag in CardComponents was handled, leaving the second codec without init, control remap, or mute LED.

Detect cs35l56 directly in CardComponents instead of SpeakerCodec1, and when cs42l43-spk is also present, initialise both codecs and extend the mute LED remap to cover all amp channels.

Toggle Speaker Switch in both device confs and set up cross-codec routing and mute tracking as needed.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/747
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/747.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
