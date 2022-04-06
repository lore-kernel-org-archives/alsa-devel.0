Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99B4C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Apr 2022 13:30:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E352171D;
	Wed,  6 Apr 2022 15:29:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E352171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649251829;
	bh=SapR/NGS0zHiukVcEi1sjt1o5RguCptFWulxy98tqWA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PFZ52HHB4yyiKlE7CfdO83bdrXwgHgMIHtYTXEtlfED+nMja4g8zBqDHCyp90ea/N
	 0NQdLjaT+QVhYcEnQe1kkSjCHya8mtI1WAulg2ebikZeyMGu0h7A9E3qFgBkczJOvd
	 vJ5EFA255IA4Fnv7U1ab0d2cNU6obVjhHYByjnTI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F967F800D2;
	Wed,  6 Apr 2022 15:28:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E97EF8020C; Wed,  6 Apr 2022 15:28:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1068F80475
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2022 15:28:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1068F80475
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qBE6vy/D"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A78D5615AE;
 Wed,  6 Apr 2022 13:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0FDC385A9;
 Wed,  6 Apr 2022 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649251720;
 bh=SapR/NGS0zHiukVcEi1sjt1o5RguCptFWulxy98tqWA=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=qBE6vy/DKRlrqfk8OWxSirFDZMVqiTSuBzW8DuegVviTNxduBA/czlteRsefSFsju
 eSrQDuT2Ri3W/8znnOPz1dvd1XS/CKOpYwo+Jhnp6pN7MOLE0pCWzsRAOnBULnwH4e
 SKuCZe+6Rlj52sdtm7QHPgTA6voOO9HfsmcvwvZZw0s8ngISWe7xCOVHSyXXiram29
 kvF9DVx4oFqWVMUXaHEcPzoXsU5mrmyxBjjTeXG1zpOuYQ9ArjNN5/M6emcLTRncEd
 ZCuW/AagOexFfhZQvjMoZfr0PGCR3AoHwup6HCUj9sn/rikJv1ifAcPGA/CLBmo90l
 XdYzf/YmcFq5w==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 tiwai@suse.com, jiaxin.yu@mediatek.com, linux-mediatek@lists.infradead.org,
 linmq006@gmail.com, koro.chen@mediatek.com, lgirdwood@gmail.com,
 matthias.bgg@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org,
 tzungbi@google.com
In-Reply-To: <20220404092903.26725-1-linmq006@gmail.com>
References: <20220404092903.26725-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Fix error handling in
 mt8173_max98090_dev_probe
Message-Id: <164925171747.83821.17392124533479234810.b4-ty@kernel.org>
Date: Wed, 06 Apr 2022 14:28:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 4 Apr 2022 09:29:01 +0000, Miaoqian Lin wrote:
> Call of_node_put(platform_node) to avoid refcount leak in
> the error path.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe
      commit: 4f4e0454e226de3bf4efd7e7924d1edc571c52d5

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
