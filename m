Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31609C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:16:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94D56128E
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94D56128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1857D828;
	Tue, 22 Jun 2021 17:15:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1857D828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624374990;
	bh=tq5W3HglBF9jy+mJvlAU7lrMCvmo4pvk0yjiPuf4/xk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=msL6Vb31xpxg4nsbX8W16RG6QW4349SL2J7qdDy0fmExTBMKFUzHJ71spb7sLbQ+b
	 PVyn2v+lgvm+RMTpkXbH+E2BfJ4+6HbxyQ/bu+gS2u/NItNWywSJPKywKEh+746ia5
	 tuu0e6Vg6KhLHYe0+Qt06SsAb1LPWxtOKj3gJrG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5065F80424;
	Tue, 22 Jun 2021 17:14:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87BA0F80268; Tue, 22 Jun 2021 17:14:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 039B9F800E1
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 17:14:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 039B9F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XL3S/7xb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 864BE600D3;
 Tue, 22 Jun 2021 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624374879;
 bh=tq5W3HglBF9jy+mJvlAU7lrMCvmo4pvk0yjiPuf4/xk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XL3S/7xbkKgf1TrgRLc11BaBRHJ1nsarxcrvBseoyoZN6FtUM90Eh4mD2gCbdS+th
 SfLvRws8xd8LydAe0yOkyrcNYseRW460yO5xSpUfFu2Jz01guOeNeO1UD61L8aayBi
 n1OQY97sXsY/1Zc7hHDcTAS6m/IS7QjaElauE/L/JuCo/a+H3pWMa45yc2XYAu2P+v
 ztDpx+p4aktwtT/LARiSyQTIlVs40j/+lORZzl9ZAHXtJ1QO2Yml4nxAuD1xRwIZPB
 SoZN5nouq5Su4diURilLDobNThZCwARFE7hz11rgqBssLqmLi3QFrBdjno1Iu6HJ3o
 16CBVm8czFFog==
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>, Jaroslav Kysela <perex@perex.cz>,
 Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jon Hunter <jonathanh@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Date: Tue, 22 Jun 2021 16:14:04 +0100
Message-Id: <162437355278.1773.13469789646711861169.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Tue, 22 Jun 2021 10:27:09 +0200, Guido Günther wrote:
> alsa-ucm groups by driver name so fill that in as well. Otherwise the
> presented information is redundant and doesn't reflect the used
> driver. We can't just use 'asoc-simple-card' since the driver name is
> restricted to 15 characters.
> 
> Before:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card: Fill in driver name
      commit: 907f0a3051869a61499905377212500155bd28ec

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
