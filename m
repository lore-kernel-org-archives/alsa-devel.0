Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16D8C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 20:50:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00D8E829;
	Fri,  8 Jul 2022 22:49:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00D8E829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657313405;
	bh=Ui9K++zFSu+pNi8A+6BxPwxgLsxDHpLwQwAfXOzb0qQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kygKYcZ1wHi87GkNb8BZLQRFYTxMwKsKydzH4xu1YlsWZgASQgQ/afCJOkPj7x+Zr
	 n6Kul8ORxEUOnQiIN1pdj3RJdiCIZQbC2g+uUhXVh9xcY7NyEvXqMQQr6/p91qqEJV
	 prAAB4si2iZH8ljMAl1y7WedUmZRWqfYPQylSBmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBA3AF80566;
	Fri,  8 Jul 2022 22:47:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6D3CF80553; Fri,  8 Jul 2022 22:47:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF083F80166
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 22:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF083F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bsCzvzZg"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 03FF3628CF;
 Fri,  8 Jul 2022 20:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F39DC341C0;
 Fri,  8 Jul 2022 20:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657313254;
 bh=Ui9K++zFSu+pNi8A+6BxPwxgLsxDHpLwQwAfXOzb0qQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bsCzvzZgJuKPKmEjuDEn15j9rrIpml4j5LU2bZ9eldKV5p6SvsEMXKqmMELh7MsvO
 Rz4lAJJ6u4Sd/p+S5OJbH03JvKtTAtxsMIu2HqrCw5aVhBilZ/udrmCVNtUb6n+Dca
 bQqX7RwyyNTiTQ2+0IlyOZILzFJ5AZPDj+OV4w0HZhLKsBdDcX4uaeOLNxL1LaCvIi
 KbAfhhbPcnfKuLUrY5Ti3YMVhH2bc17gJ66KKGkwPk3QFkgg3TkRki2bQCIK3CeKev
 gDK9iEVT1o1wPAl9VeQRY5YrcYtKDHQa1ITq55W7/LwPHJ86HNDYevZYTwnK18k97w
 2EcENihQdiPuQ==
From: Mark Brown <broonie@kernel.org>
To: CTLIN0@nuvoton.com
In-Reply-To: <20220708054647.540621-1-CTLIN0@nuvoton.com>
References: <20220708054647.540621-1-CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: Declare 2 channels for DAI of capture
 stream
Message-Id: <165731325221.2467307.8859346577253060297.b4-ty@kernel.org>
Date: Fri, 08 Jul 2022 21:47:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ctlin0.linux@gmail.com, WTLI@nuvoton.com,
 SJLIN0@nuvoton.com, KCHSU0@nuvoton.com, lgirdwood@gmail.com,
 YHCHuang@nuvoton.com, Vijendar.Mukunda@amd.com, Vsujithkumar.Reddy@amd.com
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

On Fri, 8 Jul 2022 13:46:48 +0800, David Lin wrote:
> The patch is to make driver with flexibility for more platforms support even if
> the internal design is just one ADC. Besides, many I2S controllers only support
> 2 channels.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8825: Declare 2 channels for DAI of capture stream
      commit: 0ca3d2ba1dfd110bf5e0b25ebeb8f1e1587598fb

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
