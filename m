Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E99AC4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Nov 2022 20:11:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38214169B;
	Fri, 11 Nov 2022 21:10:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38214169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668197467;
	bh=ldAYlErMXxSDvX7PgibGsmXAVUAab9FUHEviKO69Pww=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PU9709MX+D0p7ATVW+91HO59GoB9iOWnK/DNfsAp+PySTP/Fgj4Gv6+kU8OMH15Nb
	 mOSH45N7G6uOH4qbYcRaIvIgeCm8GSjrjW8Th+0f5CN1///aq4QY49QPtlvyVs5TNb
	 Xod6Kgz/ddBxMTFSCtkoHkUcIgAh2M7Sp9j7oO8Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDEE6F80519;
	Fri, 11 Nov 2022 21:09:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B776BF8028D; Fri, 11 Nov 2022 21:09:51 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 027F3F800F8
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2022 21:09:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 027F3F800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TvAzMBvw"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 588A462072;
 Fri, 11 Nov 2022 20:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E74C4347C;
 Fri, 11 Nov 2022 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668197385;
 bh=ldAYlErMXxSDvX7PgibGsmXAVUAab9FUHEviKO69Pww=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=TvAzMBvw+7pqMaw76pvdDAJFa8J14riKoIBBcuULFCuDgcHMntPeQNaHi1/vuZxpo
 dGHDkc90IsyrIAM/yBdmXAXoalY23d5KREt2KGKnyo6vylFEs2h8Cjo3lyAjoXYwzm
 2TRrH6nshedPE+VLx20LQ1yBEGwooiFbqXe+Ye68v2+r2QIDxbCKO9nXEHUiIQYA5e
 kfe58LFa0yQTcoMTne92EKcweqN2wEJqEnpXswX1HQLIIKKRHLMj3ZckXkcUtcAiJs
 1Y82te4gDFRW/dEtstkk9VX9wpsYRKr2JO1c2t78g0WpiDxdwvFl+4mHy8X9yu5wvN
 er0azwE47Y0Xw==
From: Mark Brown <broonie@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20221108001829.5100-1-rdunlap@infradead.org>
References: <20221108001829.5100-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] ASoC: codecs: wsa883x: use correct header file
Message-Id: <166819738332.635730.5845715184483403230.b4-ty@kernel.org>
Date: Fri, 11 Nov 2022 20:09:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>
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

On Mon, 7 Nov 2022 16:18:29 -0800, Randy Dunlap wrote:
> Fix build errors when GPIOLIB is not set/enabled:
> 
> ../sound/soc/codecs/wsa883x.c: In function 'wsa883x_probe':
> ../sound/soc/codecs/wsa883x.c:1394:25: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>          wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
> ../sound/soc/codecs/wsa883x.c:1395:49: error: 'GPIOD_FLAGS_BIT_NONEXCLUSIVE' undeclared (first use in this function)
>          GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> ../sound/soc/codecs/wsa883x.c:1414:9: error: implicit declaration of function 'gpiod_direction_output'; did you mean 'gpio_direction_output'? [-Werror=implicit-function-declaration]
>          gpiod_direction_output(wsa883x->sd_n, 1);
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: use correct header file
      commit: 5f52ceddc40cd61b1dd2ecf735624deaf05f779f

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
