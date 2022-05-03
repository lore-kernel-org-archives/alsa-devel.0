Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D612C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  3 May 2022 15:52:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D73859F6;
	Tue,  3 May 2022 17:52:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D73859F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651593175;
	bh=tZCpXt951+v7AWKqU2U1nzv27dPRokE5qrI8xjhBGeE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SgqDv4Y23D+HOY/1YftIcCo8l5zTVtMFdancMCVXPZP5Fb6udJkFwOxBthcRNz3aQ
	 +BzYk9dyOwDf31gaT6T7Dakm9TCtpkXPpuetGlZ/8MVZ7aWZ+CKEv2pYPpWN4P82pg
	 KylaEKJGLkTqcvC1pG53aZVnRqZiNhdC0Y7Mpx94=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F351F80511;
	Tue,  3 May 2022 17:51:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17966F80272; Tue,  3 May 2022 17:51:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CFE3F800D2
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2022 17:51:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CFE3F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="l/ZihPoi"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D32F961687;
 Tue,  3 May 2022 15:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6567BC385A9;
 Tue,  3 May 2022 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651593058;
 bh=tZCpXt951+v7AWKqU2U1nzv27dPRokE5qrI8xjhBGeE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=l/ZihPoiyFKw1GQAtzHvZkLASJrskwvbRetjgXrBrpVfhAT0J0Vs281mTB7bZzmjl
 MfCMGFZmtFtFVIUymO5j9duajX6Ek91XE9BLPo+/dxdAKQJIxe5WMiGB7VLrRbTr3S
 Wg++LceYP3XerbMylO3ZYPF8iKP8YCclaP9c8Fmuu5f5ILexHlFc1tOSA33ysJLfIE
 IrGTJVTEOGZZ2O8eAs5LwW0s+p2rMz+X5YZ9DmiFAH5uHFNoDRXTvKfsfXxnclzJWz
 FB/SdBuAfh5WXtfdgl5C5OO1Kcl94AJWoCyzRhi1IKs6wbTknMIZN8TArk3zsbRXHN
 XABy3EGc8kamA==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org
In-Reply-To: <20220428162444.3883147-1-broonie@kernel.org>
References: <20220428162444.3883147-1-broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: Fix event generation for "DSP Voice Wake
 Up" control
Message-Id: <165159305713.184114.1421832757201330871.b4-ty@kernel.org>
Date: Tue, 03 May 2022 16:50:57 +0100
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

On Thu, 28 Apr 2022 17:24:44 +0100, Mark Brown wrote:
> The driver has a custom put function for "DSP Voice Wake Up" which does
> not generate event notifications on change, instead returning 0. Since we
> already exit early in the case that there is no change this can be fixed
> by unconditionally returning 1 at the end of the function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5514: Fix event generation for "DSP Voice Wake Up" control
      commit: 4213ff556740bb45e2d9ff0f50d056c4e7dd0921

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
