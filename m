Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9827FFD0055
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Mar 2026 07:08:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 108426022A;
	Sun,  1 Mar 2026 08:08:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 108426022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772348925;
	bh=2LIGwtGGnl9kapoXGiN2OVxsaWNvU4TNW2CmJGytLvU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fZgzapVP/+4UgQ4UF+UDF80kI4s3zY8v8anDdi4ZupZwC/RpUo6vJBtdHrollrCA2
	 vE4Ds4ot9gaFzTy9kbvfWQj5kaZMrP0M5p71HRMaMmmWi++L/dq2LixVhFCmgIm6cL
	 Epm0kRFsu6fEi/hPnAiWmKCWW+HO7t7kBHE3/O7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8AF51F805ED; Sun,  1 Mar 2026 08:08:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 370A6F805F0;
	Sun,  1 Mar 2026 08:08:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB299F80524; Sun,  1 Mar 2026 08:04:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A208EF8045D
	for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2026 08:04:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A208EF8045D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1898a5bd497fa300-webhooks-bot@alsa-project.org>
In-Reply-To: <1898a5bd48340300-webhooks-bot@alsa-project.org>
References: <1898a5bd48340300-webhooks-bot@alsa-project.org>
Subject: ~/.config
Date: Sun,  1 Mar 2026 08:04:57 +0100 (CET)
Message-ID-Hash: RIPQWCY2HFWKQPMJMGAQBW3DNYEJHSO4
X-Message-ID-Hash: RIPQWCY2HFWKQPMJMGAQBW3DNYEJHSO4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RIPQWCY2HFWKQPMJMGAQBW3DNYEJHSO4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #710 was opened from beatboxa:

Alsa has a long history, and I think as a result, there may be some approaches that may predate some of today's standards.

For example, I don't believe there are any configs stored in ~/.config/ like most other modern applications use.  Even alsa's overall standard user config is ~/.asoundrc 

This may make sense as alsa is a lower-level hardware driver; however with ucm it approaches the user space and has some overlap with systems like pipewire or pulseaudio.

Therefore, I'd like to recommend considering allowing ucm channel mappings to be stored in ~/.config/, which would override systemwide ucm mappings.  Perhaps it could be hierarchical, where the system looks for configs in:

- first looks at system directories (eg. /usr/share/alsa or /etc/alsa)
- then ~/.asoundrc   (for legacy compatibility)
- then ~/.config/alsa

Such that ~/.config/alsa is the override for the others.  Particularly for ucm2 (eg. ~/.config/alsa/ucm2/), since this is designed for the user/application layer.

One major benefit would be in surviving system or alsa package upgrades.  One challenge might be in order of operations, as downstream systems like pipewire/wireplumber or pulseaudio or jack often rely on alsa; however I believe these would still end up picking up user configs.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/710
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
