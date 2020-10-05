Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27999C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:58:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554D0207EA
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XG+yZbJN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixGwxmv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554D0207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5EA8179D;
	Mon,  5 Oct 2020 19:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5EA8179D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601920709;
	bh=WXHa6/wvYZth1GPUhzSzyB/GuNKAlqCbTCHovfE5AC8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XG+yZbJNr8S4GaxsOsW0RiwCrdnlKSaBesvn06D0rekOPDFpInKrCPq+P7wFkjWCi
	 zsDs56aNpnIjRWWmWmaDGFtqxf9JS1u1G3grZsGucyCsuUC8U3bLH9+iLTSLNZQ/ew
	 htXAE4WzbE0LUdfryHWMivsiej6eIvjEVSL5UHsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1272F802EB;
	Mon,  5 Oct 2020 19:55:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C706F802E2; Mon,  5 Oct 2020 19:55:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2B08F802DC
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 19:55:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2B08F802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ixGwxmv8"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9329E2083B;
 Mon,  5 Oct 2020 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601920515;
 bh=WXHa6/wvYZth1GPUhzSzyB/GuNKAlqCbTCHovfE5AC8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ixGwxmv8lsFDsWrAjVGiNu94jjW5itloGmDVF//3U/sS8+NeX7d1BhHWyKHT65FaY
 TzVXByn88aOt4KHtq+Su7lJct727Uye5zYifQfEICK9W3dm1om1wRK/1lnT7/I/4hQ
 fyvapWMjuZSTbBbRuTF5pAPXB1CGfOFEZvnGTZ4w=
Date: Mon, 05 Oct 2020 18:54:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Jaroslav Kysela <perex@perex.cz>, Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
Subject: Re: [PATCH 00/25] ASoC: sun8i-codec: support for AIF2 and AIF3
Message-Id: <160192043040.23051.6290933944339800097.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Wed, 30 Sep 2020 21:11:23 -0500, Samuel Holland wrote:
> This series adds support the other two AIFs present in the sun8i codec,
> which can be used for codec2codec DAI links.
> 
> This series first cleans up the DAPM component driver so there is an
> organized place to put the new widgets. Then it fills out the DAI
> driver, removing assumptions that were made for AIF1 (16 bits, 2
> channels, certain clock inversions). Some new logic is required to
> handle 3 DAIs and the ADC/DAC sharing the same clock. Finally, it adds
> the new DAIs, and hooks them up with DAPM widgets and routes per the
> hardware topology.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: sun8i-codec: Set up clock tree at probe time
      commit: d8f006825ac57e34f7ed5e63a1e16d889dc1508e
[2/8] ASoC: sun8i-codec: Swap module clock/reset dependencies
      commit: ed3caa3bd44c9ae1cebeb32d787adc5ed35e29fa
[3/8] ASoC: sun8i-codec: Sort DAPM controls, widgets, and routes
      commit: d58b7247087900414aa3e988e70ecba85e06f412
[4/8] ASoC: sun8i-codec: Consistently name DAPM widgets and routes
      commit: 7b51f3c7029fab706e7d9ac99f67cbcf8f29beca
[5/8] ASoC: sun8i-codec: Correct DAPM widget types
      commit: fc5668f62d089ba69b343f0e80146f5a3bc6fa71
[6/8] ASoC: sun8i-codec: Fix AIF widget channel references
      commit: 4ab60cef3149d57fe56add8c60ee7e6d45816f27
[7/8] ASoC: sun8i-codec: Enable AIF mono/stereo control
      commit: 18ebd62c30f0380da11d6c86e20b56c771ac1e18
[8/8] ASoC: sun8i-codec: Use snd_soc_dai_get_drvdata
      commit: a886990c9525e83146829c7711ce444ff652c98a

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
