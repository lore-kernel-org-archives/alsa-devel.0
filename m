Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592D7C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 10:53:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 958CD1A28;
	Tue,  7 Jun 2022 12:52:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 958CD1A28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654599197;
	bh=3AqcgFROyY3hkCEzdOdEFdNbxxw2PBTGqPDd+uvJsfg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ab0sZnoVuFjQTCnqa9EZ503CVPI9Cff4VvGWM1vh70Tx3qlS/BXr/WlxXTUh/txj8
	 /LOMZ3LS7XMkBntkU+z8pY395/YNOycREcgfbo7uZMDs7QIpkCCS7kiJrEmhJm6Vjh
	 TiavyshnKzQUdHkPPLSCDVB2CREsoje4mG/juVmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1D57F805F3;
	Tue,  7 Jun 2022 12:46:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADCAEF805EE; Tue,  7 Jun 2022 12:46:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 557EEF805EC
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 12:46:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 557EEF805EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HMQtJMbL"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 46A4B6152C;
 Tue,  7 Jun 2022 10:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0E1C34119;
 Tue,  7 Jun 2022 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654598775;
 bh=3AqcgFROyY3hkCEzdOdEFdNbxxw2PBTGqPDd+uvJsfg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HMQtJMbLxLQSEp7UXDJ7hEzxzW4fRv+j2PIoSK3J3pTWeudUPx8n5kx7opSQXGVHA
 EyniiYipGW9svD5twRM5TSY91gW1hzouKgenmFd4IrEb4WfSuIHHIXVLKQb1Kfz8kk
 JmX9onj1NqItd3H9uZeO9yh9ozWlUNaBPiftGsjH1noMt1mBZCQ3n1UPW0UFHisUgl
 f58QhKi0WiSPJ4h4L9uI5TH0f/Hr8C2O8FAR8NFakWP/K6pKzUtwWJuEnxxWmoR8K8
 5bJp5IhW2xYqnOEhKK6WmxpehnwHmfBH9Ka7MVDKJUOlm28k/qfDQOaGaDd4au6ROD
 APBg2hiXEMQgA==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, support.opensource@diasemi.com, lgirdwood@gmail.com,
 perex@perex.cz, jiasheng@iscas.ac.cn
In-Reply-To: <20220531094712.2376759-1-jiasheng@iscas.ac.cn>
References: <20220531094712.2376759-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: codecs: da7210: add check for i2c_add_driver
Message-Id: <165459877402.301808.1092458245565665338.b4-ty@kernel.org>
Date: Tue, 07 Jun 2022 11:46:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Tue, 31 May 2022 17:47:12 +0800, Jiasheng Jiang wrote:
> As i2c_add_driver could return error if fails, it should be
> better to check the return value.
> However, if the CONFIG_I2C and CONFIG_SPI_MASTER are both true,
> the return value of i2c_add_driver will be covered by
> spi_register_driver.
> Therefore, it is necessary to add check and return error if fails.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: da7210: add check for i2c_add_driver
      commit: 82fa8f581a954ddeec1602bed9f8b4a09d100e6e

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
