Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA8FC982FA
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:39:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B493D601CC;
	Tue, 22 Sep 2026 17:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B493D601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790091591;
	bh=e9064dmLtXPIpbPgq0vdAhBqiEsQjb5F3krx6zq2ao0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Yt10aX7B5V4qLVUEfdTDU7ZSHoPVXtv61sKLPYtBLhWorJ3049PV+ATRjL5l2z99g
	 ojxW4H8i0zC695SgmVDDv+4O+u0XGwfIMlP52pmjBQ/3EBxlnlyJ8E9LpUzZxvWU8Y
	 B8ORu5CSfMRTXAf5tGVXs7yH/BDSeOfkGwQwsrJE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82EC2F805FD; Tue, 22 Sep 2026 17:39:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10945F805F9;
	Tue, 22 Sep 2026 17:39:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6980F8051F; Tue, 22 Sep 2026 17:39:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790091551;
	b=qj0VdgZyQiyd6WbT9I0H2unMhlgZ/zmXnQ8KeQ2cb20EfpMpe+4qxIy9iI9bFRGqqO5g
	 dt/rI2q3liFCxByAbJ3FgaLCpibkQEDX7oVjLmkMWVeNVxX4tDhwsMdlIDtYj5jq52xFm
	 spd/PR/6ACHXPLAT4v5DpXJj8oUV4dBfIHlHvsVGzXkXNGJDpkQ2brudhN11fgZmJv9Y3
	 cwVQa7vrFbs3Oq2gzNt8Hm9XR08MvR/l7AV2lSpooLNNGDMZjsxXn05FIsw9YwNHR4M/f
	 bInN29/HJf+Wya2Z/IeNd/7fC6hMsR6m6GuaBMiPT34/r8gwpbJr52SSIMTKIpD6R2Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790091551;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=e9064dmLtXPIpbPgq0vdAhBqiEsQjb5F3krx6zq2ao0=;
	b=TmEyMl84pjCrvaTFr5hj8Db2GnksL4kd7FG0MBQ6gRS+4VKR0/5Nu3r11yzi/UfMg8u3
	 oqaETD6cYHFy4HqX6NJM5vJhTZYemwe0I9tlaYLgo+t8xUGj9phwlso6gqs7pRi016EhB
	 0m4UA1N1AO+GPfUGTcTFLm1ssSwdWd18zB2vup0EqKGweC5shZNElHVie0kSAU2Njci3F
	 d2E5u3uZcirLUQgeH54QbFNHbqBqzJ/bqiPomGEwmLbVVGwvSBfbTRHZMLmx229ZK+kXp
	 3c8hnqVlhSHV86K0UFqBm05aAFCah9831/7bbgaHiBAmxDNjnCpT4gAxyuIgxP709PQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SkVHTBEQ;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EF1A0F800FA;
	Tue, 22 Sep 2026 17:39:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF1A0F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SkVHTBEQ
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 024D04361C;
	Tue, 22 Sep 2026 15:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117121F0089B;
	Tue, 22 Sep 2026 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091545;
	bh=jJ2dYp/XvskeEdM3P1iMUDkwcj/bYfhcJRRNYEn6Lus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SkVHTBEQaV4x4VLWjobsyTzLYeXPqxZCtoxW7HSaNThPHfWNrYWehqZXkAcxiiTjx
	 mKmLpAEoA37n/6R53/8F/7yjaXCF5eUDeO+2Knu6LKdsC5sJTyzr7DtSotc/3WF9VK
	 5E4+8se4hj8kY39Vxh/hAgvWzHgtrySgfOw1x+hlg05cJMmUk86nSZbKuNr4BFlPpm
	 rkbpipdpUjs1+xDFHJ0s+NQKtqwEhKq16xnUjPCvta7JoEj/W0x6wN38lJn7vkDsIx
	 jOV2MqGoQUU+lTtbfVPi3dbFX2bWVLHU2ohUP+wa11r7JgEbMpmDr6Hk4+VoOSG3Qc
	 eXRfAPcTrsXCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 6.1.y 0/2] ASoC: SOF: backport CVE-2023-54233 to 6.1.y
Date: Tue, 22 Sep 2026 11:38:55 -0400
Message-ID: 
 <2026-09-22-daily-reply-0002-re-asoc-sof-cve-2023-54233-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921193750.82134-1-artem@trailofbits.com>
References: <20260921193750.82134-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BPAT2FNUJJZBVNHF5225L73VLQUQOJOR
X-Message-ID-Hash: BPAT2FNUJJZBVNHF5225L73VLQUQOJOR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BPAT2FNUJJZBVNHF5225L73VLQUQOJOR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> The stable tag on patch 1 says 6.2+, but the same unsafe dereference is in
> 6.1.y. I kept the pair together and did not bring in the later topology
> refactors.
>
> Could you please queue this series for 6.1.y?

Queued the series for 6.1, thanks. Keeping the pair together was the
right call.

-- 
Thanks,
Sasha
