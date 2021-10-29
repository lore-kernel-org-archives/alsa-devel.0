Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B851FC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 15:00:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B8F610C7
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 15:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93B8F610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D2F816E0;
	Fri, 29 Oct 2021 16:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D2F816E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635519602;
	bh=mJ033J2sJBsTod2JwVjQBrjrWKl9Rdn8C5KXPYMgGCE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m0BdyZDgOmnF5DRjtqgHsbs5X/VTIkwYpj/v7FDPF4bWCKDnm72rf4h+oKauvUtdv
	 1ixlQ5d0G76NvfXfAetj9BTqh7x0x2iuSridlMIjG1n6h5c72cDjK6pRx7oSoYesmh
	 EXgqKaw2+e0JN1EpikKk9RChxoB/KERYhm6HuzNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9B2DF8025E;
	Fri, 29 Oct 2021 16:59:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A52DF8027B; Fri, 29 Oct 2021 16:59:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B33C0F800D1
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 16:59:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B33C0F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MGB4hdZq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC7A661166;
 Fri, 29 Oct 2021 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635519540;
 bh=mJ033J2sJBsTod2JwVjQBrjrWKl9Rdn8C5KXPYMgGCE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MGB4hdZqpFevXYbJhsmebtLYANQ6zfaGiFi5czl20fTo9auFxTl49hpAGxmiLdSro
 Lc/TDdy7BTBQbbDdeuSYpWKaZlePbSGaLUfkIMg+6aNDa0+bYzFaFwx/r2ARLGd7kV
 uUy30QwZjp2iHBtUxzN3/qK425QSFki/QEn/lyU1+sD7dBawzPWQmChd9V8Z8hVJ3N
 SesVE+VZwv9awx6oGcLUNa5dzD5+80xh/43x1Idk3HbYg9wjMZ+gtZqv5E3wp5lRpI
 fhSDtxaSrbHI7FLQbKU7f0DuvX1aFDTJRC5a+995ry8H5oTgZ9Gg6UpSacHhj2LHK9
 Z2xXKYto1dzRA==
From: Mark Brown <broonie@kernel.org>
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20211028140909.496022-1-brent.lu@intel.com>
References: <20211028140909.496022-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS
 codec
Message-Id: <163551953757.3555751.3149323718698508108.b4-ty@kernel.org>
Date: Fri, 29 Oct 2021 15:58:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, linux-kernel@vger.kernel.org,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Paul Olaru <paul.olaru@oss.nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Julian Braha <julianbraha@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 28 Oct 2021 22:09:09 +0800, Brent Lu wrote:
> Detect the codec variant in probe function and update DAI link
> accordingly. Also add an new entry in enumeration table for machine
> driver enumeration.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS codec
      commit: 88b4d77d6035dcf1182c4bf05c743e30363f3078

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
