Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B159C25B0E
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Aug 2022 13:27:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A17B1636;
	Tue, 16 Aug 2022 15:26:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A17B1636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660656450;
	bh=JDyNLxdszbDFx0pcncicVcptLBlcDYeGRE01CIKegz8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lgPdN8hy0atZBKGY/FSd9ieBcAXgx5T861TJ9z/aNde3AQJf8ahr2ZnWPAKQelihu
	 yl+oIReUQoVHEP1UQzSvL/lb4frRq4OowcozkYb5+HBlWF2uLf4kIEIPzzk73tCfrk
	 mPRzCm+uOCe6/CtvQ6ptNztmApMaQIuPAC1i+joU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F61DF80238;
	Tue, 16 Aug 2022 15:26:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D979CF8032D; Tue, 16 Aug 2022 15:26:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E83AF80082
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 15:26:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E83AF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pJZBp4LN"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F03C561383;
 Tue, 16 Aug 2022 13:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A021DC43150;
 Tue, 16 Aug 2022 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660656393;
 bh=JDyNLxdszbDFx0pcncicVcptLBlcDYeGRE01CIKegz8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=pJZBp4LN1ZZ7CxpAD+cuw0otGky4k3qxoaYECLg8TO+b7Z/kopPUHJ0Mq/6a5rlZy
 xFKGED1YrZDGY6KwcrtGnfDLqHpjokiyDeBDMYV0wUD4YsZUoOvxSJaVipZTrw5lMV
 0EL5AqY0S779KBdn7hCkNt1Qf2lBPlQaqOt8gdGbsBC/BuqEG94ZJDmHDIofght8he
 CtFHdNYYLpvfgfYR0C/iyrhfY0fcxryVuZKu8YuM4tzRbDpP/B0careeK04LzeYLY3
 +Tn/1iI+fuXcxIJLzqFv25yxpX1mUY8SCTFn7afHIeUAf8BK8SPmqvJkFatOdFe4VN
 DtFoIzHXX+vtA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
In-Reply-To: <20220813083353.8959-1-pieterjan.camerlynck@gmail.com>
References: <20220813083353.8959-1-pieterjan.camerlynck@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: fix incorrect mclk number in error
 message
Message-Id: <166065639137.1257437.16040745730898665354.b4-ty@kernel.org>
Date: Tue, 16 Aug 2022 14:26:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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

On Sat, 13 Aug 2022 10:33:52 +0200, Pieterjan Camerlynck wrote:
> In commit c3ecef21c3f26 ("ASoC: fsl_sai: add sai master mode support")
> the loop was changed to start iterating from 1 instead of 0. The error
> message however was not updated, reporting the wrong clock to the user.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: fix incorrect mclk number in error message
      commit: dcdfa3471f9c28ee716c687d85701353e2e86fde

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
