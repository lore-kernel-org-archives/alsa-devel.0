Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D942DC4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Nov 2022 14:28:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E96F41720;
	Fri, 25 Nov 2022 15:27:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E96F41720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669386517;
	bh=1hTsLsAyt9tlsWhWVofHJBaSZd45+Oiiml90QdlACHA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DYl3Y0cj8/pTwoaOjdYLlooxU+dBr7U0y+9Zb/bEviSq+zvojyIFvaF5qu2akKcQl
	 X6hn00lFkQTAFeX1Kjx9LcEd6Rtrm0J7fEI+xo4PHlXS31NjwjhWehdWL18t/GcP8H
	 4GjoPITmt1PmZL+MMiJpWhMhaLML7sar4bk855uY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37DB1F80542;
	Fri, 25 Nov 2022 15:27:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDCCEF80557; Fri, 25 Nov 2022 15:26:57 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D998F8014E
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2022 15:26:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D998F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d7i1XVye"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CFB2EB82B02;
 Fri, 25 Nov 2022 14:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E64C433D7;
 Fri, 25 Nov 2022 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669386413;
 bh=1hTsLsAyt9tlsWhWVofHJBaSZd45+Oiiml90QdlACHA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=d7i1XVyeymPD/W1dB8wSyfn631s2sYLxwcYl+RLcNcsR+oLFw/bWQO3xFUVKojZuW
 bq1AjRZFEQcjgWYrWDTD7sWLkBB8W+lc8T/KxjeshziQBlA+4xcpUtHlFCBHP8CSI/
 h6HfX42vHxnmYXUtcjxW0+U27Yn2g0dg9Hy0aIsA3mg/fRbeBbF5azaLBzpMHOtkUi
 FJ9XxcdliNtIir2Hh+545ihzDwwM9aDJP9ojpV+mS9Ycpub+z9RD8CC4Mxa8og/VWR
 XKW1tQZ7HxiLjAKKbasWJI1ZhTduyIvhfOQFQbfGywhD9tE+fuf7Eq0SXOUGwRm/vQ
 J5QG5vKihy7xw==
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, angelogioacchino.delregno@collabora.com,
 nfraprado@collabora.com
In-Reply-To: <20221123161130.543-1-jiaxin.yu@mediatek.com>
References: <20221123161130.543-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Correct I2S shared clocks
Message-Id: <166938641125.506633.2366556842342118458.b4-ty@kernel.org>
Date: Fri, 25 Nov 2022 14:26:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, chunxu.li@mediatek.com,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, ajye_huang@compal.corp-partner.google.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 24 Nov 2022 00:11:30 +0800, Jiaxin Yu wrote:
> In mt8186 platform, I2S2 should be the main I2S port that will provide the
> clock, on the contrary I2S3 should be the second I2S port that will use
> this clock.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Correct I2S shared clocks
      commit: 248579fc9a4f3bf36e7cfe9f6a354cee0f9848dc

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
