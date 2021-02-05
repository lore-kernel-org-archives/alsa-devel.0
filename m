Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D5C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 20:16:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A520864FC4
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 20:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A520864FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 184961657;
	Fri,  5 Feb 2021 21:15:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 184961657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612556194;
	bh=yZA214pP9uEmxnlYovW4a/vibfl67RdvPHHROfP6O8k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=krlDR1sGfWfcmez0DVwj5h6iYfVPZQObKafNELeyG3WCYednEmaUnsqtOt5QSZ1wj
	 f/0dkMoHKxKFmZAw1s9VsPb2DXuozD1sMgN+wmwoTgM1enQBwXSYjZR6ujERoZn+xg
	 tfDbfFTwWK1Njwv7iBQZrtVUwYyGAjxyu8QfEOyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDE44F80139;
	Fri,  5 Feb 2021 21:15:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC477F8015A; Fri,  5 Feb 2021 21:15:35 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88D29F80139
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 21:15:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88D29F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KRNgmLlG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBC2D64FBA;
 Fri,  5 Feb 2021 20:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612556127;
 bh=yZA214pP9uEmxnlYovW4a/vibfl67RdvPHHROfP6O8k=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=KRNgmLlGoZ/Komwtz3wcBd0HAOvRePsOzlH4bw+vBB82jfBucMtmFsqWRbMG8HLiy
 EhmccZT0slTc0iAbO7Fh3XvOsOyCD+wCLgsd50a1Q0d7Q7FyRAgFHqZZd0Q/d8bBSP
 QT3HkMxyQnOpzVN7YstdHZL/mlhKWFF0/n8LzHm/PW/D6REaUqsEQWknJxhkpgys3j
 zkeWb5pSr41qvkD5gFgZa1OdtyhXmno73VuLV0utN+D9S7uV2EopUJpURT7FkTfh6d
 g2gDqaxG+uVD0jgf9bNUTbTW5LiOLiRCi2HCl6miNvdyfJ3xLPe4QNfsXnU3g+qpKh
 vIc3uNp0sdBmQ==
From: Mark Brown <broonie@kernel.org>
To: lars@metafoo.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 tiwai@suse.com, Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz
In-Reply-To: <1612509985-11063-1-git-send-email-shengjiu.wang@nxp.com>
References: <1612509985-11063-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATH] ASoC: dmaengine_pcm: add peripheral configuration
Message-Id: <161255607746.56562.2848342434481411880.b4-ty@kernel.org>
Date: Fri, 05 Feb 2021 20:14:37 +0000
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

On Fri, 5 Feb 2021 15:26:25 +0800, Shengjiu Wang wrote:
> The commit e7bbb7acabf4 ("dmaengine: add peripheral configuration")
> adds peripheral configuration for dma_slave_config.
> 
> This configuration is useful for some audio peripherals, for
> example, the peripheral supports multi fifos, we can
> let the DMA know which fifos are selected. So also add
> this configuration for snd_dmaengine_dai_dma_data.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dmaengine_pcm: add peripheral configuration
      commit: 500c9f8c58a7c8cd5d9c1483569c046cfcfc47a4

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
