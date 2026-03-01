Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC5FFD0055
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Mar 2026 07:10:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 256AD60233;
	Sun,  1 Mar 2026 08:10:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 256AD60233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772349035;
	bh=KO1DOCr4EKMK0P28s3mGALSbBbRjQ+fgLP+SGdfq41U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VThjXBfN0zTgLtj8DjaUtUbEOvl9AjZgHjePWv0bl5mYxiYTYHe2Z4DoSeFzPu7E1
	 jIr4EUs6hPJmZwvsQVnWuUe1aZnXcGmHQhEDypGDzkfrRjNgmimjFeDRXCbJsBq49v
	 gqr6KXnD7hNOiRXOfZBnIOg9hUkeOruwxK2IcDcU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A52A5F805F9; Sun,  1 Mar 2026 08:10:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B629F805E6;
	Sun,  1 Mar 2026 08:10:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 824FDF80524; Sun,  1 Mar 2026 08:06:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E36D1F80518
	for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2026 08:06:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E36D1F80518
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1898a5d33004ef00-webhooks-bot@alsa-project.org>
In-Reply-To: <1898a5d330016e00-webhooks-bot@alsa-project.org>
References: <1898a5d330016e00-webhooks-bot@alsa-project.org>
Subject: ~/.config
Date: Sun,  1 Mar 2026 08:06:21 +0100 (CET)
Message-ID-Hash: HLNWW3RW3UD45NP7MLLWOJTQLRTSIAFI
X-Message-ID-Hash: HLNWW3RW3UD45NP7MLLWOJTQLRTSIAFI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HLNWW3RW3UD45NP7MLLWOJTQLRTSIAFI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #710 was edited from beatboxa:

Alsa has a long history, and I think as a result, there may be some approaches that may predate some of today's standards.

For example, I don't believe there are any configs stored in ~/.config/ like most other modern applications use.  Even alsa's overall standard user config is ~/.asoundrc 

This may make sense as alsa is a lower-level hardware driver; however with ucm it approaches the user space and has some overlap with systems like pipewire or pulseaudio.

Therefore, I'd like to recommend considering allowing ucm channel mappings to be stored in ~/.config/, which would override systemwide ucm mappings.  Perhaps it could be hierarchical, where the system looks for configs in:

- first looks at system directories (eg. /usr/share/alsa or /etc/alsa)
- then ~/.asoundrc   (for legacy compatibility)
- then ~/.config/alsa

Such that ~/.config/alsa is the override for the others.  Particularly for ucm2 (eg. ~/.config/alsa/ucm2/), since this is designed for the user/application layer.  

In other words, I'd like to be able to define ucm2 channel mappings in ~/.config/alsa/ucm2 , which would override those in /usr/share/alsa/ucm2 (in my distro).

One major benefit would be in surviving system or alsa package upgrades.  One challenge might be in order of operations, as downstream systems like pipewire/wireplumber or pulseaudio or jack often rely on alsa; however I believe these would still end up picking up user configs.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/710
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
