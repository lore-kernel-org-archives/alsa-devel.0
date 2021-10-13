Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37EDC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 20:02:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15056023E
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 20:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A15056023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A9B41686;
	Wed, 13 Oct 2021 22:01:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A9B41686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634155344;
	bh=1oF/0KAEVPeYlrdQqrfNh8lPmb1WJwNcWECUPEGDTyU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qRmzIY8O4viVslbOPGV1lTo6sLm2+zguuDVfSmOPjsIZNNmXBDtb+dhd9erAR7OoZ
	 H9g5CqY5TEwntai/wALdZJ5lhbZLnSSTtj/tvOs6MrqyJ7fPsc0Ws36POR8VVK8QZb
	 GdiDzhsCJl6zxsM1rx6nCzcflu5KjLsQ/iC0Z6PY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 277FCF804EB;
	Wed, 13 Oct 2021 22:00:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AC4EF804EB; Wed, 13 Oct 2021 22:00:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62D6BF804E7
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 22:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62D6BF804E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aq1y0Rs7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C00D611CA;
 Wed, 13 Oct 2021 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634155220;
 bh=1oF/0KAEVPeYlrdQqrfNh8lPmb1WJwNcWECUPEGDTyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aq1y0Rs7qvl20APh23l8rydgIcp0iUFUIvu69Tecvx5b9MQVHyl0ZFqA1C6MYJ/sv
 WGqmOowKjjgs4n4E2Hq9zEI/v9yyMfv+PRyBykMVwA4ylco2RTPf6wLMEmjYq2fKWH
 4LkvvEJXusqSXbYOE6plBJFksBuivGQmfPIeZVIgZzhCBJoI90olkvnb5+fyRPtUzg
 EYgxAsVWklPvbYeIuIgSbjbbJbLFR64m0XuBEBMpF+LjY/fL4RcxY6/lCOLC6zOzko
 BwmYRzwIq9JtTUpGz2gNbSKFfP+NaT4AjaUp7Xb5C3gIBEn1DE6auZnw7kONY+IGQw
 bPaVk9tT+YK0g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 oder_chiou@realtek.com, jack.yu@realtek.com
Subject: Re: [PATCH] ASoC: rt1011: Fix 'I2S Reference' enum control
Date: Wed, 13 Oct 2021 20:59:52 +0100
Message-Id: <163415517071.1358186.12639404549915866847.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012063113.3754-1-peter.ujfalusi@linux.intel.com>
References: <20211012063113.3754-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 pierre-louis.bossart@linux.intel.com, seppo.ingalsuo@linux.intel.com
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

On Tue, 12 Oct 2021 09:31:13 +0300, Peter Ujfalusi wrote:
> There are several things the patch adding the support for 'I2S Reference'
> got wrong:
> - "None" selection is in fact equals to last selected reference
> - The custom put overrides RX/TX len, TDM slot sizes, etc
> - the enum is useless in most part for the reference tracking
> - there is no need for EXT control as there is a single bit in
>   RT1011_TDM1_SET_1 register (bit 7) which selects the reference
> - it was using ucontrol->value.integer.value[0] in the put/get callbacks
>   which causes access to 'I2S Reference' enum with alsamixer to fail:
> $ alsamixer
> cannot load mixer controls: Invalid argument
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1011: Fix 'I2S Reference' enum control
      commit: f05a9b8552896d95fc22e135eaf9c6be541bfe79

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
