Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E77FC2BA18
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:25:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C49B836;
	Tue, 18 Jun 2024 16:24:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C49B836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718720702;
	bh=z0aiqnYxRofh69taB3z0ijaSldf6h5lhocM5coo9Xdc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hpREqK2ZwNIBjirHhVxhR0SLwzFew/aLB0tbOMu4fPN5LkTKFWF1jXq0FqZAIz4VQ
	 GY4R/LmKLCZ88CI4HfejQxq1vUT5Q27ukIBwZqH/SU3MWnN8FuoMmh2PtDJ3ybow9d
	 wem7dQkBRg4s+5MI4bKfWuAvNcklSXxFduiHc7OM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52C67F806D7; Tue, 18 Jun 2024 16:22:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 05A4EF806E8;
	Tue, 18 Jun 2024 16:22:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED204F804F2; Tue, 18 Jun 2024 16:22:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D8281F800FA
	for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2024 16:22:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8281F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hJrjCGPa
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9FEA3619A5;
	Tue, 18 Jun 2024 14:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3C1C4AF1C;
	Tue, 18 Jun 2024 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718720547;
	bh=z0aiqnYxRofh69taB3z0ijaSldf6h5lhocM5coo9Xdc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=hJrjCGPaaGr9k+pN1RjTpxGrrTV6mUiO6Im0ZzxwrIjjBFA8ZYrOosj/6UYiRjF0L
	 agmThfPkP8To6o4lywlwNX0u7z82no77gYQIUwzz7ME+G6h1KBtzPb+WyX8MGRytFO
	 NQZVGM4rR/cuvSo3+XGRdCS7bPisyWlIB4YXDvXPPsT3S0rXuRHNf8s6KoAn3uMFqw
	 J14/dt8zuBOtI9q6usgUUHvEU83EUpEWubi3A9z03/DFNZOPh+w5ZfJ0P4Tuo4TW9I
	 8BSjRkoITdC7uX2YnobxJmwsan8ExmaFIVAJEqwqdELv6tgnRN0h5cynzOPmEeEFLS
	 O6RDinvi5fzpg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240617125735.582963-1-krzysztof.kozlowski@linaro.org>
References: <20240617125735.582963-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-dai.h: Constify DAI ops
 auto_selectable_formats
Message-Id: <171872054460.81836.3714158879000443319.b4-ty@kernel.org>
Date: Tue, 18 Jun 2024 15:22:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: GA6SVDK2DBNMHN5VMAMPL6GCFV6M32JC
X-Message-ID-Hash: GA6SVDK2DBNMHN5VMAMPL6GCFV6M32JC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GA6SVDK2DBNMHN5VMAMPL6GCFV6M32JC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 17 Jun 2024 14:57:34 +0200, Krzysztof Kozlowski wrote:
> The core ASoC code does not modify contents of the
> 'auto_selectable_formats' array passed in 'struct snd_soc_dai_ops', so
> make it const for code safety.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-dai.h: Constify DAI ops auto_selectable_formats
      commit: d4a7d067e061c95c6387cf537258082074a4d299
[2/2] ASoC: Constify DAI ops auto_selectable_formats
      commit: 595265c92668cbdbd9f299c49907734d468c12e9

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

