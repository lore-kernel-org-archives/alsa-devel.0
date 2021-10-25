Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE3C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 19:42:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E9160551
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 19:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27E9160551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54B7D16CD;
	Mon, 25 Oct 2021 21:41:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54B7D16CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635190922;
	bh=SWSZ5eJgNkHDzYT39xYlU4NRFfwLZQLQLrjfCgyPeZQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMvgq2jh2xmAHfM3nc8ShYIjO0UPfZS9NllfreCHxMrCQwSLLfl2idI0o03PsGbtr
	 OyI0vVIKXpKnGFbEVerYFxbilzm/ABboTdC6v8ewsRaPKbZHff5G2vxDcqBxBTN8+4
	 hR19CmVG5BhE0VusetLSKEcBYfYrTRhrvVjoOIrk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DD94F8027B;
	Mon, 25 Oct 2021 21:40:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7389F8032B; Mon, 25 Oct 2021 21:40:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44487F80153
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 21:40:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44487F80153
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nNMVoW4u"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B0561211;
 Mon, 25 Oct 2021 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635190823;
 bh=SWSZ5eJgNkHDzYT39xYlU4NRFfwLZQLQLrjfCgyPeZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nNMVoW4u25ctiiTU8NzGP0343jp56lGM81hNph5YP2g5LM0S0Okry1WMh7Sglv3Vp
 MYaY5cK6vIHNd16wE2m0QBF4Mf2CjSGHghP0w/6dfTZGC1uEMSFjgzX+EiDRHPjm04
 gW0MLl7WSO6J1UO0oJYN9rXIx02RKDQRHyhsXmpW6yJwxcqL7Yhc/5S1kbIUt2XKrk
 TInI4WQl5kaSlEY+bdQ5OlAe6nnx7BTLTa/PzW9amz6bmuI0poFRPBU573oLX4EhTZ
 0UJxNVitr2CMw1qhpvI0y4zreWsgwNnBibalETyc8C7Hw458mKe96PfoIGe4aPKpyf
 IIdhgkl+Cv8iw==
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] ASoC: qcom: common: Respect status = "disabled" on DAI
 link nodes
Date: Mon, 25 Oct 2021 20:40:13 +0100
Message-Id: <163519067113.407220.13508385488507297441.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025105503.49444-1-stephan@gerhold.net>
References: <20211025105503.49444-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
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

On Mon, 25 Oct 2021 12:55:03 +0200, Stephan Gerhold wrote:
> At the moment, the DAI link nodes in the device tree always have to be
> specified completely in each device tree. However, the available
> interfaces (e.g. Primary/Secondary/Tertiary/Quaternary MI2S) are common
> for all devices of a SoC, so the majority of the definitions can be
> placed in a common device tree include to reduce boilerplate.
> 
> Make it possible to define such stubs in device tree includes by
> respecting the "status" property for the DAI link nodes. This is
> a trivial change that just requires switching to the _available_
> OF functions that check the "status" property additionally.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: common: Respect status = "disabled" on DAI link nodes
      commit: 4b29d5a0bdb9c0d52356dd04b4c08180e0c8aa71

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
