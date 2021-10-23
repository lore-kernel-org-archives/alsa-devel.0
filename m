Return-Path: <SRS0=LHDW=PL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6CC433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Oct 2021 20:00:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC6860EB2
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Oct 2021 20:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBC6860EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47E0F852;
	Sat, 23 Oct 2021 21:59:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47E0F852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635019225;
	bh=BPW8lGPp0IBk54KARrIXcoKWEGjr/Ou+DeAMmCe3AeE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGwfFDZxeKOdJ4POl0Vkui62RNNsCFEKnIF6UIISGUICyEfAVnnA/dpSbN/GYRffj
	 B4zMhKI7hY7tQ9W8cUj5E21LinllgblIXP+FJRHE6Hrzwrvd7bw61JrBOF/M6hiQ5H
	 ZLTtNrLjdcFm13wiiRweP0IMLnlx8wE2DKY84WrU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C744BF804E6;
	Sat, 23 Oct 2021 21:58:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 836BFF80240; Sat, 23 Oct 2021 21:58:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27985F801DB
 for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2021 21:58:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27985F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LqMj3nNx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2EDC60F48;
 Sat, 23 Oct 2021 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635019110;
 bh=BPW8lGPp0IBk54KARrIXcoKWEGjr/Ou+DeAMmCe3AeE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LqMj3nNxEq2qnVs5CG508hU2Ijc+c7g7OA/pXSEvumYuiv5s71H5ao12poGtGfceB
 jwTy9rUWet9+YOYBIL6W1IpM0QjXXUGAruaE1eFrbU8iNk+YAGpfUUFQfxVZZrs3/U
 BHW8rJLhY2EvJuP9FUIRQ3bYv9wb5H+o7KLG885+lC/UnFe/6zFwpYnbIRYGRRk9S8
 6OyhARyYCQGVIbA+gjvFcGtY0EMrTLXnfJgLNajh/H68eF9StLg/jbnNnQzxBtzXsy
 9WRIp2jTkhJO6uOs1qFV8OOe8ILpBhmaI3CIZoPQHCKjZigCVslwdS/bok55PVgdLq
 Ts/hYz+fdXlwA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V2 00/13] Add Yellow Carp platform ASoC driver
Date: Sat, 23 Oct 2021 20:58:08 +0100
Message-Id: <163501902838.919045.3108416035531446792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018112044.1705805-1-Vijendar.Mukunda@amd.com>
References: <20211018112044.1705805-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sunil-kumar.Dommati@amd.com, mlimonci@amd.com, richgong@amd.com,
 Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com,
 Basavaraj.Hiregoudar@amd.com
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

On Mon, 18 Oct 2021 16:50:31 +0530, Vijendar Mukunda wrote:
> Yellow Carp platform is new APU series based on acp6.x design.
> This patch set adds an ASoC driver for the ACP (Audio CoProcessor)
> block on AMD Yellow Carp APU with DMIC endpoint support.
> 
> changes since v1:
>   - fixed SPDX commenting style in acp6x pci driver.
>   - fixed Copyright commenting style in acp6x pci driver,
>     pdm dma driver and machine driver files.
>   - fixed local variable check logic in acp6x_power_on() function.
>   - fixed Kconfig indentation issue
>   - removed irq_flag local variable in irq handler.
>   - add dmi info check in machine driver probe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/13] ASoC: amd: add Yellow Carp ACP6x IP register header
        commit: 53880e382bb1323897f43f16f4b1b98ac5044871
[02/13] ASoC: amd: add Yellow Carp ACP PCI driver
        commit: c62442bd5d9f86575d74c77b891ef0df9e3cb6dd
[03/13] ASoC: amd: add acp6x init/de-init functions
        commit: 8c7161f2c97b2dba018ecf0af8a0553e283a5c3e
[04/13] ASoC: amd: add platform devices for acp6x pdm driver and dmic driver
        commit: fc329c1de49825a30d5381e18316a3fd45aac7a9
[05/13] ASoC: amd: add acp6x pdm platform driver
        commit: 7610174a5bfe6cf34eda8f972311e629ae6dc2d1
[06/13] ASoC: amd: add acp6x irq handler
        commit: cc0deaa2dc7300bb33e44e52cde0b6947a5d3a5d
[07/13] ASoC: amd: add acp6x pdm driver dma ops
        commit: ceb4fcc13ae58102ad31aa4071d9e57e57eea3df
[08/13] ASoC: amd: add acp6x pci driver pm ops
        commit: c8212df7bc0f2ed323ad1da96106792103ee94f1
[09/13] ASoC: amd: add acp6x pdm driver pm ops
        commit: 4c2e711af2193bc58f247f32edc30ee6a15e71f2
[10/13] ASoC: amd: enable Yellow carp acp6x drivers build
        commit: 89728d97db3f078aceb967ebe5ed2d0797b6a117
[11/13] ASoC: amd: create platform device for acp6x machine driver
        commit: 058dfdf37f25580423fd21d4b78d2daf217d0cf5
[12/13] ASoC: amd: add YC machine driver using dmic
        commit: fa991481b8b22a7797a828135ce62a73791bbe39
[13/13] ASoC: amd: enable Yellow Carp platform machine driver build
        commit: a80d7edadfa16fa1d4aca4a2253a0af921c3aaef

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
