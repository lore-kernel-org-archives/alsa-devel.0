Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00285606A321
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=hcXBkZC+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VErdOrfr
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9028601EC;
	Mon,  9 Nov 2026 15:57:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9028601EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236268;
	bh=iimiuuNag2wtVPDLPPbNdiQcTKjZe37XdcOGcsSwAHI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hcXBkZC+e7rldrAQOJoiH6RQaNTWvxCCIhnZFtTnjnKQoyGM2UMaFK7eEGlA/dJle
	 c2vzKPO13+iXMjy1QQ9RO/AtFywiEnPoDdW6rAZdfx6L1C1rIxWsdhK2ihAUwHVD/R
	 hcaDfi4HPb5nVCce1Em2kXmrI3vX3Whe1xiPK4Fg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D539BF805FC; Mon,  9 Nov 2026 15:57:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16F77F805F9;
	Mon,  9 Nov 2026 15:57:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11662F805C7; Mon,  9 Nov 2026 15:57:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794236227;
	b=Zi4k8yRPexUXmT8N5YKVoNH/Q0RiqnNGRsblsUNBXGJDfYd5Wq90jsO/dpsWg5TdxS7+
	 xBm8eGErI6hoPQ8sCqf0V9vLF5oFX8ck6kXOnkekaMvEClYeMxHFT1+PKi/XFbelgeeo4
	 m04pcQ4uscR2l1elZihGkLPfWB0WnI8xMq6T1RYpl5PvHG4wNjADO9QZBwGdlk+e45nLJ
	 0gWkWBqoUSRgq6TCeak671/zTbeW2BdtXrlzJsOmJyNpz6nT08NTR0jgeQ04oJzk2Y9mA
	 P3bT1kSe3+AFyC2SKGhK+6WQQNJoZ4wKMnFDeOFy43VudSUd1naML0xnuh6haW3zSpQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794236227;
	h=DKIM-Signature:MIME-Version:Subject:From:To:Date:Message-Id;
	bh=iimiuuNag2wtVPDLPPbNdiQcTKjZe37XdcOGcsSwAHI=;
	b=py80m0jzGsyYiXvvMJLtwjv+o/m4n+G7xM/m9zc2e5sogMhVLVmJ0K4sFPJ8krWpv+6N
	 M4NUHdQY/Tk8S6G9kKI9B8c7pu3/g3qt1eDzKMPbJT5bptssnoKgO0KRLdCglhOa40ovF
	 WT7d8CzpT8lWk2rmRdrRVd+OZmYt7ksFwM118TZPTK25ufSdQbBVZuiaiCKktNszrRisA
	 4ahGsf65vwcQg3bbJ26ht7rTlTBnpSDcPgPHCMw58EvI+GkD+gOkN4aMvcC/7AMDA1vmc
	 NstCKlU7Avh2tNFXSt2xXsr7vy3WrWpQmbmJf0/QpnKknMvs/SdBQf4dQJkxASt7osw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VErdOrfr;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06AA5F80124;
	Mon,  9 Nov 2026 15:57:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06AA5F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VErdOrfr
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2217F618FD;
	Mon,  9 Nov 2026 14:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A21F0089F;
	Mon,  9 Nov 2026 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236221;
	bh=y3Edryvb/99jgZMAk0x9cx0kGcMK+bKUAbn6GHciJAc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VErdOrfrOjE5zTQR4RL5qa3x8Gx06PwDUYXBiJvogjcO3MHStv1NmesmtYXwrnz/u
	 Tz8A68c4007AZoJweBe2OeTXplbRpvK4O1+G/XAYAGmuP5UNWRruBsVzL4BLfgk2pY
	 EUEtKqhLh+5n2jDybfiLSlWVFJ/YbUklKHxo6X2r1T7wHF5kMbqlbGsXxsoVsB5qyV
	 nhyp1+jsN7AaXbgPcwl5LUPBxp+ZDG+BCbidUghpyYLdSUMoYTlWuD22Ynnl7TT3W2
	 OwOQqIJv3tv1HhUcNYwFHA+HtPdFROnCkvk7+AuR8LHChivfJeIy66Ukir22mg2cpy
	 4G2eFuBFaJ9gg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 67D7C2EC581C;
	Mon, 09 Nov 2026 14:56:59 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] ASoC: amd: fix IRQ handler races in AMD SoundWire
 drivers
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 yung-chuan.liao@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Syed.SabaKareem@amd.com, Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 Poojitha.N@amd.com, lee@kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
In-Reply-To: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
References: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
Date: Mon, 09 Nov 2026 14:56:57 +0000
Message-Id: <179423621776.3711751.3620606745077536802.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=740; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iimiuuNag2wtVPDLPPbNdiQcTKjZe37XdcOGcsSwAHI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+3rc+vPCpHHPi/Fkz2h/bF+XlqQZWfyoJTFbh5L7Kw
 qdf+Mq8o5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABO51c7w38PcVc5V3n4fg5n1
 Vzdrhvy7q90fh045OC2qYTPLxRkSjgz/3eb83Jx13aa+T0T9ksvzHOcq12l/XSwzRDqFaj2PXp3
 IBAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 5RQUXDVU5HB2ZOYT6XAXDLICPQW5X6VK
X-Message-ID-Hash: 5RQUXDVU5HB2ZOYT6XAXDLICPQW5X6VK
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5RQUXDVU5HB2ZOYT6XAXDLICPQW5X6VK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> Patches 3 and 4 guard schedule_work() calls with the interrupt_enabled
> flag so that an in-flight IRQ arriving while the SoundWire manager is
> being torn down does not queue new work after amd_disable_sdw_interrupts()
> has cleared the flag.

> NOTE: Patches 3 and 4 depend on the following patch which introduces the
> interrupt_enabled field in the AMD SoundWire manager:

>   https://lore.kernel.org/linux-sound/20261107154659.3358223-18-Vijendar.Mukunda@amd.com/

> Until that patch is merged, patches 3 and 4 should not be picked up
> independently.

Please try to avoid mixing in things with differing dependencies into a
single series, it makes things much harder to track.

-- 
Mark Brown <broonie@kernel.org>
