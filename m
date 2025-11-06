Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9F7CCFA05
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:12:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7CA7601F7;
	Thu,  6 Nov 2025 16:12:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7CA7601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762441938;
	bh=prvuB6uMaK1hUauWmJf4huTMC186m7fu84Px9xumt9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=laBh3tdJdFQH3+BE2VanG+imSvf9mkJBXqXySbuwuyUlkNQJElCCTk1wDQ1myihfO
	 8OD5y/J4YIDPbFGkP5YaHUvC5ZNDlH95RafDBO7wEDZCyZiT9O5bOpdl7kj+MN/R3X
	 G2a4g6FxI6O4jiL6vUus34BTPWIWVGFKuwyWHvtY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E16D4F805C0; Thu,  6 Nov 2025 16:11:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AF083F805D2;
	Thu,  6 Nov 2025 16:11:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC863F80272; Thu,  6 Nov 2025 16:11:36 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AF2B8F80100
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2025 16:11:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF2B8F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nqmr3c8I
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 33AE3618E6;
	Thu,  6 Nov 2025 15:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4865C116C6;
	Thu,  6 Nov 2025 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762441890;
	bh=prvuB6uMaK1hUauWmJf4huTMC186m7fu84Px9xumt9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqmr3c8IHkLVXI5bg56Mz9PG8+mkbxwgEkmO2y5g+bviZHrVTSUjpXnjJe+osjCwI
	 NgZfXG+mKYdsUM6heaWBSgmXLSdTjOjCg/qWf6Y8ygtdAFUB6wEchYQFpvZKk1YzBC
	 LUvmvpbHkE6XQRDGyxbHdkDtxtTlSKF9B3hNwqRrHmPUFVrCMrXnKvOCDrIbNI7bPT
	 2J8zETrjtoMMOmRDbaH2Ozzpc6TEoYcMKRlJozRNzzcKlW8GBfQBH9p+flrxNPKRr/
	 lrvKcLs1x03yxmpwi7Fsgkgm5kJ52Bw/LHgCdDxbp56iv9ghi0sMF4aompC/7Zhb60
	 tYle93BG6DTFQ==
Date: Thu, 6 Nov 2025 10:11:29 -0500
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "kailang@realtek.com" <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"perex@perex.cz" <perex@perex.cz>,
	Ruslan Nikolaev <nruslan_devel@yahoo.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Bug 220109] New: Audio disappears on HP 15-fc000 after warm
 boot again (ALC256 code path)
Message-ID: <aQy6oUX7THK_VhqO@laps>
References: <1064773772.509063.1747061777318.ref@mail.yahoo.com>
 <1064773772.509063.1747061777318@mail.yahoo.com>
 <87o6vxuauk.wl-tiwai@suse.de>
 <946767975.787038.1747111000631@mail.yahoo.com>
 <e182047c-ed7c-4fb1-bd61-fc0536b12b2e@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e182047c-ed7c-4fb1-bd61-fc0536b12b2e@leemhuis.info>
Message-ID-Hash: LOX4L52F3ECN5PB7NQIDCFE2GPEHPXAM
X-Message-ID-Hash: LOX4L52F3ECN5PB7NQIDCFE2GPEHPXAM
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LOX4L52F3ECN5PB7NQIDCFE2GPEHPXAM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Nov 06, 2025 at 10:34:44AM +0100, Thorsten Leemhuis wrote:
>Hi, top-posting for once, to make this easily accessible to everyone.
>
>@Kailang, @Takashi: The fix for the mainline/6.12.y regression this
>thread is about was afaics merged for v6.17-rc3 as f4b3cef55f5f96
>("ALSA: hda/realtek: Audio disappears on HP 15-fc000 after warm boot
>again").
>
>Greg's scripts despite the Fixes-tag for some reason did not backport it
>to various series that contain the culprit. Is there a reason for that?
>Otherwise we likely should ask Greg to pick it up.

We didn't pick it up because it doesn't apply to 6.12 or prior, nor is there a
stable tag on that commit :)

I'll backport it to older trees and queue it up.

-- 
Thanks,
Sasha
