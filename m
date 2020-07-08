Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFDEC433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:35:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B0520772
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="McT5lEqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B0520772
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15D77950;
	Wed,  8 Jul 2020 23:34:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15D77950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594244122;
	bh=CE1lo+YuH068omvHJljcuDCpljxlXjdw1ydIac9WsME=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=McT5lEqRBz7HFXaFYbX8rU8quHkDbn0cZO9XRUBGZQUYY//IyFp6Unw4KCfz8NWNL
	 xOIO577als72xWqohfKKaOynJViZL71Bmy5yube0mJU2SiRpMDyZOL+ROPrwVPKtnN
	 //R+M0kET+vWxfJO2O3MxS0PYjsKdkkfK3vdnKns=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFF34F80150;
	Wed,  8 Jul 2020 23:34:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C70EFF8015A; Wed,  8 Jul 2020 23:34:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 434D6F800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 23:34:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 434D6F800AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1594244056746320963-webhooks-bot@alsa-project.org>
References: <1594244056746320963-webhooks-bot@alsa-project.org>
Subject: ucm2: Add config for Rockchip/rk3399-gru-sound
Message-Id: <20200708213424.C70EFF8015A@alsa1.perex.cz>
Date: Wed,  8 Jul 2020 23:34:24 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #39 was opened from alpernebbi:

This is the internal card for a number of ChromeOS devices based on the Gru board. Config is taken from ChromeOS sources [1] and modified to mostly look like Rockchip/max98090. Tested on a Samsung Chromebook Plus (rk3399-gru-kevin) running Linux 5.7+.

[1] https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/75cf7da335c11469956c84ddfa4e2ca73b268441/overlay-kevin/chromeos-base/chromeos-bsp-kevin/files/audio-config/ucm-config/rk3399-gru-sound

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

---

I've tested this on a Debian installation (with alsa-lib version 1.2.2) meaning I had to put the two files to /usr/share/alsa/ucm2/rk3399-gru-sound/ instead of .../Rockchip/rk3399-gru-sound, so I hope the latter is a correct path for them with later versions.

All four devices work, but I couldn't get the Speaker/Headphones to play different things or the Mic/Headset to record simultaneously, so I marked those pairs as "ConflictingDevice"s. Without that, e.g. I see all devices in pulseaudio, but when I play two different audio files to Speaker/Headphones sinks I hear an alternating mix of both files on both devices; and both Mic/Headset sources end up recording only from the headset microphone in an alternating way. 

Pulseaudio doesn't recognize the headset jack, but acpi_listen does report "jack/headphone HEADPHONE plug" events. I'll look into this more, my best guess now is that the kernel doesn't expose the jack in a way it should.

I also uploaded the alsa-info.sh output to cardinfo database:
http://alsa-project.org/db/?f=9b4102975fa9c0f109af6ad687c856c620d76909

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/39
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/39.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
