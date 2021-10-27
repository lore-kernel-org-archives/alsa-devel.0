Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D1C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 17:33:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC7B60E74
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 17:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AC7B60E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAD18169F;
	Wed, 27 Oct 2021 19:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAD18169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635356028;
	bh=Dmy2eSxMesrXx3Kt54NoJu+ASFtTZgXO7s9XqZs9lFc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qtHfWQ4t785K73tVPDmEhrOZfudRd2JFjozOeOMeIVbJzZ9nhdE6tOMBjbQOPdNXP
	 QYE6yj8wcBEvQPOA8cz0hzaKRard6fxQdqJKnZTOIg2Ly1uMZOS8F7X43E9VMj1XY+
	 6yw2oW93WAZRkb2pUTXQ2/fqAtBlguHjlKoghlhg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 427DFF8051A;
	Wed, 27 Oct 2021 19:29:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2F55F8016C; Wed, 27 Oct 2021 19:29:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F450F8049C
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 19:29:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F450F8049C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="utolcpQ8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15776610C7;
 Wed, 27 Oct 2021 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635355763;
 bh=Dmy2eSxMesrXx3Kt54NoJu+ASFtTZgXO7s9XqZs9lFc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=utolcpQ85h/f5oh9Q/bK6syRgpbaiVM1k/d8JoOYChk/iV5EtxKi/VoTkyQHVofY7
 zUGNW4xjtV3/NOI4OLZZP8tc6YGrPPhNevb7Bxj2bCBa8FHwVjpjRHItgc6hMuI0pZ
 HPT1EVUZi7W8AJ3E3d0g2CU+2QXZfLBO3teKKd2FMWf1aAn18DcjeOD2gzKD4f9Oz5
 JvwdyhUuzb4nmuc2arTmGhtz/j7FvxyzSxWrV0K2imoqDj3Xw+try+HoLD5gfUI4UW
 TLCjCGpKlKUARHf0IOpHlaCEegIFHLfoXecoeH4PQuaDRQPACRpi1a95MWtedMlPTy
 kuit7R26ABYDQ==
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20211027082359.52248-1-arnd@kernel.org>
References: <20211027082359.52248-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: fix Kconfig dependencies
Message-Id: <163535576182.4012075.12901832843673816206.b4-ty@kernel.org>
Date: Wed, 27 Oct 2021 18:29:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
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

On Wed, 27 Oct 2021 10:23:46 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The CONFIG_SND_SOC_AMD_MACH_COMMON has some dependencies that
> are not checked by the symbols that select it:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_AMD_MACH_COMMON
>   Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && X86 && PCI [=y] && I2C [=n]
>   Selected by [m]:
>   - SND_SOC_AMD_LEGACY_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]
>   - SND_SOC_AMD_SOF_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: fix Kconfig dependencies
      commit: 1dcc81d95b910dc404c40ff6101bfa2520a3528e

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
