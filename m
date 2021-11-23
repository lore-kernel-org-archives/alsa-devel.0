Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F52AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 00:02:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A1B984A;
	Tue, 23 Nov 2021 01:01:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A1B984A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637625757;
	bh=+/8tGuihtwZs7BaBjZSeqkgIiZQe+9d5nEnft6ZuQuA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVIrlMhoBLJJpoFultUADKKswik+8/AvxuGPQYsMQJlGILmRqe8BGmnjzqN6ZVh+B
	 9tvk3D5NuTGIVu8sx15hjTEnsdRG8g8tU+pZtY7x0bevjFV0PZL5/0F6Q/g2m8xDns
	 RucQQ6lnzIPPdsgO2t3Istogmtm8aZxlQMj65Vb4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5961F80508;
	Tue, 23 Nov 2021 01:00:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 976EEF804F3; Tue, 23 Nov 2021 01:00:14 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C869F804ED
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 01:00:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C869F804ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ALAqmcn1"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 680B661004;
 Tue, 23 Nov 2021 00:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637625606;
 bh=+/8tGuihtwZs7BaBjZSeqkgIiZQe+9d5nEnft6ZuQuA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ALAqmcn1/bnAKFE5uypJTtNY4R7eabaPO1BdzpHIaoXN2keRxkc0xOxueP3zow4qn
 cFzZBQ7d34jH/PlIE1GzzIlLV2XfTXdRRL0cxzgDlFMdDfdxnh4+vJ5+s6gkxIfMmI
 NLzF/mt5zHamnSyXjhNz2WUn6tqYhQOfH/OH9YQ/6k5MaL7DEiP7xABYX9xrfZIvrF
 HtTJsFzoPj0t3QLWowKsHcPHLpi+GLJ0RdBUyXEja+DxG3eAa/kpfA+1viRwcQoRHQ
 6SfttHUb9nkDr5T8DDKSHim6IqtD80Mi5XRDFlSwL71Xg9oLS7yogWitQuEOMalKxW
 mCSq1ndrAZblg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20211119094319.81674-1-daniel.baluta@oss.nxp.com>
References: <20211119094319.81674-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH v2 0/5] ASoC: SOF: Add PM support for i.MX8/i.MX8X/i.MX8M
Message-Id: <163762560411.2471742.17777975323343821279.b4-ty@kernel.org>
Date: Tue, 23 Nov 2021 00:00:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, daniel.baluta@gmail.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, linux-imx@nxp.com,
 daniel.baluta@nxp.com
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

On Fri, 19 Nov 2021 11:43:14 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patch series adds support for System PM and Runtime PM with SOF for
> i.MX8 platforms.
> 
> First patch adds common code to manage clocks, patch 2/3 adds the actual
> PM support, patch 4/5 implement the DSP start / reset callbacks for
> i.mx8m.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: SOF: imx: Add code to manage DSP related clocks
      commit: 8253aa4700b37cef1ca3bbda0d986349357608d3
[2/5] ASoC: SOF: imx8: Add runtime PM / System PM support
      commit: 6fc8515806dfd5b7d3198c189b51e7624aadafdc
[3/5] ASoC: SOF: imx8m: Add runtime PM / System PM support
      commit: a73b493d8e1b37acad686c15321d2eaab45567ce
[4/5] ASoC: SOF: imx8m: Implement DSP start
      commit: 9ba23717b2927071ddb49f3d6719244e3fe8f4c9
[5/5] ASoC: SOF: imx8m: Implement reset callback
      commit: 3bf4cd8b747a222f0f454f3220199c99f1c03da6

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
