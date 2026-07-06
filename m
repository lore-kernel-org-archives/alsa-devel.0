Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D03CC43458
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:24:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0BF86022F;
	Mon,  6 Jul 2026 16:24:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0BF86022F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783347867;
	bh=v80ShxfAB1JNdVksWI4u2Osc+1EplPpqsrHkjfEqLqc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tsDT7NQgQiN7td0ODgqD7WAUFrbt0IDN0wMkhcbBRDvV+p6gin20vOsz/3v3hPJce
	 j3yiRNCGnUhNspBGtr2qAkkxk2sAv3NlDjh22Tph/w3XZWojBmBy38H1gv3wEUioyZ
	 p2N6ghJNEmrg4isE5VypuUyvNN/6pE1lXslvKBxA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEC0EF805FD; Mon,  6 Jul 2026 16:23:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EA5DF805F5;
	Mon,  6 Jul 2026 16:23:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A169EF804FF; Mon,  6 Jul 2026 16:23:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783347826;
	b=Vhc7fuiPSyulPCy9K1xtxLbxbYlM2irR2N2mqK5SGEfxIvJgduRBbp3C9Alm4N6L8wQ8
	 BQtf0W4GtyGdJ/jMXob+5YlJcPBRqhP7W5B4Xe687PZ2/SM2sbLpVeb6Z0OqZEbY6cb8x
	 fUuHsIIXNFmkPmIU7pm68mfP6QVVzAqgWk6rBDGoNak8hhiFpTeeGyJPQZdXWBgA2i4kM
	 XN658V1iuUyZoqcroDqyCTx+hHZsPxVhSLRZAXHx7OLLmVFFHO52y+EKfiqT7fy/DQDE/
	 GKE61g0ISh8ObO9oydW0N2Q/yGJrcp0p4gKbztLQ7kMDXM04xvbdz2e4YRLXHMBrFNg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783347826;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=v80ShxfAB1JNdVksWI4u2Osc+1EplPpqsrHkjfEqLqc=;
	b=AcWQTbg6x38OQaObPM9D0r7uczdL+6xN0qfvZA6Jspbe5JXBnY/4zefkRU9Da91uha1Y
	 eU24/OEWYwrWJF0+Q9FcsjijSCOYiP9oVgI4JMU9vdy9uIVfIdB4XiPAPXjbbcxAMfuIV
	 W7cNrSmoJ/bdR+TiBwJ8RWpNsoN52U1gonYVrzP5DSTWa6pa3ZCkXx3QfYss13AlhDh5r
	 hAT9yAEQWGBEu5W7ub8JV3z6V0ZgSr00FE/d+SUWrFnLSkZpN85asTUGu6KSbdG/GOyb7
	 itiMtya65SB9BGXjfOS1ClnPltC8Vz8N4adojnQxqq4NSVPk08EiHpw6sO796om/W9w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 16DF5F8025A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 16:23:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16DF5F8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bfb965d858b300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/806@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/806@alsa-project.org>
Subject: rt721: enable capture switches by default
Date: Mon,  6 Jul 2026 16:23:46 +0200 (CEST)
Message-ID-Hash: ADK6TNMF4ICAA66GN3Z3O63HAQE6SVGO
X-Message-ID-Hash: ADK6TNMF4ICAA66GN3Z3O63HAQE6SVGO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ADK6TNMF4ICAA66GN3Z3O63HAQE6SVGO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #806 was opened from BenSharir:

Enable FU0F and FU1E capture switches in the RT721 init sequence.
Without these, DMIC and headset microphone capture is muted by default.

This matches the behavior of rt712 and rt713 codecs which both enable
their capture switches in init.conf.

**Hardware tested:**
- ASUS ProArt PX13 HN7306EAC
- AMD ACP70 SoundWire
- RT721 codec
- Card components: `cfg-amp:2 mic:acp-dmic cfg-mics:1 hs:rt721`

**System:**
- Fedora 44
- Kernel 7.0.13-200.fc44.x86_64
- alsa-ucm 1.2.16.1-1.fc44

**Before:** Microphone records silence; `amixer` shows:
- `rt721 FU0F Capture Switch`: off,off
- `rt721 FU1E Capture Switch`: off,off,off,off

**After:** Microphone works; switches enabled by default.

Fixes: #805

Signed-off-by: Ben Sharir <bensharir@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/806
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/806.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
