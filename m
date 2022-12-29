Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B60DC3DA7A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Dec 2022 22:51:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C34D161D;
	Thu, 29 Dec 2022 23:50:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C34D161D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672354278;
	bh=I93/1mRsdn1k7zesrQeJJdmqUVW8X7j/6JylnPTDMak=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CHqfb9mDEcW+on2j1+jdBX+DuASmQXdps4knMM0uBWF0mRU+4/q6dp+HlZt4fWQ7n
	 cI/9ms1iEZwUSk+E/ZO96dCnmwF4Q0CD+Loo0NMoPocKY3XurpCeUrkbhcYn81elsq
	 OxxGbOvROW/jqCOXt4uZkfd/1fh8778Yz04LK+l0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B59BEF804E4;
	Thu, 29 Dec 2022 23:50:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BA4FF804E4; Thu, 29 Dec 2022 23:50:26 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45DE0F8023B
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2022 23:50:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45DE0F8023B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=A3zMnWxQ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC65618D3;
 Thu, 29 Dec 2022 22:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8331C433D2;
 Thu, 29 Dec 2022 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672354220;
 bh=I93/1mRsdn1k7zesrQeJJdmqUVW8X7j/6JylnPTDMak=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=A3zMnWxQ2QRSKe/ukjH1wIb2KGk644x0HuxTVfQL213iMNb5bCyXlVpClZkFU7Jol
 w93hBVwJb7wwY8isey1tapUOsZ87dy/eXYlr3mjOgLVcKn3SWCHJuy/QOqPe09bx+d
 D9ikBGbeCQPbHNdAk2NpZkM95LVy3tGt9yaKzDPR82ECnBiZlJxWowZFhsquIHSwrG
 hHzYcCwAsl0B9EUaHh1A4wAlYv6Ts9J7ItcUGdUh1O70b/qIm7nvMnTondcYznu5b4
 +XXDR1BcyOohQEWXUrpczci6xMWcgUAgWcgURtWSSUPRMLVXsArKHyCehzdgAWw/+b
 F2RP8XVneaqSA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
 jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
 ajye_huang@compal.corp-partner.google.com,
 tongjian <tongjian@huaqin.corp-partner.google.com>
In-Reply-To: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
References: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
Subject: Re: [PATCH 0/2] Add new AMP MAX98360A for RT5682S
Message-Id: <167235421493.130379.3520267907504978837.b4-ty@kernel.org>
Date: Thu, 29 Dec 2022 22:50:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 28 Dec 2022 20:22:28 +0800, tongjian wrote:
> Add MAX98360A for RT5682S, MAX98360A works same as rt1019. So, it can
> be supported.
> 
> tongjian (2):
>   ASoC: mediatek: mt8186: support rt5682s_max98360
>   ASoC: dt-bindings: mt8186-mt6366: add new compatible for max98360a
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8186: support rt5682s_max98360
      commit: 6e1dbf694d7cd1737ee14866e9e05016ccc9ac40
[2/2] ASoC: dt-bindings: mt8186-mt6366: add new compatible for max98360a
      commit: 2d3dd559751ce19ba84f9690c6c7c5a4b39129df

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
