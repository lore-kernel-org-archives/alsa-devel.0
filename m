Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228ADC43334
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jul 2022 14:32:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 338241959;
	Thu, 14 Jul 2022 16:31:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 338241959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657809166;
	bh=EiqO1A6/I9zAt4h51+JBiqm/YYyr2kWxsGR7un0Pnqg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WIzUSnGRfOotkCqoM+HETRpXyc0qkSKijjFE4NxDszstqpW2vq027heBhigoMZIlq
	 sKE12NPXr6inQxYmFTjfejIzzi8CDVhifooq1p8g3ZqrFd/jQlrJWbsfqkxh4FGs66
	 HHcW4nS+GQaaNtiPh8I7glL/reFuobHdBBVHEo90=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B422F80548;
	Thu, 14 Jul 2022 16:31:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E4B2F8053D; Thu, 14 Jul 2022 16:31:20 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61F7BF800B0
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 16:31:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61F7BF800B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N8cyHSM6"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 82E60B823A2;
 Thu, 14 Jul 2022 14:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40333C341CA;
 Thu, 14 Jul 2022 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657809070;
 bh=EiqO1A6/I9zAt4h51+JBiqm/YYyr2kWxsGR7un0Pnqg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=N8cyHSM6ni8jwPibibKpTGS1PpMQJc04KyTAe2yLrpydCus24ilFx+PrS147YOEB9
 8/UbqFMoSw3vf+dsAN7TBy6OnI732xUrPvvr2fkRiw3SsHJB1aUg2L0q8HvwmcCy6V
 VeokQys4JjcLAQan2MSzMA9/VwulHZmu7mbAcT3TnEvpEK0kIP7PEVIVX1BnbGwrM+
 l0gtp5fuqnclthcQLRr5GmbdS0DoCL3q82vE8b+luU+u4SArvED6s7XGpy5opyvHOE
 cTRiMQYi0p6FXmJksth+Enz450KQIuOV8l0q02BI28ZE0RsibtY5ZVyIw3JizDdD1Q
 OWqytpPRtZ11g==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871quocio1.wl-kuninori.morimoto.gx@renesas.com>
References: <871quocio1.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: care default case on
 rsnd_ssiu_busif_err_irq_ctrl()
Message-Id: <165780906899.93789.11935019608818262283.b4-ty@kernel.org>
Date: Thu, 14 Jul 2022 15:31:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, kunihiko.nishiyama.dn@renesas.com,
 nguyen.nguyen.yj@renesas.com
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

On Thu, 14 Jul 2022 06:28:15 +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Before, ssiu.c didn't care SSI5-8, thus,
> commit b1384d4c95088d0 ("ASoC: rsnd: care default case on
> rsnd_ssiu_busif_err_status_clear()") cares it for status clear.
> 
> But we should care it for error irq handling, too.
> This patch cares it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: care default case on rsnd_ssiu_busif_err_irq_ctrl()
      commit: ef30911d3c39fd57884c348c29b9cbff88def155

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
