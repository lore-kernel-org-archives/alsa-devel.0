Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7132E7717F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:52:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BA5C14E1;
	Tue, 10 Dec 2024 15:52:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BA5C14E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733842339;
	bh=vcFRyMq2LgyT/jZlk9FVwHCu7zwyckkYnKycWPJr6ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bd6dtRWIG6PWkT30IF4TEzbctJ5i0UrhFP8cDNbYMjO5DIqYHzdg/3kSTOffu1+js
	 nL6Ujv2nFgF/xevOnMGBHtQyxAPuPXFe39/sjLjGSUBPKOn2Mozp7z7dNVstbFecOK
	 g/sTv1P128wJAEObWEqaK0WwCv5Uz/5t3YxDjm2s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 033F7F805EC; Tue, 10 Dec 2024 15:51:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DB64F805DF;
	Tue, 10 Dec 2024 15:51:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B9BCF805B0; Tue, 10 Dec 2024 15:51:34 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9CD99F805B0
	for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2024 15:51:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CD99F805B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HlL0x44Z
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C784F5C5D37;
	Tue, 10 Dec 2024 14:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FDBC4CEDE;
	Tue, 10 Dec 2024 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842286;
	bh=vcFRyMq2LgyT/jZlk9FVwHCu7zwyckkYnKycWPJr6ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HlL0x44ZrY+g9psBGk58yGcLzU6rmxdvvL/U2yD9CqqjJYjPnMZ41rN+p1LreLf7c
	 tZCdX3rrBboA9Y6njpVnDvZ1igfRoaMO8Qx5BzXMUPxYDsAIJ2HXFY4jk9y4fS+nxG
	 TM71JgY3hHNnjBj27TvyH2n19qEog+tucsKSeYN9o7aTbaw+J9p53BX3L8dNpFjtMn
	 QmQ1M1Qk7cR0zYtZsCCFKHrqVWYBrnN8u3kauOkjZnoBB5GRRD8c0od4T7mKge9UCS
	 vqpiClJ3pOnr9Tj8Tbqyi5FKDu0W1CsS/XOIwNa9ShiyIGzRDLH2Zw7gfsf0clZ4MI
	 jtoN9layVBmGQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "end.to.start" <end.to.start@mail.ru>, Jiawei Wang <me@jwang.link>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20241210091026.996860-1-venkataprasad.potturu@amd.com>
References: <20241210091026.996860-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: yc: Fix the wrong return value
Message-Id: <173384228352.64342.12647978237032666087.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 14:51:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746
Message-ID-Hash: W2TWDI4MFJ766NSOFN2II6CJHUG26LFX
X-Message-ID-Hash: W2TWDI4MFJ766NSOFN2II6CJHUG26LFX
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W2TWDI4MFJ766NSOFN2II6CJHUG26LFX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 10 Dec 2024 14:40:25 +0530, Venkata Prasad Potturu wrote:
> With the current implementation, when ACP driver fails to read
> ACPI _WOV entry then the DMI overrides code won't invoke,
> may cause regressions for some BIOS versions.
> 
> Add a condition check to jump to check the DMI entries incase of
> ACP driver fail to read ACPI _WOV method.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix the wrong return value
      commit: 984795e76def5c903724b8d6a8228e356bbdf2af

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

