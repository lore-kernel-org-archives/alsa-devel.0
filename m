Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F42DCAC598
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:11:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A843D601D0;
	Tue, 16 Sep 2025 14:10:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A843D601D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1758024658;
	bh=U7SC1k5KPIcZxsGktmNWNgubheJii36rNFKNHf1Xwn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sdjhMmbjdIjaChlihNDzZAUJCw/Qs2Cg0J60zgGLdqq2JvnlvL+osj5DuC6VV1PyO
	 94PqpAP6FCkkTF10tgBZAtY9DpXqacPHFfbmAEAsn8CoaYnJEUEXST9uY91PZDqKjF
	 3CV4kA8KCsVpIh/KmTgJYLYcPxOtI9n5swBUjjTo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49489F805C3; Tue, 16 Sep 2025 14:10:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CACA2F8057C;
	Tue, 16 Sep 2025 14:10:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B9BFF804FC; Tue, 16 Sep 2025 14:08:54 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C6615F80075
	for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2025 14:08:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6615F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Uqcs0zHp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 20616600AE;
	Tue, 16 Sep 2025 12:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B79C4CEEB;
	Tue, 16 Sep 2025 12:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758024524;
	bh=U7SC1k5KPIcZxsGktmNWNgubheJii36rNFKNHf1Xwn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Uqcs0zHph/O0ZoK7jMzCEchMF5ni535xnLSrqIe1cQIv+XzGBwvOBAQ4Vu7e8NgX9
	 FxUBCLq6vCvIeCgkHYWjc/gkxd+JZHMoYRVQ17Vw7z+/i5uLjXKw/arxLR7TWBSE7s
	 FJPkf8TMspGvNq+c0NhJmYcvpfqJoSV2Z2WEB6uRAUnp5rVF7oECFYKuyPM5J4zJV3
	 wIHC7YkRO+C4KNrRboZGyz5abEs1mZFSU+qml0PHxCWJeD0u1jTUDuvU6ezr+xaLyl
	 mY+jdODeLC9QHaqOUx7b0VmM7weHf8euGobU6i3STUvckPR/ckXK+Vd9xPNe/DJNOP
	 obmdM8NAH/Dog==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250909061959.2881158-1-venkataprasad.potturu@amd.com>
References: <20250909061959.2881158-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Fix incorrect retrival of
 acp_chip_info
Message-Id: <175802452167.111062.11810975142265512120.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 13:08:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183
Message-ID-Hash: PXSYUFFS5EQDJYCSQ5227G5ILPGH27VU
X-Message-ID-Hash: PXSYUFFS5EQDJYCSQ5227G5ILPGH27VU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PXSYUFFS5EQDJYCSQ5227G5ILPGH27VU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 09 Sep 2025 11:49:50 +0530, Venkata Prasad Potturu wrote:
> Use dev_get_drvdata(dev->parent) instead of dev_get_platdata(dev)
> to correctly get acp_chip_info members in acp I2S driver.
> This resolves issues where some members were zero due to incorrect
> data access.
> 
> Fixes: e3933683b25e ("ASoC: amd: acp: Remove redundant acp_dev_data structure")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix incorrect retrival of acp_chip_info
      commit: d7871f400cad1da376f1d7724209a1c49226c456

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

