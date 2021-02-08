Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4190C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 18:40:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E462964E6B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 18:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E462964E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55ECF169F;
	Mon,  8 Feb 2021 19:39:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55ECF169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612809647;
	bh=9TTZZw3q3O0A2iUkVrd4u4Jlc4Pb1l3noBBoy0LEpaw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lKQe9iNV6q4XuRxRqt5vT0p4s+LSEqNyI1hq9VPn+XxFS5Ssu/4QHlZzaenUW+KtU
	 8ehhBFLNv0pb1clISogWb1bjBF+dYWyPSyQGMceZ9wHIYrjrAWv6utrmSyTlSKhaI/
	 e2zk8lxK3pXuEgUJEhcR5Jyc0GSNpbWgTC/i7PS0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2CB5F80240;
	Mon,  8 Feb 2021 19:39:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97505F80114; Mon,  8 Feb 2021 19:39:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03635F80114
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 19:39:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03635F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Cx6cgD2K"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CDDC64E60;
 Mon,  8 Feb 2021 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612809542;
 bh=9TTZZw3q3O0A2iUkVrd4u4Jlc4Pb1l3noBBoy0LEpaw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Cx6cgD2Kad0MvzutSRSHnzVG0fwkxSbaj+4rIzLxmT1URrxpx9OsIVD1dZX67YK5T
 k9rr66QXY2zR4XghypCugiVHR9SQN9T+ihs4kallg2tq/+7XYKFnzIwKxDZiXmxD26
 Tsil81WRa6e3FLRgg1ByN+qjPbFJjQf1GnLe7nOGLeqpFgDwxyVrJWMKfr6mTbHpNU
 niwC2WE8wVxvSjp4Lid9ucWPmKLHw6op1ALmJJuTXbiYeXXwYv9ecinXgdsWqrr5oe
 lbliZNk8KP6+Jc9zOt+OAeS1MRrdEgYjPjDBzwen3CVkTFkgm8TF6duhgvF99xPEL5
 VUxlYjBmRvu9w==
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <1612719418-5858-1-git-send-email-spujar@nvidia.com>
References: <1612719418-5858-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v3 0/2] Rename audio graph export functions
Message-Id: <161280948305.10741.16503179975301818382.b4-ty@kernel.org>
Date: Mon, 08 Feb 2021 18:38:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, sharadg@nvidia.com
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

On Sun, 7 Feb 2021 23:06:56 +0530, Sameer Pujar wrote:
> This series renames exported functions from audio graph for a better
> global visibility. In doing so update the references in audio graph
> and Tegra audio graph card drivers.
> 
> 
> Changelog
> =========
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: audio-graph: Rename functions needed for export
      commit: 6e4ea8aace02479186b3fdaab48d7acfe06d8715
[2/2] ASoC: tegra: Add driver remove() callback
      commit: 0d7475d2a5a90127a2f87961b99bcd8f95694dd9

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
