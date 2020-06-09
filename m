Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D4C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:55:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80B3206A4
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ujb1Azps";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNl6PiKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80B3206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45ABB166D;
	Tue,  9 Jun 2020 14:54:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45ABB166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591707348;
	bh=s6DjVd5S/9BMaBHFd1sXcmmcw3hwmnb2raoYKakwRWc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ujb1Azpsm0sMV88ZT+6tc0F4sft1MdMzWpOI51pZCEl4h2M842+N48XYzZfePdltf
	 nEvQSfloQxXmuaC+RHbRPbg1Lt+3dA+W0Q75KYRqmj72dsX+TddqbRuUeGQX9Efk+r
	 q8gncdVk329nzC6Z13ihJDJjrOLKhOoJgLlwYREs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0989F80278;
	Tue,  9 Jun 2020 14:54:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0993BF8028C; Tue,  9 Jun 2020 14:54:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE58CF800F1
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 14:54:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE58CF800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dNl6PiKG"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EAC30206A4;
 Tue,  9 Jun 2020 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591707283;
 bh=s6DjVd5S/9BMaBHFd1sXcmmcw3hwmnb2raoYKakwRWc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=dNl6PiKGvSYn9EtRbIRN37OwxVFkRJ6JigXpcIGgtBn7yFIifpMp+FpXxNWy81CP0
 q/TXS0BDniJk36Hp8ST9U0GWXZkSZUuyb3UreVw0rbKlh8iRijWZ4iAza/1s8Ryruk
 cIEQ4UReD6Qw6TSMUeS7Gr/2vEIR1iZUR3KQ+I40=
Date: Tue, 09 Jun 2020 13:54:41 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 khilman@baylibre.com, trivial@kernel.org, tiwai@suse.com,
 linux-amlogic@lists.infradead.org, lgirdwood@gmail.com, jbrunet@baylibre.com,
 perex@perex.cz, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20200606153103.GA17905@amd>
References: <20200606153103.GA17905@amd>
Subject: Re: [PATCH] soc/meson: add missing free_irq() in error path
Message-Id: <159170728116.39758.7078171173608119495.b4-ty@kernel.org>
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

On Sat, 6 Jun 2020 17:31:03 +0200, Pavel Machek wrote:
> free_irq() is missing in case of error, fix that.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> 
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 2e9b56b29d31..b2e867113226 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -249,7 +249,7 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
>  	/* Enable pclk to access registers and clock the fifo ip */
>  	ret = clk_prepare_enable(fifo->pclk);
>  	if (ret)
> -		return ret;
> +		goto free_irq;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: add missing free_irq() in error path
      commit: 3b8a299a58b2afce464ae11324b59dcf0f1d10a7

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
