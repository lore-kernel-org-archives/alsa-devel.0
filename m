Return-Path: <SRS0=qlOX=OW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B733C433EF
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Oct 2021 01:38:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C9A61A3A
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Oct 2021 01:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7C9A61A3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67F0616E7;
	Sat,  2 Oct 2021 03:37:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67F0616E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633138698;
	bh=/PFYrRgQzQNC5+UvQ6oBrSSD6JkFm8iZPBKSwCs6r7A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Icz5TzdpyKhug1isjgXmUsW5x0Q32w8XUaKrIwYV474WOwKb+vv6l7aBVc5DoQFM0
	 pvCFOXysDmXIbhQvbzq4uUp5oXROUTRPVC6SpT9tRJE7gnw5++lIQuy+6n6qa9OZyA
	 RDAoBT8tpQnFHPbCrekjgQhSUhzWkjEyYZtYzf/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9964F80227;
	Sat,  2 Oct 2021 03:37:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6AEFF804BC; Sat,  2 Oct 2021 03:37:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E733F800F3
 for <alsa-devel@alsa-project.org>; Sat,  2 Oct 2021 03:37:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E733F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="onynCkVU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 415ED619F7;
 Sat,  2 Oct 2021 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633138634;
 bh=/PFYrRgQzQNC5+UvQ6oBrSSD6JkFm8iZPBKSwCs6r7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=onynCkVUn5KC8VWX8EBPOkUQiasgtccgZmdCx862Qsv1njdxv6bn+9wszDk2j9S2Q
 RzlVfWgX6eok2MLf5vE25mAV2OtKx3cmmrqTlLrSERSurVeqLraqcsiIa3eDFD/rJ3
 O9M52WLGwd81tS7ECugTW0Nin6a6ZpxP06cTweMSbfdBMc+3Kl0MDKV/Vq6S/pcYcj
 vpn4NJIPLVLMMyLEDZwSpqsBYxsTc3HYvGmOTruL+cWN+c+i0STQq5Ik+qu/Qo62Hw
 alUGqWe80WbS20wlk9zfxGFek7a6jRSIO6fJSBtDDxq7g1RA4kADalvcib/5ILre3Z
 svgYjFXnyKfLA==
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8821: new driver
Date: Sat,  2 Oct 2021 02:37:07 +0100
Message-Id: <163313828655.2275577.8876974502079799331.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001103108.3297848-1-wtli@nuvoton.com>
References: <20211001103108.3297848-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, scott6986@gmail.com,
 Mark Brown <broonie@kernel.org>, KCHSU0@nuvoton.com, lgirdwood@gmail.com,
 YHCHuang@nuvoton.com, michelle.chen@amd.com, CTLIN0@nuvoton.com,
 dardar923@gmail.com, supercraig0719@gmail.com
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

On Fri, 1 Oct 2021 18:31:08 +0800, Seven Lee wrote:
> The driver is for codec NAU88L21 of Nuvoton Technology Corporation.
> The NAU88L21 is an ultra-low power high performance audio codec that
> supports both analog and digital audio functions.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8821: new driver
      commit: aab1ad11d69fa7f35cb88105614ea7911598e1d6

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
