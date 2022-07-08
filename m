Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3B3C43334
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 20:49:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7A39839;
	Fri,  8 Jul 2022 22:48:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7A39839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657313364;
	bh=wbxNTgorCZtCHrnBt6AHynQ5WG3WbxayLiJh/ZEjMbE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fSzGN4D2j2saQfdkPtCtAthXs3S/ah3SX2/8oafJZExaLM6mbodbLO/pc1Uey41At
	 yKR5KyfhvZrp3ileGQbvHTfmwlD/DAU80+T4eXV1kLFzeyByRQR5WOFgQEIsUlFbjj
	 CuuCW7PgySR/Qu1W5C7KAPxZq2yc2655m7ZvYKE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30F44F80544;
	Fri,  8 Jul 2022 22:47:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2ECF4F80543; Fri,  8 Jul 2022 22:47:36 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B78F5F80166
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 22:47:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B78F5F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="h7Ihm0/W"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8E19FB82978;
 Fri,  8 Jul 2022 20:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64347C341C6;
 Fri,  8 Jul 2022 20:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657313250;
 bh=wbxNTgorCZtCHrnBt6AHynQ5WG3WbxayLiJh/ZEjMbE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=h7Ihm0/WE5b8d0To19NGDJYjZ71oVEYQQhfTQJGwkXAgO7cGUcd3jwOvNp8qbaUTT
 PS9GwktJmOhV6B3zNZL/LV640S7quo4SdOtmoLWpKx1vzuler/zfiudnCc1Klp5FbU
 Pr4hxN9QPHL2DY6TUfysW+L+iUDOz53O9dEsi796GLbVIX5zkdmaVcAhn1AzQ/+OKe
 mkhdrcFUuodXTSY+W2MONAC2Ix+Gt0urBj4SY2GpP4Q6MMcCQ8G6iLhP/Lj1cDSqPF
 d/pdHmYyJCk9pazrCEOERKjdgIp4xD8ANPsHoopkoQoSam4HIsyBwuReHGQfwwIDzf
 i9w77zsxhaZ5A==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220707214614.61081-1-pierre-louis.bossart@linux.intel.com>
References: <20220707214614.61081-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: amd: acp-es8336: use static variables
Message-Id: <165731324912.2467307.3897599043205504647.b4-ty@kernel.org>
Date: Fri, 08 Jul 2022 21:47:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Vijendar.Mukunda@amd.com
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

On Thu, 7 Jul 2022 16:46:14 -0500, Pierre-Louis Bossart wrote:
> Sparse warnings:
> 
> sound/soc/amd/acp-es8336.c:36:15: error: symbol 'codec_dev' was not
> declared. Should it be static?
> 
> sound/soc/amd/acp-es8336.c:37:18: error: symbol 'gpio_pa' was not
> declared. Should it be static?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp-es8336: use static variables
      commit: f460e3a9740b8c1ec5a9a034262674514bbbdcac

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
