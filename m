Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CD8C32789
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 18:51:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 860891660;
	Tue, 23 Aug 2022 20:50:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 860891660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661280685;
	bh=fNT/ML6CsNqu6evXVhQ1GENE4bqQBehy5fIvG9sMLLI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDOm17tJcQCBapryH88MSEVeW0KiXVC7UxFGEpBLjCmWt4P72DLYZXSixyXv1GXJk
	 68UX8F5mDwtkb6ZvpznVtHNtupDyjQsQszFbDxiy2VIxqMBIFsPvKddVKDiwv+CtDU
	 Sh/lNhqb/s5OcdkyIHeNTO6aKUAkdc/5zu2IsB1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 766C8F80529;
	Tue, 23 Aug 2022 20:50:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23A62F80528; Tue, 23 Aug 2022 20:50:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A47A6F80525
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 20:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A47A6F80525
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vAcy88Zb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0E9766170E;
 Tue, 23 Aug 2022 18:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA23C433D7;
 Tue, 23 Aug 2022 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661280602;
 bh=fNT/ML6CsNqu6evXVhQ1GENE4bqQBehy5fIvG9sMLLI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=vAcy88Zbsbm73QG9RIBN7kLheKv9zuhvbQlRaY7AIi5FEIXCshoGeECGld6vuQkAY
 JmT92EdCP5kYMFzPBE/2Bekz1REZJwBuLdTvusoJJv1wRln5cQkXR3wC2NgwKXBx1D
 pyFyPB8IDBVWU8XRQKXBcD+pbHW+As9qsWwsyQEEfpWW/LqfnbZQVCMaJ/DeU1c6Pt
 yfhCKb250jG3LHHYURi4HiQU+Wkg3CWVFs4mtAnPCgjD/TGnKpQJNtmtDEZuDv0Zzh
 ddKlSjcQV8wjpaWD/td+90Vxa3CZuJ9bdtvwrPl0II4b0CMojmeMfWPTvm5pM0RW+t
 TJnFTafdyU06w==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
 Xiubo.Lee@gmail.com, perex@perex.cz, 
 alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 nicoleotsuka@gmail.com, festevam@gmail.com
In-Reply-To: <1661218573-2154-1-git-send-email-shengjiu.wang@nxp.com>
References: <1661218573-2154-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATCH] ASoC: fsl_sai: Add support multi fifo sdma script
Message-Id: <166128060004.1031684.56373454264278530.b4-ty@kernel.org>
Date: Tue, 23 Aug 2022 19:50:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Tue, 23 Aug 2022 09:36:13 +0800, Shengjiu Wang wrote:
> With disabling combine mode, the multiple successive
> FIFO registers or non successive FIFO registers of SAI module
> can work with the sdma multi fifo script.
> 
> This patch is to configure the necessary information to
> the SDMA engine driver for support multi fifo script.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Add support multi fifo sdma script
      commit: 88630575406fdf2a7853545a884484bd55dab8a0

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
