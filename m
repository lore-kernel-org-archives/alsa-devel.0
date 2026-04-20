Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D126CF588C2
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:22:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4861C60216;
	Mon, 20 Apr 2026 15:21:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4861C60216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776691324;
	bh=fHiAqfG6BLI6sL2Pft1JhS0A8dnJa9d+5OvZKcRFlmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FOoiU24QHpX34GG38IJ4lDL+5FO3Of2mEsJVkun+Lrzo/xhHfbOqNVn3ahu6XAOcg
	 SDBXDUC4WHY1ppc0CXzgLnMPY8KJSGzkL9pYEePTtKYDGbQhnnlDeVa0Y9IL8TmoUe
	 qnFRx9gDUsYT9hL6WEsjwo0hwrldztHduYYjk5Q0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EAADF805EE; Mon, 20 Apr 2026 15:21:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E5DEF805F1;
	Mon, 20 Apr 2026 15:21:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06F10F80524; Mon, 20 Apr 2026 15:21:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 76318F8001F
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2026 15:21:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76318F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=e0Hwmycs
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 600C460142;
	Mon, 20 Apr 2026 13:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A38C19425;
	Mon, 20 Apr 2026 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691282;
	bh=fHiAqfG6BLI6sL2Pft1JhS0A8dnJa9d+5OvZKcRFlmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0HwmycsjbRiU8EuD4BWKxFK11kr8AFRy2g7hkrwtCL9i176yWvfZmWutwFS0JrB7
	 Jn6kcDXDJUQqf1R/pA0uRY0RqRh3OTdkkxeAx5/Ee6xpTKomVnJvRGhjLZBS+AdSDp
	 DWAw+1mWBT+USliMfEPMlZOo/ZHdZdZQ04wK8SOYH9WLNpbgoQ+Y4PCfyxkNc3Hd0l
	 bZ60tRfQQ79QZvBOXdSl6w0XJq2ZLFK81OXa3rtwt8OTGTQdd30PpTPCPi+h8Xensz
	 QJpO4e4NyG8PHN23EgxAkF4AKUbpm/8nM7A7mr0YhgwJfnH4QxDRRHvKxKvqJ/9i+N
	 E7GouStDi2Wiw==
From: Sasha Levin <sashal@kernel.org>
To: Wenshan Lan <jetlan9@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6.1.y] ALSA: usb-audio: fix race condition to UAF in
 snd_usbmidi_free
Date: Mon, 20 Apr 2026 09:21:02 -0400
Message-ID: <20260420-stable-reply-alsa-usb-audio-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417084516.464-1-jetlan9@163.com>
References: <20260417084516.464-1-jetlan9@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ALIOC2KFS2NZ6NHYIL4K3J5IMIBLESBC
X-Message-ID-Hash: ALIOC2KFS2NZ6NHYIL4K3J5IMIBLESBC
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ALIOC2KFS2NZ6NHYIL4K3J5IMIBLESBC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Apr 17, 2026, Wenshan Lan wrote:
> Backport of 9f2c0ac1423d ("ALSA: usb-audio: fix race condition to UAF
> in snd_usbmidi_free") to 6.1.y.

Queued for 6.1, thanks.

--
Thanks,
Sasha
