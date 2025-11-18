Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF1DCEBF97
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:59:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 015556020F;
	Tue, 18 Nov 2025 15:59:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 015556020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763477953;
	bh=mldAwlD3pnnfZ7HnfGudhZU7YB2CXuI20s3Iea1inXE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RR/MaWqZgbjuVze8zCLI8SicLsGZE0+0arwMlrgaHHt6lhytChfbiLZEYf/KQ7f+p
	 sTDK5iUOAharCPnknG9L9U4L8dQ8m7X3kfXT5S8yTGokks4n1cGB7xoNDa0lSjexDA
	 1TrlT+jPLjUYzcF90q1+xh8tTgETpMZUYpNKeHhA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8C94F805D6; Tue, 18 Nov 2025 15:58:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6887BF805D6;
	Tue, 18 Nov 2025 15:58:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18119F804B2; Tue, 18 Nov 2025 15:58:34 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 81BBCF80088
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2025 15:58:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81BBCF80088
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187921d14de34700-webhooks-bot@alsa-project.org>
In-Reply-To: <187921d14d888000-webhooks-bot@alsa-project.org>
References: <187921d14d888000-webhooks-bot@alsa-project.org>
Subject: Lenovo Yoga Pro 7 built-in speakers volume not controlled by
 GNOME/PipeWire
Date: Tue, 18 Nov 2025 15:58:34 +0100 (CET)
Message-ID-Hash: GEJLQ4PN5RZFDWN2GTCGKMAV4Z43DQU6
X-Message-ID-Hash: GEJLQ4PN5RZFDWN2GTCGKMAV4Z43DQU6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GEJLQ4PN5RZFDWN2GTCGKMAV4Z43DQU6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #642 was edited from 2O77:

Device: Lenovo Yoga Pro 7 14IRH8
Sound card: sof-hda-dsp
Problem: ALSA Post-Mixer / Pre-Mixer controls work via alsamixer, but GNOME volume slider or PipeWire sink volume does not affect hardware output. Likely an issue in the UCM profile for this device.

Steps to reproduce:
1. Boot any Linux distribution.
2. Attempt to change volume via GNOME/KDE slider or `pactl` / PipeWire controls.
3. Observe that output volume of laptop speakers does not change.
4. Testing with headphones (AirPods, Beats) or external speakers works correctly.

Notes:
- This issue is specific to the built-in laptop speakers.
- Different desktop environments (GNOME, KDE) and distributions (Fedora GNOME, Fedora KDE, openSUSE Tumbleweed) were tested and exhibit the same problem.
- ALSA `Post-Mixer` / `Pre-Mixer` controls work correctly when adjusted via `alsamixer`.

Expected behavior:
- GNOME / PipeWire slider should affect the actual hardware output volume of the laptop speakers.

Suggested area:
- UCM profile for sof-hda-dsp on this Lenovo model may need adjustment.

I first create an issue on pipewire and they directed me here with this outcome: 
Which mixer controls are used for the volume is controlled by the card UCM profile, so this is probably bug in the UCM profile. Its issue tracker is here: https://github.com/alsa-project/alsa-ucm-conf/issues

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/642
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
