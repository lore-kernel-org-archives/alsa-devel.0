Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DABC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jan 2022 10:24:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B8E720D4;
	Tue, 25 Jan 2022 11:23:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B8E720D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643106266;
	bh=teZpSSDIJO8MxzMjV0LQdvAm1PtEQNLwt0AmngnKKyI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WV5180sd65lbS+3mhucm8RCPY+5BYpf4WoN0bCwt2X52J1dnrM3/AydWwy/p5KwOr
	 cW8U6Ica/q+6xpG+7NZX+n3pBuJOu83BsGaC4ofQn/FywXHTgzJqxVKfsB6C7x71zF
	 EK9xyfTg6Ui6oCQCVAZ9mMcBl+MxbhtiVpzRRmi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C6FBF8054A;
	Tue, 25 Jan 2022 11:20:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BAC7F80535; Tue, 25 Jan 2022 11:20:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B153F8052E
 for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2022 11:20:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B153F8052E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dYPxNsfg"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACAC6163B;
 Tue, 25 Jan 2022 10:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4CBC340E0;
 Tue, 25 Jan 2022 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643106036;
 bh=teZpSSDIJO8MxzMjV0LQdvAm1PtEQNLwt0AmngnKKyI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=dYPxNsfgvNGvhmD+fMaXfnYHhV3TJYQ57AavGj92hdZnTsmn51oewzSYGtjgpZFA8
 kCXMb5eZHPQGcQHt1UWvCcN0fpq2EdWg9bAhIAz1DbaV48P3rRNf1+6Tn6rqRrJ8Tp
 rHUWTtlocmLtQl8jblnWlzeUbHPCrN6qyMWwbS5TzGIkCfhgjQ7LLWmoWzu3RYppn1
 qotbJ6YjF8Kg/ORPJ+oTKgfKZ7hcqwuiFUeCSRQKaiT08/maQlZTXgySNiaYTx4B1e
 jlcueyAC0HIKNsDFz9jGaj2Dwr5n2zZvYgUF4OFQTul62rgURXMpidnMz1GuVQReQ6
 RTM1UdDu4ZWLQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20220121120412.672284-1-rf@opensource.cirrus.com>
References: <20220121120412.672284-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/3] ASOC: cs42l42: Add support for system suspend
Message-Id: <164310603562.74844.1855667686976141960.b4-ty@kernel.org>
Date: Tue, 25 Jan 2022 10:20:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Fri, 21 Jan 2022 12:04:09 +0000, Richard Fitzgerald wrote:
> Add system suspend and resume handlers so that the cs42l42 is cleanly
> put into power-off state during system suspend and the registers are
> restored in resume.
> 
> The first two patches separate out two small changes that can stand
> alone and are needed to enable the system suspend implementation:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs42l42: Report full jack status when plug is detected
      commit: 8d06f797f844d04a961f201f886f7f9985edc9bf
[2/3] ASoC: cs42l42: Change jack_detect_mutex to a lock of all IRQ handling
      commit: 5982b5a8ec7ddb076e774bdd0b17d74681ab0943
[3/3] ASoC: cs42l42: Handle system suspend
      commit: f8593e88540052b3feaf1fb36f2c1c0484c9dc14

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
