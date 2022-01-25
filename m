Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C510C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jan 2022 10:22:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 947BA20FD;
	Tue, 25 Jan 2022 11:21:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 947BA20FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643106146;
	bh=ExbJRYNtfVD1s5WkJJibRPzKPc9HJ2TEz1/Xye0GnXE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y5cOJdyYVeyQ0Z3DFIR1S9jaWXYfE0UKpIOEJa0t0bH2JbnGDXm5+jCS1o4iXq42c
	 R8LJR/okA9R36aJASWpOgZE022EsZtXjxcYxqLxLulGbgnEw2G4SHumW+7UeKe7cMM
	 kKX1ZI2ggUV/L6VyLjrU5kjy8mhBu0ExIYl6S1Yg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C557F8051B;
	Tue, 25 Jan 2022 11:20:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D868F80508; Tue, 25 Jan 2022 11:20:24 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C0BFF8050F
 for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2022 11:20:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C0BFF8050F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XbBlcFol"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6F830B81752;
 Tue, 25 Jan 2022 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A70AC340E0;
 Tue, 25 Jan 2022 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643106019;
 bh=ExbJRYNtfVD1s5WkJJibRPzKPc9HJ2TEz1/Xye0GnXE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=XbBlcFolcJ6CjYh6lffKWnbPXVNuKPmolwII2mPN6HFOtV+DbYrhaOxuxUHzCwQBK
 QVsKwUNhkAVuBSHAJsACTa5GGTBWURu+7HHedxIe4nYy2KyD4ThndS1Ssd+DzfGT18
 oHN3VHIyY9u5+HnKdh8ngPTPDHky+2SsurRy3YRAQaw18DNQ6qp05ikAx9qWHxYslS
 x9SFRb/9fpYATYGMxkvIEOMoJYQZ5tGpYKJXY7wcSDnb5dG9WK7JuncBzMCY133C9r
 ES23EZdRWJ4MXm3YZQfCKvUJJiZIPR87gD1mvsXOAhK6wLybyck9eTzPVPpbxcS39Q
 PHK9zlqoS1fcA==
From: Mark Brown <broonie@kernel.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
In-Reply-To: <20220114065713.1246619-1-jiasheng@iscas.ac.cn>
References: <20220114065713.1246619-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] ASoC: codecs: Check for error pointer after calling
 devm_regmap_init_mmio
Message-Id: <164310601716.74844.9223636725378282440.b4-ty@kernel.org>
Date: Tue, 25 Jan 2022 10:20:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, bgoswami@codeaurora.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
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

On Fri, 14 Jan 2022 14:57:13 +0800, Jiasheng Jiang wrote:
> Since the possible failure of the devm_regmap_init_mmio(), it will
> return error pointer and be assigned to the regmap.
> Then the error pointer will be dereferenced.
> For example rx->regmap will be used in rx_macro_mclk_enable().
> Therefore, it should be better to check it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
      commit: aa505ecccf2ae7546e0e262d574e18a9241f3005

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
