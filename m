Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E3CC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jun 2022 10:33:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B844986F;
	Tue, 28 Jun 2022 12:32:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B844986F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656412413;
	bh=r76Re/xOvLzrRf/PxMnn/Z5S0c5ucm9VBXxqbgjKa18=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bcrose6oOk4r/xAJK+y3pWA6ovLSKtKGMY33/SMkpc2jz+YnDEqfirlU0lsZRHO24
	 WC8QLwdH91NzMyoEeudf7AyCtO7w4949U3odv7/7PSephcOLkDsL6HE1N0neEMfX0s
	 LYUgvppDkBjdG1ok8GZzzfyBY9y76s4sTRHzqhWU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95339F8053C;
	Tue, 28 Jun 2022 12:31:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4571F8049E; Tue, 28 Jun 2022 12:31:27 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FDE3F80166
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2022 12:31:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FDE3F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="B9eJcXaj"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 110CDB81DCD;
 Tue, 28 Jun 2022 10:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689D8C3411D;
 Tue, 28 Jun 2022 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656412282;
 bh=r76Re/xOvLzrRf/PxMnn/Z5S0c5ucm9VBXxqbgjKa18=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=B9eJcXaj/ZLWGZzuPRwnpDAMZDbCDBYL0iL0qxO6gUiDKzHslZesvupktrwqxMXTb
 JPgW8KYbOxZb+8Y6Mzsm1sgpB/uLJdChhZgUhyOQe5oOesUgrdePSMmaZAYyPLCaHC
 65GXd27NDWIzc29nmaR7QKdRr4juX/ESmKMwBupsKxzCmoEKKdcCFix3HfkiTI326P
 4shdcFP1jjdZwf7BHJXtCNAq8a0xb/GPJb0w3dD76tWO8ObZFTGSbJTtatOkCLfDN2
 obTDbPW/57RFnLo3IPTpEzvXOgPUXYZmpdg94/y+knRcSdEIae3c4uJ5wbNi3/C3s8
 TXtTyBkQJ4ilA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, krzysztof.kozlowski@linaro.org,
 Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
References: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: samsung: s3c-i2s-v2: Allow build for
 unsupported hardware
Message-Id: <165641228114.254424.9239114588786840760.b4-ty@kernel.org>
Date: Tue, 28 Jun 2022 11:31:21 +0100
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

On Mon, 27 Jun 2022 16:34:10 +0200, Krzysztof Kozlowski wrote:
> There is no particular need to restrict building of S3C I2S driver to
> supported platforms within the C unit, because Kconfig does it.
> Removing such restricting #ifdef from s3c-i2s-v2 allows compile testing
> it on other platforms.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: samsung: s3c-i2s-v2: Allow build for unsupported hardware
      commit: 17a1ffc7bc4d5b4657d0f3fe5c01778d8fcab9a3
[2/3] ASoC: samsung: s3c24xx-i2s: Drop unneeded gpio.h include
      commit: 3e4bac7cf06e46225322f264e7387efe6ddd457e
[3/3] ASoC: samsung: Enable compile test
      commit: f43ff8038e8289ca811b5b89e8cc15083dafe5c4

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
