Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA7FC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Nov 2022 17:41:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D325F16C9;
	Mon, 28 Nov 2022 18:40:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D325F16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669657283;
	bh=ksNf/YddouAnHYSNO35e1eWHI7ypXSlIfibrJFdWEf4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtjO2vjP5Z4/2kOm+BTf7wyPWDQhA5iPTTfr2njG4qjIPgoek2g44zTdZ9QrsIYZF
	 WjjgnSkblzaasqGGgrjVALiiWJAvaR5cOpiKmAyMI9HKq4e42qkOPdsXym9f+y4KX+
	 igO/gnsi6YWDPBMLfMO9yaiHivWQBVADAR/jqR9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A1ECF80166;
	Mon, 28 Nov 2022 18:40:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01A2FF801D8; Mon, 28 Nov 2022 18:40:31 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64A1BF801D8
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2022 18:40:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64A1BF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Osc1H1Y2"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F3526612E9;
 Mon, 28 Nov 2022 17:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C351C433D6;
 Mon, 28 Nov 2022 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669657226;
 bh=ksNf/YddouAnHYSNO35e1eWHI7ypXSlIfibrJFdWEf4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Osc1H1Y2dd/1zAyoQv+CJvEfOBepdr9KnkC0Zq43CfxEmyEQzwk67A9puNnYw1UAG
 O7eYNatbOG5Z14pGD8hrppnia2Ca1TJvKAzr96aG88MMS/18dMhTP38B9tjfH3zMta
 YqQR6azn+QEVmFrzUXaVXRPwFej2H01vc+BY0ce5spLiGefmYlCDipt0DhT9Q/yvmS
 hc7EKRFdHf93+NgdMwL47eGE10e3kiqHQqqsBa/sHM/+o+IenCpufIpc78A+zKNHDF
 gZ3Sq/2abivOb7aykWQsyg+5mbBuDoihw6NCLvLqoHlYm07PhN7incrFBJbmaAy2Ym
 3o1u0nuxP+WUw==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Ricardo Ribalda <ribalda@chromium.org>
In-Reply-To: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
References: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
Message-Id: <166965722420.688163.18006301242962769416.b4-ty@kernel.org>
Date: Mon, 28 Nov 2022 17:40:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Mon, 28 Nov 2022 11:49:16 +0100, Ricardo Ribalda wrote:
> If the device does not come straight from reset, we might receive an IRQ
> before we are ready to handle it.
> 
> Fixes:
> 
> [    2.334737] Unable to handle kernel read from unreadable memory at virtual address 00000000000001e4
> [    2.522601] Call trace:
> [    2.525040]  regmap_read+0x1c/0x80
> [    2.528434]  mt8173_afe_irq_handler+0x40/0xf0
> ...
> [    2.598921]  start_kernel+0x338/0x42c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
      commit: 4cbb264d4e9136acab2c8fd39e39ab1b1402b84b

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
