Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE0FC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:18:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7126113E
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B7126113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EE4A18A4;
	Thu, 16 Sep 2021 17:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EE4A18A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805507;
	bh=9Gk9zpsHW+o1AhEneMl7xErJHjJddOAqkm2Rp5bgtJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iCQ+DqSA7UxiYbnC/NUQ+9+D2kn3B/TcbUJGu4ReqvPT5J5C9hZS3Y4UZ7pppsAeP
	 HEpU3vYhcZVmypw5LayB9G56KHsNQFIIMQDDERQxZCKJ5HknMFoyVtx37mXEzFakWb
	 EBGHx/99BNT99Hwu4NFObNPLGygyNH2riaHYKdLA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99614F80506;
	Thu, 16 Sep 2021 17:15:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6704EF804FB; Thu, 16 Sep 2021 17:15:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71D5AF804EC
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71D5AF804EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vv4XmZqz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27D96112E;
 Thu, 16 Sep 2021 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805336;
 bh=9Gk9zpsHW+o1AhEneMl7xErJHjJddOAqkm2Rp5bgtJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vv4XmZqzqmzIeErwxZK7XzGhmjVW0Fs9nK0cEj1Zvdb9TehDKn70NHyh3nsjeObK/
 MbPyx+U5MB8/uBd+C5Rq1q4hzwOkAmRsFpiKp6L81u7sctGlQiKDiFYn23hK9pLSyJ
 +QJ9iEePf8sLUHI0uW809pwECgGDAtyHYhWWhoGL2UpyZTme7lSGdN6mbefC1TAK9Z
 Ie6c7xrc7py7+MErOYUmWOp4vQOwOVbKY1ctu3XaMEIIt3nPLq29QbSk4nDyM2lVEU
 E8laZzKa3secUy2C7XaGkn0PpAjcBzEpb7IXuVPiuc0Xfp+63WXVMaOFw3y5HQpgB+
 0zuYH55JeyCwg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Manuel Lauss <mano@roarinelk.homelinux.net>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: au1x: Convert to modern terminology for DAI clocking
Date: Thu, 16 Sep 2021 16:14:35 +0100
Message-Id: <163180495858.19842.13609592448291165418.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210915180256.39345-1-broonie@kernel.org>
References: <20210915180256.39345-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Wed, 15 Sep 2021 19:02:56 +0100, Mark Brown wrote:
> As part of retiring the old macros defining the DAI clocking mode in the
> DAI format update the au1x drivers to use the new style macros.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: au1x: Convert to modern terminology for DAI clocking
      commit: 8461d7d83f1fe878c4cff72e322711dfcb5a53ca

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
