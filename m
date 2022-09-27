Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7AFC6FA90
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 10:36:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C05FAE8;
	Tue, 27 Sep 2022 12:35:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C05FAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664274970;
	bh=lJjHanQhAo4gyBUD5O9aZXDqaj4cVWoKZzJdtxw5DuA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qCZV9LSxP9WxkFpW8kue9NfpxBGnLXP4LtAp0azjbT7vupFqD+uw3YOS8h711Yevc
	 8z70LnO0Tk2d8Ke1hoiXGIYshp7QLRLTSX7sAmWOMEXQvwaTux4oinXoT2VqjLgcGa
	 J4HM+Fv4/8GELHSuU3zkoO3ryCnNixTZOMGp+s7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8A64F80542;
	Tue, 27 Sep 2022 12:34:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51ECEF804D0; Tue, 27 Sep 2022 12:34:25 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B970FF8024C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 12:34:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B970FF8024C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CDtX/a6m"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 19E85CE11DC;
 Tue, 27 Sep 2022 10:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A89C433D6;
 Tue, 27 Sep 2022 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664274854;
 bh=lJjHanQhAo4gyBUD5O9aZXDqaj4cVWoKZzJdtxw5DuA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CDtX/a6mIQ2vC0NJAzaCEB64k7Ktn/nkcVfB5d+zql6b1tDS+bYsfbMxxZXV9NyiI
 d0uaVEVow6ihw3hFu9M04xwn/rFN5+qs6+fNzlRx56SpSKmOIch0NdtgS87kRlvJeI
 qJKIzpBRzY7Zw9c/3QkBNUtnc1dt+m+1hpzG5/tgEA3rledkpx06XAm4/PiN2+ZaeW
 2MKQgMlbBczKEfUD9/IGt4P/wWD7kzyO8ZUoSbyBFTE8Zy2y1OiHp8hSEVky+ek4Ja
 K7ZNP6/Ux5369gTEX41zR7cqyN/YTRD2QUQst17JwYgFOGZn3+nOt5NYWQHlcEkW9x
 QfaWssp5X1fsw==
From: Mark Brown <broonie@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <e4acceab57a0d9e477a8d5890a45c5309e553e7c.1663875789.git.christophe.jaillet@wanadoo.fr>
References: <e4acceab57a0d9e477a8d5890a45c5309e553e7c.1663875789.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: da7219: Fix an error handling path in
 da7219_register_dai_clks()
Message-Id: <166427485225.60697.13131714629966036302.b4-ty@kernel.org>
Date: Tue, 27 Sep 2022 11:34:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
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

On Thu, 22 Sep 2022 21:44:57 +0200, Christophe JAILLET wrote:
> If clk_hw_register() fails, the corresponding clk should not be
> unregistered.
> 
> To handle errors from loops, clean up partial iterations before doing the
> goto.  So add a clk_hw_unregister().
> Then use a while (--i >= 0) loop in the unwind section.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Fix an error handling path in da7219_register_dai_clks()
      commit: abb4e4349afe7eecdb0499582f1c777031e3a7c8

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
