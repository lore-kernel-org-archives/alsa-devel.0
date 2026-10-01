Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C3BCA5FB3
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:25:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 553926026C;
	Thu,  1 Oct 2026 06:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 553926026C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790828710;
	bh=MWU0xIkE4LozaqMui8KyiiMa5+NrbnIma8RxgawXubE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RkiFH88LTCbKvAtQxek+HjZ3Li1cGNn96xDkz03CJTbrpqY67t72NFp0klWEHVV2l
	 HZrlkB1GL1hmKzDySfLnCn+vQhPt04ugSlb337/6dXFLXp5caYMunRHNbeWXsuuvsA
	 wKB7Mb0T4o3Vr3FkunVrCbIiO8FQHWJVBfO6XQsw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D96F2F805FF; Thu,  1 Oct 2026 06:24:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44ABFF80601;
	Thu,  1 Oct 2026 06:24:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 252BBF8057F; Thu,  1 Oct 2026 06:24:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790828664;
	b=M5Ejsc+0Y6C732YeuuSCXaf4Cvafcy2+N37G4/iUYEiERIFuVqmbKt/UoOFfTWTCEwnC
	 ASaD/a5seB4O2sxoIiiPDxKQ0UaaW6/Wl1tU4c0nNKFnjtHNaJa1MABGSg7nUE8kzb+r0
	 NOdxzn6Ht2O5H9mESU/Hs2pK4VzZ//Z9Lt2M5y659R4PE7oeWgTzuYb6agA1jQT4brGgo
	 QQR5HYv5VA+C7SdtrtifhOuU3YW5AxHm8CfKylwAy+ZDGCzp2ZNbT08cwJzcGWFrx1ZEH
	 ulqzDq1rsO33z/g5u7UtNcK/OR+hWOh6uTmjlshT7fOB2sOuQ+N3zSnFyHatOo04uQQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790828664;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=MWU0xIkE4LozaqMui8KyiiMa5+NrbnIma8RxgawXubE=;
	b=jzGjRbFRzNCKghNDQtGZ7PFnceSvqYRSTuWZZbgA6ix3dUJNYgAkJnJjTBiqiQh9qrMK
	 JIh0TKyCXLzVqsiUw/MnN6zsJe7WG5t75fwWsOWLHySi0jiaCYmhyRHssomcO9nA8u704
	 szVmhSl1XRZB/Td9+ckPdijnHOGCjaSjhs67stmQ9z2+OVJYsWlUHgg8zogDrGw7Gv9VZ
	 aH2oyYIn3adPPeRTL6ll2WPNjMLP1c8pXcWS0UK2oF5Ztb41XD+k0JZN2slER50jE+kyL
	 c8EoJLkNDvJkFYIeoeltFtjJItoxYT9Uh57kSqoKx2j82DQE7b0xy+spYRxduRWjUsQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D060DF8011B
	for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2026 06:24:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D060DF8011B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18da4d2e5d9daf00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/862@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/862@alsa-project.org>
Subject: ucm2: MediaTek: add mt8901-soundwir for MT8901 SoundWire laptops
Date: Thu,  1 Oct 2026 06:24:29 +0200 (CEST)
Message-ID-Hash: ZFJVW64OKOVUTSNZ3DHZV3KQ5OGC45Y7
X-Message-ID-Hash: ZFJVW64OKOVUTSNZ3DHZV3KQ5OGC45Y7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZFJVW64OKOVUTSNZ3DHZV3KQ5OGC45Y7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #862 was opened from dcemin-nv:

Add UCM profiles for the MediaTek MT8901 SoundWire audio card (card driver "mt8901-soundwir", card name "mt8901-soundwire") as found in the NVIDIA RTX Spark laptops.

The card exposes no component string, so the dispatcher identifies the board by which SoundWire peripherals enumerated, through the sysfs device names the SoundWire core creates under /sys/bus/soundwire/devices, and selects a per-topology profile. Six variants are covered:

- 4x CS35L56 on link 0, CS42L43 on link 1
- 2x RT1321 on link 0, RT713 on link 1
- CS42L43 and 2x CS35L56, all on link 1
- CS42L43 and 4x CS35L56, all on link 1
- 2x RT1320 on link 0, RT712 on link 1 (two board variants, distinguished by the amplifier unique ids)

Each profile provides Speaker, Headphones, Headset microphone and internal microphone devices on the HiFi verb with the interconnect routes for that topology, and puts a default capture route in the verb so the capture PCM opens at profile probe time.

The kernel side (MT8901 SoundWire manager, AFE and machine driver) ships in the Ubuntu nvidia kernel for these systems and is being upstreamed separately. Speakers, jack and microphones were validated with acoustic loopback on each topology where hardware was available.

alsa-info.sh output is available on request.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/862
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/862.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
