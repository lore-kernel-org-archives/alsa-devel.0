Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58239C6FA8B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 23:14:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 927BC847;
	Tue, 20 Sep 2022 01:13:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 927BC847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663629256;
	bh=HzTSH25M/bdML0NecfkNNysiDEseO4Il3lhE0emB6cQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dHwfnNFdw/KiBSc5w/XN9w594NmQJSDH3e+YfzXnw4hi/vj5d4Fz5TT1SbT2nP7bl
	 C5RTYlHUZ3mdw5tkr/T1Szt2ivtltWSTrp2FQcSFZnBTLk9tlLE3yygHfI6xqfA+W6
	 AaBlgdb5sf1trEX1VptzIcbfrw4d50zvpRkD+BbU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B32CCF805BA;
	Tue, 20 Sep 2022 01:10:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A66AF805B5; Tue, 20 Sep 2022 01:10:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C96D8F805AA
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 01:10:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C96D8F805AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eZ5bj8bn"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 78045620DE;
 Mon, 19 Sep 2022 23:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A87C433C1;
 Mon, 19 Sep 2022 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663629020;
 bh=HzTSH25M/bdML0NecfkNNysiDEseO4Il3lhE0emB6cQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=eZ5bj8bnUD3G495Cp0WgVgrMjgL0hvah1uyGV8J2cCzm1+NFxD3QcLlXQveX85Hu2
 /VcuTifL2KzBTpb8QNw9r9wyQ6LCiNlSvONPlfKrIyk6W+G2u/GC7u2ssAizHD3vtE
 Z8jOmg1/ybi/1Ri1qcYZqdwTgaLMox7RJ5z/Y/71MBF67+LVy8TdmdKWnuu2hHwE6q
 rR+3B6OKV344WGe5qrENOcFrq8P1Ion77TC6FrGNgDGc6qsnv20G37q2Ax3I787O19
 ubECaxd0ibv0Sn2kI/4hw5os6TDSc/cIx5bPOH/eIcDsVgp4TAhNnBtW4toAIH3u/b
 EaCoioeWcdZPg==
From: Mark Brown <broonie@kernel.org>
To: steve.lee.analog@gmail.com, lgirdwood@gmail.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220916111349.4433-1-peter.ujfalusi@linux.intel.com>
References: <20220916111349.4433-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: max98390: Fix dsm calibration reading
Message-Id: <166362901910.3419825.6536843704311895151.b4-ty@kernel.org>
Date: Tue, 20 Sep 2022 00:10:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: fred.oh@linux.intel.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com
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

On Fri, 16 Sep 2022 14:13:49 +0300, Peter Ujfalusi wrote:
> With the change introduced by 6ac246105b4f, the calibration can only be
> done after the codec probe (but questionable if it is working since
> 203A_AMP_EN is 0) or when the codec is powered up for audio use, in other
> cases "AMP is not ready to run calibration" is printed.
> 
> This changes how this worked before the patch: the codec was force powered
> on for the duration of the calibration readout, then shut down.
> So, if a calibration was asked when the codec was active, it would have
> powered it down?
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: Fix dsm calibration reading
      commit: 9dd28b467c35eef320a2974f6b1f209343ad8704

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
