Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F59ECE8D6B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Nov 2025 22:39:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79A5C601CD;
	Mon, 17 Nov 2025 23:39:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79A5C601CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763419186;
	bh=U5cYZMh7sSmfKc3Gx4lQBDjpGiaPVOFevTgwdlHrAgs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BlMW1ao0M3CbtIXChkfeS29IhkBSSi0RRyTYwYqI5hFhZ6YpmxEYHNcIgnNKrmIwt
	 1djpod1t7YCh44wvQYHSL1ipIbmPsTc/PMPgtVpYliJDj2D9wAjj2rwZEKz4y0CfjD
	 nH3BuyaSTijT1kLM/zjJAdsqmUHiceYEsg3FaCec=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1ED67F805D6; Mon, 17 Nov 2025 23:39:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CAEE2F805D7;
	Mon, 17 Nov 2025 23:39:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EDFBF80551; Mon, 17 Nov 2025 23:39:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 855F9F80152
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2025 23:39:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 855F9F80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1878ec5f132a3000-webhooks-bot@alsa-project.org>
In-Reply-To: <1878ec5f1319a300-webhooks-bot@alsa-project.org>
References: <1878ec5f1319a300-webhooks-bot@alsa-project.org>
Subject: Lenovo Yoga Pro 14 built-in speakers volume not controlled by
 GNOME/PipeWire
Date: Mon, 17 Nov 2025 23:39:09 +0100 (CET)
Message-ID-Hash: XOLKXS474T5EYF6U3KKZEEJPJHNYLOIJ
X-Message-ID-Hash: XOLKXS474T5EYF6U3KKZEEJPJHNYLOIJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOLKXS474T5EYF6U3KKZEEJPJHNYLOIJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #642 was edited from 2O77:

Device: Lenovo Yoga Pro 14 14IMH9
Sound card: sof-hda-dsp
Problem: ALSA Post-Mixer / Pre-Mixer controls work via alsamixer, but GNOME volume slider or PipeWire sink volume does not affect hardware output. Likely an issue in the UCM profile for this device.

Steps to reproduce:
1. Boot any Linux distribution. I tested on Fedora (GNOME and KDE) and openSUSE Tumbleweed, but it will probably occur on other distros or desktop environments as well.
2. Attempt to change volume via GNOME slider or `pactl` / PipeWire controls.
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

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/642
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
