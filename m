Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E42C77B7C
	for <alsa-devel@archiver.kernel.org>; Thu, 11 May 2023 06:04:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDFB5F6F;
	Thu, 11 May 2023 08:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDFB5F6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683785051;
	bh=L4Nnv6gPFOyuLFZDBZsL5VCSsSaGeg9xGtmV+5kvrYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pkoyqwkwr+58AqN4ZK4wID60VkWFuA5J8NYJnm0TCa3KWXmo1iLBUPwdzLD5YBpQn
	 wkB6ozWyqH470cKihXzhAis27WrlbeSP7elKZjyrBMVZWlyB62w6xVYHmNcBGpRPl2
	 pkQtQfZlg7/xINK+5d/Y9tj5sngBNrHMk1rth8Xc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 46FF6F8032D;
	Thu, 11 May 2023 08:02:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FF8BF8032D; Thu, 11 May 2023 08:02:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10E76F8014C
	for <alsa-devel@alsa-project.org>; Thu, 11 May 2023 08:02:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10E76F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VyqAQJHF
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8002A64AD1;
	Thu, 11 May 2023 06:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E5C433D2;
	Thu, 11 May 2023 06:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683784964;
	bh=L4Nnv6gPFOyuLFZDBZsL5VCSsSaGeg9xGtmV+5kvrYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VyqAQJHFu2ZOa6qUeQpMH1Mij3SIUuel5M5juD/3iv6Fi4f3ZPTxuhUzsbHzwgYXp
	 sdAHe2fn/srgdvZTlksC2EgyVJDPdRjkr6FQb/sJ0zBdsVZI6NqtS4mNd9SesYtwbV
	 kYAP7xNLJfLWp2K7gHKdXxvZaGzo5ylVj+bU7B92cYN59jJSw0aD5hV8FYC9ItOH8W
	 zkuu5idA/ma/R/8VlmhTYgeGRE0v4tJxjKRnOPXb7i0WPq3M49XdcQep4xP6KM6oTW
	 kkB9oAcZkJfUp6qfaZTBtH8WVhZTjGzA5RAy3+E24SPb3NDi+SRMdCGDgbtvQsth7O
	 ftLcsshj4LQ1w==
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, tsbogend@alpha.franken.de, paul@crapouillou.net,
 Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
In-Reply-To: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
References: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: (subset) [PATCH v1 1/3] ASoC: jz4740-i2s: Add support for
 X1000 SoC
Message-Id: <168378495575.334814.10028126851566135486.b4-ty@kernel.org>
Date: Thu, 11 May 2023 15:02:35 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: LSTFIPS45VI5VWOJ2FVVJFDHNSNOIOWN
X-Message-ID-Hash: LSTFIPS45VI5VWOJ2FVVJFDHNSNOIOWN
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LSTFIPS45VI5VWOJ2FVVJFDHNSNOIOWN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 09 May 2023 13:42:36 +0100, Aidan MacDonald wrote:
> The X1000's AIC is similar to the AIC found on other Ingenic SoCs.
> It has symmetric playback/capture rates like the JZ4740, but more
> flexible clocking when outputting the system or bit clocks.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: jz4740-i2s: Add support for X1000 SoC
      commit: bb1b282da4be8af998de7b5a2c600af6ef01aa4f
[2/3] ASoC: ingenic: Add compatible string for X1000 SoC
      commit: d40b28d642d52e4687c73dd098fbd8ac8e2dc1d8

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

