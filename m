Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF1CC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 13:14:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCCBC18D7;
	Thu, 10 Mar 2022 14:13:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCCBC18D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646918086;
	bh=hLAwTLXVIMcSoOs+DZE5AFrkLCUXZidEtWnQvIrw/tU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y5yvIEvKu+9WVEIr9dXhJxeQJdMISuA3/XtbI3/a74QlEix4X1jAIYZMaDeS3WvF6
	 dLl3tPBpi01nRAYYEg++v3Up58nffafTGnVmgguh2Hm5EMlriVfFUXhpszz7NkwmDq
	 3DVEJ6+0NPZD9Ga3kga4ldRQz7MkyyPUqVsBz7i8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 514D0F8012F;
	Thu, 10 Mar 2022 14:13:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9CFBF80137; Thu, 10 Mar 2022 14:13:54 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89658F8012C
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 14:13:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89658F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="n6ZAn42u"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EAEE1619E9;
 Thu, 10 Mar 2022 13:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDAAC340E8;
 Thu, 10 Mar 2022 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646918028;
 bh=hLAwTLXVIMcSoOs+DZE5AFrkLCUXZidEtWnQvIrw/tU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=n6ZAn42uSq803NRWqlQCNO1MoJy7a11DC3hZHbv1j6suwf4QD3Ye56cQcpFoikUtt
 vkWv2HNPhmZ0FZEnvA5Tkd2QGAVXCunRFU23qWBEDXEoH9Noi5r/29OPlrZ+KK4Y/m
 shqQA4BDUnllAv7q6k48yn/G/KG6zvyi20Ot4lL3GwuT2rYnvd/9PcxckR9WZRJ1cZ
 1hrUqAOhTn2SlOnP0xNqI3s4DNyLkwA4rOpOb5V2a5AxBlLsRZhGsxOw4JFz3kPxPi
 3j1IReqmSFNZyfz56xywDTUA9CY/Vmxp2L3d82UZgMIXELuTTO2Si9Hr52vbfkCs2H
 rrrtQTMzSlwHQ==
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>, alsa-devel@alsa-project.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220309164116.178685-1-colin.i.king@gmail.com>
References: <20220309164116.178685-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: atmel: mchp-pdmc: Fix spelling mistake
 "microchopnes" -> "microphones"
Message-Id: <164691802584.2018412.7073594890516356081.b4-ty@kernel.org>
Date: Thu, 10 Mar 2022 13:13:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 9 Mar 2022 16:41:16 +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_info message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: Fix spelling mistake "microchopnes" -> "microphones"
      commit: 6b6bb5e26222021abe1c5360f43b4c2ff1dd012f

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
