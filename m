Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EDCECAAD5
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Aug 2022 19:05:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD22916A3;
	Tue, 30 Aug 2022 21:04:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD22916A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661886341;
	bh=eFPF/n6jVsSaGykmhj+28XDu8sEBKuaI1h0KdA5loS4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/F+EcNB4eYTLDQvrvco79Jq3B6oCoiLa1dY1RZ7C4FpnV20Kt1h6OQ7uX/M/T+89
	 0IsLXA7n1xH8XoLJapa030HMUjZjsk3rt8BDWcqxu9P6kGhZLSfpc9XUyst8WueXWR
	 SdlhdjY9d6zBtqWqfe9bdnjFw2EcjDyp4nhvy7S4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 099AAF8016B;
	Tue, 30 Aug 2022 21:04:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3E72F800F2; Tue, 30 Aug 2022 21:04:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC00FF800F2
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2022 21:04:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC00FF800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="b18RNr1x"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A618361614;
 Tue, 30 Aug 2022 19:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7ACC433D7;
 Tue, 30 Aug 2022 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661886281;
 bh=eFPF/n6jVsSaGykmhj+28XDu8sEBKuaI1h0KdA5loS4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=b18RNr1xIJMS30q6OSmh3Ztnx1M0lzSkW/gpBHTFX+Bcdwc4Hi87MqM7TFSrQaWaZ
 cCiMg0SF2H0WEFWnvk/b9zhjo/Ui5kTWNVL4t+nLc68qszjPH/W+QY+EaiKGnIIy3D
 T6VS75xwavRnhaoiAs8NMwrZRAZYapiIXrUsviGf8SNPTB3MNNCWtsJ1ftv2tcG0iI
 FDNcl4vy0bcZgJN0slgKWDAtmmMZVlrBufEf/NkH/4xC2Irr/zLr9gGREonyZFQN+P
 R9ZDpxa8oXFRl9WCNJ+OfHSrgaEfYPMH/hS2IjVJtqc0AZAWCIK6SkS/lNMTRhRQvE
 zf1mfLJxt5lQA==
From: Mark Brown <broonie@kernel.org>
To: Syed Saba Kareem <Syed.SabaKareem@amd.com>, alsa-devel@alsa-project.org
In-Reply-To: <20220830132259.7759-1-Syed.SabaKareem@amd.com>
References: <20220830132259.7759-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix spelling mistake: "i.e" -> "i.e."
Message-Id: <166188627628.1152207.14297370595024106059.b4-ty@kernel.org>
Date: Tue, 30 Aug 2022 20:04:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Cc: Sunil-kumar.Dommati@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Julian Braha <julianbraha@gmail.com>, Vijendar.Mukunda@amd.com,
 Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>
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

On Tue, 30 Aug 2022 18:52:55 +0530, Syed Saba Kareem wrote:
> From: Syed Saba kareem <Syed.SabaKareem@amd.com>
> 
> trivial fix to spelling mistake in Kconfig File.
> 
> Reported by : Randy Dunlap <rdunlap@infradead.org>
> 
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix spelling mistake: "i.e" -> "i.e."
      commit: ced579dcaaa45fe16ac6c12fe847d650734af7bb

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
