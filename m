Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1F5C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jan 2022 10:25:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C2C82817;
	Tue, 25 Jan 2022 11:24:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C2C82817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643106336;
	bh=V+CXNMlBJLDkVnoMPBK0epjEdchEM7zxpeDI595A+Bw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RXC4UGOGdeaIiKublk2AtxaFP/d7Xz1wtNj1x6yw43L+u+CX0fVjBv/cbE8M01hOO
	 OMQFFHcNMX5w06bQ6PuPrmaf1tKabRGV5kPdA2Rz3Ed6/1ZN7MyUZ+YUiJ2RfaWAjU
	 I1TRlZwA6TyRh/Ewn6cQrxevkfgfvMnV9zkja6qA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F047CF804CF;
	Tue, 25 Jan 2022 11:20:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8759F8056F; Tue, 25 Jan 2022 11:20:48 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DA4FF80551
 for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2022 11:20:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DA4FF80551
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="te+l92wR"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8E21F61635;
 Tue, 25 Jan 2022 10:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5890EC340E9;
 Tue, 25 Jan 2022 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643106044;
 bh=V+CXNMlBJLDkVnoMPBK0epjEdchEM7zxpeDI595A+Bw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=te+l92wRX7p451mWxm/bQ9/Y7QwQ07TyYhXRvd9JGv6T/QJXaQwZJbzN9g/qFFxUk
 7yF5WuiSVn5Hct9ABnMSV/YjmNtZcaWqi/fcXTmlLHaa4Jh/w4s4TJcDf/7gDaFTEv
 +QUBe5zdsQkVHx5UdhqqFlDxEEtuuDUN6va0lsim7mSQ9CB3rDl4LO1NZwtB/XgzzB
 k5F1g1ZZjJbeSEBbwuZd9MCvhVnVBNFeJIZBDx6EB5LQVesvo8Y7lacUCouRoHmKzb
 +pvRQnvYXCGk9sWrb5dWfA2UeZk0Uu/WG0GEeBgxg3GNGlnDH190K3hb+BHf7bChgv
 M1qT64xqFZYPA==
From: Mark Brown <broonie@kernel.org>
To: V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20220122194707.2661026-1-vsujithkumar.reddy@amd.com>
References: <20220122194707.2661026-1-vsujithkumar.reddy@amd.com>
Subject: Re: [PATCH] ASoC: amd: sof-mach: Add support for RT5682S and RT1019
 card
Message-Id: <164310604108.74844.4371897613558454989.b4-ty@kernel.org>
Date: Tue, 25 Jan 2022 10:20:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sunil-kumar.Dommati@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Kai Vehmanen <kai.vehmanen@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vijendar.Mukunda@amd.com, Daniel Baluta <daniel.baluta@nxp.com>
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

On Sun, 23 Jan 2022 01:16:59 +0530, V sujith kumar Reddy wrote:
> We have new platform with rt5682s as a primary codec and rt1019 as an
> amp codec. Add machine struct to register sof audio based sound card
> on such Chrome machine.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: sof-mach: Add support for RT5682S and RT1019 card
      commit: 330dc18356e697eaf9796732b6acbdf948022136

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
