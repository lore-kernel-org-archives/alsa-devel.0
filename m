Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4E4CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:48:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5637601EF;
	Tue, 29 Sep 2026 20:47:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5637601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790707684;
	bh=u5f/SO9hNGS17X6FHiyPg6Nt/7LR1KRIYpYmcK3LD0M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Y3VhGipvIhxFoNXL5SOUGKBgwTQZzlXfRTJw3rAAMkYumTDAZ+e92OYIV5XmSbjmz
	 hUuH+Y0IilbThDnpbjclA/Z1FbKBDPxzJ2zUp50lVLTBwmRaOaKizxZqLdlb32gPR+
	 OaAJPaJRY40VPXPMGn8D2kAkZxdhxkcx7gwmNY/g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6421F805FF; Tue, 29 Sep 2026 20:47:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45899F8025A;
	Tue, 29 Sep 2026 20:47:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84415F8055C; Tue, 29 Sep 2026 20:47:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790707643;
	b=FZGjseYCpgLKpyeGFHAqs9kTvEac+QA781NQH0wVRq5HOshCMAon9+ga4wXjlrb4WEVF
	 KgsqtrfWIeJRgl+FbBGoXnenu/ldc98Gzs6bsXGymIb17o5Z3KPnlx8j0Z3yPrwU242HY
	 y3GxYsmM5QWM0neKOLjwq3skNQ+5FaAR4y2+gueUyS1nInJMsqd7XBPlMXy1n67mMlSEd
	 +nyu3i0wISgjgvLQ4EhjfQTGYzxMyZl+Rx2vfwrwAKc/gBjCmWozQ6BxQ/1MAbyBZUjU6
	 PgxNYsNP4hgII3vrJk62WfkGcbOwC9yEKenbtI7QUe3opk5IA8gxb8600yQZ/MX9lnQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790707643;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=u5f/SO9hNGS17X6FHiyPg6Nt/7LR1KRIYpYmcK3LD0M=;
	b=cortBUSI+0Uk1EMocFtlV9Pohz84TGQnK5gviCLeWRfdDyZ50GsUlsLOXip1eaUX5DxF
	 OiOAQ7Ihv87hha0FgGRQuoaUj5pKOLSTWJSDVlNr6v4zQjgaYUDuMTStoC+Wg3sFonjpQ
	 jOhfJkZ3q2KQO+YWUPEKyTaCaMLj+hdDXmlZfcGhpB0+E/V4FtzCvH7ptwYci2IYJQTQP
	 I9JgJjWAH5zzOLKTBM1rrUuzadA+bvV3Mk4NFlqx0BCYB0pcEIjaVjLlcN3VZAXmfcC4r
	 ahe0Af1s2GAM1L7YtW2V4QSmupqKx8+EkjIm9E3HEHDPCFB5ef/9NUJv/VAzgFC5hyQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B75D7F80448
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 20:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B75D7F80448
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d9df1cd9056f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/861@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/861@alsa-project.org>
Subject: USB-Audio/EVO4: correct naming scheme for Master Playback
Date: Tue, 29 Sep 2026 20:47:24 +0200 (CEST)
Message-ID-Hash: WPZ6PGGGYZNPAB3QOENYVX5QKIDR64MB
X-Message-ID-Hash: WPZ6PGGGYZNPAB3QOENYVX5QKIDR64MB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WPZ6PGGGYZNPAB3QOENYVX5QKIDR64MB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #861 was edited from fxzzi:

With the merge of https://lore.kernel.org/linux-sound/87bj9g19d6.wl-tiwai@suse.de/ , correct the name for PlaybackVolume as is done in snd-usb-audio, as well as add the new PlaybackSwitch, which will allow us to mute the interface in hardware.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/861
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/861.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
