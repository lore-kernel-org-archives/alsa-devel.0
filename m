Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2238EC4828F
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Feb 2024 15:24:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EB3A852;
	Wed,  7 Feb 2024 16:24:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EB3A852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707319468;
	bh=vCIUvcs2yJHC3pfB3WGhxcNTY9rCr8WkfWcd1WjOEK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hb1DMy43A8gyyjCnQX9Ir1LHpzbWC03meTdfp2EIhqa6LvQ0K2k0oI22CLkx1b2wT
	 sJ938acRGf4aPrzJ75HKGlNp6bkc+GslMBeqy267++vubVOYchjucT6TuDkszu37sK
	 kFDx2l/IrajxKBp231Ip/UbuXX6Clj1uSsg7Xkqc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40500F8059F; Wed,  7 Feb 2024 16:23:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B799EF801EB;
	Wed,  7 Feb 2024 16:23:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BFADF801EB; Wed,  7 Feb 2024 16:23:48 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C92B2F8016E
	for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2024 16:23:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C92B2F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mr5j9RH/
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7BC04CE131B;
	Wed,  7 Feb 2024 15:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CECC433C7;
	Wed,  7 Feb 2024 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707319417;
	bh=vCIUvcs2yJHC3pfB3WGhxcNTY9rCr8WkfWcd1WjOEK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mr5j9RH/VKAgsbrhCSoaG/FBWjJzRaRIYlRje6KNcFueNqWa0cU0srhbaj6vgGyRT
	 MCXLq1Xe9x0hp6xBr9/aBMccyLzr4hsdMPhJzyGHecLSAdTHUbN4QfFdGFohqRhU8t
	 h9nSX6fmvVFGqUQHm8vBStLg+Y+S0OnbtXni3ovHe+uf7VwKiYdE0xOMGhhql+L2ov
	 qgMGzfCt5b59PraNxoj86R4jW/ONM5VWyABPMXIReVWb1+fPvH45f3/oH902s1XzHl
	 fngQYFsyzf/ChvqmZv6z3xI7GvWuuKye4OgwZzQWzsLr4SlhnbSKnEtQqugNWMcH3M
	 PvdMaZOM3Is8g==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org
In-Reply-To: <20240206113850.719888-1-ckeepax@opensource.cirrus.com>
References: <20240206113850.719888-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l43: Handle error from
 devm_pm_runtime_enable
Message-Id: <170731941619.1063747.5587451866450239802.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:23:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: W6HSURSD2W6IWSYLGKWO5BYLUILFRMMA
X-Message-ID-Hash: W6HSURSD2W6IWSYLGKWO5BYLUILFRMMA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W6HSURSD2W6IWSYLGKWO5BYLUILFRMMA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 06 Feb 2024 11:38:49 +0000, Charles Keepax wrote:
> As devm_pm_runtime_enable can fail due to memory allocations, it is
> best to handle the error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs42l43: Handle error from devm_pm_runtime_enable
      commit: d1722057477a3786b8c0d60c28fc281f6ecf1cc3
[2/2] ASoC: cs42l43: Add system suspend ops to disable IRQ
      commit: 64353af49fecbdec1de9aadf2369d54fc00f1899

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

