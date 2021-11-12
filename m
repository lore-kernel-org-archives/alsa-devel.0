Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15657C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:29:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2D8610A2
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B2D8610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D11DA1681;
	Fri, 12 Nov 2021 22:28:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D11DA1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636752549;
	bh=Sj67EJTcfNfebO7+2dFYJs7CjOGrXVceD5/GOOnZkDA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IdLlDw3khTfzvMkso7bjqjqpy9bwerv5XRhtKMil2VDWYrZCh/1Y8cF5nibgOUtzZ
	 /8llKbKaBM1ZQ/oqzPNHYmuAP696M9ZXnXkdWW4NlJ2slSKwsechPSXmfbK0ir0Mpx
	 +L+IthrKMgI3y8b9+QO8Q5LA507ub5gAPdzzFIH8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40CD0F804EB;
	Fri, 12 Nov 2021 22:27:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4641F804E6; Fri, 12 Nov 2021 22:27:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 521ADF804B3
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 22:27:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 521ADF804B3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YCwHmgMd"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10C0960F5B;
 Fri, 12 Nov 2021 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636752443;
 bh=Sj67EJTcfNfebO7+2dFYJs7CjOGrXVceD5/GOOnZkDA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=YCwHmgMdKX91m0UCuH1lhfZWLoUNYbnfXDBzP1Tl4kfXG6SGA5E8nlJuG7YkzatvU
 5VGjIJKbFKFQwsBKopuFe8mRtBEbLqanKlz082sVaU5DYRYRjDOu4c9FPDBvT8JNld
 OdUk65+M07FE2AV8e65cQ3kDicBuECcNdyWFrKQK4KX2m0yaAR7YQyON28h21ExdjW
 13G4enLRK26jPJmBXwqiw7UvD5AsIZdF/6UeCJzmgJ92wNPIYS5b9GyQ80t/4agnKI
 NRBmNmaDJvm03O2ByPOog2hd7rFjZmblKaSaY6kmqYZVIXRUheTpYD9O+Vqa1ELWSi
 XXGBigHGc9Yhg==
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>, lgirdwood@gmail.com
In-Reply-To: <20211111091705.20879-1-jack.yu@realtek.com>
References: <20211111091705.20879-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt1011: revert 'I2S Reference' to SOC_ENUM_EXT
Message-Id: <163675244180.742274.7545715112047788968.b4-ty@kernel.org>
Date: Fri, 12 Nov 2021 21:27:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

On Thu, 11 Nov 2021 17:17:05 +0800, Jack Yu wrote:
> Revert 'I2S Reference' to SOC_ENUM_EXT because the settings are specific
> for some platforms, the default setting for 'I2S Reference' does nothing,
> only some SoC platform need to configure it.
> Previous 'I2S Reference' in SOC_ENUM format only toggles one bit of
> RT1011_TDM1_SET_1 register, which isn't enough for specific platform.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: rt1011: revert 'I2S Reference' to SOC_ENUM_EXT
      commit: a382285b6feda8db56955e5897453405c198048d

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
