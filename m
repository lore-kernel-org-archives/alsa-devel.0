Return-Path: <SRS0=PqWm=CF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEEFC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:00:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED04722CAE
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fU4GhOeg";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNAYHYV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED04722CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6424717F9;
	Thu, 27 Aug 2020 15:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6424717F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598536802;
	bh=D4c5bsAhd8zZSEispX8Tg/Y2kX5Znff1UJUvDwZcLZg=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fU4GhOeglePPKLxdF4kEPN5hq2YkSZ4l6HxnPMJyR/jrAeTGAE27d+MnLmbNyy8x2
	 fB3vMAPcIHCaARcF19/iH3yGuPdiVCF5V/KdCjiPZDoxEV9yksWW5CENyIaWpC7hZB
	 GNsJhoRATmgm9EqYtHcAKRoEJ9YgmWivAGFfT2UU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB8C1F8026A;
	Thu, 27 Aug 2020 15:57:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F060F8025A; Thu, 27 Aug 2020 15:57:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02885F80085
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2020 15:57:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02885F80085
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VNAYHYV6"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AAE222CAF;
 Thu, 27 Aug 2020 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598536651;
 bh=D4c5bsAhd8zZSEispX8Tg/Y2kX5Znff1UJUvDwZcLZg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=VNAYHYV6qs4wzz8m4vr2zthC96wAPi/a/F1FPiYuLb+5hmmmP/D9hq6kTTsbHwUsh
 2JcyDeGC2vV2CcDs79Tjvzh5cW0aZFkSoHPA+JmDv53dgscaoSolOnd4KWECMtWNih
 is5MMii1o630zHnJtu1CMB5YBpFlpJCjszAtwxJs=
Date: Thu, 27 Aug 2020 14:56:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87blixvuab.wl-kuninori.morimoto.gx@renesas.com>
References: <87blixvuab.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: soc-core: add snd_soc_find_dai_with_mutex()
Message-Id: <159853660472.29762.4382776935010264742.b4-ty@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On 27 Aug 2020 08:55:39 +0900, Kuninori Morimoto wrote:
> commit 25612477d20b52 ("ASoC: soc-dai: set dai_link dpcm_ flags with a helper")
> added snd_soc_dai_link_set_capabilities().
> But it is using snd_soc_find_dai() (A) which is required client_mutex (B).
> And client_mutex is soc-core.c local.
> 
> 	struct snd_soc_dai *snd_soc_find_dai(xxx)
> 	{
> 		...
> (B)		lockdep_assert_held(&client_mutex);
> 		...
> 	}
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: add snd_soc_find_dai_with_mutex()
      commit: c1c277b2c425f69b9b4f4258d9db18562d9be041

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
