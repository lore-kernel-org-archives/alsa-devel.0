Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86813C61DFD
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:41:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15718601D4;
	Tue,  1 Sep 2026 00:41:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15718601D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788216106;
	bh=eMENB9Suqa90DdWZDOARhxRqTlmQr8bxp3dZGoVsUig=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hipUdKWBhYxO6+dpilkBzmRPnwJNgnVittGN4Sh3qKvVJLpwXmyerWI2oNfviKwfH
	 naPxZiwpSqeRBFZRmzONzN5wmXzVsTkpJKAxg29WcMzf+PYKJCIC/3SEmR/nvz2sTJ
	 wpRQ5Zsa5QtO6ap7WTPe8HXs5Z8GTSzrQlBJ6uFQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CABCF80601; Tue,  1 Sep 2026 00:41:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 104ACF805EE;
	Tue,  1 Sep 2026 00:41:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EE42F804CC; Tue,  1 Sep 2026 00:41:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788216062;
	b=axBQTY1/WZ0GR5CwA9XCRdlGN6UzCJPhmPM211E1TZzeLZ4qcsEbJqeqgqdm4sBP+Mp1
	 7RleHP2KnHkscX6g0061cjujVbRgg9VCH1Gwk1PENVT2zkEsRXqXa2sVYf5arvduR6krW
	 D+bax5jiwoXb5/i67fNr6cD/4pl9+pm+pRR01/7OtHDy8nrGF+xq50GnBUbn9/YpDNevi
	 NsETCmITuy/NzY811Bk11eL5xP948VbI8DxK3bo7UOPmO7Pl5TU2P6TYzNYD6o3FjpT3C
	 D+3ttzPgFkcmYb5tTSgMnEaAd6wS3u9Oq2Aeq03NpIqnsd/NtaBMZ/kRmRRxq2ucarA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788216062;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=eMENB9Suqa90DdWZDOARhxRqTlmQr8bxp3dZGoVsUig=;
	b=Lm/VLwTO0RKTW74usuIWg/lFReI4Mzg7+Dq10J1tibbvSt2AaUlNYUMwmoAoqUDx4evf
	 RZef14ozq75K0hjFue5+d9OyoNBRn1Njv7rn5sUhbh0mF1n0qA9QRV/AOXlIHGcsHwAhZ
	 ChDppmLAoqkAA0In59SVnpEBpJZpUB9T+devvIa95MrCzBS3gTrX2mufhXehVf5QCc7Ww
	 1ZpSa/mWp11TJQKYlm7uaGd/x+bePqVYb875WqjtMUB3EhixxMuSyMmEHSTcQBXArS2N/
	 ti6+WBjgcFJ6SYD5HvxX2al8DMd1NxmO24yWx2gS/y8GTLa1KoLd03RpNW63i/Wjn5Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A14DF80246
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 00:41:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A14DF80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d1050858849d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/847@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/847@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: add Microsoft Surface Pro 11
Date: Tue,  1 Sep 2026 00:41:03 +0200 (CEST)
Message-ID-Hash: OANQ6UFRX5JDIRVGFPWA6ZAGSSDPWML7
X-Message-ID-Hash: OANQ6UFRX5JDIRVGFPWA6ZAGSSDPWML7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OANQ6UFRX5JDIRVGFPWA6ZAGSSDPWML7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #847 was opened from dwhinham:

Enables two WSA8845 speakers, a two-microphone VA DMIC array, and two DisplayPort/HDMI outputs via the USB-C ports.

Devicetree changes for DP/HDMI submitted here:
https://lore.kernel.org/lkml/20260831-surface-pro-11-dp-audio-v1-1-fb9c0d3216b7@gmail.com/

Tested on a Surface Pro 11 with a HDMI display attached via USB-C adaptor. Switching between speaker and HDMI profiles works fine with PipeWire.

However, the DisplayPort audio IP is powered off while no display is attached, so PipeWire's probe of that PCM fails and the profile is dropped. Displays must therefore be connected before PipeWire starts:

https://lore.kernel.org/all/76b8ca1d-040b-472e-9804-5c0c0100b5b5@oss.qualcomm.com/

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/847
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/847.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
