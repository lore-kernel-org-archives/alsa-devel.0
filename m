Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F04C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 16:13:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C6491DD;
	Mon,  7 Nov 2022 17:12:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C6491DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667837629;
	bh=Db683hampCuZTP16Yrgc889NP7L7eCCVMISCrOD8GKE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hR3ZjuIMUQK3eNXkg1U1fbPtTgAAFnyYR9BOJzraiqmp5qO+ziHT9KN9br/BcFp4H
	 H13ENyOTmjZsCMgPVTsbt21BHTxyWJqyOqkPFC8+kiLiVxYjAT/FNgnyXFRUUR6GpA
	 yBTTQprey7vfJzws6sdVcvsVXyKxCrKVjl9FyfKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEDB2F804BD;
	Mon,  7 Nov 2022 17:12:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B39F1F804DF; Mon,  7 Nov 2022 17:12:37 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 154D9F80116
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 17:12:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 154D9F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="e1pjMXY3"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D355E61191;
 Mon,  7 Nov 2022 16:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75176C43470;
 Mon,  7 Nov 2022 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667837551;
 bh=Db683hampCuZTP16Yrgc889NP7L7eCCVMISCrOD8GKE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=e1pjMXY3bNKWx8NEoDBjxFLFl7m0jj7uVVfBqRYXuNyFRXBUWFduAMDnJX9HEQzgs
 mTFUxqL5lp0Qxzn11YaZE3JFYfIJksKjQNj1730UleKqBUjWA4F1axEknja7Uu9rgC
 ZuKgkqHbbQB0fUcccpw9NxoNxA+ZzsZgUyzjwdsItMtYuE/OodD4ocyGgaojLXxZZW
 4UaGIjvYc+V1HnDgrJIMA91K3sI5ed4ZqnxY/2gzVnXedtJtWJ9688kx0NAPWNpGqy
 oewpGT06W0XEJ2JOeGGS26EuiTmIoTyJ+piTi+6DjvxH/mmo/HYr4A3mGaFDcJyTgf
 SWS4YYwUET/XQ==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com
In-Reply-To: <20221107090433.5146-1-peter.ujfalusi@linux.intel.com>
References: <20221107090433.5146-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: No need to assign core ID if token
 parsing failed
Message-Id: <166783755020.206087.17291687088093107144.b4-ty@kernel.org>
Date: Mon, 07 Nov 2022 16:12:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com
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

On Mon, 7 Nov 2022 11:04:33 +0200, Peter Ujfalusi wrote:
> Move the return value check before attempting to assign the core ID to the
> swidget since we are going to fail the sof_widget_ready() and free up
> swidget anyways.
> 
> Fixes: 909dadf21aae ("ASoC: SOF: topology: Make DAI widget parsing IPC agnostic")
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: topology: No need to assign core ID if token parsing failed
      commit: 3d59eaef49ca2db581156a7b77c9afc0546eefc0

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
