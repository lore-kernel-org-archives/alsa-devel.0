Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D58C46CD2
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:44:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED9FBE0F;
	Tue, 30 Jan 2024 16:44:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED9FBE0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706629467;
	bh=WMy6RRsQJLRJBWnLJ89lCoe7Y2F1OmudZmS9VXnXbF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EjV/e1py48wZdUp1G0K1p5eCblABxp8sqJ8CEOWIrFyaMdBv4WZeu4E61VSP2qDZl
	 MkO8plkkD4Ha2eK5aVHwx4z+OO8ZPdGcAi5tI0ra2LQXFjc99/xHJMTUoAEKX4rc98
	 VfNj9x2hsZotHkHLW/F+np07/xZYcbLXavqzIS0M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3502BF80588; Tue, 30 Jan 2024 16:43:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23196F80568;
	Tue, 30 Jan 2024 16:43:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88E32F8055C; Tue, 30 Jan 2024 16:43:50 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AE869F80149
	for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2024 16:43:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE869F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XIPWTimC
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 32BEB60DF3;
	Tue, 30 Jan 2024 15:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FFC433F1;
	Tue, 30 Jan 2024 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629420;
	bh=WMy6RRsQJLRJBWnLJ89lCoe7Y2F1OmudZmS9VXnXbF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XIPWTimC4vkbKvCeyHE5AQ73La6/FDJpl9jnJKlCmjVKEnoDHYUTIatIZlVXwAg5U
	 Pk0a3PR9adimq8/TbjBoMg/G0aWvD/sR+WdMV4lmWT+rzQ8mu1qHeKEVH2b/GXhmYj
	 viKITSR98ijF31um22mekf8HEVrJXbxgpyr0v+FrpxOA8NbEQXi5u3mwzBm1YJRUWa
	 uwxAwfysaL0mQ0VKUg8nlPkaeMIQqwxfSiJ58JKl6PqyObHkaV3RsJSFgBol+lgSEd
	 rBLzNgqBlZDxNpy+oPFMeKvW7gAI87vKVr3bGao074pSg27TvZE8Fjjq3tpRndC8i9
	 7PsTpI64hgG5w==
From: Mark Brown <broonie@kernel.org>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123113246.75539-1-mstrozek@opensource.cirrus.com>
References: <20240123113246.75539-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23
 for MTL
Message-Id: <170662941829.37296.6809902115507707468.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 15:43:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c
Message-ID-Hash: PLZIU5JP4LKOTLRZEVI4JA33LIKN3UYE
X-Message-ID-Hash: PLZIU5JP4LKOTLRZEVI4JA33LIKN3UYE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PLZIU5JP4LKOTLRZEVI4JA33LIKN3UYE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 23 Jan 2024 11:32:46 +0000, Maciej Strozek wrote:
> The layout is configured as:
> - Link0: CS42L43 Jack and mics (2ch)
> - Link2: 2x CS35L56 Speaker (amps 3 and 4, right)
> - Link3: 2x CS35L56 Speaker (amps 1 and 2, left)
> 
> Corresponding SOF topology:
> https://github.com/thesofproject/sof/pull/8773
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23 for MTL
      commit: 84b22af29ff6c74e09e3faa0ad52c843cca1f426

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

