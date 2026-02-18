Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A28E9A02C
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Feb 2026 23:37:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4FBB6020E;
	Thu, 19 Feb 2026 00:37:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4FBB6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771457836;
	bh=tZ80juMdw/uefTvy0uIX6JFC/KOlaT93tA+XqCxCHs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bLWC48K0CPjqq6vnzHt60ycyDnQhkCOsvnuwy576rO2BWEGlbZfIrB6Txnjey7WrY
	 /RgXLQvziHjfVXhFq8p8cmmTny0IzkKrXUnF9e/rxuaLL7rPL9OE2c53NhaCRq7RTi
	 uFZ6nJqazXY0OHY3ma1z9woLu9+X9S8OO4BmawJ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2E7CF805E2; Thu, 19 Feb 2026 00:36:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D0E8F805F1;
	Thu, 19 Feb 2026 00:36:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29A87F804F2; Thu, 19 Feb 2026 00:34:56 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0EF4AF80153
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2026 00:34:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EF4AF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SIg/lp5a
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CFDD66132F;
	Wed, 18 Feb 2026 23:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C5AC116D0;
	Wed, 18 Feb 2026 23:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771457687;
	bh=tZ80juMdw/uefTvy0uIX6JFC/KOlaT93tA+XqCxCHs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SIg/lp5aQ4Dvg2IbkEJXh29eoTYow4mH7XVbX9PQTmPcCaQfbzNNCKKmZDSjrUDbw
	 ybOl5MGTumOtd6XJM2E7qicRJSL0Sgrh/ql8z1ueSQMGtHeuwkvAjp24nXM+mNP+ai
	 s+giWf3hRQ4XAq9Z9ywUVeW4EBkQTGH2SZ9t6x73yhIJ8+bGuVO3CsT83itA7yXszv
	 4S8LwLAAegm7G+geeAjrZ4SQ3i4brZroTFJ/+tgm52GkGLxfige0QzBu2OjZk+avUi
	 0St9CE6BfGjBq/MhSjZnw3xYo30I9dUorPjBw5KDsRX7Hub5sNDwao9KwXdPQ+MhFt
	 /j13fI48Xwmgw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260218104734.3641481-1-Vijendar.Mukunda@amd.com>
References: <20260218104734.3641481-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/2] ASoC: amd: add ACPI mach entries and quirk
Message-Id: <177145768554.2257280.17103760824582405342.b4-ty@kernel.org>
Date: Wed, 18 Feb 2026 23:34:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
Message-ID-Hash: G7B5A5B22Q4K6YE3P5A5BJGEOH2RJQDQ
X-Message-ID-Hash: G7B5A5B22Q4K6YE3P5A5BJGEOH2RJQDQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G7B5A5B22Q4K6YE3P5A5BJGEOH2RJQDQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 18 Feb 2026 16:15:32 +0530, Vijendar Mukunda wrote:
> Add ACPI mach entries for ACP7.0 platform for RT1320 + RT722 combination
> and include machine driver quirk for Lenovo laptops.
> 
> Vijendar Mukunda (2):
>   ASoC: amd: acp: Add ACP7.0 match entries for Realtek parts
>   ASoC: amd: amd_sdw: add machine driver quirk for Lenovo models
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: acp: Add ACP7.0 match entries for Realtek parts
      commit: 7869f1c1123cfc0fb22a9de96cc6eb75072a3971
[2/2] ASoC: amd: amd_sdw: add machine driver quirk for Lenovo models
      commit: 3acf517e1ae05ef66561b7a2782690387ce46e21

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

