Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C03AC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Feb 2022 16:55:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C4E61A2C;
	Thu, 10 Feb 2022 17:54:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C4E61A2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644512103;
	bh=UI4Mv4qVHEGpdjZQVIbbdsVyd0EHwfhjae+7UgeGC5A=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZVIKleiAku3i/opmDL3JEg1PJa5avwMCvfiZsZEOlp/qXRHvi8g1Uw5dCpcKW89af
	 4E+/Ogcf1OgMTG4nYCw1iOEpbVe/lQrxYZ9Bij9gpPMjyNQz/+gfgSuUz/SSfYNWjo
	 I6cR+hlHINdCgPH+Pg5HihxtUlMXbG7W3QYY1k7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D30FDF804FF;
	Thu, 10 Feb 2022 17:53:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7F02F80423; Thu, 10 Feb 2022 17:53:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B7A7F80423
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 17:53:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B7A7F80423
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IJIpXo/X"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 02C9A61006;
 Thu, 10 Feb 2022 16:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A957BC340EF;
 Thu, 10 Feb 2022 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644511995;
 bh=UI4Mv4qVHEGpdjZQVIbbdsVyd0EHwfhjae+7UgeGC5A=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=IJIpXo/XKmo35Zk76235PhkWQhhx2ZXUCwjuBTHnGRP7aOxOOr9sLUDkCaH0YjhlS
 KOf7KtFRKfiQhad8R9vEo19ffCmgJkjOCXKk3sjwTrfDXuL6+wQA6CvO73NOumJGCW
 2ZftkVvpDOyx5t/mBYWHZNM6qfGCz0ad8GJdTWv/zJfcaXrimPELka1cNItgms26MI
 oULj4UBvdGVfAfcwLRQZP2lh10wn/AWcwxZfD7C5uZF6JGKkPBJfZDSPhFiwscbJph
 S9G4lpKzN/25ZcCevsbhtnDcCUDqNGk+rcFhH1U/vQaHnLQJnNdGBzShehoeW8zrKx
 FH5z/ybSs6LWg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Oder Chiou <oder_chiou@realtek.com>
In-Reply-To: <20220210071900.17287-1-oder_chiou@realtek.com>
References: <20220210071900.17287-1-oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: Remove the sysclk and sysclk_src checking
Message-Id: <164451199341.2625306.11810466943506622797.b4-ty@kernel.org>
Date: Thu, 10 Feb 2022 16:53:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, spujar@nvidia.com,
 albertchen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

On Thu, 10 Feb 2022 15:19:00 +0800, Oder Chiou wrote:
> Remove the sysclk and sysclk_src checking in the function set_sysclk() to
> prevent the PLL power off. It is not getting re-programmed during
> subsequent runs after the first run (in BIAS_OFF stage).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5640: Remove the sysclk and sysclk_src checking
      commit: d9c5996ab37fca71b4d97440798d54dd87540c8b

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
