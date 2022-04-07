Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FD2C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Apr 2022 09:39:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A26C1852;
	Thu,  7 Apr 2022 11:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A26C1852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649324397;
	bh=TNEhWEcbjVm0jSKmKL51ANFFVzUTdaJeILNY7yjz2wE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uNtwQtDl9SUqyZHKQbDKGaunaKwTBrueykH9FgEnaplEcA6PnKtqBXWNHFaSLo6zA
	 967YceOsqex5yoRQf8q/pr2EgqWz0iLwzWkvkibJVOh+mgAguyZ0nOGEknVKvE6cfm
	 6irVMIl/zr+c0n4AKllddfxWmZnRQXUHES9+1tUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F92FF80519;
	Thu,  7 Apr 2022 11:38:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23700F80524; Thu,  7 Apr 2022 11:38:29 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B194F8051C
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2022 11:38:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B194F8051C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AkNzu5jV"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 34D83B826ED;
 Thu,  7 Apr 2022 09:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B3C385A0;
 Thu,  7 Apr 2022 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649324302;
 bh=TNEhWEcbjVm0jSKmKL51ANFFVzUTdaJeILNY7yjz2wE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=AkNzu5jVfmFLbY73qSLFCkKgbC5mQU8ox5OhjQrnqsajckQcDygHtwot08RpbpgV7
 WdwNcZ3dihjkVHkjvPYc/QK0QmTtunaR+o65UT1rmyElyIzdEjw9WnzNRMFT2BmXcP
 zHqVyIhcj6c+PJuWzfYvuiO2AEaSP6+U6KS0SFcL7t9ZYG4GCvNQ7V/v2svMEb/Fw9
 qRsBxnn0LhfDx1KgGQJH7vdYJx38aXOeAvFIOj6fFBBZAcI2ghlpZQM/l1fL9hro+L
 gTFPrLhYsZKA3NKeolatR8eo4NioBX6IpUbwfN0tw9hgPn62aLFLnNEllnPV1bzDhd
 GBehfKplDTV0Q==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, perex@perex.cz, nizhen@uniontech.com
In-Reply-To: <20220314054621.14694-1-nizhen@uniontech.com>
References: <20220314054621.14694-1-nizhen@uniontech.com>
Subject: Re: [PATCH v2] ASoC: Intel: boards: Use temporary variable for struct
 device
Message-Id: <164932430152.3844153.10230903353373172658.b4-ty@kernel.org>
Date: Thu, 07 Apr 2022 10:38:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Mon, 14 Mar 2022 13:46:21 +0800, Zhen Ni wrote:
> Use temporary variable for struct device to make code neater.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: boards: Use temporary variable for struct device
      commit: 8b3520f7f6f6b54bb6b6e50b88f707a6b8113887

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
