Return-Path: <SRS0=AXUI=KO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F2C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 16:14:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8105D6135C
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 16:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8105D6135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3ACC16A0;
	Wed, 19 May 2021 18:13:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3ACC16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621440838;
	bh=na6FALQoNuy8u03ZG29zB+aTDGjiYRhmATrXpQWBCAw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UqBu66xcp1m6jL25o4YJq239fbOfie9zSgCPPJXqBi6FOo+o3jTBxbZpO1OIg7UI4
	 +aOWOssEU8KwCpkfrDaN8zMloADNxMR8XheiWgi45HGcrCbK+F4JymFhNRARuYSiHI
	 gKnXi0tM0iG7ZQB1niVafvmP2rZl2+Z24JicrLAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 062CDF80475;
	Wed, 19 May 2021 18:11:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FDD8F80127; Wed, 19 May 2021 18:11:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98227F80258
 for <alsa-devel@alsa-project.org>; Wed, 19 May 2021 18:11:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98227F80258
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M8qK9qlv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B06DB6124C;
 Wed, 19 May 2021 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621440684;
 bh=na6FALQoNuy8u03ZG29zB+aTDGjiYRhmATrXpQWBCAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M8qK9qlv1xTdKbAIltgvg+rJeQrfD6rWZ3qGsvDwCpkySLGOY7w0PLI5svRkIbHoh
 RLhl5ybGt7z1ZSI3GzedvHOtWdotKfkJQV9AmmLoRdX+1Foun3bUCvhBsDCKcqx6L3
 Z+MpvafZ95wCw35PONHCbVpL2f2+TYLMLlhjVbMRPEL5fuKcNzCOhIhmDpWi++i3vG
 y+IY7va2TV4EMoRbuTBPDt0Gk/4A70DiSyitS2AAkLjdolxeNiQRKLgqcQIVCuaH6m
 9VQIHm10JySYHd/RpBCkdu8ukCjHg1KWBKgW06XPO8lbggU8qLK+2GL5P0rVLStKyc
 OMF/RJXyoy0Rg==
From: Mark Brown <broonie@kernel.org>
To: jbrunet@baylibre.com,
	Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/2] ASoC: meson: g12a-toacodec: add support for SM1
Date: Wed, 19 May 2021 17:10:18 +0100
Message-Id: <162144027324.37060.1996054206902696511.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511074829.4110036-1-narmstrong@baylibre.com>
References: <20210511074829.4110036-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 11 May 2021 09:48:27 +0200, Neil Armstrong wrote:
> This patchset adds Amlogic SM1 support on the TOACODEC driver, first by switching
> to regmap fields for some bit fields to avoid code duplication, and then by adding
> the corresponding bits & struct for the SM1 changed bits.
> 
> Changes since v2 at [2]:
> - use raw values instead of defines in REG_FIELD() for g12a_toacodec_match_data
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: meson: g12a-toacodec: use regmap fields to prepare SM1 support
      commit: 172dd9216d2b8a3fa162039d89c4361ef35c85ae
[2/2] ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC
      commit: 7487238c5f530b418745ce134d1b0a7fba3a0d8d

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
