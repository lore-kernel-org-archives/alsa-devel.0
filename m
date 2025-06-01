Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFC4C54FB3
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Jun 2025 16:03:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A060C601EA;
	Sun,  1 Jun 2025 18:03:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A060C601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748793807;
	bh=EZnbpdKCHkrn6M1rlfyzcdE4yGNeCJwzKISW8OwDpYo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HnjmorHnheW+ZThaxZKEg04JgEqjDpeAHtf0IlbNr2BDOLiQbktw9y24+N88IoL6y
	 1duA9n9eW6EUcIG5FAWBgN0k6SHlmsLwn0lpHMA1xQ0celJwYws7DOql3/giRllOll
	 mxsW8oHAqrjneK+HUunmmo97rSlnLQY1su6AGAA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3606F805C0; Sun,  1 Jun 2025 18:02:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A727FF805C0;
	Sun,  1 Jun 2025 18:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B85FF80269; Sun,  1 Jun 2025 18:02:49 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D2F3DF8013D
	for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2025 18:02:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2F3DF8013D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1844f6aa733f2a00-webhooks-bot@alsa-project.org>
In-Reply-To: <1844f6aa73329000-webhooks-bot@alsa-project.org>
References: <1844f6aa73329000-webhooks-bot@alsa-project.org>
Subject: Arturia AudioFuse support
Date: Sun,  1 Jun 2025 18:02:49 +0200 (CEST)
Message-ID-Hash: HZ74IENJ6MPSNVSQB5WRTDR6K33CZBVJ
X-Message-ID-Hash: HZ74IENJ6MPSNVSQB5WRTDR6K33CZBVJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HZ74IENJ6MPSNVSQB5WRTDR6K33CZBVJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #568 was opened from saaj:

I own [Arturia AudioFuse][1]. I am on Linux Mint and I got faux "Analogue Surround 7.1 Output" probably since Linux Mint 20. The version before that was property split input multiple devices in the system sound settings. Not a big deal, but occasionally I want just plug it in to listen to music on a good DAC and headphone (without setting up Jack and ingestigating XRUNs). I didn't find a simple workaround and just used Jack (in my instrument/recording setup).

I recently updated to Linux Mint 22.1 (based on Ubuntu 24.04) and wanted to explore if there's a solution, since LM's audio is now based in PipeWire. Out of the box I got the same "Analogue Surround 7.1 Output". After a lot of searching, I found that some Arturia products are already in my `/usr/share/alsa/ucm2/USB-Audio/Arturia` (alsa-ucm-conf 1.2.10-1ubuntu5.4). 

Then I just applied https://github.com/alsa-project/alsa-ucm-conf/commit/b68aa52, `cp Minifuse-12.conf Audiofuse.conf`, `cp Minifuse-12-HiFi.conf Audiofuse-HiFi.conf`, added an include in `USB-Audio.conf` and `s/minifuse12/audiofuse` in the files. `systemctl --user restart pipewire pipewire-pulse wireplumber` and viola -- I've got the split back! :-) I'm only interested in "Main Output L/R AudioFuse", which is working. The rest may not, and I still plan to use Jack for recording. But I'm happy to validate things on the interface.

Attaching my patch over Minifuse-12 for completeness.

[audiofuse.patch.gz](https://github.com/user-attachments/files/20541119/audiofuse.patch.gz)

[1]: https://www.arturia.com/products/audio/audiofuse/overview

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/568
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
