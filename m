Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5556AC38A2A
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 12:20:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70DA2083B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b0dShwtQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwpyh3Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70DA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 408C9180F;
	Thu,  7 May 2020 14:19:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 408C9180F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588854008;
	bh=I5hKmcE5mcDLVhZaWDRwI64U3QpiZUFmJdDuCE+vXmE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b0dShwtQLP52EQZshxaWwwa/sooS24/gVsXCzgRbDaDXX8UOxEIyVxr2PmQB3Go/T
	 T5SfVRwiPuErz62pVP4Fc9/IRbKkesCUofhWfDt2DS9fY3msjBJoV6WeiNbY/7cUkO
	 SHlVAVX1wa+z9/TaxSyLd4V6yCXG35pCIHn3ik/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 276F7F80171;
	Thu,  7 May 2020 14:18:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4B55F801D9; Thu,  7 May 2020 14:18:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7ABAF800F6
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 14:18:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7ABAF800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fwpyh3Lq"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 618C320CC7;
 Thu,  7 May 2020 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588853901;
 bh=I5hKmcE5mcDLVhZaWDRwI64U3QpiZUFmJdDuCE+vXmE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=fwpyh3Lq9mAdWayXxnmENOvUYSaL7jTt72sbM3RezkaGAhPeWB5n+kBGgYIECnHHg
 rhiZgbOKFBvTWslJBreJjVlcVftxMHR2R4WhmM/Nw82hu5LE/J7/Urhwcxr4qSjXac
 6D73eceh/8FZ9DbaTnhzg6b6Wmx87GdNx1gwhibg=
Date: Thu, 07 May 2020 13:18:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>, Takashi Iwai <tiwai@suse.com>,
 Oder Chiou <oder_chiou@realtek.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200507094335.14302-1-weiyongjun1@huawei.com>
References: <20200507094335.14302-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: rt5677: Use devm_snd_soc_register_component()
Message-Id: <158885389338.38935.14311915230086603146.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
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

On Thu, 7 May 2020 09:43:35 +0000, Wei Yongjun wrote:
> Using devm_snd_soc_register_component() can make the code
> shorter and cleaner.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/codecs/rt5677-spi.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: rt5677: Use devm_snd_soc_register_component()
      commit: 9558ad215509b75c72c84f4f7691f1bd80fda42a

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
