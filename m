Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B635AC41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:23:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D4206DD
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RY+XoL6P";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0lH4RAry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5D4206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AF79173C;
	Tue,  6 Oct 2020 17:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AF79173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601997787;
	bh=IL1qUaq16zUuaudsbYu3xsH7hhilOeFElEGAdB2ZSW0=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RY+XoL6Pw5emhIL0Tip7rOyjfn/EtT3s69urLRCT+5ZvmFEA2HVSiykY6zSXDJBsf
	 CYwZAK2fpkjO9J/3os2EiFcjbKrmRI08NbSnWA/NCfA/NSZ44LRKIlsY93SsfdJ0Ga
	 yDoiXWvlXN4PL9NJHBvJu4VkckJgx4oAx05QAP5c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCB75F8015B;
	Tue,  6 Oct 2020 17:22:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB516F8015B; Tue,  6 Oct 2020 17:22:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D95DF8012B
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 17:21:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D95DF8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0lH4RAry"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6B02B20789;
 Tue,  6 Oct 2020 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601997715;
 bh=IL1qUaq16zUuaudsbYu3xsH7hhilOeFElEGAdB2ZSW0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=0lH4RAry/3jk/7lNm/uCSFWxzMhkOHkHY1QWm2a3yKVRgVYe63NARW6c9fc26vVEL
 iVJz4/tLGsDAjWblxHzlCTs5H8M89tKPjvYRkLjMT6aI3rDyZK68TU/W3FJgwMgVVV
 XcPAzEZI+KaiLSaQxeNgVFw2eEd1hlUgMF9ywYU8=
Date: Tue, 06 Oct 2020 16:20:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20201006101252.1890385-1-tzungbi@google.com>
References: <20201006101252.1890385-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8183-da7219: fix wrong ops for I2S3
Message-Id: <160199764658.51353.13573290899066355390.b4-ty@kernel.org>
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

On Tue, 6 Oct 2020 18:12:52 +0800, Tzung-Bi Shih wrote:
> DA7219 uses I2S2 and I2S3 for input and output respectively.  Commit
> 9e30251fb22e ("ASoC: mediatek: mt8183-da7219: support machine driver
> with rt1015") introduces a bug that:
> - If using I2S2 solely, MCLK to DA7219 is 256FS.
> - If using I2S3 solely, MCLK to DA7219 is 128FS.
> - If using I2S3 first and then I2S2, the MCLK changes from 128FS to
>   256FS.  As a result, no sound output to the headset.  Also no sound
>   input from the headset microphone.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183-da7219: fix wrong ops for I2S3
      commit: ebb11d1d9fe2d6b4a47755f7f09b2b631046e308

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
