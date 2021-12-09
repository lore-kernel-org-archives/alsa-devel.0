Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75661C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Dec 2021 13:48:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10FE621EB;
	Thu,  9 Dec 2021 14:47:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10FE621EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639057724;
	bh=x+agiAdO+O8HMfHk6nHrE9Ld8pw385XGK369338bWJg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IX4Ca7vJv1Xc0MXnt8022msymSJ2KgbEzF+REJTSodhOcX4Sz5D2+HksMFopCLCnn
	 Qsl+dGJRMGhne67ma+HbaPYsyucOjkFOzDhXOGXmyFaomv+41JJZdjFZ7qWpwnL6MM
	 tG6EfeTBhxes3uFrkgnaAtLyhS7G7imhLOK+rzdE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B9EAF80259;
	Thu,  9 Dec 2021 14:47:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67AF3F8028D; Thu,  9 Dec 2021 14:47:50 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00773F80103
 for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2021 14:47:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00773F80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J6raT8fn"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9397BCE25B6;
 Thu,  9 Dec 2021 13:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28F7C004DD;
 Thu,  9 Dec 2021 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639057657;
 bh=x+agiAdO+O8HMfHk6nHrE9Ld8pw385XGK369338bWJg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=J6raT8fnRMM+0hL/+PwZjxcJX/lilIyDfXOGxb+K+/o4bBk+3EXmMi7yxdHQE4U+I
 9v3yn/ifnHJ5tVkPFCpF+CTYFOdXnDL/FN9QkLed0K8H+mp/fOjSMDXDw5c0ZoJ03o
 x9ZyX/EDVf54NOdW1d3a9wNGm5OctHhSfk+rfQc2cuuJCillSx7HK5YxruZTJlxdlH
 Bs0yKqyWcXdqFkHkBoDaF1GiwwajuI04SzXGQkygL6rYNOeBNp+t1WqOTa9aUkVe/G
 vcgnQwFMSPlWI+rD9jzCXr89kkxlM1Eg1r/8Jj4ZW9OKRx3vTdy5tV2rpT1SrPkuhK
 Kt9gKxRFwt9zA==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210915180957.39996-1-broonie@kernel.org>
References: <20210915180957.39996-1-broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: amd: Convert to new style DAI format definitions
Message-Id: <163905765661.1055325.9010200484005767100.b4-ty@kernel.org>
Date: Thu, 09 Dec 2021 13:47:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Wed, 15 Sep 2021 19:09:57 +0100, Mark Brown wrote:
> Convert the AMD machine drivers to use the new style defines for clocking
> in DAI formats.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Convert to new style DAI format definitions
      commit: 62df22396bea321435153cdba37585ad8ff9c567

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
