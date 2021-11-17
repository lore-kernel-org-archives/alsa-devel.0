Return-Path: <SRS0=ac5z=QE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F026C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 22:34:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED6D61279
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 22:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BED6D61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 215D61919;
	Wed, 17 Nov 2021 23:33:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 215D61919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637188443;
	bh=82ceyM9vLIZ5d639AKquHRPRlsJyYThu0VLcLZrUCsQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TUeQJfEGxe1JeNY1a3oRPxtMyQLSEPUVNrkbvyu6gP67wsysFztyBW8p5zHqdcijL
	 ahwt9JgxgDgsoT20FZtu9t0VUTKv+1AsUd0kSYRZgmGDDjk2/n3bFsq59JHkjIm81k
	 0E5b21cz4zlYPyZPFXIVTa3H3EAZu8g1JURNCv9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B8D7F804F2;
	Wed, 17 Nov 2021 23:31:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EE33F804ED; Wed, 17 Nov 2021 23:31:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2543CF8016C
 for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2021 23:31:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2543CF8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J3RSmq8f"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6783F61B51;
 Wed, 17 Nov 2021 22:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637188293;
 bh=82ceyM9vLIZ5d639AKquHRPRlsJyYThu0VLcLZrUCsQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=J3RSmq8f5DtAtBMTpQuFXsUkdjHMe8QUYV+p3x5v+xz796JdL3g8Uv2Nhdw+lwCo6
 C73plujiJiR6fLtvWWbGALyLIZBTrT5w1+nkAiehFjvKxBKKHBuQDRT4NSC+JFO4s8
 A14gNpycG6xF8KXIjYVL36OCwe5J//tayhYUdcNvnpTWFozdzZkIhS/j2N9hXV1RQc
 Vits96ivmEMqmFFtvXAuJdr3crlKtSIezTZFNjebb2eCfjCl/PQwCoxunQRc+qYbly
 iGdOHWMJNN/CtwamBhT+R2pI5n1hLncm7Bf2C9juyZF0lPF89DUK/EPJyzgfgwru5f
 +IB1LYwt8JUQg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20211116163901.45390-1-rf@opensource.cirrus.com>
References: <20211116163901.45390-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/4] ASoC: cs42l42: Remove redundant code
Message-Id: <163718829216.136850.12619030505977686878.b4-ty@kernel.org>
Date: Wed, 17 Nov 2021 22:31:32 +0000
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

On Tue, 16 Nov 2021 16:38:57 +0000, Richard Fitzgerald wrote:
> - Remove field writes in regmap_update_bits() calls where the code
>   intends that the field value is not changed.
> 
> - Remove unnecessary complexity from reporting jack unplug event
> 
> - Remove a PLL config value member that was introduced in a bugfix
>   but made redundant by a later bugfix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: cs42l42: Remove redundant writes to DETECT_MODE
      commit: 976001b10fa4441917f216452e70fd8c5aeccd94
[2/4] ASoC: cs42l42: Remove redundant writes to RS_PLUG/RS_UNPLUG masks
      commit: f2dfbaaa5404cadf70213146a5b4b89b647d9092
[3/4] ASoC: cs42l42: Simplify reporting of jack unplug
      commit: 3edde6de090617adea18f2068489086c0d8087e3
[4/4] ASoC: cs42l42: Remove redundant pll_divout member
      commit: bbf0e1d36519a5cd2c08dc1348f997cd5240eb2e

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
